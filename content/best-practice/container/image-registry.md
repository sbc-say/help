---
title: "Container Architecture"
description: "Alibaba Cloudでコンテナを活用したシステム構成を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 20
draft: true
---

そもそもコンテナを利用する事で、どんな事が実現できるか。
 1. 開発スピードが早くなり、機能実装やバグ修正までの時間を短くする
 1. 開発環境と本番環境の差分が最小限となり、人的バグを極小化する
 1. オンプレミスやクラウドを問わず、デプロイが容易になる

これらをAlibaba Cloudのサービスを使って、どのように実現出来るかを紹介いたします。  

## 全体アーキテクチャ

システム構成  
![Show as JPEG](/help/image/23.1.png)

開発フロー  
![Show as JPEG](/help/image/23.1.png)

コンテナを用いる上では、エンドユーザから見た効果はほぼ同じであるが、
開発フローを刷新する事で、コンテナを最大限活用できます。
その為に、開発フローに焦点を当てて、コンテナの活用方式を紹介いたします。

### 開発フロー
1. 開発環境
1. バージョン管理
1. イメージビルド
1. イメージレジストリ
1. デプロイ・管理方式
1. モニター
1. ログ管理
1. データ分析

## 開発環境
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

## イメージレジストリ
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
