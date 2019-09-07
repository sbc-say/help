---
title: "名前解決"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 20
draft: true
---

以下の区分により、Alibaba Cloudを活用したWebアプリケーション構築手法を紹介いたします。

1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース/キャッシュ

本項目では、Alibaba Cloudの<b>名前解決</b>に関するサービスの仕様と設計ポイントを紹介します。

## 名前解決
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - 参考リンク一覧

## 対象サービス
名前解決に関するサービスは2種類あり、「Domain」と「Cloud DNS」になります。
Domainでは、ドメインのレジストリ登録や管理を行い、Cloud DNSではAレコードやMXレコードの登録や削除等のゾーンの管理を行います。

### 基本的な仕様
{{%panel header="Domain"%}}
  * 新規ドメインを購入する際、ICANN情報を入力します。<br>
  * .cnドメインの取得もサポートしています。<br>
  * 1年〜10年単位でドメインを購入できます。<br>
  * レジスタラはALIBABA.COM SINGAPORE E-COMMERCE PRIVATE LIMITEDになります。<br>
  * DNSSECを有効化できます。<br>
  * ドメインの移管（転入転出）にも対応しています。<br>
  * ドメインの移管及び更新に対するセキュリティロックを有効化できます。<br>
  * 当該ドメインに対する変更証跡をコンソールから確認できます。<br>
  * デフォルトでAlibaba Cloudのネームサーバ（e.g. ns7.alidns.comとns8.alidns.com）を利用しますが、独自のDNSサーバへ変更できます。
  {{%/panel%}}

{{%panel header="Cloud DNS"%}}
  * DNSレコード管理を行い、ロードバランサや仮想サーバの名前解決をサポートします。<br>
  * デフォルトではインターネット公開向けですが、プライベートゾーンへも変更可能です。<br>
  * オペレーションログをコンソールから確認できます。<br>
  * デフォルトは無料版であり、Cloud DNS有料版を購入する事で以下の対応ができるようになります。<br>
      * レコード登録数やサブドメインレベルの上限緩和<br>
      * QPS上限設定によるDNS攻撃からの保護<br>
      * クエリボリュームの確認<br>
      * 他のレジスタラと併用して、Cloud DNSをSecondary DNSとして設定<br>
  * Global Traffic Managerというサービスで、以下のようにDNSトラフィックを制御できます。<br>
      * GEO DNSの有効化による名前解決の高速化<br>
      * リージョンやISPライン単位でトラフィックを制御<br>
      * DNS Failoverの対応<br>
      * DNSレコードに対するHealth Checkの有効化
{{%/panel%}}

### 設計のポイント 
{{%panel theme="danger" header="Domain"%}}
* CloudDNSの有料版を購入した場合、Domainにて当該ドメインのネームサーバ設定をデフォルトから指定のネームサーバ（e.g. vip7.alidns.comとvip8.alidns.com）へ変更する必要があります。<br>
* ドメインの移管と更新の操作に対して、セキュリティロックをかける事ができ、本番環境での適用が推奨されます。
{{%/panel%}}

{{%panel theme="danger" header="Cloud DNS"%}}
* 最小TTLはデフォルト10分ですが、有料版を利用する事で最小1秒まで設定可能となります。<br>
* レコードを追加する時に、ISP回線というパラメータは基本的に「デフォルト」を選択してください。デフォルト以外を選択した場合、名前解決されない場合があります。<br>
* 有料版の購入はまずパッケージを購入する処理となります。その後、購入したパッケージとドメインの紐付けをする事で初めてCloud DNSがアップグレードされ、有料版扱いとなります。
{{%/panel%}}

## 参考リンク一覧
|タイトル|URL|
| ---- | ---- |
|Alibaba Cloud DNSドキュメント|https://jp.alibabacloud.com/help/product/34269.htm|
|Transfer Your DomainBegin the process of transferring your domain(s) to Alibaba Cloud|https://www.alibabacloud.com/domain/transfer-in|
|Transfer your domain names to Alibaba Cloud (英語ドキュメント)|https://www.alibabacloud.com/help/doc-detail/54077.htm|
|中国ドメインの取得|https://www.alibabacloud.com/help/doc-detail/108953.htm|
|Domainセキュリティベストプラクティス|https://www.alibabacloud.com/help/doc-detail/35824.htm|
|Global Traffic Manager|https://www.alibabacloud.com/help/doc-detail/87297.htm|
