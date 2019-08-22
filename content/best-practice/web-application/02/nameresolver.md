---
title: "Development Architecture"
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

## 名前解決
 - 対象サービス（Domain & Cloud DNS）
 - 基本的な仕様
 - 設計のポイント
 - アーキテクチャ図

## Domain & Cloud DNS
Domainというサービスで、ドメインの取得・管理を行います。
ドメインを取得後に、Alibaba Cloud DNSで実際のAレコードやMXレコードを登録します。

### 基本的な仕様
- 証明書を新規取得もしくは既存登録を行い、SSLアクセラレータとして機能します。
- Cloud DNSを使って、Aレコード登録して外部公開します。
- マルチゾーンに配置して、アベイラビリティーゾーン単位でも負荷分散させます。
- バックエンドにECSを置き、ヘルスチェックを有効化できます。

### 設計のポイント
- SLBとECS間のネットワークはAlibaba Cloud管理となり、全てのトラフィックが許可されています。  
- Googleのクローラーでなく、デフォルト
- バックエンドとして、デフォルトサーバーグループ、VServerグループ、アクティブ/スタンバイサーバーグループがありそれぞれ使い分ける必要があります。  
  特別な用途がなければVServerグループが最も無難な選択肢です。

### アーキテクチャ図


## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm

