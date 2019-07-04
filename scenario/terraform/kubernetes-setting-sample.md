---
title: "Kubernetesの構築と設定"
date: 2019-07-01T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でkubernetesを作成します"
weight: 190
draft: false
---

&nbsp; 簡単なkuberntesクラスターを作ってみます。シングルゾーンによるクラスタでの作成になります。ゴールの構成図は以下の通りです。

![図 1](/help/image/20.1.png)

<br>
ソースは以下になります。サンプルソースは[こちら]()にあります。

<br>
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
  description = "Enable k8s-Sample vpc"  
}

resource "alicloud_vswitch" "vsw" {
  name = "${var.project_name}-vswitch"  
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
  description = "Enable k8s-Sample vswitch"  
}

resource "alicloud_cs_kubernetes" "k8s" {
  name                  = "${var.project_name}-k8s"  
  vswitch_ids           = ["${alicloud_vswitch.vsw.id}"]
  availability_zone     = "${var.zone}"
  new_nat_gateway       = true
  master_instance_types  = ["ecs.xn4.small"]
  worker_instance_types  = ["ecs.xn4.small"]
  worker_numbers        = [2]
  master_disk_size      = 40
  worker_disk_size      = 100
  password              = "${var.k8s_password}"
  pod_cidr              = "172.20.0.0/16"
  service_cidr          = "172.21.0.0/20"
  enable_ssh            = true
  install_cloud_monitor = true
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
variable "k8s_password" {}

```

<br>
output.tf

```
output "cluster_id" {
  value = ["${alicloud_cs_kubernetes.k8s.*.id}"]
}
output "worker_nodes" {
  value = ["${alicloud_cs_kubernetes.k8s.*.worker_nodes}"]
}
output "master_nodes" {
  value = ["${alicloud_cs_kubernetes.k8s.*.master_nodes}"]
}
```

<br>
confing.tfvars

```
access_key = "xxxxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "Kubernetes-Sample-for-Terraform"
k8s_password = "!Password2019"
```

<br>
provisioning.sh

```
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
これで問題なく実行できたら、cluster_id、worker_nodes、master_nodesが表示され、こうしてkubernetesクラスター操作、管理ができます。
<br>






