#!/bin/bash
# start_rx.sh — Kazu watchdog版 DVB-S2 RX launcher
#
# Usage:
#   ./start_rx.sh <frequency_hz> <modcod> <symbol_rate>
#
# Example:
#   ./start_rx.sh 437000000 QPSK1/4 333000

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

RX_HZ="${1:?frequency required}"
MODE="${2:?modcod required}"
SR="${3:?symbol rate required}"

# 333k / 1M: SPS=4
# 1.5M / 2M: SPS=2
if [ "$SR" -ge 1500000 ]; then
    SPS=2
else
    SPS=2
fi

WATCHDOG="$SCRIPT_DIR/watchdog_rx.sh"
UDP_RELAY="$SCRIPT_DIR/udp_relay.py"

echo "[RX] Cleaning previous processes..."

if [ -f /tmp/watchdog_rx.pid ]; then
    OLD_PID=$(cat /tmp/watchdog_rx.pid 2>/dev/null || true)
    if [ -n "${OLD_PID:-}" ]; then
        kill "$OLD_PID" 2>/dev/null || true
    fi
fi

pkill -9 -f "watchdog_rx.sh" 2>/dev/null || true
pkill -9 -f "dvbs2-rx --source plutosdr" 2>/dev/null || true
pkill -9 -f "python3 .*udp_relay.py" 2>/dev/null || true
pkill -9 -f "ffplay.*udp://127.0.0.1:2000" 2>/dev/null || true

sleep 1

if [ ! -x "$WATCHDOG" ]; then
    echo "[RX] ERROR: $WATCHDOG not found or not executable"
    exit 1
fi

if [ ! -f "$UDP_RELAY" ]; then
    echo "[RX] ERROR: $UDP_RELAY not found"
    exit 1
fi

if ! command -v iio_info >/dev/null 2>&1; then
    echo "[RX] ERROR: iio_info not found"
    echo "Install it with: sudo apt install libiio-utils"
    exit 1
fi

if ! command -v dvbs2-rx >/dev/null 2>&1; then
    echo "[RX] ERROR: dvbs2-rx not found"
    exit 1
fi

if ! command -v ffplay >/dev/null 2>&1; then
    echo "[RX] ERROR: ffplay not found"
    exit 1
fi

echo "[RX] Start:"
echo "  Frequency   : $RX_HZ Hz"
echo "  MODCOD      : $MODE"
echo "  Symbol rate : $SR"
echo "  SPS         : $SPS"

rm -f /tmp/watchdog_rx.log
rm -f /tmp/watchdog_relay.log
rm -f /tmp/watchdog_dvbs2rx_stderr.log
rm -f /tmp/ffplay_rx.log

# UDP受信画面
ffplay \
    -loglevel warning \
    -fflags nobuffer \
    -flags low_delay \
    -probesize 1000000 \
    -analyzeduration 1000000 \
    udp://127.0.0.1:2000 \
    > /tmp/ffplay_rx.log 2>&1 &

FFPLAY_PID=$!
echo "$FFPLAY_PID" > /tmp/ffplay_rx.pid
(
    cd "$SCRIPT_DIR" || exit 1
    exec "$WATCHDOG" "$RX_HZ" "$MODE" "$SR" "$SPS" 0.2
) > >(tee -a /tmp/watchdog_rx.log) 2>&1 &

# カズさんのwatchdog受信系
#(
#    cd "$SCRIPT_DIR" || exit 1
#    exec "$WATCHDOG" "$RX_HZ" "$MODE" "$SR" "$SPS" 0.2
#) > /tmp/watchdog_rx.log 2>&1 &
#) 2>&1 &

WATCHDOG_PID=$!
echo "$WATCHDOG_PID" > /tmp/watchdog_rx.pid

sleep 2

if ! kill -0 "$WATCHDOG_PID" 2>/dev/null; then
    echo "[RX] ERROR: watchdog_rx.sh stopped"
    cat /tmp/watchdog_rx.log
    exit 1
fi

echo "[RX] Started."
echo "[RX] watchdog PID : $WATCHDOG_PID"
echo "[RX] ffplay PID   : $FFPLAY_PID"
echo
echo "[RX] Logs:"
echo "  /tmp/watchdog_rx.log"
echo "  /tmp/watchdog_relay.log"
echo "  /tmp/watchdog_dvbs2rx_stderr.log"
echo "  /tmp/ffplay_rx.log"
