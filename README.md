<img width="1920" height="1080" alt="20260917_094901_grim" src="https://github.com/user-attachments/assets/a809adaa-63a4-434c-ae28-0a0ec6e2da6a" />
<img width="1920" height="1080" alt="20260917_094927_grim" src="https://github.com/user-attachments/assets/5afe8d70-d209-4922-921c-f2e3e34b87d2" />
<img width="1920" height="1080" alt="20260917_094931_grim" src="https://github.com/user-attachments/assets/71227dcf-a034-4395-9e36-4326ccf7d5a8" />
<img width="1920" height="1080" alt="20260917_094935_grim" src="https://github.com/user-attachments/assets/5f6d4ebb-49d7-4369-a0e0-028e0befc7e0" />


# Raspberry Pi 5 KISS H.265 DVB-S2 Transceiver

A simple H.265 / HEVC DVB-S2 transmitter and receiver for Raspberry Pi 5 using GNU Radio, FFmpeg, libx265 and Pluto Plus.

This project provides a GTK4 graphical user interface and supporting scripts for practical DVB-S2 DATV transmission and reception.

The basic design philosophy is:

> **KISS — Keep It Simple.**

The goal is not to support every SDR, webcam, SBC, operating system, codec or possible configuration.

The goal is to provide a simple and reproducible DVB-S2 transceiver based on a known working hardware and software configuration.

The DVB-S2 transmitter operates with:

> **Pilot ON**

A particularly important result of this project is that real-time H.265 / HEVC transmission is possible on a Raspberry Pi 5 even without a dedicated H.265 hardware encoder.

The Raspberry Pi 5 performs H.265 encoding in software using:

```text
FFmpeg
+
libx265
+
Raspberry Pi 5 CPU
```

The following configuration has been successfully demonstrated in real DVB-S2 operation:

```text
Raspberry Pi 5 2GB
Logitech C920
YUYV422 input
960x720
20 fps
libx265
preset medium
H.265 / HEVC
MP2 audio
GNU Radio DVB-S2
Pluto Plus
```

Result:

```text
It works.
```

---

# H.265 / HEVC

H.265 / HEVC is the primary experimental video codec in this version of the project.

Two different H.265 approaches have been tested.

## Raspberry Pi 5

```text
Logitech C920
      |
      | YUYV422
      v
Raspberry Pi 5
      |
      | FFmpeg
      | libx265
      | Software H.265 encoding
      v
MPEG Transport Stream
      |
      v
GNU Radio / gr-dvbs2
      |
      v
Pluto Plus
      |
      v
DVB-S2 RF
```

## Orange Pi 3B

```text
USB Camera
      |
      v
Orange Pi 3B
RK3566
      |
      | Rockchip VPU
      | RKMPP
      | Hardware H.265 encoding
      v
MPEG Transport Stream
      |
      v
GNU Radio / gr-dvbs2
      |
      v
Pluto Plus
      |
      v
DVB-S2 RF
```

These represent two different engineering approaches:

```text
Raspberry Pi 5
=
strong CPU
+
software H.265 encoding
```

and:

```text
Orange Pi 3B
=
Rockchip VPU
+
hardware H.265 encoding
```

Both are useful.

---

# Raspberry Pi 5 H.265 Software Encoding

The Raspberry Pi 5 used in this experiment does not use a dedicated H.265 hardware encoder.

Instead, the Raspberry Pi 5 CPU performs H.265 encoding using FFmpeg and libx265.

The camera used for the verified experiment is:

```text
Logitech C920
```

The C920 is used as a YUYV video source.

Its internal H.264 encoder is **not used** for H.265 transmission.

The processing path is:

```text
Logitech C920
      |
      | YUYV422
      v
Raspberry Pi 5
      |
      | FFmpeg
      | YUYV422 -> YUV420P
      |
      | libx265
      | H.265 software encoding
      v
MPEG Transport Stream
      |
      v
GNU Radio DVB-S2
      |
      v
Pluto Plus
      |
      v
DVB-S2 RF
```

---

# Verified Raspberry Pi 5 H.265 Configuration

The following configuration has been demonstrated in real operation.

```text
Platform     : Raspberry Pi 5 2GB
Camera       : Logitech C920
Camera input : YUYV422
Resolution   : 960x720
Frame rate   : 20 fps
Encoder      : libx265
Preset       : medium
Tune         : zerolatency
Profile      : main
Pixel format : yuv420p
Audio codec  : MP2
Transport    : MPEG-TS
DVB-S2       : GNU Radio / gr-dvbs2
SDR          : Pluto Plus
```

Live transmission and reception were confirmed.

The H.265 encoding process is entirely software based.

No H.265 hardware encoder is used on the Raspberry Pi 5.

---

# Software H.265 Encoding Result

The experiment began conservatively.

Lower resolutions and faster presets were tested first.

The test was then gradually increased through:

```text
800x448
960x720
```

and through several libx265 presets:

```text
ultrafast
superfast
fast
medium
```

The final practical test reached:

```text
960x720
20 fps
libx265
preset medium
```

while simultaneously running the DVB-S2 transmission chain.

The system remained operational for extended test periods.

Typical observations during the experiment were approximately:

```text
CPU usage     : around 50 percent per core
Memory usage  : approximately 1 GB
Swap usage    : 0 during stable operation
```

These values are not fixed specifications.

They depend on:

```text
video bitrate
audio bitrate
symbol rate
MODCOD
FFmpeg version
GNU Radio load
desktop applications
temperature
camera mode
x265 preset
```

The important result is:

```text
Raspberry Pi 5
+
Logitech C920 YUYV
+
libx265 software H.265
+
960x720 / 20 fps
+
GNU Radio DVB-S2
+
Pluto Plus
=
WORKS
```

---

# Why YUV420P Is Required

The Logitech C920 can provide YUYV422 video.

For H.265 Main Profile, the stream must be converted to YUV420P.

Therefore this filter is used:

```bash
-vf "format=yuv420p"
```

Without this conversion, libx265 may report an error similar to:

```text
main profile not compatible with i422 input chroma subsampling
```

The correct path is:

```text
C920 YUYV422
      |
      v
FFmpeg
      |
      | format=yuv420p
      v
libx265 Main Profile
```

---

# Representative FFmpeg H.265 Configuration

A representative Raspberry Pi 5 H.265 software encoding command is:

```bash
timeout "${TX_SECONDS}" \
ffmpeg \
    -hide_banner \
    -y \
    -loglevel warning \
    \
    -thread_queue_size 1024 \
    -f v4l2 \
    -input_format yuyv422 \
    -video_size 960x720 \
    -framerate 20 \
    -i "${CAM}" \
    \
    -thread_queue_size 1024 \
    -f alsa \
    -ac 2 \
    -ar "${SR}" \
    -i hw:2,0 \
    \
    -vf "format=yuv420p" \
    \
    -c:v libx265 \
    -preset medium \
    -tune zerolatency \
    -profile:v main \
    \
    -g 15 \
    -keyint_min 15 \
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
    -mpegts_flags +resend_headers \
    -muxdelay 0 \
    -muxpreload 0 \
    \
    -f mpegts \
    "${FIFO}"
```

The following values must be selected according to the chosen DVB-S2 operating condition:

```text
VBIT
ABIT
BUFSIZE
MUXRATE
MODCOD
Symbol Rate
```

---

# H.265 Reception

The receiver outputs an MPEG Transport Stream.

The H.265 transport stream can then be decoded using FFmpeg / ffplay.

Typical receive path:

```text
DVB-S2 RF
      |
      v
Pluto / Pluto Plus
      |
      v
GNU Radio / gr-dvbs2rx
      |
      v
MPEG Transport Stream
      |
      v
ffplay / FFmpeg
      |
      v
H.265 Live Video
```

The DVB-S2 receiver and H.265 decoder are deliberately kept as separate stages.

This follows the KISS philosophy.

---

# Current H.265 Status

Verified:

```text
Raspberry Pi 5
+ Logitech C920
+ YUYV422
+ libx265 software H.265
+ 960x720
+ 20 fps
+ preset medium
+ MP2 audio
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

Verified:

```text
Raspberry Pi 5
+ GNU Radio DVB-S2 RX
+ H.265 MPEG-TS
+ ffplay
= WORKS
```

Verified:

```text
Orange Pi 3B
+ RK3566
+ RKMPP
+ H.265 hardware encoding
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

The Raspberry Pi 5 software H.265 encoder is therefore not only a theoretical possibility.

It has been demonstrated in actual DVB-S2 transmission.

---

# How this project started

This project did not start with a plan to build a complete H.265 DVB-S2 transceiver.

The original inspiration came from the DVB-S2 loopback test provided by Igor's `gr-dvbs2rx` project.

The original question was very simple:

> "What happens if the transmitter and receiver in the loopback test are separated and connected through a real RF path?"

That experiment worked.

From there the project gradually evolved through:

```text
software loopback
real RF testing
live video transmission
DVB-S2 receiver testing
receiver stability investigation
receiver reacquisition improvements
watchdog implementation
Raspberry Pi 5 integration
Pluto Plus integration
GTK4 GUI development
H.264 experiments
software H.264 encoding
Orange Pi experiments
hardware H.265 encoding
Raspberry Pi 5 software H.265 encoding
```

The DVB-S2 modulation and demodulation technology itself comes from the excellent existing open-source projects on which this system is built.

The purpose of this project is not to reinvent DVB-S2.

Its purpose is to integrate existing open-source DVB-S2 technology into a simple and practical DATV transceiver.

---

# License

This project is licensed under the GNU General Public License version 3 or any later version.

See the `LICENSE` file for the complete license text.

## ライセンス

本プロジェクトはGNU General Public Licenseバージョン3、
またはそれ以降のバージョンの下で提供されます。

ライセンス全文については `LICENSE` ファイルを参照してください。

---

# Copyright

Copyright (C) 2026 Shinji Yamazaki and Kazuichi Shinjoh

## 著作権

Copyright (C) 2026 Shinji Yamazaki and Kazuichi Shinjoh

---

# Credits

## Shinji Yamazaki

- Original project concept
- System architecture
- Hardware testing
- DVB-S2 transmission experiments
- DVB-S2 reception experiments
- Real RF testing
- Raspberry Pi 5 integration
- Pluto Plus integration
- Logitech C920 experiments
- H.264 experiments
- Raspberry Pi 5 H.264 software encoding experiments
- Raspberry Pi 5 H.265 software encoding experiments
- Orange Pi 3B H.265 experiments
- Audio transmission experiments
- Project coordination
- Documentation
- Release preparation

## Kazuichi Shinjoh

- Source-code analysis
- Receiver stabilization
- Receiver reacquisition improvements
- Development and improvement of operational scripts
- Watchdog implementation
- Automatic receiver restart implementation
- GTK4 GUI implementation
- Integration work
- Technical support for standalone operation

This project was made possible through the joint technical work of Shinji Yamazaki and Kazuichi Shinjoh.

---

# クレジット

## 山崎 慎慈

- プロジェクト原案
- システム構成
- 実機試験
- DVB-S2送信実験
- DVB-S2受信実験
- 実RF試験
- Raspberry Pi 5統合
- Pluto Plus統合
- Logitech C920実験
- H.264実験
- Raspberry Pi 5 H.264ソフトウェアエンコード実験
- Raspberry Pi 5 H.265ソフトウェアエンコード実験
- Orange Pi 3B H.265実験
- 音声送信実験
- プロジェクト調整
- ドキュメント作成
- 公開準備

## 真城 和一氏

- ソースコード解析
- 受信機安定化
- 受信再捕捉処理改善
- 運用スクリプト開発および改良
- watchdog実装
- 受信機自動再起動機能実装
- GTK4 GUI実装
- 関連統合作業
- スタンドアロン運用の技術支援

本プロジェクトは山崎慎慈と真城和一氏による共同技術作業によって実現しました。

---

# Current Status

This is an experimental and community-test release.

The transceiver has been demonstrated on the developers' test systems.

Additional testing on different installations is welcome.

Feedback, test reports and bug reports are welcome.

## 現在の状況

これは実験およびコミュニティ試験を目的としたリリースです。

開発者の試験環境では送受信動作を確認しています。

異なる環境での試験報告、
フィードバック、
不具合報告を歓迎します。

---

# Design Policy

This project follows the KISS principle.

```text
Keep It Simple.
```

Another important rule is:

```text
One application
One SDR
One primary task
```

The project does not try to support every possible combination of:

```text
SBC
SDR
webcam
codec
audio interface
operating system
driver
```

Instead:

```text
Build it.
Test it.
Measure it.
Publish the result.
```

---

# DVB-S2 Transmission

The DVB-S2 transmitter operates with:

```text
Pilot ON
```

Pilot OFF transmission is not implemented in the current KISS configuration.

## DVB-S2送信

DVB-S2送信機は、

```text
Pilot ON
```

で動作します。

Pilot OFF送信は現在のKISS構成には実装していません。

---

# DVB-S2 Reception

The receiver supports:

```text
Pilot ON
Pilot OFF
```

Pilot ON is recommended for normal operation.

Pilot OFF reception requires considerably more accurate frequency tuning.

In experimental operation, Pilot OFF reception became increasingly difficult as frequency error increased.

For reliable Pilot OFF reception, keeping the frequency offset within a few tens of Hz is recommended.

Actual performance depends on:

```text
symbol rate
MODCOD
signal level
SDR hardware
oscillator accuracy
frequency stability
```

---

# DVB-S2受信

受信機は、

```text
Pilot ON
Pilot OFF
```

の両方に対応します。

通常運用ではPilot ONを推奨します。

Pilot OFF受信では、
より正確な周波数調整が必要です。

安定したPilot OFF受信のためには、
周波数ずれを数十Hz以内に保つことを推奨します。

実際の性能は、

```text
シンボルレート
MODCOD
信号レベル
SDRハードウェア
発振器精度
周波数安定度
```

などによって変化します。

---

# Main Features

- Raspberry Pi 5 support
- GTK4 transceiver GUI
- GNU Radio DVB-S2 transmission
- GNU Radio DVB-S2 reception
- Pluto Plus support
- Logitech C920 support
- H.265 / HEVC transmission
- Raspberry Pi 5 software H.265 encoding
- FFmpeg / libx265
- H.265 reception
- MP2 audio
- Pilot ON transmission
- Pilot ON reception
- Pilot OFF reception
- Receiver watchdog
- Automatic receiver restart
- Real RF operation

---

# 主な機能

- Raspberry Pi 5対応
- GTK4送受信GUI
- GNU Radio DVB-S2送信
- GNU Radio DVB-S2受信
- Pluto Plus対応
- Logitech C920対応
- H.265 / HEVC送信
- Raspberry Pi 5によるH.265ソフトウェアエンコード
- FFmpeg / libx265
- H.265受信
- MP2音声
- Pilot ON送信
- Pilot ON受信
- Pilot OFF受信
- 受信watchdog
- 受信機自動再起動
- 実RF運用

---

# Symbol Rates

Tested values include:

```text
333 kSym/s
1 MSym/s
1.5 MSym/s
2 MSym/s
```

---

# MODCOD

```text
QPSK 1/4
QPSK 1/2
QPSK 3/4
8PSK 3/5
```

---

# Roll-off

```text
0.20
0.25
0.35
```

---

# Reference DVB-S2 Configuration

A useful starting configuration is:

```text
Symbol Rate : 333 kSym/s
MODCOD      : QPSK 3/4
Pilot       : ON
Roll-off    : 0.20
RX Watchdog : ON
```

H.265 video bitrate and MPEG-TS mux rate must be selected according to the available DVB-S2 transport bitrate.

---

# 基準DVB-S2設定

試験開始時の代表設定：

```text
Symbol Rate : 333 kSym/s
MODCOD      : QPSK 3/4
Pilot       : ON
Roll-off    : 0.20
RX Watchdog : ON
```

H.265映像ビットレートおよびMUXRATEは、
DVB-S2の利用可能な伝送容量に合わせて設定してください。

---

# Reference Hardware

The reference Raspberry Pi 5 H.265 configuration is:

```text
Raspberry Pi 5 2GB
Raspberry Pi OS 64-bit Desktop
Logitech C920
USB audio
Pluto Plus connected via USB
Wired Ethernet
```

For H.265 transmission, the C920's internal H.264 encoder is not used.

The C920 provides YUYV422 video.

The Raspberry Pi 5 performs H.265 compression using libx265.

---

# 基準ハードウェア

Raspberry Pi 5 H.265実験の基準構成：

```text
Raspberry Pi 5 2GB
Raspberry Pi OS 64-bit Desktop
Logitech C920
USB Audio
USB接続Pluto Plus
有線Ethernet
```

H.265送信時には、
C920内部のH.264ハードウェアエンコーダーは使用しません。

C920からYUYV422を取得し、

```text
Raspberry Pi 5
+
FFmpeg
+
libx265
```

によってH.265へソフトウェアエンコードします。

---

# Check Logitech C920 Formats

To inspect the C920 supported formats:

```bash
v4l2-ctl -d /dev/video0 --list-formats-ext
```

A shorter list can be displayed with:

```bash
v4l2-ctl -d /dev/video0 --list-formats
```

Current camera settings can be checked with:

```bash
v4l2-ctl -d /dev/video0 --all
```

FFmpeg can also list formats:

```bash
ffmpeg -f v4l2 -list_formats all -i /dev/video0
```

---

# Logitech C920フォーマット確認

C920が対応する映像形式を確認：

```bash
v4l2-ctl -d /dev/video0 --list-formats-ext
```

簡易表示：

```bash
v4l2-ctl -d /dev/video0 --list-formats
```

現在の設定：

```bash
v4l2-ctl -d /dev/video0 --all
```

FFmpegでも確認できます。

```bash
ffmpeg -f v4l2 -list_formats all -i /dev/video0
```

---

# Raspberry Pi 5 Software H.265 Experimental Result

The most important Raspberry Pi 5 H.265 result is:

```text
Camera       : Logitech C920
Input format : YUYV422
Resolution   : 960x720
Frame rate   : 20 fps
Video codec  : H.265 / HEVC
Encoder      : libx265
Preset       : medium
Tune         : zerolatency
Profile      : main
Pixel format : yuv420p
Audio        : MP2
Platform     : Raspberry Pi 5 2GB
```

This configuration successfully produced live DVB-S2 video.

This proves that a dedicated H.265 hardware encoder is not an absolute requirement for Raspberry Pi 5 DATV experiments.

Software encoding can be practical.

---

# Raspberry Pi 5 H.265ソフトウェアエンコード結果

今回実機確認した代表条件：

```text
カメラ       : Logitech C920
入力形式     : YUYV422
解像度       : 960x720
フレーム率   : 20 fps
映像Codec    : H.265 / HEVC
Encoder      : libx265
Preset       : medium
Tune         : zerolatency
Profile      : main
Pixel Format : yuv420p
Audio        : MP2
Platform     : Raspberry Pi 5 2GB
```

この条件でDVB-S2ライブ映像送信および受像に成功しました。

Raspberry Pi 5には今回使用できるH.265ハードウェアエンコーダーはありません。

それでも、

```text
CPU
+
FFmpeg
+
libx265
```

によるソフトウェアエンコードで実用的なライブ送信が可能でした。

---

# Orange Pi 3B H.265 Hardware Encoding

Orange Pi 3B with RK3566 has also been tested as an H.265 DVB-S2 platform.

The Rockchip VPU can perform H.265 hardware encoding.

Typical path:

```text
Camera
    |
    v
Orange Pi 3B
RK3566
    |
    | Rockchip VPU
    | RKMPP
    | H.265 hardware encoding
    v
MPEG-TS
    |
    v
GNU Radio / gr-dvbs2
    |
    v
Pluto Plus
    |
    v
DVB-S2 RF
```

This provides an interesting comparison with Raspberry Pi 5.

```text
Raspberry Pi 5
H.265 software encode
CPU
```

versus:

```text
Orange Pi 3B
H.265 hardware encode
VPU
```

---

# Hardware H.265 vs Software H.265

## Raspberry Pi 5

Strengths:

```text
Fast CPU
Mature Raspberry Pi OS
Easy GNU Radio installation
Good documentation
Large software ecosystem
```

H.265 method:

```text
FFmpeg
libx265
CPU software encoding
```

## Orange Pi 3B

Strengths:

```text
Low cost
RK3566
Dedicated Rockchip VPU
H.265 hardware encoding
H.265 hardware decoding
```

H.265 method:

```text
FFmpeg Rockchip
RKMPP
VPU hardware encoding
```

Neither method is declared universally superior.

They are simply different engineering solutions.

---

# KISS Design Philosophy

The basic principle is:

```text
Keep It Simple.
```

and:

```text
One application
One SDR
One primary task
```

A simple system reduces:

```text
CPU contention
Memory pressure
I/O complexity
Driver complexity
Debugging difficulty
Maintenance burden
```

A simple system is easier to:

```text
understand
test
debug
modify
port
maintain
```

New hardware can be evaluated without redesigning the entire project.

```text
Test it.
Measure it.
Add code if necessary.
Update the README.
Publish the result.
```

That is enough.

---

# Hardware Is Replaceable

Hardware changes.

Today it may be:

```text
Raspberry Pi 4
Raspberry Pi 5
Orange Pi 3B
Pluto
Pluto Plus
```

Tomorrow it may be something else.

The reusable foundation is:

```text
Linux
GNU Radio
FFmpeg
gr-dvbs2
gr-dvbs2rx
Git
GitHub
Open Source
```

The SBC is replaceable.

The important assets are:

```text
Code
Knowledge
Measurements
Reproducible results
```

Affordable hardware that performs the required job is welcome.

---

# Current Experimental Status

Verified:

```text
Raspberry Pi 5
+ Logitech C920 YUYV422
+ libx265 Software H.265
+ 960x720 / 20 fps
+ preset medium
+ MP2 audio
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

Verified:

```text
Raspberry Pi 5
+ GNU Radio DVB-S2 RX
+ H.265 Live Video
= WORKS
```

Verified:

```text
Orange Pi 3B
+ RK3566 VPU
+ H.265 Hardware Encode
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

Verified:

```text
Raspberry Pi 4
+ GNU Radio DVB-S2 RX
+ 333 kSym/s QPSK 3/4
= WORKS
```

Verified:

```text
Raspberry Pi 4
+ GNU Radio DVB-S2 RX
+ 1 MSym/s 8PSK 3/5
= WORKS
```

The final criterion remains simple:

```text
Result: It works.
```

---

# 現在の実験状況

確認済み：

```text
Raspberry Pi 5
+ Logitech C920 YUYV422
+ libx265 Software H.265
+ 960x720 / 20 fps
+ preset medium
+ MP2 Audio
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

確認済み：

```text
Raspberry Pi 5
+ GNU Radio DVB-S2 RX
+ H.265 Live Video
= WORKS
```

確認済み：

```text
Orange Pi 3B
+ RK3566 VPU
+ H.265 Hardware Encode
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

確認済み：

```text
Raspberry Pi 4
+ GNU Radio DVB-S2 RX
+ 333 kSym/s QPSK 3/4
= WORKS
```

確認済み：

```text
Raspberry Pi 4
+ GNU Radio DVB-S2 RX
+ 1 MSym/s 8PSK 3/5
= WORKS
```

判断基準は単純です。

```text
実機で動いたか。
```

---

# Not Officially Supported

The following configurations are outside the reference KISS appliance configuration:

- Raspberry Pi OS Lite
- Network-connected Pluto Plus
- RTL-SDR
- Other SDR hardware
- Other webcams
- Other USB audio devices
- Wi-Fi operation
- Unverified SBC combinations

Some configurations may work.

However:

> **Working experimentally does not automatically make a configuration officially supported.**

Users are welcome to modify the source code and test other hardware.

---

# 非公式構成

以下は基準KISS構成には含めません。

- Raspberry Pi OS Lite
- ネットワーク接続Pluto Plus
- RTL-SDR
- その他のSDR
- その他のWebカメラ
- その他のUSBオーディオ
- Wi-Fi運用
- 未検証のSBC構成

動作する可能性はあります。

ただし、

> **実験で動作したことと正式サポートは別です。**

自由に変更し、実験してください。

試験結果の報告を歓迎します。

---

# Required Software

- Raspberry Pi OS 64-bit Desktop
- GNU Radio
- gr-dvbs2
- gr-dvbs2rx
- GTK4
- FFmpeg
- libx265
- ffplay
- Python 3
- libiio
- libad9361
- v4l-utils

---

# 必要なソフトウェア

- Raspberry Pi OS 64-bit Desktop
- GNU Radio
- gr-dvbs2
- gr-dvbs2rx
- GTK4
- FFmpeg
- libx265
- ffplay
- Python 3
- libiio
- libad9361
- v4l-utils

---

# Environment Setup

Update the package list:

```bash
sudo apt update
```

Install required packages:

