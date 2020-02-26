---
title: "Linkkit SDK 利用ガイド"
description: "Alibabaの IOT Platform と繋がるためデバイス側使ってるSDKとその開発例を紹介します。"
date: 2020-02-05T12:30:18+08:00
weight: 30
draft: false
---

Tags ： AlibabaCloud IOT-Platform Linkkit

---

## 目的

Link Kit SDKは、Alibaba Cloudによってデバイスメーカーに提供され、デバイスに統合し、デバイスをAlibaba Cloud IoTプラットフォームに安全に接続し、Alibaba Cloud IoTプラットフォームによってデバイスを制御および管理できるようにします。デバイスは、Link Kit SDKを統合するためにTCP / IPプロトコルスタックをサポートする必要があります。zigbeeやKNXなどの非IPデバイスの場合、ゲートウェイデバイスを介してAlibaba Cloud IoTプラットフォームに接続する必要があり、ゲートウェイデバイスはLink Kit SDKを統合する必要があります。

![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103238/intl_en/1548121692667/relationShip.JPG)

本書はLink Kit SDK 関連の知識や Link Kit SDKを使ってIOT Platformと繋がる方法を紹介させてください。

本ガイドの全体的な流れは下記の通りです。

| セクション         | Topic              | 説明                                      |
| --------------------- |:---------------------------- |:----------------------------------------- |
| 概要紹介        | Linkkit SDK と　AliOS things | Linkkit SDK と　AliOS things の関係の紹介 |
| -             | SDK利用以外の方法            |      SDK以外でIOT Platformへ繋がる方法を説明        |
| -            | アーキテクチャ               | アーキテクチャ 基本特徴を紹介               |
| -       | SDKバージョンと区別          | 各バージョンの紹介         |
| -          | 製品の範囲         | 適用デバイスの紹介          |
| 開発プロセス          | 開発プロセス  |   一般的な開発プロセスの紹介             |
| C言語Link Kit SDK紹介 | C言語Link Kit SDK紹介     |  C言語SDKの開発概要を紹介 |
| 開発サンプル     |  Linuxベースの開発事例   | １つ簡単な開発事例を紹介 |


## 概要紹介
Linkkit SDKの概要について紹介させてください。

### Linkkit SDK と　AliOS things の関係

AliOS thingsを実装されたデバイスはIOT PlatformのSDK（Linkkit SDK）を実装不要で、簡単にIOT Platformへの接続が可能です。

もしデバイスはAliOS thingsを実装してない場合は、Linkkit SDKの実装でIOT Platformへの接続も可能です。ただし、Linkkit SDKとデバイス既存OSへの適合性によって、一部ハードウェア関連のドライブ部分はお客様自身で実装する必要があります。

### SDK利用以外の実装方法

* Alinkプロトコルに基づいて独自のSDKを開発する
提供されたSDKでは満たされない特定の開発要件がある場合は、Alinkプロトコルに基づいて独自のSDKを開発できます。詳細については、 [Alink protocol](https://www.alibabacloud.com/help/doc-detail/90459.htm?spm=a2c63.p38356.879954.7.530e1e025J4Jaa#concept-pfw-hdg-cfb)に参照.

* 汎用プロトコルSDK [generic protocol SDK](https://www.alibabacloud.com/help/doc-detail/86369.htm?spm=a2c63.p38356.879954.8.530e1e025J4Jaa#concept-d4s-jcv-42b)使用できます。デバイスまたはプラットフォームをIoT Platformに接続するブリッジを構築し、相互に通信できるようにするためにIoT Platformによって提供されます。

### ソフトウェアのアーキテクチャと機能

Link Kit SDKのソフトウェアアーキテクチャと機能は次のとおりです。
![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103238/intl_en/1548123349797/sdkStruct.JPG)

- アプリケーションプログラミングインターフェイス（API）
Link Kit SDKは、デバイスがさまざまな機能モジュールを制御するためのAPIを提供します。

- 汎用モジュール
Link Kit SDKは、一連の汎用モジュールを提供します。
  1. クラウド接続：MQTT、CoAP、HTTP、HTTPSなど、デバイスをAlibaba Cloud IoTプラットフォームに接続するためのさまざまな方法を提供します。
  2. デバイス認証：IoTプラットフォームに接続されたデバイスが正当であるかどうかを検証します。認証は、デバイスレベルまたは製品レベルごとに基づくことができます。
  3. OTA：デバイスファームウェアのアップグレードをサポートします。
  4. サブデバイス管理：ゲートウェイによってIoTプラットフォームに接続されたサブデバイスを接続します。
  5. Wi-Fiプロビジョニング：Wi-Fi AP SSIDとパスワードを、アップリンクネットワークインターフェイスとしてWi-Fiを使用するIoTデバイスに送信します。
  6. デバイスモデリング：デバイスのプロパティ、サービス、およびイベントに基づくデバイス管理。
  7. ユーザーバインド：SmartLifeがユーザーのアカウントをデバイスにバインドするために使用する安全なバインドトークンを提供します。
  8. ローカルデバイス制御：デバイスがスマートフォンまたはゲートウェイと同じローカルエリアネットワーク（LAN）に接続する場合、この機能を介してスマートフォンまたはゲートウェイで直接制御できます。これにより、より高速で信頼性の高いデバイス制御が可能になります。


- ハードウェアアブストラクションレイヤー (HAL)
SDKはOSや製品から独立するように設計されているため、この目的のためにレイヤー（HAL）を定義します。デバイスメーカーはこれらの機能を実装する必要があります。

### SDKバージョンと区別

Link Kit SDKは現在、C、Java、Python、NodeJS、Android、iOSなどの複数の言語/プラットフォームをサポートしていますが、機能は異なる言語/プラットフォームバージョンで完全に同じではありません。詳細は[ドキュメント](https://help.aliyun.com/document_detail/100576.html)に参照してください。

OTAなどすべての機能を利用したい場合は、C言語のSDKがおすすめです。

### 製品の範囲
Link Kit SDKは、TCP / IPを介してAlibaba Cloud IoTプラットフォームと通信できるすべての製品に適しています。典型的なデバイスの種類は次のとおりです:
- 家庭用機器/家電
![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103238/intl_en/1548124014219/wifiaccess.JPG)
- ゲートウェイ製品とサブデバイス製品
![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103238/intl_en/1548124139449/GwAccess.JPG)
- セルラーネットワーク接続を使用する製品
![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103238/intl_en/1548124228667/wanAccess.JPG)

## 開発プロセス
デバイスを開発してAlibaba Cloud IoT Platformに接続する手順は、次の手順で構成されています:

- クラウド側の製品定義：Alibaba Cloud IoT Platformで製品機能（デバイスプロパティ、サービス、イベントを含む）を定義します。このドキュメントでは、クラウド上で製品を定義する方法については説明しません。製品作成の詳細については、Alibaba Cloud IoT Webサイトをご覧ください。

- デバイス側の開発：Link Kit SDKをデバイスに統合して、機能開発を開始し、IoTプラットフォームで定義された製品機能を実装します。

- アップリンクおよびダウンリンクのデバッグ：IoTプラットフォームからテストデバイスの3つ組（デバイスがクラウドに接続するために使用する一意のIDを表す）に適用し、それらをデバイスに書き込みます。次に、デバイスとクラウド間のアップリンクおよびダウンリンク接続をデバッグして、デバイスがAlibabaクラウドIoTプラットフォームと適切に通信できることを確認します。このセクションでは、デバッグプロセスについては説明しません。以降のセクションで説明します。

![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103245/intl_en/1548125431388/ProdDevProc.JPG)

デバイスがデバッグされたら、デバイスの大量生産のために、Alibaba Cloud IoT Platformで複数のデバイスに同時にトライプルを適用します。

次の図は、デバイス側でのLink Kit SDK統合の一般的な開発手順を示しています。
![](http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103245/intl_en/1548125624674/DevSideDev.JPG)

Wi-Fi経由でネットワークに接続されているデバイスの場合、開発プロセスは次のとおりです。
![](http://http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/pic/103245/intl_en/1548127502273/wifiDevProc.JPG)

その他デバイスの開発プロセスについて、詳細は[ドキュメント](https://www.alibabacloud.com/help/doc-detail/96597.htm) に参照ください。

## C言語Link Kit SDK紹介

### 概要
C言言リンクキットSDKは、C言言の実行速度が速い/必要な実行中のメモリ量が少ないため、C言言を実行する機能を使用するために、C言言を開くトラフィック処理を使用するデバイスに適しています。
デバイスは、TCP / IPをサポートするか、AT命令の外部ネットワーク通信モジュールを介してLink Kit SDKを統合する必要があり、zigbee / 433 / KNXのような非IPデバイスは、Link Kit SDKを統合したウェブ関連デバイスをAliyunyunIoTに接続する必要があります。

### アーキテクチャ

構造図は下記の通り：
特別なOSを使ってるデバイスの場合は、HAL層はデバイスプロバイダーより実装する必要があります。

![](https://sbcloud-iot-guide.oss-ap-northeast-1.aliyuncs.com/sdk_arc.png)

```
    +---------------------------+
    |                           |
    |   C-SDK Example Program   |
    |                           |
    +---------------------------+
    |                           |
    |   C-SDK Interface Layer   |
    |                           |
    |       IOT_XXX_YYY() APIs  |
    |   linkkit_mmm_nnn() APIs  |
    |                           |
    +---------------------------+
    |                           |
    |   C-SDK Core Implements   |
    |   : =>                    |
    |   : You SHOULD NOT Focus  |
    |   : on this unless        |
    |   : you're debugging SDK  |
    |                           |
    +---------------------------+
    |                           |
    |  Hardware Abstract Layer  |   HAL層
    |                           |
    |     HAL_XXX_YYY() APIs    |
    |                           |
```

### 開発環境準備
エンドポイントのいくつかの標準的な動作、登録されたウェブサイトのコントロールパネルの動作、十分な制御の動作、製品の種類の作成、および以下の機器の例など、Ubuntu16.04のインストールなどが含まれます。開発環境の構築、開発環境のインストール、C-SDKソースの代替品のダウンロードなど。

### C-SDKをターゲットプラットフォームにクロスコンパイルします
C-SDKソースコードを、開発したいデバイスのターゲット組み込みプラットフォーム形式にクロスコンパイルします。
このリンクの成功した製品は、ターゲットプラットフォーム形式のバイナリスタティックライブラリファイルlibiot_sdk.aであり、当社が提供するxxx_api.hヘッダーファイル（xxxはアクセスする機能ポイントを表します）で、いわゆるSDKを取得しています。
すべてのプログラミングAPI関数はヘッダーファイルで宣言され、ライブラリファイルで実装されます。

### HALレイヤーの実装を開発する

C-SDK自体は、実行するハードウェアプラットフォーム、および実行するオペレーティングシステム（またはオペレーティングシステムなし）を想定しないクロスプラットフォームSDKです。基礎となるレイヤーへの依存関係は、HAL_XXXスタイルの関数インターフェイスのセットに抽象化されます。 xxxという名前の関数ポイントが依存する基礎となる関数の代わりに、それらはsrc / xxx / xxx_wrapper.hに表示されます。現時点では、ユーザーまたはハードウェアプラットフォームプロバイダーは、独自のプラットフォームでこれらのインターフェイス機能の実装を提供する必要があります。
C-SDKには、参照用にUbuntuおよびWindowsでこれらのインターフェイスを実装するためのソースコードが付属しています。

### SDKおよびHALレイヤー実装をファームウェアに埋め込みます

上記のlibiot_sdk.aを機能のコアとして使用し、libiot_hal.aをSDKのサポートライブラリとして独自に開発したため、重要なコンポーネントの準備が整いました。それらをプロジェクトのコンパイルシステム/コンパイル環境に持ち込み、ターゲットファームウェアまたはターゲットアプリケーションにリンクされるようにコンパイル設定を変更します。C-SDKが提供するAPIを使用できます。

### 業務ロジック実装
C-SDKが提供するAPIを使用した後、それを使用して、レポートデータ、トピックのサブスクライブ、コマンドの受信など、独自のビジネス/アプリケーションを作成できます。繰り返しになりますが、Ubuntu 16.04などのホストプラットフォームでビジネスロジックコードの記述とテストを完了してから、組み込みターゲットプラットフォームに移行することを強くお勧めします。これにより、問題がある場合は、ホスト上の同じソースコードと比較することもできます。

## 開発サンプル

Alibaba Cloudが提供するデバイス側C言語SDKは、Linuxシステムで直接実行でき、MQTTプロトコルを介してIoTプラットフォームにアクセスできます。この記事では、Ubuntu x86_64システムでコンパイルされたデバイス側のC言語SDKを例にして、デバイスでのクラウド構成と開発プロセスを紹介します。

### 製品とデバイスを作成する

IoTプラットフォームコンソールにログインし、左側のナビゲーションバーで[デバイス管理]> [製品]を選択し、[製品の作成]をクリックして製品を作成します。

* 製品名：カスタム製品名。
* カテゴリ：カスタムカテゴリを選択します。
* ノードタイプ：直接接続されたデバイスを選択します。
* ネットワーク：WiFiを選択します。
* データ形式：ICA標準データ形式（Alink JSON）を選択します。
* 認証方法：デバイスキーを選択します。

左側のナビゲーションバーでデバイスを選択し、[デバイスの追加]をクリックして、作成した製品の下にデバイスを追加します。
デバイスが正常に作成されたら、デバイス証明書情報を取得します（ProductKey、DeviceNameとDeviceSecret）。

### 製品モデルを定義する
IoTプラットフォームが提供するデバイス側のC SDKデモパッケージには、オブジェクトモデルというJSON形式のConfigファイルが含まれています。この例では、物理モデルファイルをインポートして、製品の物理モデルを生成します。

1. モデルファイルの編集。
TSLと呼ばれる`オブジェクトモデル`とは、Thing Specification Languageです。 JSON形式のファイルです。センサー、車載デバイス、建物、工場など、物理空間内のエンティティのデジタル表現です。属性、サービス、イベントの3つの次元で、エンティティの内容、実行できる内容、提供できる内容を説明します情報。これらの3つのディメンションが定義されると、製品機能の定義が完了します。
 `src/dev_model/examples`ディレクトリのmodel_for_examples.jsonファイルを開きます。`オブジェクトモデル`JSONファイルのproductKeyの値を、IoTプラットフォームで作成した製品ProductKeyに置き換えて、ファイルを保存します。
![](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/zh-CN/2742669751/p71413.png)

2. IoTプラットフォームコンソールの製品ページで、以前に作成した製品を見つけて、対応するビューをクリックします。
3. [製品の詳細]ページの[機能定義]タブで、[ドラフトの編集]> [クイックインポート]をクリックします。
4.ポップアップダイアログボックスで、インポートモデルを選択し、前の手順で編集したモデルのJSONファイルをアップロードして、[OK]をクリックします。
5. [更新の発行]をクリックして、物理モデルを公式バージョンとして発行します。

### SDK設定更新
開発ツールで、C SDKデモをインポートし、構成ファイルの情報をデバイス情報に変更します。

1. `wrappers/os/ubuntu`ディレクトリのSDKデモで、デバイス証明書情報を`HAL_OS_linux.c`ファイルのデバイス証明書情報に変更します。
![](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/zh-CN/2742669751/p71419.png)
2. SDKをコンパイルします。 SDKルートディレクトリで、make reconfigを実行し、3を選択してからmakeを実行します。
![](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/zh-CN/2742669751/p71422.png)
3. SDKテスト。
![](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/zh-CN/2742669751/p71424.png)

SDKが正常に実行されると、IoTプラットフォームコンソールのデバイスのデバイス詳細ページで、デバイスによって報告されたデバイスステータスと材料モデルデータを表示できます。


参考として、詳しい情報をほしい場合は下記中国語のドキュメントを参照してください。
* [SDK マニュアル](https://code.aliyun.com/edward.yangx/public-docs/wikis/user-guide/Linkkit_User_Manual)
* [オフィシャルドキュメントセンター](https://help.aliyun.com/document_detail/96596.html)


以上です。
