---
title: "Terraform 07章 dockerについて"
date: 2019-07-01T00:00:00+09:00
weight: 10
draft: false
---


# 第7章
## dockerについて

&nbsp; 前章までは Terraformのインストール方法、Terraformの文法、実行方法を説明しました。しかしこれらは`Terraform v0.11.13`前提での話なので、Terraformのバージョンが違うことで挙動が異なってしまうこともあります。Terraformでよく使うメソッドが急に廃止、、というのもよくあります。それを防ぐためにdockerを使ったインストール、利用する方法があります。dockerはパッケージングを行うための技術です。
**注：Terraformのバージョン食い違いは基本的に[tfenv](https://github.com/tfutils/tfenv)でカバーできます。詳しくは[3章 Install & docker](docs/3/install.md)を参照してください*

<br>
### 7.1 dockerについて
&nbsp; dockerはOS・ミドルウェア・ファイルシステム全体をイメージという単位で取り扱い、まるごとやりとり出来るツールです。また、イメージの配布やバージョン管理も可能です。メリットとして、手軽に同じ環境を何人のユーザ・ユーザ・他のマシンでも手に入れることができ、即座に同環境を再現（ CI (Continuous Integration) 継続的インテグレーションと CD (Continuous Delivery) 継続的デリバリー ）することができます。
また、dockerによるTerraformのインストールのみならず、docker Imageを使った既存のプロダクトリソースをそのまま導入することも可能です。（docker Imageとは、dockerコンテナを作成する際に必要となるファイルシステムです。）


<br>
### 7.2 dockerのTerraform位置について
&nbsp; Terraformによるdockerの利用は大きく2パターンあります。
* Terraformのバージョン違いなど環境差分を抑えつつ実行する場合
* CI/CD:継続的インテグレーションと継続的デリバリーをする場合

&nbsp; 前者はバージョン固定や実行環境を汚さずに使用するメリットがあります。様々な環境でterraformを使用したい場合は直接terraformコマンドをインストールせず、バージョン管理が可能なツール(`tfenv`)を使用してインストールすルことを勧めます。
![図 7.0](image/7.0.png)

&nbsp; 後者に関しては、dockerのImageファイルをdocker hub（リポジトリ）へ保存することで、新規ECSや各種アプリケーション、Webサイトを立ち上げる時、docker hub（リポジトリ）から対象のDocker ImageファイルをPullしそのまま実行することで、どの環境でも継続CI/CDを実現することができます。

![図 7.1](image/7.1.png)
本ガイドラインはTerraformをメインとしてるため、ここにCI/CDや方法は載せませんが、やり方は以下サイトを参照してみてください。（近日中に日本語で手順方法を載せる予定）

[Dockerize App and Push to Container Registry: CI/CD Automation on Container Service (1)](https://www.alibabacloud.com/blog/dockerize-app-and-push-to-container-registry-cicd-automation-on-container-service-1_594539)

[Continuous Deployment Automation on Alibaba Cloud: CI/CD Automation on Container Service (2)](https://www.alibabacloud.com/blog/continuous-deployment-automation-on-alibaba-cloud-cicd-automation-on-container-service-2_594540)

[Deploy Docker Image to Alibaba Cloud Container Service: CI/CD Automation on Container Service (3)](https://www.alibabacloud.com/blog/deploy-docker-image-to-alibaba-cloud-container-service-cicd-automation-on-container-service-3_594541)



<br>
### 7.3 docker上でのTerraform実行について
&nbsp; それではdocker上でterraformを実行してみます。実行するためには先にdocker Imageを入手する必要がありますので、まずは以下サイトを[参照](https://hub.docker.com/r/hashicorp/terraform/)してください。
https://hub.docker.com/r/hashicorp/terraform/


参考：Terraformのdocker Imageについて
https://github.com/hashicorp/docker-hub-images/tree/master/packer

<br>
Desktopにて`terraform-docker`というディレクトリを作成し、そこでdockerを実行します。
```
$ mkdir ~/Desktop/terraform-docker
$ cd ~/Desktop/terraform-docker
$ touch main.tf
```
以下サンプルソース main.tfを作ってみます。
```
provider "alicloud" {
  region = "ap-northeast-1"
}

resource "alicloud_vpc" "vpc" {
  name = "docker-test-vpc"
  cidr_block = "192.168.1.0/24"
}
```
<br>
これで準備完了です。構成はこの通りになります。

![図 7.2](image/7.2.png)
<br>

次にTerraformをdocker上で起動します。
そのとき、access_key・secret_keyを渡すことでAlibabaCloudのTerraformが実行できます。また、ホストのカレントディレクトリをコンテナ上へマウント( -v $(pwd):/terraform )してファイルの共有を行います。
今後の記述するTerraformのコードはこのディレクトリに配置してコンテナと共有します。
またterraformのバージョンは過去の`0.10.1`を指定してみます。

```
docker run \
    -e access_key=<ACCESS KEY> \
    -e secret_key=<SECRET KEY> \
    -v $(pwd):/terraform \
    -w /terraform \
    -it \
    --entrypoint=ash \
    hashicorp/terraform:0.10.1
```

<br>
これが実行できたらdocker環境上に入ります。
最後に、docker内でTerraformを操作するためのコマンドを確認してみます。
```
terraform version
```
<br>
実行内容、結果はこのようになります。

![図 7.3](image/7.3.png)

<br>
あとはいつもの通りに`terraform init`や`terraform plan`、`terraform apply`を実行するだけです。（docker環境、terraform version 0.10.1での実行になります。）

![図 7.4](image/7.4.png)
<br>

docker環境を終了する場合は`exit`を入力するだけです。
```
exit
```



