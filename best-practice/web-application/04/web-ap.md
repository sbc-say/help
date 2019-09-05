---
title: "Web/APサーバ"
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

ここではAlibaba CloudのWeb/APサーバに関するサービスの基本仕様と設計ポイントを紹介します。

## Web/APサーバ
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - アーキテクチャ図

## 対象サービス
仮想サーバであるElastic Compute Serviceを用いるのが最も一般的です。
加えて昨今はContainer Serviceもアプリケーション環境として活用されており、こちらも紹介します。
 
### 基本的な仕様
- ECS
  - OSには、Fedora、Cent、Ubuntu、Windowsに加えて、独自のAliyunOSも利用できます。
  - ログはCloudMonitorから確認できます。
  - セキュリティグループでインバウンドアウトバウンドを設定します。
  - ECSインスタンス自体にAlibaba CloudのSaaS利用の権限をRAMより付与します。
  - [VNCからアクセス可能](https://jp.alibabacloud.com/help/doc-detail/25433.htm)です。
  - メタ情報はcurl で取得できます。
  - Webを公開していると、セキュリティアラートを能動的に検知します。
  - インスタンス削除をリリースと呼び、時間指定リリースが可能です。

- Container Service
  - Kubernetesを利用して、Dedicated Kubernetes・Managed Kubernetes・Serverless Kubernetesが利用できます。
  - フロントエンドとしてSLBを連携作成します。
  - バックエンドはデータベースを指定してホワイトリスト形式でアクセス許可する事で疎通させます。
  - Kubernetesで利用可能な主要モジュールをコンソールから実施できます。
    - ステートフルコンテナの起動
    - バッチコンテナの起動
  - Container Registryと併用する事で、Github/Gitlab/BitbucketからシームレスにKubernetes環境にデプロイ可能です。
  - Log ServiceやCloudMonitorといったAlibaba Cloudのサービスとの他に、Prometheus＋Grafanaを用いたモニタリングも推奨されています。
  
### 設計ポイント
- ECS
  - 時間が中国語。
  - 新規インスタンス作成時にパスワードか秘密鍵のいずれかを指定できますが、デフォルトではどちらも設定されずに作成されます。
  - サブスクリプションする場合には、EBSディスクも一緒に購入できます。
  - セキュリティグループのルール設定は、許可・禁止を選択でき、優先度設定によって管理します。
  - 同一セキュリテイグループに紐付くインスタンス間の通信は全許可されます。
  - AliyunOSの場合、NginxをパッケージインストールしようとするとTerwayがインストールされます。

- Container Service
  - リージョンやアカウントの種類によって、Container Registryが利用できない等一部利用可能なサービスに違いがあります。
  - DockerfileにENVとして記載された環境変数がそのままコンソールの環境変数項目にもパースされるので、環境変数は
    docker-entrypoint.sh等のカスタムスクリプト内で指定するよりもDockerfileで環境変数を指定する方が手間が省けます。

## アーキテクチャ図
ECS利用した場合の構成図  
![Show as JPEG](/help/image/23.1.png)
Container Service利用した場合の構成図  
![Show as JPEG](/help/image/23.1.png)

## 参考リンク一覧
https://jp.alibabacloud.com/help/product/34269.htm
https://jp.alibabacloud.com/help/product/27537.htm

