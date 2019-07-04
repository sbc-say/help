---
title: "SLBの構築と設定"
date: 2019-07-01T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でSLBを作成します"
weight: 170
draft: false
---

&nbsp; TerraformでロードバランサーであるSLBの構築と設計行ってみます。ゴールの構成図は以下の通りです。

![図 1](/help/image/18.1.png)
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
  description = "Enable SLB-Setteing-Sample vpc"  
}

resource "alicloud_vswitch" "vsw" {
  name = "${var.project_name}-vswitch"  
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
  description = "Enable SLB-Setteing-Sample vswitch"  
}

resource "alicloud_security_group" "sg" {
  name   = "${var.project_name}_sg"
  description = "Marker security group for SLB-Setteing-Sample"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ECS_instance_for_SLB_Sample" {
  instance_name   = "${var.project_name}-ECS-instance"
  host_name   = "${var.project_name}-ECS-instance"
  instance_type   = "ecs.n4.small"
  image_id        = "centos_7_04_64_20G_alibase_201701015.vhd"
  system_disk_category = "cloud_efficiency"
  count = 2
  security_groups = ["${alicloud_security_group.sg.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  internet_max_bandwidth_out = 5
  password = "${var.ecs_password}"
  user_data = "${file("provisioning.sh")}"
}

resource "alicloud_slb" "default" {
  name                 = "${var.project_name}-slb" 
  internet             = true
  internet_charge_type = "paybytraffic"
  bandwidth            = 5
}

resource "alicloud_slb_listener" "tcp_http" {
  load_balancer_id = "${alicloud_slb.slb.id}"
  backend_port = "80"
  frontend_port = "80"
  protocol = "tcp"
  bandwidth = "10"
  health_check_type = "tcp"
}

resource "alicloud_slb_attachment" "slb_attachment" {
  load_balancer_id = "${alicloud_slb.slb.id}"
  instance_ids = ["${alicloud_instance.ECS_instance_for_SLB_Sample.*.id}"]
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
variable "ecs_password" {}
```

<br>
output.tf

```
output "ECS_instance_ip" {
  value = "${alicloud_instance.ECS_instance.*.public_ip}"
}
output "slb_ip" {
  value = "${alicloud_slb.default.address}"
}
```

<br>
confing.tfvars

```
access_key = "xxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "SLB-Sample-for-Terraform"
ecs_password = "!Password2019"
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

<br>
これで完了です。問題なく実行できたら、ECSとSLBのIPが表示されます。

<br>


