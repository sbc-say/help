---
title: "Development Architecture"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 50
draft: true
---

Webアプリケーションを構築する際には以下のコンポーネントが必要となります。

### Components
1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース/キャッシュ
1. 静的コンテンツ

ここではAlibaba Cloudの名前解決に関するサービスの基本仕様と設計ポイントを紹介します。

## 名前解決
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - アーキテクチャ図

## 対象サービス
名前解決に関するサービスは２種類あり、「Domain」と「Cloud DNS」になります。
Domainサービスで、ドメインの取得・管理を行い、ドメインを取得後のAレコードやMXレコードの登録をCloud DNSで行います。

### 基本的な仕様
- Domain
  - 新規ドメインを購入する場合、ICANN情報の入力が必要です。
  - .cnドメインの取得もサポートしています。
  - 1年〜10年単位でドメインを購入できます。
  - レジスタラはALIBABA.COM SINGAPORE E-COMMERCE PRIVATE LIMITEDになります。
  - DNSSECを有効化できます。
  - ドメインの移管（転入転出）にも対応しています。
  - ドメインの移管及び更新に対するセキュリティロックを有効化できます。
  - ドメインに対するChangeLogをコンソールから確認できます。
- Cloud DNS
  - DNSレコード管理を行い、ロードバランサや仮想サーバの名前解決をサポートします。
  - デフォルトではインターネット公開向けですが、PrivateZoneを別途設定可能です。
  - デフォルトでは無料版であり、Cloud DNS有料版を購入する事で以下の対応ができます。
    - レコード登録数やサブドメインレベルの上限緩和
    - GEO DNSの有効化による名前解決の高速化
    - QPS上限設定によるDNS攻撃からの保護
    - 既存レジスタラと併用して、Cloud DNSをSecondary DNSとして設定
  - Global Traffic Managerを購入する事でDNSのトラフィック全体を制御できます。
    - リージョンやISPライン単位でトラフィックを制御できます。
    - DNS Failoverの対応
    - DNSレコードに対するHealth Checkの有効化
  - オペレーションログをコンソールから確認できます。    

### 設計のポイント 
- Domain
  - DNSサーバはデフォルトでAlibaba Cloudのネームサーバ（e.g. ns7.alidns.comとns8.alidns.com）を利用します。
  - Alibaba Cloudのネームサーバから変更したい場合には、コンソールから独自のDNSサーバに変更可能です。
- Cloud DNS
  - Cloud DNSのISPラインの設定する時、デフォルトを選択してください。単一のIPアドレスへの名前解決の場合、例えばGoogle botsを設定しても名前解決されない場合があります。
  - 最小TTLはデフォルト10分ですが、有料版を利用する事で最小1秒まで設定可能となります。

### アーキテクチャ図
システム構成  
![Show as JPEG](/help/image/23.1.png)

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm

### Transfer Your DomainBegin the process of transferring your domain(s) to Alibaba Cloud
https://www.alibabacloud.com/domain/transfer-in

### Transfer your domain names to Alibaba Cloud (英語ドキュメント)
https://www.alibabacloud.com/help/doc-detail/54077.htm

### 中国ドメインの取得
https://www.alibabacloud.com/help/doc-detail/108953.htm?spm=a2c63.p38356.b99.14.588d1ccdSjCXOh

### Domainセキュリティベストプラクティス
https://www.alibabacloud.com/help/doc-detail/35824.htm

### Global Traffic Manager
https://www.alibabacloud.com/help/doc-detail/87297.htm
