<img width="2720" height="1080" alt="20260821_07h47m46s_grim" src="https://github.com/user-attachments/assets/fdcab640-5e55-4708-9a29-28ccea2d7b8e" />
<img width="2720" height="1080" alt="20260823_11h09m40s_grim" src="https://github.com/user-attachments/assets/f5d482a1-900f-45de-b3e9-8342b6dfc8ee" />
<img width="2720" height="1080" alt="20260823_11h09m46s_grim" src="https://github.com/user-attachments/assets/12c6d2bd-54e6-4ca7-9fdd-60e9471055f0" />
<img width="1920" height="1080" alt="20260827_16h24m52s_grim" src="https://github.com/user-attachments/assets/9a856d98-e809-43ee-ad7e-d3843c1638db" />



# Raspberry Pi 5 KISS DVB-S2 Transceiver

A simple DVB-S2 transmitter and receiver for Raspberry Pi 5 using GNU Radio and Pluto Plus.

This project provides a GTK4 graphical user interface for starting and stopping a GNU Radio based DVB-S2 software transmitter and receiver.

The system has been developed and tested as a simple KISS:

> Keep It Simple.

DATV transceiver using Raspberry Pi 5 and Pluto Plus.

The goal is not to support every SDR, webcam, audio device, operating system, or possible configuration.

The goal is to provide a simple and reproducible DVB-S2 transceiver using a known working hardware and software configuration.

The DVB-S2 transmitter operates with **Pilot ON**.

---

## How this project started

This project did not start with a plan to build a complete DVB-S2 transceiver.

The original inspiration came from the DVB-S2 loopback test provided by Igor's `gr-dvbs2rx` project.

The initial idea was very simple:

> "What happens if the transmitter and receiver in the loopback test are separated and connected through a real RF path?"

That experiment worked.

From there, the system gradually evolved through:

- real RF testing
- live video transmission
- DVB-S2 receiver testing
- receiver stability investigation
- receiver reacquisition improvements
- watchdog implementation
- Raspberry Pi 5 integration
- Pluto Plus integration
- GTK4 GUI development
- appliance-style operation

The DVB-S2 modulation and demodulation technology itself comes from the excellent existing open-source projects on which this system is built.

The purpose of this project is not to reinvent DVB-S2.

Its purpose is to integrate existing open-source DVB-S2 technology into a simple and practical Raspberry Pi 5 DATV transceiver.

---

# License

This project is licensed under the GNU General Public License version 3 or any later version.

See the `LICENSE` file for the complete license text.

## ライセンス

本プロジェクトはGNU General Public Licenseバージョン3、
またはそれ以降のバージョンの下で提供されます。

ライセンスの全文については `LICENSE` ファイルを参照してください。

---

# Copyright

Copyright (C) 2026 Shinji Yamazaki and Kazuichi Shinjoh

## 著作権

Copyright (C) 2026 Shinji Yamazaki and Kazuichi Shinjoh

---

# Credits

## Shinji Yamazaki

- Original project concept
- System architecture and design decisions
- Hardware testing
- DVB-S2 transmission and reception experiments
- Real RF testing
- Raspberry Pi 5 and Pluto Plus integration
- Live video transmission experiments
- Low-cost webcam software H.264 encoding experiments
- Audio transmission experiments
- Project coordination
- Release preparation

## Kazuichi Shinjoh

- Source-code analysis
- Receiver stabilization
- Receiver reacquisition improvements
- Development and improvement of operational scripts
- Watchdog and automatic receiver restart implementation
- GTK4 GUI implementation
- Integration work
- Technical support for preparing the transceiver as a standalone application

This project was made possible through the joint technical work of
Shinji Yamazaki and Kazuichi Shinjoh.

## クレジット

### 山崎 慎慈

- プロジェクトの原案および方式決定
- システム構成
- 実機試験
- DVB-S2送受信実験
- 実RF試験
- Raspberry Pi 5およびPluto Plusの統合
- ライブ映像送信実験
- 安価なWebカメラを使用したソフトウェアH.264エンコード実験
- 音声送信実験
- プロジェクト調整
- 公開準備

### 真城 和一氏

- ソースコード解析
- 受信機の安定化
- 受信再捕捉処理の改善
- 運用スクリプトの開発および改良
- watchdogと受信機自動再起動機能の実装
- GTK4 GUIの実装
- 関連する統合作業
- スタンドアロン送受信機として公開するための技術支援

本プロジェクトは、山崎慎慈と真城和一氏による共同技術作業によって
実現しました。

---

# Current Status

This is a **preliminary release for community testing**.

The transceiver has been demonstrated on the developers' test systems,
but additional testing on different installations is required.

Feedback, test reports, and bug reports are welcome.

Community testing will help improve the project.

## 現在の状況

これはコミュニティによる試験を目的とした**予備リリース**です。

開発者の試験環境では送受信動作を確認していますが、
異なるインストール環境での追加試験が必要です。

フィードバック、試験報告、不具合報告を歓迎します。

コミュニティによる実機試験が、本プロジェクトの改善につながります。

---

# Design Policy

This project follows the KISS principle.

The officially supported configuration is intentionally limited.

A configuration may be technically possible and may even have been experimentally demonstrated without becoming part of the officially supported appliance configuration.

This distinction is important:

- **Officially supported** means part of the defined KISS appliance configuration.
- **Experimentally verified** means demonstrated in real operation, but not part of the officially supported appliance configuration.
- **Not tested** means no claim of operation is made by this project.

---

# DVB-S2 Transmission

The DVB-S2 transmitter operates with:

> **Pilot ON**

Pilot OFF transmission is not implemented in this project.

## DVB-S2送信

DVB-S2送信機は、

> **Pilot ON**

で動作します。

Pilot OFF送信は本プロジェクトでは実装していません。

---

# DVB-S2 Reception

The receiver supports both:

- Pilot ON
- Pilot OFF

Pilot ON is recommended for normal operation.

## Pilot OFF Reception

Pilot OFF reception is supported, but frequency tuning is considerably more critical than with Pilot ON.

In our tests, reception was possible with a frequency offset of several hundred Hz, but operation became increasingly unreliable as the offset increased.

Under the tested conditions, an offset of approximately 500 Hz was already close to the practical limit.

For reliable Pilot OFF reception, the frequency offset should ideally be kept within a few tens of Hz.

Therefore:

- **Pilot ON:** Recommended for normal and stable reception.
- **Pilot OFF:** Supported, but requires accurate frequency tuning.
- **Pilot OFF reliable operation:** Keeping the frequency offset within a few tens of Hz is recommended.

Actual performance may vary depending on:

- symbol rate
- MODCOD
- signal level
- SDR hardware
- oscillator accuracy
- frequency stability
- other reception conditions

## Pilot OFF受信

受信機はPilot ONおよびPilot OFFの両方に対応しています。

通常の受信では **Pilot ONを推奨**します。

Pilot OFF受信ではPilot ONよりも正確な周波数調整が必要です。

実験では数百Hz程度の周波数ずれでも受信できましたが、
ずれが大きくなるにつれて動作は不安定になりました。

試験条件では約500 Hzのずれは、
すでに実用上の限界に近い状態でした。

安定したPilot OFF受信のためには、
周波数ずれを数十Hz以内に保つことを推奨します。

したがって、

- **Pilot ON:** 通常の安定受信に推奨
- **Pilot OFF:** 対応しているが正確な周波数調整が必要
- **Pilot OFFの安定運用:** 数十Hz以内の周波数ずれを推奨

実際の性能は、シンボルレート、MODCOD、信号レベル、
SDRハードウェア、発振器精度、周波数安定度、
およびその他の受信条件によって変化します。

---

# Main Features

- Simple GTK4 transceiver GUI
- Raspberry Pi 5 support
- GNU Radio based DVB-S2 transmission
- GNU Radio based DVB-S2 reception
- Pluto Plus support
- Logitech C920 H.264 hardware encoder support
- USB audio support
- Pilot ON transmission
- Pilot ON reception
- Pilot OFF reception
- Receiver watchdog
- Receiver automatic restart capability
- Real RF operation

## Symbol Rates

- 333 kSym/s
- 1 MSym/s
- 1.5 MSym/s
- 2 MSym/s

## MODCOD

- QPSK 1/4
- QPSK 1/2
- QPSK 3/4
- 8PSK 3/5

## Roll-off

- 0.20
- 0.25
- 0.35

---

# 主な機能

- シンプルなGTK4送受信GUI
- Raspberry Pi 5対応
- GNU RadioによるDVB-S2送信
- GNU RadioによるDVB-S2受信
- Pluto Plus対応
- Logitech C920 H.264ハードウェアエンコーダー対応
- USBオーディオ対応
- Pilot ON送信
- Pilot ON受信
- Pilot OFF受信
- 受信watchdog
- 受信機自動再起動機能
- 実RF運用

## シンボルレート

- 333 kSym/s
- 1 MSym/s
- 1.5 MSym/s
- 2 MSym/s

## MODCOD

- QPSK 1/4
- QPSK 1/2
- QPSK 3/4
- 8PSK 3/5

## ロールオフ

- 0.20
- 0.25
- 0.35

---

# Officially Supported Hardware

The official KISS appliance configuration is:

- Raspberry Pi 5 2GB
- Raspberry Pi OS 64-bit Desktop
- Official Raspberry Pi 7-inch touchscreen
- USB mouse
- Pluto Plus connected via USB
- Logitech C920 equipped with the H.264 hardware encoder
- USB audio dongle already supported by Langstone
- Wired Ethernet connection

This is the reference hardware configuration used for the appliance.

Other configurations may work, but they are not part of the officially supported configuration.

---

# 公式対応ハードウェア

本プロジェクトはKISS設計思想に基づき、
公式サポート構成を意図的に限定しています。

基準となる構成は以下です。

- Raspberry Pi 5 2GB
- Raspberry Pi OS 64-bit Desktop
- Raspberry Pi公式7インチタッチスクリーン
- USBマウス
- USB接続Pluto Plus
- H.264ハードウェアエンコーダー搭載Logitech C920
- Langstoneですでに使用実績のあるUSBオーディオドングル
- 有線Ethernet

その他の構成でも動作する可能性がありますが、
公式サポート構成には含めません。

---

# Experimental and Verified Configurations

The following configurations are **not part of the officially supported KISS appliance**, but have been demonstrated experimentally in real operation.

The basic design philosophy remains simple:

**KISS — Keep It Simple.**

The purpose of these experiments is not to support every possible hardware configuration.

The purpose is to verify practical, inexpensive and reproducible DATV configurations using real hardware.

---

## Low-Cost Webcam with Raspberry Pi 5 Software H.264 Encoding

A low-cost USB webcam without an H.264 hardware encoder has been successfully used for live DVB-S2 transmission.

The webcam provides uncompressed YUYV video.

The processing path is:

```text
Low-cost USB webcam
        |
        | YUYV
        v
Raspberry Pi 5
        |
        | FFmpeg / libx264
        | Software H.264 encoding
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

A working experimental script is provided as:

```text
experiment.sh.lowcostwebcam-with-noencoder
```

The tested FFmpeg configuration includes:

```text
Camera input : YUYV422
Input size   : 400x300
Input rate   : 20 fps
Output size  : 800x480
Encoder      : libx264
Preset       : ultrafast
Tune         : zerolatency
Profile      : baseline
Audio        : OFF
```

This demonstrates that DVB-S2 live video transmission does not fundamentally require a webcam with a built-in H.264 encoder.

The Raspberry Pi 5 can perform the H.264 encoding in software.

However, this configuration remains experimental and is **not officially supported as part of the KISS appliance**.

---

## Experimental Mono Audio Transmission

A second experimentally verified configuration adds mono audio to the low-cost webcam software-encoding system.

A working script is provided as:

```text
experiment.sh.lowcost-SM1M-mono-audio
```

The tested signal path is:

```text
Low-cost webcam
      |
      | YUYV
      v
Raspberry Pi 5
      |
      +---- libx264 software H.264 video encoding
      |
USB audio input
      |
      +---- MP2 mono audio encoding
      |
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

The tested audio configuration is:

```text
Codec       : MP2
Bitrate     : 24 kbit/s
Sample rate : 22050 Hz
Channels    : 1 (mono)
ALSA input  : hw:2,0
```

The default operating condition of this script is:

```text
Symbol Rate : 1 MSym/s
MODCOD      : QPSK 3/4
Pilot       : ON
```

Video and mono audio transmission have both been confirmed in actual operation.

This configuration is an experimental demonstration and is not part of the officially supported KISS appliance configuration.

---

# Raspberry Pi 4 DVB-S2 Receiver Test

The GNU Radio DVB-S2 receiver has now also been successfully tested on a Raspberry Pi 4.

Test system:

```text
Raspberry Pi 4
Raspberry Pi OS 64-bit Desktop
GNU Radio DVB-S2 receiver
Pluto / Pluto Plus
2.4 GHz
```

Confirmed reception:

```text
333 kSym/s
QPSK 3/4
```

and:

```text
1 MSym/s
8PSK 3/5
```

Stable live video reception was confirmed.

At 1 MSym/s / 8PSK 3/5, the Raspberry Pi 4 still showed practical CPU and memory headroom.

Observed memory usage was approximately:

```text
1.2 - 1.3 GB
```

on a Raspberry Pi 4 with approximately 4 GB RAM.

An operating temperature of approximately:

```text
53.5 degrees C
```

was observed with a small heatsink.

The important result is that a Raspberry Pi 5 is **not required for DVB-S2 reception at these tested conditions**.

The Raspberry Pi 4 remains a practical platform for this GNU Radio DVB-S2 receiver.

Result:

```text
Raspberry Pi 4 RX: It works.
```

The result was also shared with the BATC community together with screenshots showing actual live reception and htop measurements.

---

# Planned Raspberry Pi 4 H.264 Hardware Encoding Experiment

The Raspberry Pi 4 is also interesting because it provides hardware-assisted H.264 video encoding capability.

The Raspberry Pi 5 has substantially more CPU performance, but for DATV raw CPU performance is not the only consideration.

Dedicated video hardware can be very useful.

A future Raspberry Pi 4 transmission experiment will therefore use:

```text
USB webcam
        |
        | YUYV
        v
Raspberry Pi 4
        |
        | H.264 hardware encoding
        v
MPEG Transport Stream
        |
        v
GNU Radio / gr-dvbs2
        |
        v
Pluto / Pluto Plus
        |
        v
DVB-S2 RF
```

The first tests will use relatively low symbol rates.

For example:

```text
333 kSym/s
QPSK
Pilot ON
```

The purpose is to determine how far a slower CPU can go when video encoding is handled by dedicated hardware.

This experiment has **not yet been completed**.

No transmission result is claimed at this stage.

---

# Planned Orange Pi 3B H.265 Experiment

An Orange Pi 3B with a Rockchip RK3566 SoC will be evaluated as a low-cost H.265 / HEVC DVB-S2 transmitter.

The Orange Pi 3B under test is a 2 GB model.

The main reason for selecting this board is not raw CPU performance.

The main interest is the Rockchip VPU and its H.265 hardware video processing capability.

The planned processing path is:

```text
USB webcam
        |
        | YUYV
        v
Orange Pi 3B
RK3566
        |
        | Rockchip VPU
        | H.265 / HEVC hardware encoding
        | FFmpeg / RKMPP
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

The receiving side will use the Raspberry Pi 4 system that has already been successfully tested.

The planned end-to-end configuration is:

```text
TX : Orange Pi 3B
     RK3566
     H.265 hardware encoding
     GNU Radio DVB-S2

             |
             | DVB-S2 RF
             v

RX : Raspberry Pi 4
     GNU Radio DVB-S2 receiver
     H.265 decoding
     Live video
```

This keeps transmission and reception completely separate.

One SBC performs one primary task.

This follows the KISS design philosophy.

---

## Orange Pi 3B Test Procedure

The Orange Pi experiment will be performed step by step.

The first step is simply to confirm the operating system and architecture.

```bash
uname -m
```

Expected result:

```text
aarch64
```

Next, Rockchip MPP / RKMPP support will be investigated.

A possible source is:

```text
https://github.com/rockchip-linux/mpp
```

A Rockchip-compatible FFmpeg implementation will also be evaluated.

One candidate is:

```text
https://github.com/nyanmisaka/ffmpeg-rockchip
```

The exact build procedure will be determined after the actual Orange Pi 3B hardware arrives and the installed kernel and operating system are confirmed.

The FFmpeg encoder list will then be checked with:

```bash
ffmpeg -encoders | grep rkmpp
```

The desired H.265 hardware encoder is expected to appear as something similar to:

```text
hevc_rkmpp
```

H.264 hardware encoding may also appear as:

```text
h264_rkmpp
```

---

## H.265 Hardware Encoding Test

Before GNU Radio is added, H.265 hardware encoding will be tested independently.

The first test will use a low-resolution USB webcam.

Possible initial conditions:

```text
Resolution : 400x300 or 640x480
Frame rate : 20 fps
Codec      : H.265 / HEVC
Encoder    : Rockchip VPU / RKMPP
```

The important measurements will include:

```text
CPU load
Memory usage
VPU operation
Low-bitrate image quality
Latency
Encoder stability
Long-term operation
```

The purpose is to confirm that the H.265 encoding load is handled by the VPU instead of consuming large amounts of CPU time.

---

## GNU Radio DVB-S2 Transmission Test

After H.265 hardware encoding has been confirmed, the next stage will be:

```text
H.265 / HEVC
      |
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

The first DVB-S2 test will use:

```text
333 kSym/s
```

If successful, higher symbol rates will be tested.

Possible progression:

```text
333 kSym/s
      |
      v
1 MSym/s
      |
      v
2 MSym/s
```

The practical upper limit will be determined experimentally.

No assumption will be made before real measurements are available.

---

## Final H.265 End-to-End Test

The final experiment will be:

```text
USB webcam
    |
    v
Orange Pi 3B
    |
    | RK3566 VPU
    | H.265 hardware encoding
    v
MPEG Transport Stream
    |
    v
GNU Radio DVB-S2 TX
    |
    v
Pluto Plus
    |
    | RF
    v
Pluto / Pluto Plus
    |
    v
Raspberry Pi 4
    |
    | GNU Radio DVB-S2 RX
    v
H.265 decode
    |
    v
Live video
```

Only after this complete path has been confirmed in actual operation will H.265 DVB-S2 transmission be considered successfully demonstrated.

Until then:

```text
Orange Pi 3B H.265 DVB-S2 TX
= NOT YET VERIFIED
```

If successful, a separate experimental script will be added.

Tentative name:

```text
experiment.sh.h265
```

The exact implementation and filename may change after real hardware testing.

---

# KISS Design Philosophy

The project intentionally does not attempt to support every possible SBC, SDR, webcam, operating system and codec.

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

Transmission and reception do not need to run simultaneously on the same SBC.

This reduces:

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

If a new SBC works:

```text
Test it.
Measure it.
Add a script if necessary.
Update the README.
Publish the result.
```

That is enough.

---

# Hardware Is Replaceable

The hardware platform will change over time.

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
Git
GitHub
Open Source
```

The SBC is replaceable.

The software, knowledge and experimental results can remain.

Affordable hardware that performs the required job is welcome.

---

# Current Experimental Status

Verified:

```text
Raspberry Pi 5
+ low-cost YUYV webcam
+ libx264 software H.264
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

Verified:

```text
Raspberry Pi 5
+ low-cost webcam
+ mono MP2 audio
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

Not yet tested:

```text
Raspberry Pi 4
+ H.264 hardware encoding
+ GNU Radio DVB-S2 TX
= NOT YET TESTED
```

Not yet tested:

```text
Orange Pi 3B
+ RK3566 VPU
+ H.265 hardware encoding
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= NOT YET TESTED
```

Planned end-to-end experiment:

```text
Orange Pi 3B
H.265 DVB-S2 TX
        |
        | RF
        v
Raspberry Pi 4
DVB-S2 RX
        |
        v
H.265 Live Video
```

The final criterion remains simple:

```text
Result: It works.
```

---

# 実験的に動作確認した構成

以下は正式なKISSアプライアンス構成には含まれませんが、
**実機で動作確認した構成**です。

基本思想は変わりません。

**KISS — Keep It Simple.**

すべてのハードウェアへ対応することを目的にはしていません。

安価で、実際に動き、再現可能なDATV構成を実機で確認することを目的としています。

---

## 安価なWebカメラ＋Raspberry Pi 5ソフトウェアH.264エンコード

H.264ハードウェアエンコーダーを搭載していない安価なUSB Webカメラを使用し、
DVB-S2ライブ映像送信に成功しています。

WebカメラからYUYV映像を取得し、
Raspberry Pi 5上のFFmpeg / libx264でH.264へソフトウェアエンコードします。

処理経路：

```text
安価なUSB Webカメラ
        |
        | YUYV
        v
Raspberry Pi 5
        |
        | FFmpeg / libx264
        | H.264ソフトウェアエンコード
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

動作確認済み実験スクリプト：

```text
experiment.sh.lowcostwebcam-with-noencoder
```

代表的なFFmpeg設定：

```text
カメラ入力 : YUYV422
入力解像度 : 400x300
フレーム率 : 20 fps
出力解像度 : 800x480
エンコーダ : libx264
Preset     : ultrafast
Tune       : zerolatency
Profile    : baseline
音声       : OFF
```

この実験によって、
DVB-S2ライブ映像送信にH.264ハードウェアエンコーダー内蔵Webカメラが
必須ではないことを確認しました。

Raspberry Pi 5によるH.264ソフトウェアエンコードでも実際に送信できます。

ただし、これは実験構成であり、
正式なKISSアプライアンスのサポート対象には含めません。

---

## 安価なWebカメラ＋モノラル音声

さらに、Pi 5によるH.264ソフトウェアエンコード映像へ
モノラル音声を追加した構成でも動作を確認しました。

動作確認済みスクリプト：

```text
experiment.sh.lowcost-SM1M-mono-audio
```

音声設定：

```text
Codec       : MP2
Bitrate     : 24 kbit/s
Sample rate : 22050 Hz
Channels    : 1 mono
ALSA input  : hw:2,0
```

デフォルト送信条件：

```text
Symbol Rate : 1 MSym/s
MODCOD      : QPSK 3/4
Pilot       : ON
```

映像およびモノラル音声の両方について、
実際の送受信動作を確認しています。

この構成も正式サポートではなく、
実験的な動作確認例として提供します。

---

# Raspberry Pi 4 DVB-S2受像

GNU Radio DVB-S2受信機を、

```text
Raspberry Pi 4
Raspberry Pi OS 64-bit Desktop
```

でも実機確認しました。

確認済み条件：

```text
333 kSym/s
QPSK 3/4
2.4 GHz
```

さらに、

```text
1 MSym/s
8PSK 3/5
2.4 GHz
```

でも受像に成功しました。

1 MSym/s / 8PSK 3/5でも、
安定したライブ映像受像を確認しています。

メモリ使用量は概ね、

```text
約1.2～1.3 GB
```

でした。

CPUにも実用上の余裕があります。

小型ヒートシンク使用時には、

```text
約53.5℃
```

という温度を確認しました。

この結果から、今回確認した条件では、

**DVB-S2受像にRaspberry Pi 5は必須ではありません。**

Raspberry Pi 4でも十分実用的に受像できます。

Result:

```text
Raspberry Pi 4 RX: It works.
```

この結果は、
実受像画面およびhtopのスクリーンショットとともに
BATCコミュニティへ投稿しました。

---

# Raspberry Pi 4 H.264ハードウェアエンコード実験予定

Raspberry Pi 4にはH.264映像処理用の専用ハードウェアがあります。

Pi 5はCPU性能では大幅に高速ですが、
DATVではCPU性能だけが重要ではありません。

専用映像ハードウェアを利用することで、
遅いCPUでも十分な性能を得られる可能性があります。

予定している送信経路：

```text
USB Webカメラ
        |
        | YUYV
        v
Raspberry Pi 4
        |
        | H.264ハードウェアエンコード
        v
MPEG Transport Stream
        |
        v
GNU Radio / gr-dvbs2
        |
        v
Pluto / Pluto Plus
        |
        v
DVB-S2 RF
```

最初は、

```text
333 kSym/s
QPSK
Pilot ON
```

程度から確認します。

目的はPi 5とCPU性能を競うことではありません。

```text
遅いCPU
+
専用VPU
```

で、どこまでDATVを実現できるかを見る実験です。

この送信実験はまだ未確認です。

---

# Orange Pi 3B + H.265 実験予定

Orange Pi 3B / RK3566を、
安価なH.265 / HEVC DVB-S2送信機として評価する予定です。

使用するOrange Pi 3Bは2GBモデルです。

このボードを選んだ最大の理由は、
CPU性能そのものではありません。

狙いは、

**RK3566 VPUによるH.265 / HEVCハードウェアエンコード**

です。

予定している処理経路：

```text
USB Webカメラ
        |
        | YUYV
        v
Orange Pi 3B
RK3566
        |
        | Rockchip VPU
        | H.265 / HEVCハードウェアエンコード
        | FFmpeg / RKMPP
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

受信側には、
すでに動作確認できたRaspberry Pi 4を使用します。

予定構成：

```text
送信 : Orange Pi 3B
       RK3566
       H.265 Hardware Encode
       GNU Radio DVB-S2

               |
               | DVB-S2 RF
               v

受信 : Raspberry Pi 4
       GNU Radio DVB-S2
       H.265 Decode
       Live Video
```

送受信を同じSBCで同時には行いません。

```text
Orange Pi 3B = 送信
Raspberry Pi 4 = 受信
```

1台1役です。

KISSです。

---

## Orange Pi 3B 到着後の確認

まず64bit Linuxを確認します。

```bash
uname -m
```

期待する結果：

```text
aarch64
```

次にRockchip MPP / RKMPPを確認します。

候補：

```text
https://github.com/rockchip-linux/mpp
```

さらにRockchip対応FFmpegを評価します。

候補：

```text
https://github.com/nyanmisaka/ffmpeg-rockchip
```

正確なビルド手順は、
Orange Pi 3B実機到着後にOSおよびカーネルを確認して決定します。

エンコーダーは、

```bash
ffmpeg -encoders | grep rkmpp
```

で確認します。

H.265 / HEVCでは、

```text
hevc_rkmpp
```

のようなエンコーダーが利用できることを期待しています。

H.264では、

```text
h264_rkmpp
```

が利用可能な場合もあります。

---

## H.265単独試験

最初からGNU Radioまで全部動かしません。

まず、

```text
USB Webカメラ
        |
        v
RK3566 VPU
        |
        v
H.265
```

だけを確認します。

初期条件候補：

```text
解像度     : 400x300 または 640x480
フレーム率 : 20 fps
Codec      : H.265 / HEVC
Encoder    : Rockchip VPU / RKMPP
```

確認項目：

```text
CPU負荷
メモリ使用量
VPU動作
低ビットレート画質
遅延
安定性
長時間動作
```

狙いは、
H.265圧縮処理をCPUではなくVPUへ任せることです。

---

## GNU Radio DVB-S2送信

H.265ハードウェアエンコードが安定した後、

```text
H.265
↓
MPEG-TS
↓
GNU Radio / gr-dvbs2
↓
Pluto Plus
↓
DVB-S2 RF
```

へ進みます。

最初は、

```text
333 kSym/s
```

から試します。

成功すれば、

```text
333 kSym/s
↓
1 MSym/s
↓
2 MSym/s
```

と上げます。

実用上限は実測で判断します。

到着前に上限を決めつけることはしません。

---

## 最終H.265送受信実験

最終的な実験構成：

```text
USB Webカメラ
    |
    v
Orange Pi 3B
    |
    | RK3566 VPU
    | H.265 Hardware Encode
    v
MPEG Transport Stream
    |
    v
GNU Radio DVB-S2 TX
    |
    v
Pluto Plus
    |
    | RF
    v
Pluto / Pluto Plus
    |
    v
Raspberry Pi 4
    |
    | GNU Radio DVB-S2 RX
    v
H.265 Decode
    |
    v
Live Video
```

ここまで実際に通って初めて、

```text
Result: It works.
```

とします。

現時点では、

```text
Orange Pi 3B
+ H.265 Hardware Encode
+ GNU Radio DVB-S2 TX
= NOT YET VERIFIED
```

です。

Orange Pi 3Bはまだ到着していないため、
現時点でH.265 DVB-S2送信成功とはしません。

---

## H.265実験用スクリプト

実験が成功した場合は、

```text
experiment.sh.h265
```

のような独立した実験用スクリプトを追加する予定です。

正式なKISS構成へ無理に統合せず、
必要な機能だけを追加します。

---

# KISS

基本は、

```text
Keep It Simple.
```

です。

さらに、

```text
1 application
1 SDR
1 primary task
```

を基本とします。

送信と受信を一台へ全部詰め込みません。

これによって、

```text
CPU競合
メモリ不足
I/O競合
ドライバ依存
デバッグの複雑化
保守負担
```

を減らします。

簡単なシステムは、

```text
理解しやすい
試験しやすい
故障箇所を切り分けやすい
移植しやすい
変更しやすい
保守しやすい
```

という利点があります。

新しいSBCが出た場合も、

```text
実機で試す
測る
必要ならスクリプトを追加する
READMEへ追記する
結果を公開する
```

それで十分です。

---

# Hardware Is Replaceable

ハードウェアは変わります。

現在は、

```text
Raspberry Pi 4
Raspberry Pi 5
Orange Pi 3B
Pluto
Pluto Plus
```

を使っています。

将来は別のSBCやSDRになるかもしれません。

しかし、

```text
Linux
GNU Radio
FFmpeg
gr-dvbs2
Git
GitHub
Open Source
```

というソフトウェア資産は残ります。

SBCそのものは交換可能です。

重要なのは、

```text
Code
Knowledge
Measurements
Reproducible results
```

です。

安価で、
使えて、
面白いハードウェアなら、

Welcome.

---

# 現在の実験状況

確認済み：

```text
Raspberry Pi 5
+ 安価なYUYV Webカメラ
+ libx264 Software H.264
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= WORKS
```

確認済み：

```text
Raspberry Pi 5
+ 安価なWebカメラ
+ MP2 Mono Audio
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

未確認：

```text
Raspberry Pi 4
+ H.264 Hardware Encode
+ GNU Radio DVB-S2 TX
= NOT YET TESTED
```

未確認：

```text
Orange Pi 3B
+ RK3566 VPU
+ H.265 Hardware Encode
+ GNU Radio DVB-S2 TX
+ Pluto Plus
= NOT YET VERIFIED
```

最終目標：

```text
Orange Pi 3B
H.265 DVB-S2 TX
        |
        | RF
        v
Raspberry Pi 4
DVB-S2 RX
        |
        v
H.265 Live Video
```

実機で確認するまでは成功とはしません。

```text
Result first.
Screenshot next.
Code follows.
```

73,

Shinji
---

# Not Officially Supported

The following configurations are outside the official KISS appliance configuration:

- Raspberry Pi OS Lite
- Network-connected Pluto Plus
- RTL-SDR
- Other SDR hardware
- Other webcams
- Logitech C920 without the H.264 hardware encoder
- Raspberry Pi 5 software H.264 encoding
- Other USB audio devices
- Wi-Fi operation

Some of these configurations may work.

In particular, Raspberry Pi 5 software H.264 encoding with a low-cost webcam has already been experimentally demonstrated as described above.

However:

> **Working experimentally does not automatically make a configuration officially supported.**

Users are welcome to modify the source code, test other hardware, and report their results.

---

# 非公式構成

以下は正式なKISSアプライアンス構成には含まれません。

- Raspberry Pi OS Lite
- ネットワーク接続Pluto Plus
- RTL-SDR
- その他のSDR
- その他のWebカメラ
- H.264ハードウェアエンコーダー非搭載C920
- Raspberry Pi 5によるH.264ソフトウェアエンコード
- その他のUSBオーディオデバイス
- Wi-Fi運用

このうち一部については動作する可能性があります。

特に、安価なWebカメラとRaspberry Pi 5による
H.264ソフトウェアエンコードについては、
前述のとおり実際に動作確認済みです。

ただし、

> **実験で動作したことと、正式サポートすることは別です。**

他のハードウェアを使用したい場合は、
自由にソースコードを変更し、実験してください。

試験結果の報告を歓迎します。

---

# Reference DVB-S2 Configuration

The recommended default operating configuration is:

```text
Symbol Rate : 333 kSym/s
MODCOD      : QPSK 3/4
Pilot       : ON
Roll-off    : 0.20
RX Watchdog : ON
```

This configuration is intended as the normal starting point for operation and testing.

---

# 基準DVB-S2設定

通常運用および試験の開始点として推奨する設定は以下です。

```text
Symbol Rate : 333 kSym/s
MODCOD      : QPSK 3/4
Pilot       : ON
Roll-off    : 0.20
RX Watchdog : ON
```

---

# Required Software

- Raspberry Pi OS 64-bit Desktop
- GNU Radio
- gr-dvbs2
- gr-dvbs2rx
- GTK4
- FFmpeg
- ffplay
- Python 3
- libiio
- libad9361

---

# 必要なソフトウェア

- Raspberry Pi OS 64-bit Desktop
- GNU Radio
- gr-dvbs2
- gr-dvbs2rx
- GTK4
- FFmpeg
- ffplay
- Python 3
- libiio
- libad9361

---

# Environment Setup

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

---

## Build and Install gr-dvbs2

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

## Clone the Transceiver Repository

```bash
cd ~/src

git clone https://github.com/shinji-y-jp/rpi-dvbs2-transceiver-gui.git
```

---

## Build and Install gr-dvbs2rx

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

sed -i -E \
"s/BINDTOOL_HEADER_FILE_HASH\([0-9a-fA-F]+\)/BINDTOOL_HEADER_FILE_HASH(${HASH})/" \
"$BINDING"

mkdir -p build
cd build

cmake ..
make -j$(nproc)

sudo make install
sudo ldconfig
```

---

## Build the Transceiver GUI

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

---

## gr-dvbs2 のビルドとインストール

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

## 送受信機リポジトリの取得

```bash
cd ~/src

git clone https://github.com/shinji-y-jp/rpi-dvbs2-transceiver-gui.git
```

---

## gr-dvbs2rx のビルドとインストール

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

sed -i -E \
"s/BINDTOOL_HEADER_FILE_HASH\([0-9a-fA-F]+\)/BINDTOOL_HEADER_FILE_HASH(${HASH})/" \
"$BINDING"

mkdir -p build
cd build

cmake ..
make -j$(nproc)

sudo make install
sudo ldconfig
```

---

## GUI送受信機のビルド

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

## DVB-S2 Transmitter

- `RF_UDP_dvbs2_tx.grc`  
  GNU Radio Companion DVB-S2 transmitter flowgraph.

- `RF_FIFO_dvbs2_experiment.py`  
  DVB-S2 experimental FIFO transmitter flowgraph.

- `start_tx.sh`  
  Starts the transmitter.

- `stop_tx.sh`  
  Stops the transmitter.

## DVB-S2 Receiver

- `RF_UDP_dvbs2_rx.py`  
  GNU Radio DVB-S2 receiver.

- `RF_UDP_my_dvbs2_rx2_pluto.grc`  
  GNU Radio Companion DVB-S2 receiver flowgraph for Pluto.

- `dvbs2rx_rx_hier.grc`  
  GNU Radio Companion hierarchical receiver flowgraph.

- `dvbs2_rx_epy_block_0.py`  
  Embedded Python block used by the GNU Radio receiver.

- `start_rx.sh`  
  Starts the receiver.

- `stop_rx.sh`  
  Stops the receiver.

## Receiver Stability

- `watchdog_rx.sh`  
  Monitors receiver operation and restarts it when required.

- `check_stall.sh`  
  Checks CPU usage of the processing threads and diagnoses whether `plsync_cc`
  has entered an infinite search state.

- `gr-dvbs2rx_reset_fixes.patch`  
  Receiver reset and reacquisition fixes for `gr-dvbs2rx`.

## Test and Utility Files

- `start_app.sh`  
  Starts the GUI application.

- `udp_relay.py`  
  Relays the received UDP Transport Stream.

- `run_udp_hd_test.sh`  
  Starts the transmission, reception, UDP relay, and verification processes used for testing.

- `stop_test.sh`  
  Stops all processes used for testing and removes temporary files.

- `dvbs2_tx_rx_epy_block_0.py`  
  Embedded Python block used by the DVB-S2 transmit/receive system.

- `experiment.sh`  
  General DVB-S2 experimental operation script.

## Experimental Low-Cost Webcam Tests

- `experiment.sh.lowcostwebcam-with-noencoder`  
  Tested video-only DVB-S2 transmission using a low-cost YUYV webcam and Raspberry Pi 5 software H.264 encoding.

- `experiment.sh.lowcost-SM1M-mono-audio`  
  Tested DVB-S2 transmission using a low-cost webcam, Raspberry Pi 5 software H.264 encoding, and MP2 mono audio.

## Still Image Example

- `ume.JPG`  
  Sample photograph used for DVB-S2 still-image transmission.

- `experiment.sh.ume`  
  Sample still-image transmission script.

---

# ファイル

## メインアプリケーション

- `main4.c`  
  GTK4送受信GUIのソースコード。

- `makefile`  
  GTK4送受信GUIをビルドします。

## DVB-S2送信機

- `RF_UDP_dvbs2_tx.grc`  
  GNU Radio Companion DVB-S2送信フローグラフ。

- `RF_FIFO_dvbs2_experiment.py`  
  DVB-S2実験用FIFO送信フローグラフ。

- `start_tx.sh`  
  送信機を起動します。

- `stop_tx.sh`  
  送信機を停止します。

## DVB-S2受信機

- `RF_UDP_dvbs2_rx.py`  
  GNU Radio DVB-S2受信機。

- `RF_UDP_my_dvbs2_rx2_pluto.grc`  
  Pluto用GNU Radio Companion DVB-S2受信フローグラフ。

- `dvbs2rx_rx_hier.grc`  
  GNU Radio Companion階層型受信フローグラフ。

- `dvbs2_rx_epy_block_0.py`  
  GNU Radio受信機で使用するEmbedded Python Block。

- `start_rx.sh`  
  受信機を起動します。

- `stop_rx.sh`  
  受信機を停止します。

## 受信安定化関連

- `watchdog_rx.sh`  
  受信動作を監視し、必要に応じて受信機を再起動します。

- `check_stall.sh`  
  各処理スレッドのCPU使用率を確認し、
  `plsync_cc`が無限探索状態へ陥っていないか診断します。

- `gr-dvbs2rx_reset_fixes.patch`  
  `gr-dvbs2rx`の受信再捕捉改善用パッチ。

## 試験およびユーティリティ

- `start_app.sh`  
  GUIアプリケーションを起動します。

- `udp_relay.py`  
  受信したUDP Transport Streamを中継します。

- `run_udp_hd_test.sh`  
  試験用の送信、受信、UDPリレー、
  および検証処理を一括して起動します。

- `stop_test.sh`  
  試験に使用した全プロセスを停止し、
  一時ファイルを削除します。

- `dvbs2_tx_rx_epy_block_0.py`  
  DVB-S2送受信システムで使用するEmbedded Python Block。

- `experiment.sh`  
  DVB-S2実験用スクリプト。

## 安価Webカメラ実験

- `experiment.sh.lowcostwebcam-with-noencoder`  
  安価なYUYV WebカメラとRaspberry Pi 5ソフトウェアH.264エンコードを使用した、
  映像のみのDVB-S2送信動作確認済みスクリプト。

- `experiment.sh.lowcost-SM1M-mono-audio`  
  安価なWebカメラ、Raspberry Pi 5ソフトウェアH.264エンコード、
  MP2モノラル音声を使用したDVB-S2送信動作確認済みスクリプト。

## 静止画サンプル

- `ume.JPG`  
  DVB-S2静止画送信に使用するサンプル写真。

- `experiment.sh.ume`  
  静止画送信用サンプルスクリプト。

---

# Sample Image Transmission

The files:

```text
ume.JPG
experiment.sh.ume
```

are included as a simple DVB-S2 still-image transmission example.

Rename:

```text
experiment.sh.ume
```

to:

```text
experiment.sh
```

and run the script.

The transmitter will send the JPEG image named:

```text
ume.JPG
```

The included `ume.JPG` is a photograph of Japanese plum blossoms taken by Shinji Yamazaki.

In Japan, plum blossoms are traditionally regarded as one of the beautiful signs that early spring is approaching.

## Using Your Own Image

You can replace the sample photograph with your own JPEG image.

Rename your JPEG image to:

```text
ume.JPG
```

place it in the same directory, and run:

```bash
./experiment.sh
```

This provides a simple way to transmit your own still image using the DVB-S2 transmitter.

---

# サンプル画像送信

`ume.JPG` と `experiment.sh.ume` は、
DVB-S2による静止画送信を試すための簡単なサンプルです。

`experiment.sh.ume` を、

```text
experiment.sh
```

へ名前変更して実行すると、

```text
ume.JPG
```

という名前のJPEG画像が送信されます。

収録している `ume.JPG` は山崎慎慈が撮影した梅の花です。

日本では梅の花は、
早春の訪れを告げる美しいものの一つとして古くから親しまれています。

## 自分の画像を送信する場合

自分のJPEG画像を、

```text
ume.JPG
```

へ名前変更して同じディレクトリへ置き、

```bash
./experiment.sh
```

を実行してください。

これにより、自分の静止画をDVB-S2で簡単に送信できます。

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
Logitech C920 with H.264 hardware encoder
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

Exit without rebooting yet.

---

## 3. Check the DVB-S2 Application

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

cd /home/pi/src/rpi-dvbs2-transceiver-gui || exit 1

./app
EOF

chmod +x ~/start-dvbs2-appliance.sh
```

---

## 5. Create Desktop Autostart Directory

```bash
mkdir -p ~/.config/autostart
```

---

## 6. Register DVB-S2 GUI for Automatic Startup

```bash
cat > ~/.config/autostart/dvbs2-appliance.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=DVB-S2 KISS UI
Exec=/home/pi/start-dvbs2-appliance.sh
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
```

---

## 7. Check Autostart Configuration

```bash
cat ~/start-dvbs2-appliance.sh

cat ~/.config/autostart/dvbs2-appliance.desktop
```

---

## 8. Disable Wi-Fi

```bash
sudo rfkill block wifi
```

---

## 9. Disable Bluetooth if Not Required

```bash
sudo rfkill block bluetooth
```

---

## 10. Check Wired Ethernet

```bash
ip addr show

ip route
```

---

## 11. Check Pluto Plus USB

```bash
iio_info -s
```

---

## 12. Check Logitech C920

```bash
v4l2-ctl --list-devices
```

---

## 13. Check USB Audio

```bash
aplay -l

arecord -l
```

---

## 14. Reboot and Test Appliance Startup

```bash
sudo reboot
```

After reboot, confirm:

```text
Desktop Auto Login
DVB-S2 KISS UI Auto Start
Pluto Plus USB
Logitech C920
USB Audio
Wired Ethernet
```

Then test the reference configuration:

```text
Symbol Rate : 333 kSym/s
MODCOD      : QPSK 1/2
Pilot       : ON
Roll-off    : 0.20
Watchdog    : ON
```

Verify both TX and RX.

---

# Golden Master Final Cleanup

Perform the following steps **only after all appliance tests have passed**.

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

## Shutdown the Golden Master

```bash
sudo poweroff
```

> **DO NOT BOOT THIS SD CARD AGAIN BEFORE CREATING THE DISTRIBUTION IMAGE.**

After shutdown:

1. Remove the SD card.
2. Create the distribution image from the SD card.
3. Preserve the original Golden Master.

---

# KISSアプライアンス化

以下は、試験済みRaspberry Pi 5環境を
単純なアプライアンスとして使用するための手順です。

基準環境：

```text
Raspberry Pi 5 2GB
Raspberry Pi OS 64-bit Desktop
Raspberry Pi公式7インチタッチスクリーン
USBマウス
USB接続Pluto Plus
H.264ハードウェアエンコーダー搭載Logitech C920
USBオーディオ
有線Ethernet
```

---

## 1. システム更新

```bash
sudo apt update
sudo apt upgrade -y
```

---

## 2. Desktop Auto Loginを有効化

```bash
sudo raspi-config
```

以下を選択します。

```text
System Options
  -> Boot / Auto Login
  -> Desktop Autologin
```

この時点では再起動しません。

---

## 3. DVB-S2アプリケーション確認

```bash
cd ~/src/rpi-dvbs2-transceiver-gui

pwd
ls -l
```

---

## 4. アプライアンス起動スクリプト作成

```bash
cat > ~/start-dvbs2-appliance.sh <<'EOF'
#!/bin/bash

sleep 5

cd /home/pi/src/rpi-dvbs2-transceiver-gui || exit 1

./app
EOF

chmod +x ~/start-dvbs2-appliance.sh
```

---

## 5. Desktop autostartディレクトリ作成

```bash
mkdir -p ~/.config/autostart
```

---

## 6. DVB-S2 GUI自動起動登録

```bash
cat > ~/.config/autostart/dvbs2-appliance.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=DVB-S2 KISS UI
Exec=/home/pi/start-dvbs2-appliance.sh
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
```

---

## 7. 自動起動設定確認

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

## 9. 不要な場合はBluetooth無効化

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

## 11. Pluto Plus USB確認

```bash
iio_info -s
```

---

## 12. Logitech C920確認

```bash
v4l2-ctl --list-devices
```

---

## 13. USBオーディオ確認

```bash
aplay -l

arecord -l
```

---

## 14. 再起動およびアプライアンス動作確認

```bash
sudo reboot
```

再起動後、以下を確認します。

```text
Desktop Auto Login
DVB-S2 KISS UI Auto Start
Pluto Plus USB
Logitech C920
USB Audio
Wired Ethernet
```

基準設定：

```text
Symbol Rate : 333 kSym/s
MODCOD      : QPSK 1/2
Pilot       : ON
Roll-off    : 0.20
Watchdog    : ON
```

TXおよびRXの両方を確認します。

---

# Golden Master Final Cleanup

以下は**すべてのアプライアンス試験が完了した後だけ**実行してください。

## シェル履歴削除

```bash
history -c
rm -f ~/.bash_history
```

## APTキャッシュ削除

```bash
sudo apt clean
```

## ユーザーキャッシュ削除

```bash
rm -rf ~/.cache/*
```

## SSHホストキー削除

```bash
sudo rm -f /etc/ssh/ssh_host_*
```

## machine-id初期化

```bash
sudo truncate -s 0 /etc/machine-id

sudo rm -f /var/lib/dbus/machine-id

sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
```

## ディスク使用量確認

```bash
df -h
```

## Golden Masterをシャットダウン

```bash
sudo poweroff
```

