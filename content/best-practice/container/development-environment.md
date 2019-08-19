---
title: "Container Architecture"
description: "Alibaba Cloudでコンテナを活用したシステム構成を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 20
draft: true
---

コンテナを用いる上では、エンドユーザから見た効果はほぼ同じであるが、
開発フローを刷新する事で、コンテナを最大限活用できます。
その為に、開発フローに焦点を当てて、コンテナの活用方式を紹介いたします。

## 全体アーキテクチャ

システム構成  
![Show as JPEG](/help/image/23.1.png)

開発フロー  
![Show as JPEG](/help/image/23.1.png)


### 開発フロー
1. 開発環境
1. バージョン管理
1. イメージビルド
1. イメージレジストリ
1. デプロイ・管理方式
1. モニター

## 開発環境
  - Windows
  - macOS/Linux
  - SaaS

### Windows
プライベートでもビジネスでも最もよく利用されているOSはWindowsであり、
慣れ親しんだ画面のまま開発できるメリットは大きいです。

しかしながらWindowsのデスクトップ上でDockerをそのまま利用する為には
EditionやBIOS設定での制限をクリアする必要があります。

https://docs.docker.com/docker-for-windows/install/

言い換えれば、macOSやLinuxを利用するケースと比べて手間がかかるというデメリットがあり
慣れないうちはVirtualBoxやIaaSを用いてLinux環境を用意するのが無難でしょう。

### macOS/Linux
普段からmacOSを利用している場合には、OSに対する大きな制限はない為、以下公式URLを参照して
比較的容易にインストールできます。

https://docs.docker.com/docker-for-mac/install/

LinuxもmacOSと同様、以下の公式URLからインストールできますが、OSの種類によってコマンドが異なる点に注意が必要です。

[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/) /
[Debian](https://docs.docker.com/install/linux/docker-ce/debian/) / 
[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/) /
[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)  

### SaaS
Alibaba CloudにはSaaS型のクラウド開発環境は2019年8月時点ではありませんが、
サービス提供が開始次第、本記事を更新して、紹介いたします。

## 開発ツール
Containerと併用する事が有用な開発ツールを紹介します。
いずれもAlibaba Cloud上でコンテナサービスを利用する時でも有益なものとなります。

 - skaffold: Kubernetesと連動して試験可能な開発ツール  
https://skaffold.dev/docs/getting-started/

 - Minikube: ローカル環境におけるKubernetes環境  
https://kubernetes.io/docs/tasks/tools/install-minikube/

