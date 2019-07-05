---
title: "インストール"
date: 2019-07-01T00:00:00+09:00
description: "Alibaba Cloudでも用いられるTerraformのインストール手順を説明します"
weight: 20
draft: false
---

本章は Terraform のインストール方法を学びます。  

> ※ Mac/Linuxでのインストール方法になります。Windows版でのTerraform導入方法は別途記載予定です。
> ※ Terraformバージョン違いを防止するために[こちらのDockerファイル](https://hub.docker.com/r/hashicorp/terraform/)を使った使用方法がありますが、こちらも別途記載予定です。

### 1. Homebrew
&nbsp; Terraformは前章で説明した通り、[HashiCorp](https://www.hashicorp.com/)社がオープンソースとして展開してるツールです。基本的にはバージョンアップに 追従しやすい tfenv の利用を推奨しますが、お試しであればHomebrew も手軽です。
macOS の場合は次のように、Homebrew を使ってインストールできます。

```
$ brew install terraform
$ terraform --version
Terraform v0.11.13
```
<br>

### 2. tfenv

[tfenv](https://github.com/tfutils/tfenv)は Terraformのバージョン管理マネージャです。
tfenvを使うことで、異なるバージョンのTerraformを差異なく利用できます。

```
$ brew install tfenv
$ tfenv --version
tfenv 0.6.0
```
完了したら、インストール可能なTerraform のバージョンを確認します。

```
$ tfenv list-remote
0.12.0-beta1
0.11.13
・・・
```

最新の安定バージョンかつAlibabaCloud Terraform対応は 0.11.13です。0.11.13を次のようにインストールします。

```
$ tfenv install 0.11.13
```

terraformには .terraform-versionというファイルがあり、こちらにバージョンを記述すると、そのバージョンを自動的にインストールできます。

```
$ echo 0.11.13 > .terraform-version
$ tfenv install
```

チームなど複数メンバーでの開発/運用の場合は、このファイルをリポジトリに含めましょう。
そうすれば、チームメンバが「tfenv install」コマンドを実行するだけでバージョンを統一できます。
<br>
### 3. クレデンシャル
&nbsp; TerraformでAlibabaCloudを扱うにはAccessKeysとSecretKeyが必要です。
AlibabaCloudコンソールにあるResource Access Management (RAM) でAccessKeysとSecretKeyを発行しましょう。
&nbsp; 本書ではAdministratorAccessポリシーをアタッチしたRAMユーザのAccessKeysを前提とします。
AdministratorAccessポリシー以外では、権限不足でTerraform実行が失敗する場合が゙あります。
その場合は、エラーメッセージを参考に必要な権限を付与します。

![図 1](/help/image/3.1.png)
▲ AlibabaCloudコンソールのRAMページにて、左側タブの「ユーザー」を選択します。
<br>
![図 2](/help/image/3.2.png)
▲ Terraformを実行したいユーザーを選択して、、（もちろんAlibabaCloudのリソースが実行できる権限がついてることが望ましい）
<br>
![図 3](/help/image/3.3.png)
▲ ユーザのAccessKey/SecretKeyを発行します。これは重要な情報なので無くさないようメモなどに残してください。

&nbsp; 上記作業によって取得したAccessKeysとSecretKeyは、`confing.tfvars`などに入れます。
ちなみに間違えてAccessKey/SecretKeyを外部流出しないよう気をつけてください。

<br>
confing.tfvars

```
access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "Web-Application-for-Terraform"
ecs_password = "!Password2019"
```