```bash
sudo apt install -y \
build-essential \
cmake \
pkg-config \
git \
wget \
curl \
python3 \
python3-pip \
python3-numpy \
python3-mako \
python3-yaml \
python3-click \
python3-click-plugins \
libboost-all-dev \
libfftw3-dev \
libgmp-dev \
libusb-1.0-0-dev \
libudev-dev \
liborc-0.4-dev \
libspdlog-dev \
doxygen \
graphviz \
libpcap-dev \
libgtk-4-dev \
gnuradio \
gnuradio-dev \
ffmpeg \
v4l-utils
```

Install Pluto / IIO related packages:

```bash
sudo apt install -y \
libiio-dev \
libiio-utils \
python3-libiio \
libad9361-dev
```

Check that libx265 is available:

```bash
ffmpeg -encoders | grep 265
```

Expected encoder:

```text
libx265
```

---

# Build and Install gr-dvbs2

```bash
cd ~

mkdir -p src
cd ~/src

git clone https://github.com/drmpeg/gr-dvbs2.git

cd ~/src/gr-dvbs2

mkdir -p build
cd build

cmake ..
make -j$(nproc)

sudo make install
sudo ldconfig
```

---

# Clone the Transceiver Repository

```bash
cd ~/src

git clone https://github.com/shinji-y-jp/rpi-dvbs2-transceiver-gui.git
```

---

# Build and Install gr-dvbs2rx

```bash
cd ~/src

git clone https://github.com/igorauad/gr-dvbs2rx.git

cd ~/src/gr-dvbs2rx

git clone https://github.com/google/cpu_features.git

git apply ~/src/rpi-dvbs2-transceiver-gui/gr-dvbs2rx_reset_fixes.patch
```

Fix Python binding header hash after applying the patch:

```bash
HEADER="include/gnuradio/dvbs2rx/symbol_sync_cc.h"
BINDING="python/dvbs2rx/bindings/symbol_sync_cc_python.cc"

HASH=$(md5sum "$HEADER" | awk '{print $1}')

sed -i -E \
"s/BINDTOOL_HEADER_FILE_HASH\([0-9a-fA-F]+\)/BINDTOOL_HEADER_FILE_HASH(${HASH})/" \
"$BINDING"
```

Build:

```bash
mkdir -p build
cd build

cmake ..

make -j$(nproc)

sudo make install
sudo ldconfig
```

---

# Build the Transceiver GUI

```bash
cd ~/src/rpi-dvbs2-transceiver-gui

mkdir -p data

chmod +x *.py
chmod +x *.sh

make clean
make
```

Run:

```bash
./app
```

---

# 環境構築

パッケージ一覧を更新：

```bash
sudo apt update
```

必要なパッケージをインストール：

```bash
sudo apt install -y \
build-essential \
cmake \
pkg-config \
git \
wget \
curl \
python3 \
python3-pip \
python3-numpy \
python3-mako \
python3-yaml \
python3-click \
python3-click-plugins \
libboost-all-dev \
libfftw3-dev \
libgmp-dev \
libusb-1.0-0-dev \
libudev-dev \
liborc-0.4-dev \
libspdlog-dev \
doxygen \
graphviz \
libpcap-dev \
libgtk-4-dev \
gnuradio \
gnuradio-dev \
ffmpeg \
v4l-utils
```

Pluto / IIO関連：

```bash
sudo apt install -y \
libiio-dev \
libiio-utils \
python3-libiio \
libad9361-dev
```

libx265確認：

```bash
ffmpeg -encoders | grep 265
```

以下が表示されることを確認します。

```text
libx265
```

---

# gr-dvbs2 のビルド

```bash
cd ~

mkdir -p src
cd ~/src

git clone https://github.com/drmpeg/gr-dvbs2.git

cd ~/src/gr-dvbs2

mkdir -p build
cd build

cmake ..
make -j$(nproc)

sudo make install
sudo ldconfig
```

---

# リポジトリ取得

```bash
cd ~/src

git clone https://github.com/shinji-y-jp/rpi-dvbs2-transceiver-gui.git
```

---

# gr-dvbs2rx のビルド

```bash
cd ~/src

git clone https://github.com/igorauad/gr-dvbs2rx.git

cd ~/src/gr-dvbs2rx

git clone https://github.com/google/cpu_features.git

git apply ~/src/rpi-dvbs2-transceiver-gui/gr-dvbs2rx_reset_fixes.patch
```

Python bindingヘッダーハッシュ修正：

```bash
HEADER="include/gnuradio/dvbs2rx/symbol_sync_cc.h"
BINDING="python/dvbs2rx/bindings/symbol_sync_cc_python.cc"

HASH=$(md5sum "$HEADER" | awk '{print $1}')

sed -i -E \
"s/BINDTOOL_HEADER_FILE_HASH\([0-9a-fA-F]+\)/BINDTOOL_HEADER_FILE_HASH(${HASH})/" \
"$BINDING"
```

ビルド：

```bash
mkdir -p build
cd build

cmake ..

make -j$(nproc)

sudo make install
sudo ldconfig
```

---

# GUI送受信機のビルド

```bash
cd ~/src/rpi-dvbs2-transceiver-gui

mkdir -p data

chmod +x *.py
chmod +x *.sh

make clean
make
```

実行：

```bash
./app
```

---

# Files

## Main Application

- `main4.c`  
  GTK4 transceiver GUI source code.

- `makefile`  
  Builds the GTK4 transceiver GUI.

---

## DVB-S2 Transmitter

- `RF_UDP_dvbs2_tx.grc`  
  GNU Radio Companion DVB-S2 transmitter flowgraph.

- `RF_FIFO_dvbs2_experiment.py`  
  DVB-S2 FIFO transmitter.

- `start_tx.sh`  
  Starts the transmitter.

- `stop_tx.sh`  
  Stops the transmitter.

---

## DVB-S2 Receiver

- `RF_UDP_dvbs2_rx.py`  
  GNU Radio DVB-S2 receiver.

- `RF_UDP_my_dvbs2_rx2_pluto.grc`  
  GNU Radio Companion receiver flowgraph for Pluto.

- `dvbs2rx_rx_hier.grc`  
  Hierarchical DVB-S2 receiver flowgraph.

- `dvbs2_rx_epy_block_0.py`  
  Embedded Python block used by the receiver.

- `start_rx.sh`  
  Starts the receiver.

- `stop_rx.sh`  
  Stops the receiver.

---

## Receiver Stability

- `watchdog_rx.sh`  
  Monitors receiver operation and restarts it when required.

- `check_stall.sh`  
  Checks processing threads and diagnoses receiver stall conditions.

- `gr-dvbs2rx_reset_fixes.patch`  
  Receiver reset and reacquisition fixes for gr-dvbs2rx.

---

## H.265 Experimental Operation

The Raspberry Pi 5 H.265 experiment uses:

```text
Logitech C920
YUYV422
FFmpeg
libx265
MPEG-TS
GNU Radio DVB-S2
Pluto Plus
```

A separate experimental script may be used for H.265 transmission.

Recommended naming:

```text
experiment.sh.h265
```

Representative H.265 settings:

```text
960x720
20 fps
libx265
preset medium
tune zerolatency
main profile
yuv420p
```

---

## Test and Utility Files

- `start_app.sh`  
  Starts the GUI application.

- `udp_relay.py`  
  Relays the received UDP Transport Stream.

- `run_udp_hd_test.sh`  
  Starts transmission, reception, UDP relay and verification processes.

- `stop_test.sh`  
  Stops test processes and removes temporary files.

- `dvbs2_tx_rx_epy_block_0.py`  
  Embedded Python block used by the transmit / receive system.

- `experiment.sh`  
  General experimental operation script.

---

# ファイル

## メインアプリケーション

- `main4.c`  
  GTK4送受信GUI。

- `makefile`  
  GTK4送受信GUIをビルドします。

---

## DVB-S2送信

- `RF_UDP_dvbs2_tx.grc`
- `RF_FIFO_dvbs2_experiment.py`
- `start_tx.sh`
- `stop_tx.sh`

---

## DVB-S2受信

- `RF_UDP_dvbs2_rx.py`
- `RF_UDP_my_dvbs2_rx2_pluto.grc`
- `dvbs2rx_rx_hier.grc`
- `dvbs2_rx_epy_block_0.py`
- `start_rx.sh`
- `stop_rx.sh`

---

## 受信安定化

- `watchdog_rx.sh`
- `check_stall.sh`
- `gr-dvbs2rx_reset_fixes.patch`

---

## H.265実験

Raspberry Pi 5 H.265実験構成：

```text
Logitech C920
YUYV422
FFmpeg
libx265
MPEG-TS
GNU Radio DVB-S2
Pluto Plus
```

H.265用の独立スクリプト名として、

```text
experiment.sh.h265
```

を推奨します。

代表設定：

```text
960x720
20 fps
libx265
preset medium
tune zerolatency
main profile
yuv420p
```

---

# KISS Appliance Setup

The following procedure converts a tested Raspberry Pi 5 installation into a simple appliance-style system.

Reference environment:

```text
Raspberry Pi 5 2GB
Raspberry Pi OS 64-bit Desktop
Official Raspberry Pi 7-inch touchscreen
USB mouse
Pluto Plus USB
Logitech C920
USB audio
Wired Ethernet
```

---

## 1. Update System

```bash
sudo apt update
sudo apt upgrade -y
```

---

## 2. Enable Desktop Auto Login

Run:

```bash
sudo raspi-config
```

Select:

```text
System Options
  -> Boot / Auto Login
  -> Desktop Autologin
```

---

## 3. Check Application Directory

```bash
cd ~/src/rpi-dvbs2-transceiver-gui

pwd
ls -l
```

---

## 4. Create Appliance Startup Script

```bash
cat > ~/start-dvbs2-appliance.sh <<'EOF'
#!/bin/bash

sleep 5

cd "$HOME/src/rpi-dvbs2-transceiver-gui" || exit 1

./app
EOF

chmod +x ~/start-dvbs2-appliance.sh
```

---

## 5. Create Autostart Directory

```bash
mkdir -p ~/.config/autostart
```

---

## 6. Register GUI for Automatic Startup

