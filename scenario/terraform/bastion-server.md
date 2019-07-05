---
title: "SSH踏み台サーバの作成"
date: 2019-07-01T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でssh踏み台サーバの作成方法を紹介します"
weight: 160
draft: false
---

&nbsp; Terraformで踏み台サーバ、本番サーバを作ってみます。ゴールの構成図は以下の通りです。

![図 1](/help/image/17.1.png)
<br>
ソースは以下になります。サンプルソースは[こちら]()にあります。

main.tf
```
provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "alicloud_vpc" "vpc" {
  name = "${var.project_name}-vpc"
  cidr_block = "192.168.1.0/24"
  description = "Enable Bastion-Server vpc"  
}

resource "alicloud_vswitch" "vsw" {
  name = "${var.project_name}-vswitch"  
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
  description = "Enable Bastion-Server vswitch"  
}

# SSH踏み台専用
resource "alicloud_security_group" "sg_bastion_server" {
  name   = "${var.project_name}_Bastion_Server"
  description = "Enable SSH access via port 22"  
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_bastion_server.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ECS_instance_for_Bastion_Server" {
  instance_name   = "${var.project_name}-Bastion-Server-ECS-instance"
  host_name       = "${var.project_name}-Bastion-Server-ECS-instance"
  instance_type   = "ecs.xn4.small"
  image_id        = "centos_7_04_64_20G_alibase_201701015.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg_bastion_server.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  password = "!Bastion2019"
  internet_max_bandwidth_out = 5
}

# 実行サーバ専用
resource "alicloud_security_group" "sg_production_server" {
  name   = "${var.project_name}_Production_Server"
  description = "Marker security group for Production server"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_production_server.id}"
  cidr_ip           = "0.0.0.0/0"
}

# 実行サーバへssh接続はssh踏み台サーバのみ許容する
resource "alicloud_security_group_rule" "allow_ssh_for_Bastion" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_production_server.id}"
  cidr_ip           = "${alicloud_instance.ECS_instance_for_Bastion_Server.public_ip}" 
}

resource "alicloud_instance" "ECS_instance_for_Production_Server" {
  instance_name   = "${var.project_name}-Production-Server-ECS-instance"
  host_name   = "${var.project_name}-Production-Server-ECS-instance"
  instance_type   = "ecs.n4.small"
  image_id        = "centos_7_04_64_20G_alibase_201701015.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg_production_server.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  internet_max_bandwidth_out = 5
  password = "!Production2019"  
  user_data = "${file("provisioning.sh")}"
}
```

<br>  
variables.tf

```
variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "zone" {}
variable "project_name" {}
```
<br>
output.tf

```
output "Bastion-Server-ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance_for_Bastion_Server.*.public_ip}"
}

output "Production-Server-ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance_for_Production_Server.*.public_ip}"
}
```
<br>
confing.tfvars

```
access_key = "xxxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "Bastion-Server-for-Terraform"
```
<br>
provisioning.sh

```
#!/bin/sh
yum install -y httpd
systemctl start httpd
systemctl enable httpd
```
<br>

### 実行
&nbsp; ソースの準備ができたら実行します。

```
terraform init
terraform play -var-file="confing.tfvars"
terraform apply -var-file="confing.tfvars"
```

![図 2](/help/image/17.2.1.png)
<br>
これで問題なく実行できたら、踏み台サーバと本番サーバそれぞれのPublic IPが表示されます。
![図 3](/help/image/17.2.2.png)
<br>

実際にssh制限してるかチェックしてみます。踏み台サーバのIPアドレスが`47.74.54.92`、本番サーバのIPアドレスが`47.74.52.85`です。
![図 4](/help/image/17.2.3.png)
<br>

本番サーバにsshログインは出来ず、ssh踏み台サーバにsshログインできました。
それでは本番サーバに踏み台サーバからsshログインしてみます。
![図 5](/help/image/17.2.4.png)
ログインできました。これで本番サーバに対し外部からssh接続不可といったセキュアな運用ができます。


<!--

<br>
### 17.3 ssh踏み台サーバ with OSSへのロギング
&nbsp; Terraformで踏み台サーバ、本番サーバを作りました。今度はOSSへのロギング付きバージョンを作ってみます。
全てのSSH接続は、セキュリティ観点上 OSSのssh-logsバケットにて記録されます。
ゴールの構成図は以下の通りです。

![図 17.3](/help/image/17.3.png)
<br>
ソースは以下になります。サンプルソースは[こちら]()にあります。

-->
