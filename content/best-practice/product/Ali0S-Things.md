---
title: "AliOS Things 利用ガイド"
description: "AlibabaのIOT専用OS、AliOS Things の使い方と開発例を紹介します。"
date: 2020-02-01T12:30:18+08:00
weight: 30
draft: false
---

Tags ： AlibabaCloud AliOS-Things IOT

---

## 目的

Alibaba Cloud IoT IoTオペレーティングシステム（別名AliOS Things）は、Alibaba CloudのIoT分野向けの拡張性の高いIoTオペレーティングシステムです。 AliOS Thingsは、極端なパフォーマンス、最小限の開発、クラウド統合、豊富なコンポーネント、セキュリティ保護などの主要な機能を備えたクラウド統合IoTインフラストラクチャの構築に取り組んでいます。 AliOS Thingsは、Alibaba Cloud Linkプラットフォームに接続されたさまざまなデバイスをサポートしており、スマートホーム、スマートシティ、産業、新しい旅行などの分野で広く使用できます。

本書はAliOS Things 関連の知識や AliOS Thingsを使ってIOT Platformと繋がる方法を紹介させてください。

本ガイドの全体的な流れは下記の通りです。

| セクション         | Topic                       | 説明                                     |
| ------------------ |:--------------------------- |:---------------------------------------- |
| 前提知識           | AliOS と AliOS things    | AliOS と AliOS things の関係の紹介                     |
| -                  | AliOS things　と IOT Platform    | AliOS things　と IOT Platform の関係        |
| 基本構成           |  基本特徴             | AliOS things 基本特徴を紹介     |
| -           | アーキテクチャ              | AliOS things アーキテクチャを紹介           |
| -            | 関連ハードウェア          | 関連ハードウェアと開発Board紹介 |
| -            | 開発ツール     | 開発ツールAliOS Things Studio   |
| 開発サンプル           |  AliOSの開発事例          | AliOS使ってAlibabaCloudと繋がる事例を紹介     |


## 前提知識
本ガイドを理解するために、下記の前提知識が必要になります。

### 1.AliOS と ALIOS things の関係

AliOS Thingsは、AliOSファミリーに属するIoT指向の高度にスケーラブルなIoTオペレーティングシステムです。 AliOS Thingsは、限られた電力とリソース、接続されたソケットSoCを備えたMCU向けに設計されており、IoTデバイスに非常に適しています。


### 2.AliOS things　と IOT Platform の関係

AliOS thingsを実装されたデバイスはIOT PlatformのSDK（Linkkit SDK）を実装不要で、簡単にIOT Platformへの接続が可能です。

もしデバイスはAliOS thingsを実装してない場合は、Linkkit SDKの実装でIOT Platformへの接続も可能です。ただし、Linkkit SDKとデバイス既存OSへの適合性によって、一部ハードウェア関連のドライバー部分はお客様自身で実装する必要があります。

## 基本構成

### 1.基本特徴

- 豊かな生態
AliOS Thingsは、認定された80以上のハードウェアプラットフォームと100以上のセンサーサポートを提供します。

- 高カスタマイズ性
オンラインでコンポーネントの組み合わせを選択できる。

- 安全統合
Alibaba Cloud IoTセキュリティサービスのデバイス側機能をネイティブに統合して、IoTデバイスの安全な操作を保護します。

- IoTプロトコル
Alink、MQTT、Http / Https、Coap、LwM2M、LoRaWANなど、さまざまなIoTプロトコルコンポーネントのサポートをユーザーに提供します。

- 便利な開発ツール
編集、コンパイル、およびデバッグを統合する開発ツールをサポートし、包括的な開発リンクツールをユーザーに提供します。

- SALソケット抽象化コンポーネント
AIoTのMCU外部通信モジュールシナリオに適した標準のネットワークソケット抽象化コンポーネントを提供します。異なる通信モジュールの接続の違いからユーザーを保護し、開発をより効率的にするため。

- OTAオンラインアップグレード
ユーザーに、ピンポンアップグレード、圧縮アップグレード、差分アップグレード、セキュリティアップグレードなど、複数のデバイス側のアップグレード方法を提供します。

### 2.AliOS things アーキテクチャ

AliOS Thingsのアーキテクチャは、階層型アーキテクチャとコンポーネント化されたアーキテクチャの両方に適用できます。下から上に、AliOS Thingsに含まれるもの：

- ボードサポートパッケージ（BSP）：SoCベンダーによって主に開発および保守されています
- ハードウェアアブストラクションレイヤー（HAL）：WiFiやUARTなど
- カーネル：Rhinoリアルタイムオペレーティングシステムカーネル、Yloop、VFS、KVストレージを含む
- プロトコルスタック：TCP / IPプロトコルスタック（LwIP）、uMeshネットワークプロトコルスタックを含む
- セキュリティ：セキュアトランスポートレイヤープロトコル（TLS）、トラステッドサービスフレームワーク（TFS）、トラステッドオペレーティング環境（TEE）
- AOS API：アプリケーションソフトウェアとミドルウェアのAPIを提供します
- ミドルウェア：一般的なIoTコンポーネントとAlibabaの付加価値サービスミドルウェアが含まれています
- サンプルアプリケーション：Aliの自己開発サンプルコード、および完全なテストに合格したアプリケーション（Alinkappなど）


すべてのモジュールはコンポーネントに編成されており、各コンポーネントには独自の.mkファイルがあります。これは、他のコンポーネントとの依存関係を記述するために使用され、アプリケーション開発者が必要に応じて選択するのに便利です。

![deploy](https://camo.githubusercontent.com/23557640f98638b76db16d163a35d36ff33c0d10/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f544231664b514d69687249384b4a6a7930467058586235685658612d323333302d313239322e706e67)

### 3.関連ハードウェアと開発Board紹介

- AliOS Things Starter Kit
スターターキットは、AliOS Thingsに合わせて開発された開発ボードで、ボードレベルセンサー、LCDスクリーン（240 * 240）、オーディオ、オンボードWiFiモジュールなど、豊富なオンボードリソースを提供します。
![](https://img.alicdn.com/tfs/TB1_KoTiFmWBuNjSspdXXbugXXa-3704-2422.jpg)
GUIサンプル
![](https://img.alicdn.com/tfs/TB17EnugqmWBuNjy1XaXXXCbXXa-484-387.gif)
詳細紹介：http://aliosthings.io/#/zh-cn/starterkit

- AliOS Things Developer Kit

Developer Kitは、AliOS Thingsが作成した公式のハイエンド開発ボードで、スターターキットよりも豊富なリソースを提供します。
センサーに関しては、慣性航法加速度計およびジャイロスコープに加えて、磁力計、気圧計、温度および湿度センサー、赤外線センサー、近接光センサーなどの多数の環境センシングデバイスが提供され、さまざまなタイプのIoTビジネスシナリオを提供できます。クラウド統合ソリューションの検証。
![](https://img.alicdn.com/tfs/TB122RCtntYBeNjy1XdXXXXyVXa-2373-3121.png)
詳細紹介：http://aliosthings.io/#/zh-cn/developerkit

- サポートモジュール：
  - 慶科（EMW3060）
![](https://img.alicdn.com/tfs/TB13M4zceOSBuNjy0FdXXbDnVXa-1200-761.png)
EMW3060は、上海Qingke（MXCHIP）が発売した費用対効果の高い組み込みW-Fiモジュールで、ARM9、WLAN MAC /ベースバンド/ RFと高度に統合され、最高周波数は120MHzです。

  - 楽鑫(ESP-WROOM-32)
![](https://img.alicdn.com/tfs/TB1zrdLch9YBuNjy0FfXXXIsVXa-595-800.png)
乐鑫の最先端のSoCに基づいたESP-WROOM-32モジュールは、高性能で豊富な周辺機器を備え、Wi-FiとBluetooth機能を統合し、高度なIoTアプリケーションに高度に統合されたソリューションを提供します。

- そのたDiscovery kit
Development board STM32 B-L475E-IOT01A
詳細について、 [Introduction of STM32](http://www.st.com/content/st_com/en/products/evaluation-tools/product-evaluation-tools/mcu-eval-tools/stm32-mcu-eval-tools/stm32-mcu-discovery-kits/b-l475e-iot01a.html)
![](https://camo.githubusercontent.com/c1e015357611579c5ef0a75145afa71257f6d685/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f5442314a364b4c6d5a4c4a384b4a6a7930466e58586346447058612d333936382d323937362e6a7067)

AliOSThings対応済みhardware一覧は下記リンクを参照してください：
http://aliosthings.io/#/zh-cn/hardware

### 4.開発ツールAliOS Things Studio

AliOS Studioは、vscodeに基づいた一連の開発環境であり、windows、linux、macOSをサポートしています。 AliOS Studioには次の機能があります：

- 優れた開発体験とシンプルな操作インターフェース
- AliOS Thingsアプリケーション開発のサポート
- コード補完、インデックス作成、ヒントなど
- AliOS Thingsのコンパイル/ダウンロード/デバッグ
- 複数の開発ボードに適応
- シリアルツール、TSL変換ツールなど

#### インストール
- ダウンロードしてインストール Visual Studio Code
- 以下に示すように、vscodeを開き、AliOS Studioプラグインをインストールします
![deploy](https://camo.githubusercontent.com/1c0d3cbfe721c4246b8964ac586ca03a70c464fc/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f5442315f746f35674d6f514d654a6a7930467058586354787058612d323838302d313830302e706e67)
- aos-cubeインストール
AliOS Studioはaos-cubeに依存しています.aos-cubeを手動でインストールする場合は、システム環境のセットアップを参照してください。同時に、AliOS Studioは、以下に示すようにaos-cubeのワンクリックインストールもサポートしています：
![deploy](https://camo.githubusercontent.com/aa47d46f4033f11e5effe8d77920f9608a6a74fa/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f54423175644538645f5a6d7831566a535a464758586178325858612d313134302d3832302e6769662377696474683d)

#### 使用

AliOS Studioの主な機能は、vscodeの下のツールバーに集中しており、左から右への小さなアイコンがアプリケーションプロジェクトを作成しています。
![](https://camo.githubusercontent.com/442b59c2b502e3f6fdcc68655561ed6190cf9715/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f5442316d65507269454831674b306a535a5379585858746c7058612d3939382d37362e6a7067)

左側のhelloworld @ developerkitはコンパイルターゲットで、形式はアプリケーション名@ターゲットボード名のルールに従っています。クリックして、アプリケーションとターゲットボードを順番に選択します。

- Build
![](https://camo.githubusercontent.com/6a669b8de1c4e5124c6e5127bc75dd41ef0e22c3/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f544231625578724c7748714b31526a535a4667585861374a5858612d313134302d3832302e6769662377696474683d)

- Upload
開発ボードとコンピューターをUSBマイクロケーブルで接続し、下のツールバーの稲妻アイコンをクリックして、ファームウェアの書き込みを完了します：
![](https://camo.githubusercontent.com/c5eeaf68688a6a1aaddf7ef8dddd5e9fa489e152/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f544231697138724c7232704b31526a535a46735858614e6c5858612d313134302d3832302e6769662377696474683d)

- Monitor
USBマイクロワイヤを介して、送信パネルと電源を接続します。
最初の接続は、書き込みソケットのデバイス名と波の速度を示すことを示します。

- Debug
 F5キーを押すか、メニューバー[デバッグ]> [デバッグの開始]をクリックして、デバッグモードに入ります。
 ![](https://camo.githubusercontent.com/e3a6d7225b9ef4c165dea0475a2aad09c1b48a4e/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f544231634e52534c786a614b31526a535a4b7a58585856775858612d313134302d3832302e6769662377696474683d)

## 開発サンプル

使用条件：

```
AliOS Things >= 3.0
aos-cube >= 0.3.7
```

![](https://camo.githubusercontent.com/a73df4a7a04aae19cefa1a0364e877d5997ea7a3/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f54423138764b5268473637674b306a535a4648585861396a5658612d313230352d3730372e676966)

### 1：AliOS Things 3.0ソースコードをダウンロード

* Open sourceから https://github.com/alibaba/AliOS-Things 全量ダウンロード。
* オフィシャルサイトから：https://aliosthings.iot.aliyun.com カスタマイズダウンロードも可能です。

### 2：AOS_SDK_PATH環境変数を追加する

AOS_SDK_PATHシステム環境変数を追加して、AliOS Things 3.0ソースコードパスを指すようにするAos-cubeは、AOS_SDK_PATH環境変数に従ってAliOS Thingsソースコードを検索します。さまざまなシステムがさまざまな方法で環境変数を追加します。

### ３：AliOS Studioのアプリケーションプロジェクト作成
Vscodeで、AliOS Studioが提供する「+」ボタンをクリックして、新しいプロジェクトを作成します（ボタンはvscodeの左下隅のステータスバーにあります）。AliOSStudioは、プロジェクト名>プロジェクトストレージパス>開発ボードの選択を求められ、指定したパスになります。以下で最も簡単なアプリケーションプロジェクトを生成します。

```
.
├── .aos               # AliOS Things 3.0 アプリケーションの説明
├── .vscode            # AliOS Studio 構成ファイル
├── Config.in          # Menuconfig 構成ファイル
├── README.md          # 説明ドキュメント
├── aos.mk             # Buildファイル
├── app_main.c         # サンプルコード
└── k_app_config.h     # カーネル構成
```

完全な作成例：
![effect](https://img.alicdn.com/tfs/TB18vKRhG67gK0jSZFHXXa9jVXa-1205-707.gif)

### ４、Alibaba Cloud IoT プラットフォームへ接続する
- 4.1、クラウド上の5つのステップ:
  - Alibabaクラウドアカウントを登録する
  - IoTスイートを開始する
  - 製品の作成、getProductKey
  - デバイスを作成し、DeviceNameとDeviceSecretを取得します
  - Topic （PRODECT_KEY）/ $（DEVICE_NAME）/ dataを定義し、アクセス許可を次のように設定します：デバイスはパブリッシュおよびサブスクライブできます

- 4.2、デバイス側のパラメーター変更
mqttアプリのソースコードは `AliOS-Things/example/mqttapp/mqtt-example.c`で、mqttサーバーに接続するための資格情報は`framework/protocol/linkkit/iotkit /sdk-encap/imports/iot_import_product.h`にあります。
クラウドから取得した3つのパラメーター（ProductKey、ProductSecret、DeviceNameおよびDeviceSecret）は、コード内の3つのマクロPRODUCT_KEY、PRODUCT_SECRET、DEVICE_NAMEおよびDEVICE_SECRETに対応しています。

```
#elif  MQTT_TEST
#define PRODUCT_KEY             "b1eszMRbDvz"
#define DEVICE_NAME             "mqtt_test"
#define DEVICE_SECRET           "CAaQz8Fc1JkFEyuzFhu4NpHSTlRSmRxV"
#define PRODUCT_SECRET          "Fxx6nyYptOugnS6H"
#else
```

- 4.3、MQTT他のもののコンパイルアプリ
現在のAliOS Things mqttアプリのコンパイルコマンドラインは次のとおりです。
```
aos make mqttapp @ b_l475e
```
コマンドの実行後、生成されたbinファイルとhexファイルはout / mqttapp @ b_l475e / binary /ディレクトリーにあります。

### ５、Bulid, Upload, Debug

前章の「開発ツールAliOS Things Studio」を参照してください。

### ６、ネットワークとデータ接続の構成
上記の4つのステップの後、対応するmqttappバイナリがstm32L475開発ボードに焼き付けられ、次のようにポートプリントが開始されます。

Wifiモジュールは、コマンドラインを介して対応するAPに接続できます。

```
netmgr connect * ssid * * password * * open | wep | wpa | wpa2 *
```

デバイスがネットワークに接続できるようになると、mqttappが実行を開始します。次の図は、mqtt実行ログです。

![](https://camo.githubusercontent.com/9feb1c73abdbe27fd030d608bd6c4b140e18c6b5/68747470733a2f2f696d672e616c6963646e2e636f6d2f7466732f5442315f3943426d384448384b4a6a5373706e5858624e415658612d313730382d3238342e6a7067)


以上です。
