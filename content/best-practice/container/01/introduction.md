---
title: "イントロダクション"
description: "Alibaba Cloudでコンテナを活用した開発手法を紹介します。"
date: 2019-09-04T16:20:40+09:00
weight: 10
draft: false
---

### 本記事の狙い
世間一般ではコンテナを用いた開発が一般的になりつつありますがが、Alibaba CloudでもAWSやGCP、Azureと同等かそれ以上のコンテナサービスが揃っており、使い方次第で最もコンテナのメリットを享受できるパブリッククラウドとなります。本項ではコンテナ開発の基礎から、Alibaba Cloudを最大限活用した形までを紹介いたします。

### コンテナ活用とは
そもそもコンテナ※を利用する事で、どんなメリットを享受できるのか。  
　※containerdを用いたDockerコンテナと定義

 1. 開発スピードが早くなり、機能実装やバグ修正までの時間を短くする
 1. 開発環境と本番環境の差分が最小限となり、人的バグを極小化する
 1. オンプレミスやクラウドを問わず、デプロイが容易になる

エンドユーザがシステムを利用する上で、バックグラウンドがコンテナか仮想サーバかは関係なく、メリットを得るのはシステム開発者です。
システム開発者がAlibaba Cloudにおけるコンテナ活用で得られるメリットを、下記開発フローから順を追って紹介いたします。

#### 開発フロー
1. 開発環境
1. コンテナイメージの作成・管理
1. コンテナデプロイ管理
1. ログ管理・モニタリング

## 開発端末
- 選択肢
  - Windows
  - MAC
  - SaaS (Cloud9的な何か)
- 評価基準
  - Shell/Powershell
  - Docker Desktop
  - MiniKube
  - Microk8s
  - Alibaba Native?

## バージョン管理
- 選択肢
  - Github
  - Gitlab
  - Bitbucket
- 評価基準
  - Alibaba Native?
  - Documentation

## イメージビルド
- 選択肢
  - Private Server (Jenkins/JenkinsX)
  - Public Service (CircleCI/TravisCI)
  - Alibaba Cloud Managed Service (Container Registry)

## イメージリポジトリ
- 選択肢
  - Private Repository (Docker Trusted Registry)
  - Public Repository (Dockerhub)
  - Alibaba Cloud Managed Service (Container Registry)

## 管理方式
- 選択肢
  - Custom Middleware (Kubernetes/Mesos/Nomad)
  - Managed Service (Kubernetes)

## モニタリング
- 選択肢
  - Custom Middleware (Prometheus/ElasticSearch)
  - Managed Service (CloudMonitor)
  
