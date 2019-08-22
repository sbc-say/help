---
title: "Web/APサーバ"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 50
draft: true
---

Webアプリケーションを構築する上でDNSを用いる上で仕様と設計ポイントを紹介します。

## 全体アーキテクチャ
システム構成  
![Show as JPEG](/help/image/23.1.png)

### Components
1. 名前解決
1. ロードバランサー
1. Web/APサーバ
1. データベース
1. 静的コンテンツ（CDN、OSS）

## Web/APサーバ
 - 対象サービス（Elastic Compute Service、Container Service）
 - 基本的な仕様
 - 設計のポイント
 - アーキテクチャ図

### 対象サービス
仮想サーバであるElastic Compute Serviceを用いるのが最も一般的です。
昨今はContainer Serviceもあり、こちらを紹介します。
 
### 基本的な仕様
- OS使えます。
- ログはCloudMonitorから確認できます。
- セキュリティグループでインバウンドアウトバウンドを設定します。
- ECSインスタンス自体にAlibaba CloudのSaaS利用の権限をRAMより付与します。
- [VNCからアクセス可能](https://jp.alibabacloud.com/help/doc-detail/25433.htm)です。
- メタ情報はcurl で取得できます。
- デフォルトで同じセキュリテイグループ内の通信は全許可されます。
- パスワード・秘密鍵どちらも設計でき、デフォルトではどちらも設定されていません。
- Webを公開していると、セキュリティアラートを能動的に検知します。

### 設計ポイント
- AliyunOSの場合、WebサーバはNginxでなくTerwayがインストールされます。
- セキュリティグループのルール設定は、許可・禁止を選択でき、優先度設定によって管理します。
- サブスクリプションする場合には、EBSディスクも一緒に購入できます。
- 時間が中国語。

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm

