---
title: "負荷分散"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 30
draft: true
---

以下の区分により、Alibaba Cloudを活用したWebアプリケーション構築手法を紹介いたします。

1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース/キャッシュ

本項目では、Alibaba Cloudの<b>負荷分散</b>に関するサービスの基本仕様と設計ポイントを紹介します。

## 負荷分散
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - 参考リンク一覧

## 対象サービス
Webアプリケーションにおいて負荷分散を実現するサービスを3つ紹介します。ひとつはロードバランサーの役割を担うServer Load Balancerです。もうひとつは、jpegやcss等の静的ファイルを公開する際に用いるObject Storage Serviceです。最後に、コンテンツデリバリーサービスとして機能するAlibaba CDNです。以上の3つのサービスを活用する事で、可用性の高いWebアプリケーションを実現します。

### 基本的な仕様
- Server Load Balancer (SLB)
   - SLBインスタンスを作成する際、以下のパラメータを入力します。
    - インスタンス名
    - スペック
    - インターネット公開かイントラネット公開か
    - アベイラビリティゾーンの設定
      - プライマリゾーンとバックアップゾーン
  - バックエンドに複数のECSからなるサーバグループを指定、ヘルスチェックを有効化して、疎通確認します。
  - SLBインスタンスのIPアドレスもしくはCNAMEを、A/CNAMEレコード登録してドメインとして公開します。
  - SLBインスタンスに付与されたIPアドレスは静的であり、動的変更されません。
  - 証明書を登録して、SSLアクセラレータとして機能させます。
  - WebSocketやHTTP2.0、セッション維持の有効・無効を指定できます。
  - 物理ロードバランサと同じようなセキュリティルールを設定してアクセス制御します。同ルールには以下が含まれます。
    - アクセスの許可もしくは禁止（ホワイトリストとブラックリストの双方として機能する）
    - プロトコルとポート番号
    - 1~100までの優先番号をつけ、数字が小さい方から優先適用
  
- Object Storage Service (OSS)
  - バケットを作成して、その配下にファイルをアップロードして利用します。
  - オブジェクトストレージとして一般的なGET/HEAD/PUT/POST/DELETEに対応しています。
  - バケットには標準ストレージ、低頻度アクセスストレージ、アーカイブストレージと3種類のタイプがあります。
  - Web公開する機能を有しています。
    - HTMLを置いて、Sorryサーバとして機能させる事ができます。
    - SDKを介してアクセストークンによる限定公開も設定できます。
  - リファラーホワイトリスト設定をしてアクセス制御が可能です。
  - ファイルをOSSにアップロードする前に、クライアント側で暗号化する事ができます。
  - サーバー側での暗号化も可能です。
  - SDKを介したファイルのアップロード結果は以下のように確認できます。
    ```python
    result = bucket.put_object('<yourObjectName>', 'content of object')
    # HTTP return code
    print('http status: {0}'.format(result.status))
    ```
  - Log Serviceというサービスを併用してアプリケーションのログをアップロードする事も可能です。

- Alibaba Cloud CDN
  - CDNを適用したいドメイン名を登録すると、FQDNが発行される。そのFQDNをCNAMEとしてドメインに登録する。



### 設計のポイント
- SLB
  - 本番環境では最も大きいインスタンスタイプ（slb.s3.large）を指定する事を推奨します。 
    - SLBのインスタンスタイプを変更する時には１秒〜３秒程度のTCP接続断が発生する可能性がある為、あらかじめ最大インスタンスタイプを指定しておきます。
    - SLBインスタンスタイプは従量課金制なので、大きいインスタンスタイプを購入してもインスタンスに対するトラフィックが閾値（特定のQPS）を超すまで、最低限のインスタンスタイプとして課金となります。
    - 小さいインスタンスタイプ（slb.s1.small等）では
    
  - SLBとECS間のネットワークは全てのトラフィックが許可されます。当該ネットワークはAlibaba Cloud内部管理の為、セキュリティグループ等で変更できません。
    - 全て許可で固定の為、SLBからのヘルスチェックを疎通させる為に、ECSのセキュリティグループのインバウンド設定を変更する必要はありません。
  - バックエンドとして、デフォルトサーバーグループ、VServerグループ、アクティブ/スタンバイサーバーグループがありそれぞれ使い分ける事ができます。  
    ただ、特別な用途がなければVServerグループが最も無難な選択肢です。
  - マルチゾーンに配置して、プライマリゾーンとバックアップゾーンを指定しますが、プライマリゾーンにしかトラフィックは流れません。
- OSS
  - 権限管理のサービスとしてRAMを用いますが、OSSにアクセスする権限は最小限に設定します。
  - 1ファイルの最大サイズは48.8TBで、保存できる容量は無制限の為、コスト管理に気をつける必要があります。
  - 1ファイルが5GBを超える場合、マルチパートアップロードと言うモードでファイルを分割してアップロードする必要があります。

## アーキテクチャ図
システム構成  
![Show as JPEG](/help/image/23.1.png)

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm

Alibaba Document
https://jp.alibabacloud.com/help/product/27537.htm

### Best Practice in PDF
http://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/download/pdf/DNSLB11825295_ja-JP_jp_190524094546_public_48f51f1c98dba2f44bbc936c3f27f11b.pdf

### SDKを利用したOSSへの一時公開
https://jp.alibabacloud.com/help/doc-detail/32122.htm

### リファラーホワイトリスト設定
https://jp.alibabacloud.com/help/doc-detail/32127.htm?spm=a21mg.p38356.b99.482.33ed6d34SQp2RX

### バケットのアクセスログ設定
https://jp.alibabacloud.com/help/doc-detail/32125.htm?spm=a21mg.p38356.b99.480.3623431frijy4g

## OSS PDF Best Practice
http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/pdf/oss-user-guide-jp-ja-2018-02-14.pdf

## ECSのログ取得
https://www.alibabacloud.com/help/doc-detail/72561.htm?spm=a2c63.p38356.b99.29.351e45acTnqpib

## OSSへのログ送信
https://www.alibabacloud.com/help/doc-detail/29002.htm?spm=a2c63.p38356.b99.285.2eff592fnf9HNU
