---
title: "データベース"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 50
draft: true
---

Webアプリケーションを構築する上でDNSを用いる上で特徴と設計ポイントを紹介します。

## 全体アーキテクチャ
システム構成  
![Show as JPEG](/help/image/23.1.png)

### Components
1. 名前解決
1. ロードバランサー
1. Web/APサーバ
1. データベース
1. 静的コンテンツ（CDN、OSS）

## データベース
###
RDSとPoloarDB

### 基本的な仕様
- リードレプリカの追加
- ディスク消費量のコンソールからの確認
- メンテナンス時間の設定
- アクセスホワイトリストの設定
- コンソールからパラメータの書き換え可能
- 文字コードはデータベースの仕様に準拠

### 設計ポイント
- 時間が中国語。？？？？

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm

