---
title: "コンテナイメージ作成・管理"
description: "Alibaba Cloudでコンテナを活用する際のコンテナイメージ管理手法を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 30
draft: false
---
以下の区分により、コンテナを活用したAlibaba Cloudにおける開発手法を紹介いたします。

1. 開発環境
1. コンテナイメージの作成・管理
1. コンテナデプロイ管理
1. ログ管理とモニタリング

本項目では、 <b>コンテナイメージ作成・管理</b> に焦点を当てて、インターネットと接続しないプライベート環境における手法とインターネット上で利用可能なパブリックサービスを用いた手法の2種類を紹介します。その後、Alibaba Cloudにおける推奨を紹介します。

## コンテナイメージ管理
  - プライベート環境における手法
  - パブリックサービスを用いた手法
  - Alibaba Cloudにおける推奨

### プライベート環境における手法
プライベート環境（外部公開していないサーバ）にてコンテナをビルドする時には、まずコンテナイメージをビルドするスクリプトを自身で作成します。その後、パイプラインツールを実行するサーバを作成してその上で、「コードソースの変更を検知して、ビルドスクリプトを実行、ビルドされたコンテナイメージをイメージリポジトリにプッシュする」仕組みを実装するのが一般的です。  
パイプラインツールはJenkinsが無償で利用でき、最も広く利用されています。パブリックサービスであるGitLabCIやCircleCIの有償パッケージを、プライベート環境に導入する事も可能です。コンテナイメージリポジトリは有償のDocker Trusted RegistryやGitlab Enterprise Registryが利用可能です。

- イメージビルド
  - Jenkins/JenkinsX
  - GitLabCI
  - CircleCI Enterprise
- イメージレジストリ
  - Docker Trusted Registry
  - Gitlab Enterprise Registry

### パブリックサービスを用いた手法
パブリックサービスを用いてコンテナイメージをビルドする時も、自前でビルドスクリプトを作成する点は変更ありません。
ただ独自の環境変数やパイプライン処理が事前に提供されている為、Jenkins等のパイプラインツールよりも簡素的に実装できる事が多く、何よりサーバの管理が不要な為、運用における利便性に優れていると言えます。

- イメージビルド
  - GitLabCI
  - CircleCI
  - TravisCI
- イメージレジストリ
  - Dockerhub
  - Gitlab Registry

### Alibaba Cloudでの選択肢
Alibaba CloudではContainer Registryというイメージサービスの機能の一つとしてコンテナのビルドが実行できます。
Container RegistryはGithub/Gitlab/Bitbucketのソースコードを読み取り、自動でビルドを実行して
イメージをリポジトリにプッシュします。特徴的なのは他のサービスでは必要となるビルドスクリプトの作成や
YAMLファイルが一切不要で、GUI操作のみで一貫してビルドからプッシュまでを設定できる点です。
この為、Container Registryは有用な選択肢の一つと言えるでしょう。

- イメージビルド・レジストリ
  - Container Registry

## 参考リンク一覧
|タイトル|URL|
| ---- | ---- |
|Alibaba Cloudのコンテナベストプラクティス|https://www.alibabacloud.com/help/doc-detail/60951.htm|
|コンテナ自動ビルドの設定|https://www.alibabacloud.com/help/doc-detail/60997.htm|

