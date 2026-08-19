#!/usr/bin/env bash
set -euo pipefail

### CONFIG
FIFO="/tmp/in.ts"
CAM="/dev/video0"

FREQ="${1:-1295000000}"
MODCOD="${2:-QPSK1/4}"
SYMRATE="${3:-333000}"

ABIT="24k"
SR="22050"

TX_SECONDS=480
SLEEP_SECONDS=60

DVBS2="./RF_FIFO_dvbs2_experiment.py"

log()
{
    echo "[$(date '+%F %T')] $*"
}

cleanup_procs()
{
    [[ -n "${FFMPEG_PID:-}" ]] && kill "${FFMPEG_PID}" 2>/dev/null || true
    [[ -n "${DUMMY_PID:-}"  ]] && kill "${DUMMY_PID}"  2>/dev/null || true
    [[ -n "${DVBS2_PID:-}"  ]] && kill "${DVBS2_PID}"  2>/dev/null || true

    pkill -f "RF_FIFO_dvbs2_experiment.py" 2>/dev/null || true
    pkill -f "ffmpeg" 2>/dev/null || true
    pkill -f "python3 -c.*open.*${FIFO}" 2>/dev/null || true

    sudo fuser -k /dev/video0 2>/dev/null || true

    FFMPEG_PID=""
    DUMMY_PID=""
    DVBS2_PID=""
}

trap '
    log "TRAP: cleanup"
    cleanup_procs
    rm -f "${FIFO}" 2>/dev/null || true
    exit 0
' INT TERM


############################################################
# DVB-S2 parameters
############################################################

case "${SYMRATE}" in

    333000)
        SPS=4

        case "${MODCOD}" in

            QPSK1/4)
                VBIT="90k"
                MUXRATE="140k"
                ;;

            QPSK1/2)
                VBIT="229k"
                MUXRATE="305k"
                ;;

            QPSK3/4)
                VBIT="350k"
                MUXRATE="485k"
                ;;

            8PSK3/5)
                VBIT="430k"
                MUXRATE="585k"
                ;;

            *)
                echo "Unsupported MODCOD: ${MODCOD}"
                exit 1
                ;;
        esac
        ;;


    1000000)
        SPS=4

        case "${MODCOD}" in

            QPSK1/4)
                VBIT="330k"
                MUXRATE="480k"
                ;;

            QPSK1/2)
                VBIT="700k"
                MUXRATE="975k"
                ;;

            QPSK3/4)
                VBIT="1050k"
                MUXRATE="1465k"
                ;;

            8PSK3/5)
                VBIT="1300k"
                MUXRATE="1770k"
                ;;

            *)
                echo "Unsupported MODCOD: ${MODCOD}"
                exit 1
                ;;
        esac
        ;;


    1500000)
        SPS=2

        case "${MODCOD}" in

            QPSK1/4)
                VBIT="500k"
                MUXRATE="740k"
                ;;

            QPSK1/2)
                VBIT="1050k"
                MUXRATE="1492k"
                ;;

            QPSK3/4)
                VBIT="1600k"
                MUXRATE="2244k"
                ;;

            8PSK3/5)
                VBIT="1900k"
                MUXRATE="2688k"
                ;;

            *)
                echo "Unsupported MODCOD: ${MODCOD}"
                exit 1
                ;;
        esac
        ;;


    2000000)
        SPS=2

        case "${MODCOD}" in

            QPSK1/4)
                VBIT="700k"
                MUXRATE="986k"
                ;;

            QPSK1/2)
                VBIT="1400k"
                MUXRATE="1989k"
                ;;

            QPSK3/4)
                VBIT="2150k"
                MUXRATE="2992k"
                ;;

            8PSK3/5)
                VBIT="2550k"
                MUXRATE="3584k"
                ;;

            *)
                echo "Unsupported MODCOD: ${MODCOD}"
                exit 1
                ;;
        esac
        ;;


    *)
        echo "Unsupported SYMRATE: ${SYMRATE}"
        exit 1
        ;;

esac


############################################################
# x264 buffer
############################################################

BUFSIZE="$(( ${VBIT%k} * 2 ))k"


echo "===================================="
echo "FREQ       : ${FREQ}"
echo "MODCOD     : ${MODCOD}"
echo "SYMRATE    : ${SYMRATE}"
echo "SPS        : ${SPS}"
echo "VIDEO BIT  : ${VBIT}"
echo "AUDIO BIT  : ${ABIT}"
echo "AUDIO RATE : ${SR}"
echo "MUX RATE   : ${MUXRATE}"
echo "BUF SIZE   : ${BUFSIZE}"
echo "TX TIME    : ${TX_SECONDS}"
echo "===================================="


############################################################
# Main loop
############################################################

while true
do

    log "===== cycle start ====="

    cleanup_procs

    rm -f "${FIFO}"
    mkfifo "${FIFO}"

    log "FIFO prepared: ${FIFO}"


    ########################################################
    # Dummy writer
    #
    # EOF防止だけが目的。
    # TSデータ不足を補うものではない。
    ########################################################

    log "start dummy writer"

    python3 -c "
import time
f=open('${FIFO}','wb',buffering=0)
time.sleep(10**9)
" > /tmp/dummy_writer.log 2>&1 &

    DUMMY_PID=$!


    ########################################################
    # DVB-S2 transmitter
    ########################################################

    log "start DVB-S2"

    "${DVBS2}" \
        -z "${FREQ}" \
        -m "${MODCOD}" \
        -s "${SYMRATE}" \
        -o "${SPS}" \
        > /tmp/dvbs2.log 2>&1 &

    DVBS2_PID=$!

    sleep 1


    ########################################################
    # FFmpeg
    ########################################################

    log "start FFmpeg"

    timeout "${TX_SECONDS}" \
    ffmpeg \
        -hide_banner \
        -y \
        -loglevel warning \
        \
        -thread_queue_size 1024 \
        -f v4l2 \
        -input_format yuyv422 \
        -video_size 400x300 \
        -framerate 20 \
        -i "${CAM}" \
        \
        -thread_queue_size 1024 \
        -f alsa \
        -ac 2 \
        -ar "${SR}" \
        -i hw:2,0 \
        \
        -vf "scale=800:480,format=yuv420p" \
        \
        -c:v libx264 \
        -preset ultrafast \
        -tune zerolatency \
        -profile:v baseline \
        -level 3.0 \
        \
        -g 15 \
        -keyint_min 15 \
        -sc_threshold 0 \
        \
        -b:v "${VBIT}" \
        -minrate "${VBIT}" \
        -maxrate "${VBIT}" \
        -bufsize "${BUFSIZE}" \
        \
        -c:a mp2 \
        -b:a "${ABIT}" \
        -ac 2 \
        -ar "${SR}" \
        \
        -muxrate "${MUXRATE}" \
        -mpegts_flags resend_headers \
        -muxdelay 0 \
        -muxpreload 0 \
        \
        -f mpegts \
        "${FIFO}" \
        > /tmp/ffmpeg.log 2>&1 &

    FFMPEG_PID=$!


    wait "${FFMPEG_PID}" || true

    log "FFmpeg finished"


    ########################################################
    # Cleanup
    ########################################################

    cleanup_procs

    rm -f "${FIFO}" || true


    ########################################################
    # Rest
    ########################################################

    log "sleep ${SLEEP_SECONDS}s"

    sleep "${SLEEP_SECONDS}"

    log "===== cycle end ====="

done
