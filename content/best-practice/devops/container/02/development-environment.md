---
title: "開発環境"
description: "Alibaba Cloudでコンテナを活用する際の開発環境を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 20
draft: false
---

本記事では、開発環境について紹介いたします。

1. 開発環境
1. コンテナイメージ管理
1. コンテナデプロイ管理
1. ログ管理とモニタリング

開発環境は、開発端末とバージョン管理リポジトリの２点に焦点を当てて紹介します。

## 開発環境
  - Windows
  - Linux
  - バージョン管理
  - Alibaba Cloudにおける選択肢
  - Kubernetes開発ツール

### Windows
プライベートでもビジネスでも最もよく利用されているOSはWindowsであり、
慣れ親しんだ画面のまま開発できるメリットは大きいです。

しかしながらWindowsのデスクトップ上でDockerをそのまま利用する為には
EditionやBIOS設定での制限をクリアする必要があります。

https://docs.docker.com/docker-for-windows/install/

Windowsにおける開発ツールとしては以下が挙げられます。
- Bash for Windows
- Docker Desktop for Windows
- 各種IDEのDocker Clientプラグイン

### macOS/Linux
普段からmacOSを利用している場合には、OSに対する制限は比較的少なく、以下公式URLを参照してインストールできます。

https://docs.docker.com/docker-for-mac/install/

LinuxもmacOSと同様、以下の公式URLからインストールできますが、OSの種類によってコマンドが異なる点に注意が必要です。

[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/) /
[Debian](https://docs.docker.com/install/linux/docker-ce/debian/) / 
[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/) /
[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)  

## バージョン管理
Github/Gitlab/Bitbucket
- Github Enterprise
- Gitlab
- Bitbuckert

### Alibaba Cloudにおける選択肢
開発端末において、Alibaba Cloudだからという選択肢はなく、コンテナ環境で最もユーザの文化にあった開発端末を推奨します。
また、Alibaba CloudにはSaaS型の開発環境サービスは2019年8月時点で提供されておりませんが、同サービスが提供され次第、本記事を更新して、紹介いたします。

ただし、バージョン管理リポジトリについては、Github/Gitlab/Bitbucketのいずれかを推奨しております。
理由としては、後述のContainer Registryサービスからのソースコードの読み取りが、上記3種類のリポジトリから可能な為です。

### 参考リンク一覧
Alibaba Cloudのコンテナベストプラクティス  
https://www.alibabacloud.com/help/doc-detail/60951.htm

コンテナ自動ビルドの設定  
https://www.alibabacloud.com/help/doc-detail/60997.htm
