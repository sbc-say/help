---
title: "開発環境"
description: "Alibaba Cloudでコンテナを活用する際の開発環境を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 20
draft: false
---

以下の区分により、コンテナを活用したAlibaba Cloudにおける開発手法を紹介いたします。

1. 開発環境
1. コンテナイメージの作成・管理
1. コンテナデプロイ管理
1. ログ管理とモニタリング

本項目では、 <b>開発環境</b> に焦点を当てて、開発端末とバージョン管理システムの選択肢を紹介します。
その後、Alibaba Cloudにおける推奨を紹介します。

## 目次
- 開発端末
- バージョン管理
- Alibaba Cloudにおける推奨

## 開発端末
  - Windows
  - macOS
  - Linux/その他

#### Windows
プライベートでもビジネスでも最もよく利用されているOSはWindowsであり、慣れ親しんだUIのまま開発できるメリットは大きいです。
開発ツールとして、Docker Desktop for Windowsが提供されており、Bash for Windowsや各種IDEのDocker Clientプラグインと併せて、よく利用されます。  
ただ、Windowsのデスクトップ上でDockerコンテナを利用する為にはEditionやBIOSにおいて制限をクリアする必要があります。具体的にはOSがWindows 10 64-bitで、EditionはPro、Enterprise、もしくはEducationのいずれか、かつHyper-Vが有効化されている必要があります。最新の情報は以下の公式ホームページより確認ください。  
<br>
Docker Desktop for Windowsインストール要件：https://docs.docker.com/docker-for-windows/install/  
<br>
上記要件を満たしている場合には、Bash for Windowsを併せてインストールする事で、Windows上でDockerコンテナの開発環境が整います。  
Docker Desktop for Windowsのインストール要件を満たしていない場合には、Vagrantやパブリッククラウド上でLinuxを稼働させる形で開発環境を整えます。

#### macOS
macOSで開発する場合には、Windowsと比較して制限は少なく、OS X Sierra 10.12かそれより新しいOSが利用要件となります。
手順として、以下DockerhubのURLよりdmgパッケージをダウンロードします。
<br>
https://hub.docker.com/editions/community/docker-ce-desktop-mac  
<br>
その後、以下のDocker公式のURLの手順を参照して、インストールする事でDockerコンテナが利用可能となります。  
https://docs.docker.com/docker-for-mac/install/

#### Linux/その他
LinuxもmacOSと同様、以下の公式URLからインストールできます。OSによってコマンドが異なりますが、Dockerを含むパッケージリポジトリを登録して、OSのパッケージ管理コマンドを用いて、ダウンロードおよびインストールする流れとなります。  
<br>
[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/) /
[Debian](https://docs.docker.com/install/linux/docker-ce/debian/) / 
[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/) /
[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)  

## バージョン管理リポジトリ
- Github/Gitlab/Bitbucket
- それ以外のリポジトリ

#### Github/GitLab/Bitbucket
コンテナを活用した開発では、Gitを用いた形が一般的です。  
それぞれの概要は以下の通りとなります。  
<br>
Github: Gitのリポジトリとして最も有名なリポジトリ。利用における情報量も最も多い。  
GitLab: Githubの次に有名で、コード管理だけでなく、コンテナレジストリやCIを含めた様々な機能が無料で提供されている。  
Bitbucket: Atlassian社製で、同社のコラボレーションツールとの相性が良い。  
#### それ以外のリポジトリ
Gitリポジトリにおいて、Github/GitLab/Bitbucket以外のリポジトリは情報量が少なく、後述するAlibaba Cloudのコンテナサービスとの相性も良くありません。また、SVN等のGit以外のバージョン管理リポジトリも、情報量の観点から、今現在コンテナ開発に向いているとは言えません。

## Alibaba Cloudにおける推奨
#### 開発端末
開発端末において、Alibaba Cloudによる推奨の選択肢はありません。その為、最もユーザの文化にあった開発端末を推奨します。
また、Alibaba CloudにはSaaS型の開発環境サービスは2019年9月時点で提供されておりませんが、同サービスが提供され次第、本記事を更新して、紹介いたします。

#### バージョン管理リポジトリ
バージョン管理リポジトリについては、Github/Gitlab/Bitbucketのいずれかを推奨しております。
理由としては、Alibaba Cloudのコンテナイメージレジストリサービスである、Container Registryが上記のGitレポジトリとのアカウント連携可能な為となります。アカウント連携する事で、ソースコードの読み取りやDockerイメージビルドが自動で設定する事が可能となります。

#### 参考リンク一覧
Alibaba Cloudのコンテナベストプラクティス  
https://www.alibabacloud.com/help/doc-detail/60951.htm  
<br>
コンテナ自動ビルドの設定  
https://www.alibabacloud.com/help/doc-detail/60997.htm  
