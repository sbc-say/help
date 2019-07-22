---
title: "Terraform"
description: "AlibabaCloudにおけるTerraformの実践例を記載します"
date: 2019-05-13T16:20:40+09:00
weight: 30
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->
&nbsp; 本章はゴールとなる構成図、完成像からTerraformを使ってリソースを作成します。 この実践例は初心者でもわかりやすいようにモジュールは非使用、`main.tf`、`variables.tf`、`output.tf`、`confing.tfvars`、`provisioning.sh`の４つのファイルに分けて作成します。（kubernetesなど一部例外もありますし、`provisioning.sh`が空白の事例もあります。またTerraformはリソースごとに`immutable`と`not_immutable`で分けてフォルダ・ファイル構成をするのが理想ですが、ここは同フォルダにて同様配置を前提とします。）

このサンプルで実行したTerraformのバージョンは`Terraform v0.11.13`、`tfenv 0.6.0`になります。Terraformのバージョン情報は以下の記事を参照ください。 

https://sbcloud.github.io/help/best-practice/devops/terraform/02/install/

<br>
実践例の実行方法の流れとしては、実行したいコードを空のディレクトリに保存（格納）し、コードを実行するだけです。なので他のプロジェクトの実行ファイル`.tf`と混ざらないように注意してください。

<br>
コードを実行するときは `confing.tfvars` にて各自の個人情報を入力してください。
```
access_key = "xxxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxxx"
```
<br>
あとは以下のコマンドで実行できます。
```
terraform init
terraform play -var-file="confing.tfvars"
terraform apply -var-file="confing.tfvars"
```
<br>
もし作成したリソースを削除、解放したい場合は、諸元となるソースコードを一切変更せずに このコマンドを実行します。これで作成したリソースを破棄できます。
```
terraform destroy -var-file="confing.tfvars"
```

それではTerraformを使って誰でも簡単にAlibabaCloudによるリソース作成をしてみましょう。


<!-- 配下タイトル一覧がコンテンツの後に表示されます -->
