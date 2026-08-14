#!/bin/bash
# watchdog_rx.sh
#
# Initial acquisition and post-lock stalls are handled separately.
#
# Usage:
#   ./watchdog_rx.sh <freq> <modcod> <symrate> <sps> [rolloff]

set -u

FREQ="${1:?freq required}"
MODCOD="${2:?modcod required}"
SYMRATE="${3:?symrate required}"
SPS="${4:?sps required}"
ROLLOFF="${5:-0.2}"

# 初回ロックには十分な時間を与える
ACQUIRE_TIMEOUT=60

# 一度TSが流れた後の停止判定
STALL_TIMEOUT=8
CHECK_INTERVAL=2

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

RELAY_LOG=/tmp/watchdog_relay.log
STDERR_LOG=/tmp/watchdog_dvbs2rx_stderr.log

PIPE_PID=""
PIPE_PGID=""

cleanup_pipeline() {
    if [ -n "${PIPE_PGID:-}" ]; then
        kill -TERM -- "-$PIPE_PGID" 2>/dev/null || true
        sleep 1
        kill -KILL -- "-$PIPE_PGID" 2>/dev/null || true
    fi

    PIPE_PID=""
    PIPE_PGID=""
}

cleanup() {
    echo "[watchdog] $(date '+%T') Stopping..."
    cleanup_pipeline
    exit 0
}

trap cleanup SIGINT SIGTERM EXIT

cd "$SCRIPT_DIR" || exit 1

while true; do
    PLUTO_ADDR=$(
        iio_info -s 2>/dev/null |
        grep -oE 'usb:[0-9]+\.[0-9]+\.[0-9]+' |
        head -1
    )

    if [ -z "$PLUTO_ADDR" ]; then
        echo "[watchdog] $(date '+%T') PlutoSDR not found, retrying in 3s..."
        sleep 3
        continue
    fi

    echo "[watchdog] $(date '+%T') Starting dvbs2-rx ($PLUTO_ADDR, $MODCOD, ${SYMRATE}sym/s, sps=$SPS)..."

    : > "$RELAY_LOG"
    : > "$STDERR_LOG"

    # 独立したプロセスグループとしてパイプラインを起動
    setsid bash -c '
        dvbs2-rx \
            --source plutosdr \
            --plutosdr-addr "$1" \
            --plutosdr-gain-mode slow_attack \
            -f "$2" \
            -m "$3" \
            -s "$4" \
            -o "$5" \
            -r "$6" \
            --sink fd \
            --out-fd 1 \
            2>>"$7" |
        python3 -u "$8/udp_relay.py" \
            2>>"$9"
    ' _ \
        "$PLUTO_ADDR" \
        "$FREQ" \
        "$MODCOD" \
        "$SYMRATE" \
        "$SPS" \
        "$ROLLOFF" \
        "$STDERR_LOG" \
        "$SCRIPT_DIR" \
        "$RELAY_LOG" &

    PIPE_PID=$!
    PIPE_PGID=$PIPE_PID

    LAST_TOTAL=0
    NO_DATA_ELAPSED=0
    SEEN_DATA=0

    while kill -0 "$PIPE_PID" 2>/dev/null; do
        sleep "$CHECK_INTERVAL"

        CUR_TOTAL=$(
            grep -o 'total=[0-9]*' "$RELAY_LOG" 2>/dev/null |
            tail -1 |
            cut -d= -f2
        )
        CUR_TOTAL=${CUR_TOTAL:-0}

        if [ "$CUR_TOTAL" -gt "$LAST_TOTAL" ]; then
            if [ "$SEEN_DATA" -eq 0 ]; then
                echo "[watchdog] $(date '+%T') Initial TS data detected: total=$CUR_TOTAL"
            fi

            SEEN_DATA=1
            LAST_TOTAL=$CUR_TOTAL
            NO_DATA_ELAPSED=0
            continue
        fi

        NO_DATA_ELAPSED=$((NO_DATA_ELAPSED + CHECK_INTERVAL))

        if [ "$SEEN_DATA" -eq 0 ]; then
            # 初回ロック待ち
            if [ "$NO_DATA_ELAPSED" -ge "$ACQUIRE_TIMEOUT" ]; then
                echo "[watchdog] $(date '+%T') No initial TS data for ${NO_DATA_ELAPSED}s, restarting..."
                break
            fi
        else
            # 一度動いた後のスタール
            if [ "$NO_DATA_ELAPSED" -ge "$STALL_TIMEOUT" ]; then
                echo "[watchdog] $(date '+%T') TS stalled for ${NO_DATA_ELAPSED}s at total=$CUR_TOTAL, restarting..."
                break
            fi
        fi
    done

    if ! kill -0 "$PIPE_PID" 2>/dev/null; then
        echo "[watchdog] $(date '+%T') Receiver pipeline exited."
    fi

    cleanup_pipeline
    sleep 1
done
