---
title: "Terraform 14章 RDS"
date: 2019-07-01T00:00:00+09:00
weight: 10
draft: false
---

# 第14章
## AlibabaCloud RDSについて

&nbsp; 第8章までは Terraformのインストール方法、コード記載方法、実行方法を説明しました。第9章-第16章はユーザ各自でコード作成、応用ができるよう、AlibabaCloudの基本プロダクトサービスの説明を通じて解説します。

* 第9章：AlibabaCloud VPC
* 第10章：AlibabaCloud ECS、EIP
* 第11章：AlibabaCloud SLB
* 第12章：AlibabaCloud AutoScale
* 第13章：AlibabaCloud OSS
* **第14章：AlibabaCloud RDS**
* 第15章：AlibabaCloud RAM
* 第16章：AlibabaCloud Kubernetes

各章それぞれサンプルを交えて説明します。


<br>
### 14.1 RDS
&nbsp; Relation Database Service （RDS）は、ApsaraDB for RDS 、クラウド内の独立したデータベースサービスです。

<br>
### 14.2 コンポーネント
&nbsp; ApsaraDB for RDSシリーズとしてMySQL、SQL Server、PostgreSQL、PPASがあります。

・ApsaraDB for MySQL・・・MySQL。現状5.5、5.6、5.7をサポートしています。

・ApsaraDB for SQL Server・・・SQL Server。2008 R2 EE、2012 のWeb/Standard/EE、2016 のWeb/Standard/EEをサポートしています。

・ApsaraDB for PostgreSQL・・・PostgreSQL。9.4をサポートしています。

・ApsaraDB for PPAS・・・Postgres Plus Advanced Server （ PPAS ）、Oracle Database互換性機能があります。現在バージョン 9.3 をサポートしています。

<br>
### 14.3 RDSのTerraformについて
&nbsp; 本題、RDS作成に移ります。ApsaraDB for MySQLというインスタンスを作成し、databaseをセット、アカウントを作成する内容です。

```
resource "alicloud_db_instance" "default" {
  engine = "MySQL"
  engine_version = "5.6"
  instance_type = "rds.mysql.t1.small"
  instance_storage = 5
  vswitch_id = "${var.vswitch}"
  security_ips = [
    "0.0.0.0/0"
  ]
}

resource "alicloud_db_database" "default" {
  instance_id = "${alicloud_db_instance.default.id}"
  name = "bolt_site"
  character_set = "utf8"
}

resource "alicloud_db_account" "default" {
  instance_id = "${alicloud_db_instance.default.id}"
  name = "db_user"
  password = "db1234"
}

```
#### **alicloud_db_instance**
* `engine` - （必須）データベースタイプ。MySQL、SQLServer、PostgreSQL、PPASのどれかを選定。
* `engine_version` - （必須）データベースのバージョン。
* `instance_type` - （必須）DBインスタンスタイプ。
* `instance_storage` - （必須）DBインスタンスのストレージ容量。
* `vswitch_id` - （必須）接続したいVSwitchのID。 

他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/db_instance.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/db_instance.html


#### **alicloud_db_database**
※ ***alicloud_db_database はPostgreSQL、PPASデータベースソースをサポートしていないため、別の作り方で回避する必要があります***
* `instance_id` - （必須）データベースを実行できるインスタンスのID。
* `name` - （必須）データベースの名前。
* `character_set` - （必須）文字コード。

#### **alicloud_db_account**
* `instance_id` - （必須）データベースを実行できるインスタンスのID。
* `name` - （必須）アカウント。
* `password` - （必須）アカウントに対するパスワード。


<br>
第18章にRDSの実際のサンプルを入れていますので、こちらも参照してみてください。

[18章 example: RDS設定サンプル](docs/18/RDS-Setting-Sample.md)





