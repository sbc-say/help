---
title: "Web/APサーバ"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 50
draft: false
---

以下の区分により、Alibaba Cloudを活用したWebアプリケーション構築手法を紹介いたします。

1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース/キャッシュ

本項目では、Alibaba Cloudの<b>Web/APサーバ</b>に関するサービスの仕様と設計ポイントを紹介します。

## 負荷分散
 - 対象サービス
 - 基本的な仕様
 - 設計のポイント
 - 参考リンク一覧

## 対象サービス
Web/APサーバとして用いるサービスは、仮想サーバであるElastic Compute Serviceを用いるのが最も一般的です。
Autoscalingを実装します。加えてContainerServiceもアプリケーション環境として活用されており、こちらも紹介します。
 
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

- Auto Scaling
  - インスタンスの最大数・最小数、インスタンスをデプロイするVPC、インスタンスの削除ポリシーを設定して利用します。
  - 最初に「スケーリンググループ」を作成してスケーリングに関する設定を行い、次に「スケーリング設定」を作成して、スケールするECSの設定を紐付けます。
  - 既存のインスタンスを、オートスケーリンググループに追加することも可能です。
 
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

- Auto Scaling
  - スケーリング設定の代わりに起動テンプレートを使用すると、既存のすべてのスケーリング設定が自動的に無効になります。
  - 台数の細かく調整する時には、スケーリングルールを作成・実行することで、スケーリングアクティビティをトリガーできます。

- Container Service
  - リージョンやアカウントの種類によって、Container Registryが利用できない等一部利用可能なサービスに違いがあります。
  - DockerfileにENVとして記載された環境変数がそのままコンソールの環境変数項目にもパースされるので、環境変数は
    docker-entrypoint.sh等のカスタムスクリプト内で指定するよりもDockerfileで環境変数を指定する方が手間が省けます。

## 参考リンク一覧
|タイトル|URL|
| ---- | ---- |
|Auto Scalingのよくある質問DF|https://jp.alibabacloud.com/help/faq-detail/25967.htm|