```bash
cat > ~/.config/autostart/dvbs2-appliance.desktop <<EOF
[Desktop Entry]
Type=Application
Name=DVB-S2 KISS UI
Exec=$HOME/start-dvbs2-appliance.sh
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
```

---

## 7. Check Configuration

```bash
cat ~/start-dvbs2-appliance.sh

cat ~/.config/autostart/dvbs2-appliance.desktop
```

---

## 8. Disable Wi-Fi if Not Required

```bash
sudo rfkill block wifi
```

---

## 9. Disable Bluetooth if Not Required

```bash
sudo rfkill block bluetooth
```

---

## 10. Check Ethernet

```bash
ip addr show
ip route
```

---

## 11. Check Pluto Plus

```bash
iio_info -s
```

---

## 12. Check Logitech C920

```bash
v4l2-ctl --list-devices
```

Check formats:

```bash
v4l2-ctl -d /dev/video0 --list-formats-ext
```

---

## 13. Check USB Audio

```bash
aplay -l
arecord -l
```

---

## 14. Reboot

```bash
sudo reboot
```

After reboot confirm:

```text
Desktop Auto Login
DVB-S2 KISS UI Auto Start
Pluto Plus USB
Logitech C920
USB Audio
Wired Ethernet
```

---

# KISSアプライアンス化

基準環境：

```text
Raspberry Pi 5 2GB
Raspberry Pi OS 64-bit Desktop
Raspberry Pi公式7インチタッチスクリーン
USBマウス
USB Pluto Plus
Logitech C920
USB Audio
有線Ethernet
```

---

## 1. 更新

```bash
sudo apt update
sudo apt upgrade -y
```

---

## 2. Desktop Auto Login

```bash
sudo raspi-config
```

選択：

```text
System Options
  -> Boot / Auto Login
  -> Desktop Autologin
```

---

## 3. アプリ確認

```bash
cd ~/src/rpi-dvbs2-transceiver-gui

pwd
ls -l
```

---

## 4. 起動スクリプト

```bash
cat > ~/start-dvbs2-appliance.sh <<'EOF'
#!/bin/bash

sleep 5

cd "$HOME/src/rpi-dvbs2-transceiver-gui" || exit 1

./app
EOF

chmod +x ~/start-dvbs2-appliance.sh
```

---

## 5. autostartディレクトリ

```bash
mkdir -p ~/.config/autostart
```

---

## 6. 自動起動登録

```bash
cat > ~/.config/autostart/dvbs2-appliance.desktop <<EOF
[Desktop Entry]
Type=Application
Name=DVB-S2 KISS UI
Exec=$HOME/start-dvbs2-appliance.sh
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
```

---

## 7. 設定確認

```bash
cat ~/start-dvbs2-appliance.sh
cat ~/.config/autostart/dvbs2-appliance.desktop
```

---

## 8. Wi-Fi無効化

```bash
sudo rfkill block wifi
```

---

## 9. Bluetooth無効化

```bash
sudo rfkill block bluetooth
```

---

## 10. 有線LAN確認

```bash
ip addr show
ip route
```

---

## 11. Pluto Plus確認

```bash
iio_info -s
```

---

## 12. C920確認

```bash
v4l2-ctl --list-devices
```

フォーマット：

```bash
v4l2-ctl -d /dev/video0 --list-formats-ext
```

---

## 13. USB Audio確認

```bash
aplay -l
arecord -l
```

---

## 14. 再起動

```bash
sudo reboot
```

---

# Golden Master Final Cleanup

Perform these steps only after all tests have passed.

## Clear Shell History

```bash
history -c
rm -f ~/.bash_history
```

## Clean APT Cache

```bash
sudo apt clean
```

## Clean User Cache

```bash
rm -rf ~/.cache/*
```

## Remove SSH Host Keys

```bash
sudo rm -f /etc/ssh/ssh_host_*
```

## Reset machine-id

```bash
sudo truncate -s 0 /etc/machine-id

sudo rm -f /var/lib/dbus/machine-id

sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
```

## Check Disk Usage

```bash
df -h
```

## Shutdown

```bash
sudo poweroff
```

> **DO NOT BOOT THIS SD CARD AGAIN BEFORE CREATING THE DISTRIBUTION IMAGE.**

After shutdown:

```text
1. Remove the SD card.
2. Create the distribution image.
3. Preserve the original Golden Master.
```

---

# Final Notes

The Raspberry Pi 5 H.265 experiment began with a simple question:

```text
Can the Raspberry Pi 5 brute-force H.265 in software?
```

The answer from the real hardware experiment is:

```text
Yes.
```

Not only at very low resolution.

The tested system reached:

```text
960x720
20 fps
libx265
preset medium
MP2 audio
DVB-S2 real-time transmission
```

using:

```text
Raspberry Pi 5 2GB
Logitech C920
Pluto Plus
GNU Radio
FFmpeg
libx265
```

No H.265 hardware encoder was used.

The CPU did the work.

That is exactly the kind of experiment this project exists for.

```text
Result first.
Screenshot next.
Code follows.
```

73,

Shinji Yamazaki
