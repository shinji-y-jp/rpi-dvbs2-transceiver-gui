# Raspberry Pi DVB-S2 Transceiver GUI

A simple DVB-S2 transceiver application for Raspberry Pi 5.

This project provides a GTK4 graphical user interface for starting and
stopping a GNU Radio DVB-S2 software transmitter and receiver.

The system has been developed and tested as a simple KISS
,(Keep It Simple,Stupid) DATV transceiver using Raspberry Pi 5 and Pluto Plus.

The DVB-S2 transmitter operates with Pilot ON.

## License

This project is licensed under the GNU General Public License
version 3 or any later version.

See the `LICENSE` file for the complete license text.

---

## ライセンス

本プロジェクトは、GNU General Public Licenseバージョン3、
またはそれ以降のバージョンの下で提供されます。

ライセンスの全文については、`LICENSE` ファイルを参照してください。

## Copyright

Copyright (C) 2026 Shinji Yamazaki and Kazuichi Shinjoh

## 著作権

Copyright (C) 2026 Shinji Yamazaki and Kazuichi Shinjoh


## Credits

- **Shinji Yamazaki**
  - Original project concept
  - System architecture
  - Hardware testing
  - DVB-S2 transmission and reception experiments
  - Raspberry Pi 5 and Pluto Plus integration
  - Project coordination and release preparation

- **Kazuichi Shinjoh**
  - Source-code analysis
  - Receiver stabilization
  - Development and improvement of operational scripts
  - Watchdog and automatic receiver restart implementation
  - GTK4 GUI implementation and related integration work
  - Technical support for preparing the transceiver as a standalone application

This project was made possible through the joint technical work of
Shinji Yamazaki and Kazuichi Shinjoh.

## クレジット

- **山崎 慎慈**
  - プロジェクトの原案及び方式決定
  - システム構成
  - 実機試験
  - DVB-S2送受信実験
  - Raspberry Pi 5およびPluto Plusの統合
  - プロジェクト調整および公開準備

- **真城 和一氏**
  - ソースコード解析
  - 受信機の安定化
  - 運用スクリプトの開発および改良
  - watchdogと受信機自動再起動機能の実装
  - GTK4 GUIの実装および関連する統合作業
  - スタンドアロン送受信機として公開するための技術支援

本プロジェクトは、山崎慎慈と真城和一氏による共同技術作業によって
実現しました。

## Current status

This is a preliminary release for community testing.

The transceiver works on the author's system, but testing on different
hardware and software environments is required.

Feedback, test reports and bug reports are welcome.
We need the community's help to improve it.

## DVB-S2 Transmission

The DVB-S2 transmitter operates with Pilot ON.

Pilot OFF transmission is not implemented in this project.

## DVB-S2送信

DVB-S2送信機はPilot ONで動作します。

Pilot OFF送信は本プロジェクトでは実装していません。


## Pilot OFF Reception

Pilot ON is recommended for normal operation.

Pilot OFF reception is supported, but frequency tuning is much more critical.

In our tests, reception was possible with a frequency offset of several hundred Hz, but operation became unreliable as the offset increased. An offset of approximately 500 Hz was already close to the practical limit under the tested conditions.

For reliable Pilot OFF reception, the frequency offset should ideally be kept within a few tens of Hz.

Therefore:

- Pilot ON: Recommended for normal and stable operation.
- Pilot OFF: Supported, but requires accurate frequency tuning.
- For Pilot OFF, keeping the frequency offset within a few tens of Hz is recommended for reliable operation.

Actual performance may vary depending on symbol rate, signal level, SDR hardware, oscillator accuracy, and other reception conditions.

## 現在の状況

これはコミュニティによる試験を目的とした予備リリースです。

受信機は作者の環境では動作していますが、異なるハードウェアおよび
ソフトウェア環境での試験が必要です。

フィードバック、試験報告、不具合報告を歓迎します。

## Main features

- Simple GTK4 receiver GUI
- Raspberry Pi 5 support
- GNU Radio based DVB-S2 reception
- PlutoSDR / Pluto+ support
- Symbol rates:
  - 333 kSym/s
  - 1 MSym/s
  - 1.5 MSym/s
  - 2 MSym/s
- MODCOD support:
  - QPSK 1/4
  - QPSK 1/2
  - QPSK 3/4
  - 8PSK 3/5
- Roll-off:
  - 0.20
  - 0.25
  - 0.35

## 主な機能

- シンプルなGTK4受信GUI
- Raspberry Pi 5対応
- GNU RadioによるDVB-S2受信
- PlutoSDR / Pluto+対応
- シンボルレート:
  - 333 kSym/s
  - 1 MSym/s
  - 1.5 MSym/s
  - 2 MSym/s
- MODCOD:
  - QPSK 1/4
  - QPSK 1/2
  - QPSK 3/4
  - 8PSK 3/5
- ロールオフ:
  - 0.20
  - 0.25
  - 0.35

## Supported Hardware

This project follows a KISS (Keep It Simple,Stupid) design philosophy.

The officially supported and tested configuration is limited to:

- Raspberry Pi 5
- Pluto Plus connected by USB
- Logitech C920 with H.264 hardware encoder
- The specific USB audio dongle tested by the developer

Not supported:

- Network-connected Pluto Plus
- Other SDR hardware
- Other webcams
- Software H.264 encoding on Raspberry Pi 5
- Other USB audio devices

Other hardware may work, but it is outside the scope of this project
and is not officially supported.

## 対応ハードウェア

本プロジェクトはKISS（Keep It Simple,Stupid）の設計思想に基づいています。

公式にサポートし、実機試験を行っている構成は以下に限定します。

- Raspberry Pi 5
- USB接続のPluto Plus
- H.264ハードウェアエンコーダー搭載Logitech C920
- 開発者が実機試験した特定のUSBオーディオドングル

以下はサポート対象外です。

- ネットワーク接続のPluto Plus
- その他のSDRハードウェア
- その他のWebカメラ
- Raspberry Pi 5によるH.264ソフトウェアエンコード
- その他のUSBオーディオデバイス

その他のハードウェアでも動作する可能性はありますが、
本プロジェクトの対象範囲外であり、公式にはサポートしません。


## Required software

- Raspberry Pi OS 64-bit
- GNU Radio
- gr-dvbs2rx
- GTK4
- FFmpeg / ffplay
- Python 3

## 必要なソフトウェア

- Raspberry Pi OS 64-bit
- GNU Radio
- gr-dvbs2rx
- GTK4
- FFmpeg / ffplay
- Python 3

## Environment setup

Update the package list and install the required packages:

```bash
sudo apt update

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
gnuradio-dev

sudo apt install -y \
libiio-dev \
libiio-utils \
python3-libiio \
libad9361-dev
```

### Build and install gr-dvbs2

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

### Build and install gr-dvbs2rx

```bash
cd ~/src

git clone https://github.com/igorauad/gr-dvbs2rx.git
git clone https://github.com/shinji-y-jp/rpi-dvbs2-receiver-gui.git

cd ~/src/gr-dvbs2rx

git clone https://github.com/google/cpu_features.git

git apply ~/src/rpi-dvbs2-receiver-gui/gr-dvbs2rx_reset_fixes.patch

# Fix Python binding header hash after applying the patch
HEADER="include/gnuradio/dvbs2rx/symbol_sync_cc.h"
BINDING="python/dvbs2rx/bindings/symbol_sync_cc_python.cc"
HASH=$(md5sum "$HEADER" | awk '{print $1}')
sed -i -E "s/BINDTOOL_HEADER_FILE_HASH\([0-9a-fA-F]+\)/BINDTOOL_HEADER_FILE_HASH(${HASH})/" "$BINDING"

mkdir -p build
cd build

cmake ..
make -j$(nproc)

sudo make install
sudo ldconfig
```

### Clone the receiver repositories

```bash

cd ~/src

git clone https://github.com/shinjiy5984-lgtm/dvbs2-lab.git

```

### Build the receiver GUI

```bash
cd ~/src/rpi-dvbs2-receiver-gui

chmod +x *.py
chmod +x *.sh

make clean
make
```

---

## 環境構築

パッケージ一覧を更新し、必要なパッケージをインストールします。

```bash
sudo apt update

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
gnuradio-dev
```

### gr-dvbs2 のビルドとインストール

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

### gr-dvbs2rx のビルドとインストール

```bash
cd ~/src

git clone https://github.com/igorauad/gr-dvbs2rx.git

cd ~/src/gr-dvbs2rx

git clone https://github.com/google/cpu_features.git

mkdir -p build
cd build

cmake ..
make -j$(nproc)

sudo make install
sudo ldconfig
```

### 受信機リポジトリの取得

```bash
cd ~/src

git clone https://github.com/shinjiy5984-lgtm/dvbs2-lab.git

git clone https://github.com/shinji-y-jp/rpi-dvbs2-receiver-gui.git
```

### GUI受信機のビルド

```bash
cd ~/src/rpi-dvbs2-receiver-gui

chmod +x *.py
chmod +x *.sh

make clean
make
```

## Files

- `main4.c`  
  GTK4 receiver GUI source code

- `RF_UDP_dvbs2_rx.py`  
  GNU Radio DVB-S2 receiver

- `start_app.sh`  
  Starts the GUI application

- `start_rx.sh`  
  Starts the receiver

- `stop_rx.sh`  
  Stops the receiver

- `watchdog_rx.sh`  
  Monitors receiver operation and restarts it when required

- `udp_relay.py`  
  Relays the received UDP transport stream

- `run_udp_hd_test.sh`  
  Starts the 800x480 transmission, reception, UDP relay, and verification processes together

- `check_stall.sh`  
  Checks CPU usage of the processing threads and diagnoses whether `plsync_cc` has entered an infinite search state

- `stop_test.sh`  
  Stops all processes used for the test and removes temporary files

- `dvbs2rx_rx_hier.grc`  
  GNU Radio Companion hierarchical receiver flowgraph

- `dvbs2_rx_epy_block_0.py`  
  Embedded Python block used by the GNU Radio receiver

- `makefile`  
  Builds the GTK4 GUI

## ファイル

- `main4.c`  
  GTK4受信GUIのソースコード

- `RF_UDP_dvbs2_rx.py`  
  GNU Radio DVB-S2受信機

- `start_app.sh`  
  GUIアプリケーションを起動します

- `start_rx.sh`  
  受信機を起動します

- `stop_rx.sh`  
  受信機を停止します

- `watchdog_rx.sh`  
  受信動作を監視し、必要に応じて受信機を再起動します

- `udp_relay.py`  
  受信したUDPトランスポートストリームを中継します

- `run_udp_hd_test.sh`  
  800x480の送信、受信、UDPリレー、および検証処理を一括して起動します

- `check_stall.sh`  
  各処理スレッドのCPU使用率を確認し、`plsync_cc`が無限探索状態へ陥っていないか診断します

- `stop_test.sh`  
  試験に使用した全プロセスを停止し、一時ファイルを削除します

- `dvbs2rx_rx_hier.grc`  
  GNU Radio Companionの階層型受信フローグラフ

- `dvbs2_rx_epy_block_0.py`  
  GNU Radio受信機で使用するEmbedded Python Block

- `makefile`  
  GTK4 GUIをビルドします## Build

```bash
make
