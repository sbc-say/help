---
title: "データベース"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 50
draft: false
---

以下の区分により、Alibaba Cloudを活用したWebアプリケーション構築手法を紹介いたします。

1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース

本項目では、Alibaba Cloudの<b>データベース</b>に関するサービスの基本仕様と設計ポイントを紹介します。

## データベース
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - アーキテクチャ図

## 対象サービス
Relational DatabaseとしてAspara for RDS、NoSQL DatabaseとしてAspara for MongoDBを利用する事が出来ます。
"Aspara"という名前はAlibaba社内でのAlibaba Cloudを指す為、その名残として名称となります。

### 基本的な仕様
{{%panel header="Aspara for RDS"%}}
* リードレプリカの追加<br>
* ディスク消費量のコンソールからの確認<br>
* メンテナンス時間の設定<br>
* アクセスホワイトリストの設定<br>
* コンソールからパラメータの書き換え可能<br>
* 文字コードはデータベースの仕様に準拠<br>
{{%/panel%}}
{{%panel header="Polar DB"%}}
* 2019年8月末時点でジャカルタリージョンのみ利用可能です。<br>
{{%/panel%}}
{{%panel header="Aspara for MongoDB"%}}
* レプリカセットかシャーディングかの選択をした後に、リージョン、VPC、スペック、MongoDBバージョン、レプリカ/シャーディング数、パスワードを入力して作成<br>
* 作成後には主に以下の設定が可能となります。<br>
  * バックアップ・リカバリ<br>
  * リソース監視<br>
  * アラームルール設定<br>
  * パラメータ設定<br>
  * 監査ログの確認<br>
  * スロークエリ含むログ確認<br>
  * インデックス最適化<br>
  * Data Transfer Serviceを用いた既存MongoDBの移行<br>
{{%/panel%}}

### 設計ポイント
{{%panel theme="danger" header="ECS"%}}
* 時間が中国語。<br>
{{%/panel%}}

## 補足
日本リージョン未公開だが他の有用なデータベースサービスとして、クラウドネイティブでハイパフォーマンスなMySQL, PostgreSQL, and Oracleを提供する[Polardb](https://www.alibabacloud.com/products/apsaradb-for-polardb)と、独身の日でのオンライントランザクションを支えた分散型SQLエンジンである[Distributed Relational Database Service](https://www.alibabacloud.com/product/drds)があります。現在これらは中国リージョンのみで利用可能ですが、東京リージョンでも利用可能になり次第紹介したいと思います。

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm
