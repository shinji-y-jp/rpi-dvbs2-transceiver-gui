# Raspberry Pi DVB-S2 Transceiver GUI

A simple DVB-S2 transceiver application for Raspberry Pi 5.

This project provides a GTK4 graphical user interface for starting and
stopping a GNU Radio DVB-S2 software transmitter and receiver.

The system has been developed and tested as a simple KISS
(Keep It Simple, Stupid) DATV transceiver using Raspberry Pi 5 and Pluto Plus.

The DVB-S2 transmitter operates with Pilot ON.

## How this project started

This project did not start with a plan to build a complete DVB-S2 transceiver.

The original inspiration came from the DVB-S2 loopback test provided by Igor's gr-dvbs2rx project.

The initial idea was very simple:

> "What happens if the transmitter and receiver in the loopback test are separated and connected through a real RF path?"

That experiment worked.

From there, the system gradually evolved through real RF testing, live video transmission, receiver stability testing, and finally a simple GTK4 user interface.

The DVB-S2 modulation and demodulation technology itself comes from the excellent existing open-source projects on which this system is built.

The purpose of this project is not to reinvent DVB-S2, but to integrate those components into a simple and practical Raspberry Pi 5 DVB-S2 transceiver.

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

## 現在の状況

これはコミュニティによる試験を目的とした予備リリースです。

送受信機は作者の環境では動作していますが、異なるハードウェアおよび
ソフトウェア環境での試験が必要です。

フィードバック、試験報告、不具合報告を歓迎します。

コミュニティの協力によって本プロジェクトを改善していきたいと考えています。

## DVB-S2 Transmission

The DVB-S2 transmitter operates with Pilot ON.

Pilot OFF transmission is not implemented in this project.

## DVB-S2送信

DVB-S2送信機はPilot ONで動作します。

Pilot OFF送信は本プロジェクトでは実装していません。

## Pilot OFF Reception

Pilot ON is recommended for normal reception.

Pilot OFF reception is supported, but frequency tuning is much more critical.

In our tests, reception was possible with a frequency offset of several hundred Hz,
but operation became unreliable as the offset increased.

An offset of approximately 500 Hz was already close to the practical limit
under the tested conditions.

For reliable Pilot OFF reception, the frequency offset should ideally
be kept within a few tens of Hz.

Therefore:

- Pilot ON: Recommended for normal and stable reception.
- Pilot OFF: Supported, but requires accurate frequency tuning.
- For Pilot OFF, keeping the frequency offset within a few tens of Hz is recommended for reliable operation.

Actual performance may vary depending on symbol rate, signal level,
SDR hardware, oscillator accuracy, and other reception conditions.

## Pilot OFF受信

通常の受信ではPilot ONを推奨します。

Pilot OFF受信にも対応していますが、
周波数調整はPilot ONよりもはるかに重要になります。

実験では数百Hz程度の周波数ずれでも受信できましたが、
ずれが大きくなるにつれて動作は不安定になりました。

試験条件では約500 Hzのずれは、
すでに実用上の限界に近い状態でした。

安定したPilot OFF受信のためには、
周波数ずれを数十Hz以内に保つことを推奨します。

したがって、

- Pilot ON：通常の安定受信に推奨
- Pilot OFF：対応しているが、正確な周波数調整が必要
- Pilot OFFでは数十Hz以内の周波数ずれを推奨

実際の性能は、シンボルレート、信号レベル、SDRハードウェア、
発振器精度、およびその他の受信条件によって変化します。

## Main features

- Simple GTK4 transceiver GUI
- Raspberry Pi 5 support
- GNU Radio based DVB-S2 transmission and reception
- Pluto Plus support
- Logitech C920 H.264 hardware encoder support
- USB audio support
- DVB-S2 transmission with Pilot ON
- Pilot ON / Pilot OFF reception
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

- シンプルなGTK4送受信GUI
- Raspberry Pi 5対応
- GNU RadioによるDVB-S2送受信
- Pluto Plus対応
- Logitech C920 H.264ハードウェアエンコーダー対応
- USBオーディオ対応
- DVB-S2送信はPilot ON
- Pilot ON / Pilot OFF受信
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

This project officially supports and has been tested with the following hardware configuration:

- Raspberry Pi 5 2GB
- Raspberry Pi OS 64-bit Desktop (not Lite)
- Official Raspberry Pi 7-inch touchscreen
- Pluto Plus connected via USB only
- Logitech C920 equipped with the H.264 hardware encoder
- USB audio dongle already supported by Langstone

Other hardware configurations are not officially supported.

They may work, but they have not been tested as part of this appliance.

Users are welcome to experiment with other hardware configurations and report their results.

## Not supported:

- Network-connected Pluto Plus
- Other SDR hardware
- Other webcams
- Software H.264 encoding on Raspberry Pi 5
- Other USB audio devices

Other hardware may work, but it is outside the scope of this project
and is not officially supported.

## 対応ハードウェア

本プロジェクトはKISS（Keep It Simple, Stupid）の設計思想に基づいています。

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
- gr-dvbs2
- gr-dvbs2rx
- GTK4
- FFmpeg / ffplay
- Python 3

## 必要なソフトウェア

- Raspberry Pi OS 64-bit
- GNU Radio
- gr-dvbs2
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

### Clone the transceiver repository

```bash
cd ~/src

git clone https://github.com/shinji-y-jp/rpi-dvbs2-transceiver-gui.git
```

### Build and install gr-dvbs2rx

```bash
cd ~/src

git clone https://github.com/igorauad/gr-dvbs2rx.git

cd ~/src/gr-dvbs2rx

git clone https://github.com/google/cpu_features.git

git apply ~/src/rpi-dvbs2-transceiver-gui/gr-dvbs2rx_reset_fixes.patch

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

### Build the transceiver GUI

```bash
cd ~/src/rpi-dvbs2-transceiver-gui
mkdir data
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

sudo apt install -y \
libiio-dev \
libiio-utils \
python3-libiio \
libad9361-dev
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

### 送受信機リポジトリの取得

```bash
cd ~/src

git clone https://github.com/shinji-y-jp/rpi-dvbs2-transceiver-gui.git
```

### gr-dvbs2rx のビルドとインストール

```bash
cd ~/src

git clone https://github.com/igorauad/gr-dvbs2rx.git

cd ~/src/gr-dvbs2rx

git clone https://github.com/google/cpu_features.git

git apply ~/src/rpi-dvbs2-transceiver-gui/gr-dvbs2rx_reset_fixes.patch

# パッチ適用後にPython bindingのヘッダーハッシュを修正
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

### GUI送受信機のビルド

```bash
cd ~/src/rpi-dvbs2-transceiver-gui

chmod +x *.py
chmod +x *.sh

make clean
make
```

## Files

- `main4.c`
  GTK4 transceiver GUI source code

- `RF_UDP_dvbs2_tx.grc`
  GNU Radio Companion DVB-S2 transmitter flowgraph

- `RF_UDP_dvbs2_rx.py`
  GNU Radio DVB-S2 receiver

- `RF_UDP_my_dvbs2_rx2_pluto.grc`
  GNU Radio Companion DVB-S2 receiver flowgraph for Pluto

- `RF_FIFO_dvbs2_experiment.py`
  DVB-S2 experimental transmitter flowgraph

- `start_app.sh`
  Starts the GUI application

- `start_tx.sh`
  Starts the transmitter

- `stop_tx.sh`
  Stops the transmitter

- `start_rx.sh`
  Starts the receiver

- `stop_rx.sh`
  Stops the receiver

- `watchdog_rx.sh`
  Monitors receiver operation and restarts it when required

- `udp_relay.py`
  Relays the received UDP transport stream

- `run_udp_hd_test.sh`
  Starts the transmission, reception, UDP relay, and verification processes used for testing

- `check_stall.sh`
  Checks CPU usage of the processing threads and diagnoses whether `plsync_cc`
  has entered an infinite search state

- `stop_test.sh`
  Stops all processes used for the test and removes temporary files

- `dvbs2rx_rx_hier.grc`
  GNU Radio Companion hierarchical receiver flowgraph

- `dvbs2_rx_epy_block_0.py`
  Embedded Python block used by the GNU Radio receiver

- `dvbs2_tx_rx_epy_block_0.py`
  Embedded Python block used by the DVB-S2 transmit/receive system

- `gr-dvbs2rx_reset_fixes.patch`
  Receiver reset and reacquisition fixes for gr-dvbs2rx

- `experiment.sh`
  Experimental DVB-S2 operation script

- `makefile`
  Builds the GTK4 transceiver GUI

## ファイル

- `main4.c`
  GTK4送受信GUIのソースコード

- `RF_UDP_dvbs2_tx.grc`
  GNU Radio Companion DVB-S2送信フローグラフ

- `RF_UDP_dvbs2_rx.py`
  GNU Radio DVB-S2受信機

- `RF_UDP_my_dvbs2_rx2_pluto.grc`
  Pluto用GNU Radio Companion DVB-S2受信フローグラフ

- `RF_FIFO_dvbs2_experiment.py`
  DVB-S2実験用送信フローグラフ

- `start_app.sh`
  GUIアプリケーションを起動します

- `start_tx.sh`
  送信機を起動します

- `stop_tx.sh`
  送信機を停止します

- `start_rx.sh`
  受信機を起動します

- `stop_rx.sh`
  受信機を停止します

- `watchdog_rx.sh`
  受信動作を監視し、必要に応じて受信機を再起動します

- `udp_relay.py`
  受信したUDPトランスポートストリームを中継します

- `run_udp_hd_test.sh`
  試験用の送信、受信、UDPリレー、および検証処理を一括して起動します

- `check_stall.sh`
  各処理スレッドのCPU使用率を確認し、
  `plsync_cc`が無限探索状態へ陥っていないか診断します

- `stop_test.sh`
  試験に使用した全プロセスを停止し、一時ファイルを削除します

- `dvbs2rx_rx_hier.grc`
  GNU Radio Companionの階層型受信フローグラフ

- `dvbs2_rx_epy_block_0.py`
  GNU Radio受信機で使用するEmbedded Python Block

- `dvbs2_tx_rx_epy_block_0.py`
  DVB-S2送受信システムで使用するEmbedded Python Block

- `gr-dvbs2rx_reset_fixes.patch`
  gr-dvbs2rxの受信再捕捉改善用パッチ

- `experiment.sh`
  DVB-S2実験用スクリプト

- `makefile`
  GTK4送受信GUIをビルドします
  
## Sample Image Transmission

The files `ume.JPG` and `experiment.sh.ume` are included as a simple
DVB-S2 still-image transmission example.

Rename:

```bash
experiment.sh.ume
```

to:

```bash
experiment.sh
```

and run the script.

The transmitter will send the JPEG image named:

```text
ume.JPG
```

The included `ume.JPG` is a photograph of Japanese plum blossoms
taken by Shinji Yamazaki.

In Japan, plum blossoms are one of the beautiful signs that early spring
is approaching.

### Using Your Own Image

You can replace the sample photograph with your own JPEG image.

Any JPEG image can be used as long as the file is named:

```text
ume.JPG
```

Simply rename your JPEG image to `ume.JPG`, place it in the same directory,
and run `experiment.sh`.

This provides a simple way to transmit your own still image using the
DVB-S2 transmitter.

## サンプル画像送信

`ume.JPG` と `experiment.sh.ume` は、DVB-S2による静止画送信を
試すための簡単なサンプルとして収録しています。

`experiment.sh.ume` を

```text
experiment.sh
```

へ名前変更してスクリプトを実行すると、

```text
ume.JPG
```

という名前のJPEG画像が送信されます。

収録されている `ume.JPG` は、山崎慎慈が撮影した梅の花の写真です。

日本では、梅の花は早春の訪れを告げる美しいものの一つとして
古くから親しまれています。

### 自分の画像を送信する場合

サンプルの梅の写真を、自分で用意したJPEG画像へ置き換えることもできます。

JPEG画像のファイル名を、

```text
ume.JPG
```

にしてください。

自分のJPEG画像を `ume.JPG` へ名前変更し、同じディレクトリへ置いて
`experiment.sh` を実行すれば、その画像を送信できます。

これにより、自分の静止画をDVB-S2で簡単に送信できます。

## Build

```bash
make
./app
```
