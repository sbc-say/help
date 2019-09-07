---
title: "コンテナデプロイ管理"
description: "Alibaba Cloudでコンテナを活用する際のコンテナデプロイ管理手法を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 40
draft: false
---

本記事では、コンテナデプロイ管理について紹介いたします。

1. 開発環境
1. コンテナイメージの作成・管理
1. コンテナデプロイ管理
1. ログ管理とモニタリング

コンテナデプロイ管理では、開発環境と本番環境の２点に焦点を当てて紹介します。その後、Alibaba Cloudにおける推奨を紹介します。

## コンテナデプロイ管理
- 開発環境
- 本番環境
- Alibaba Cloudでの選択肢

### 開発環境
開発環境の場合ではコードの変化に伴って、コンテナイメージを作成、環境変数を伴ってデプロイする必要があります。
その際には各種IDEのプラグインよりdocker buildを実践して、コンテナイメージを作成して、docker-composeを使って他のコンテナとの連携する方法が最もシンプルです。また、本番環境でKubernetesを利用する場合には、Minikubeやmicrok8sを用いて、Kubernetes環境をローカルの開発環境に再現する事も有用です。

- IDEのプラグイン
- docker-compose
- Minukube
- microk8s
- scaffold

### 本番環境
本番環境では、可用性を保つ為にサーバでクラスターを組み、冗長性を保った上でコンテナを動作させる事が一般的です。
簡易的な機能のみであればNomad、フルスタックな機能が必要であればKubernetesが利用できます。

- Nomad
- Kubernetes

### Alibaba Cloudでの選択肢
Alibaba Cloudでは現在のデファクトスタンダードと言えるKubernetesを３種類の形で提供しています。
Kubernetesは大きくMaster nodeとWorker nodeの2種類のホストで構成され、それぞれをユーザが管理するか
Alibaba Cloudの任せるかという違いがあります。

|  種類  |  Master nodeの管理  |  Worker nodeの管理  |
| ---- | ---- | ---- |
|  Dedicated  |  ユーザ  |  ユーザ  |
|  Managed  |  Alibaba Cloud  |  ユーザ  |
|  Serverless  |  Alibaba Cloud  |  Alibaba Cloud  |

Dedicatedは既存でKubernetesを利用していて、その設定を引き継ぎたいなど、より細かい設定をしたい要件がある時、
インフラの細かい設定が不要でとにかく使いたい場合はServerless、その中間の選択肢がManagedとなります。

## 参考リンク一覧
|タイトル|URL|
| ---- | ---- |
|Container Service for Kubernetes とは|https://jp.alibabacloud.com/help/doc-detail/86737.htm|
|Alibaba Cloud Kubernetes と自作 Kubernetes|https://jp.alibabacloud.com/help/doc-detail/69575.htm|
