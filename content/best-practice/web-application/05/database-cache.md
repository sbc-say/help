---
title: "データベース/キャッシュ"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 50
draft: false
---

Webアプリケーションを構築する際には以下のコンポーネントが必要となります。

### Components
1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース/キャッシュ

ここではAlibaba Cloudのデータベース及びキャッシュに関するサービスの基本仕様と設計ポイントを紹介します。

## Web/APサーバ
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - アーキテクチャ図

## 対象サービス
Relational Databaseとして、Aspara for RDSを利用できます。
Poloardbとして。
NoSQL Databaseとして、Aspara for MongoDBとTableStore( https://www.alibabacloud.com/product/table-store?spm=5176.2020520106.104.1.36615aeZ5aeZcP )があります。
キャッシュの用途として、Aspara for RedisとAspara for Memcacheが提供されています。
（"Aspara"という名前はAlibaba社でAlibaba Cloudを指す名称で、一部サービスにその名残があります。）
ちなみに、中国のみだとTime Series & Spatial Temporal Database (TSDB)、（ https://www.alibabacloud.com/help/product/54825.htm ）
と、DRDS Instances( https://docs.aliyun.com/en?spm=5176.2019202119.103.3.77b51593FCpP4p#/pub/drds_en_us )が利用できます。

### 基本的な仕様
- Aspara for RDS
  - リードレプリカの追加
  - ディスク消費量のコンソールからの確認
  - メンテナンス時間の設定
  - アクセスホワイトリストの設定
  - コンソールからパラメータの書き換え可能
  - 文字コードはデータベースの仕様に準拠
- Polar DB
  - Managedされていて、管理不要
- Aspara for MongoDB
  - Managedされていて、管理不要
- TableStore
  - Managedされていて、管理不要
- Aspara for Redis
  - 準拠
- Aspara for Memcache
  - 準拠

### 設計ポイント
- 時間が中国語。

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm
