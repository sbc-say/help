---
title: "Kubernetesの構築と設定"
date: 2019-07-22T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でkubernetesを作成します。"
weight: 190
draft: false
---


&nbsp; 簡単なkuberntesクラスターを作ってみます。シングルゾーンによるクラスタでの作成になります。ゴールの構成図は以下の通りです。

![図 1](/help/image/20.1.png)

それぞれのパラメータは以下の通りです。


ネットワーク構成:


|リソース|リソース名|パラメータ|必須|設定値|内容|
|---|---|---|---|---|---|
|alicloud_vpc|vpc|name|任意|${var.project_name}-vpc|VPC の名称。この例の場合、Kubernetes-Sample-for-Terraform-vpc として表示されます。|
||vpc|cidr_block|必須|192.168.1.0/24|VPC の CIDR ブロック|
||vpc|description|任意|Enable k8s-Setteing-Sample vpc|VPC の説明。|
|alicloud_vswitch|vsw|name|任意|${var.project_name}-vswitch|vswitch の名称。この例の場合、Kubernetes-Sample-for-Terraform-vswitch として表示されます。|
||vsw|vpc_id|必須|${alicloud_vpc.vpc.id}|アタッチするVPCのID|
||vsw|cidr_block|必須|192.168.1.0/28|vswitch の CIDR ブロック|
||vsw|availability_zone|必須|${var.zone}|使用するアベイラビリティゾーン|
||vsw|description|任意|Enable k8s-Sample vswitch|vswitch の説明。|


kubernetesクラスター構成:


|リソース|リソース名|パラメータ|必須|設定値|内容|
|---|---|---|---|---|---|
|alicloud_cs_kubernetes|k8s|name|任意|${var.project_name}-k8s|kubernetesクラスター名称|
||k8s|vswitch_ids|必須|"${alicloud_vswitch.vsw.id}"|アタッチするVSwitchのID。|
||k8s|availability_zone|必須|${var.zone}|使用するアベイラビリティゾーン|
||k8s|new_nat_gateway|任意|true|kubernetesクラスタの作成中に新しいNATゲートウェイを作成するかどうか。デフォルトはtrue。|
||k8s|master_instance_types|必須| ["ecs.xn4.small"]|マスターノードのインスタンスタイプ。|
||k8s|worker_instance_types|必須| ["ecs.xn4.small"]|ワーカーノードのインスタンスタイプ。|
||k8s|worker_numbers|任意|[2]|ワーカーノードの台数。|
||k8s|master_disk_size|任意|40|マスターノードのシステムディスクサイズ。|
||k8s|worker_disk_size|任意|100|ワーカーノードのシステムディスクサイズ。|
||k8s|password|任意|"${var.k8s_password}"|クラスタノードのsshログインパスワード。|
||k8s|pod_cidr|任意|"172.20.0.0/16"|ポッドネットワークのCIDRブロック。|
||k8s|service_cidr|任意|"172.21.0.0/20"|サービスネットワークのCIDRブロック。|
||k8s|enable_ssh|任意|true|SSHログインを許可するか。デフォルトはfalse。|
||k8s|install_cloud_monitor|任意|true|クラウドモニタをkubernetesノードにインストールするかどうか。|


<br>
ソースは以下になります。

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
# 今回はprovisioning.shを使用しないため、空白です
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

```
alicloud_cs_kubernetes.k8s: Still creating... (25m10s elapsed)
alicloud_cs_kubernetes.k8s: Still creating... (25m20s elapsed)
alicloud_cs_kubernetes.k8s: Still creating... (25m30s elapsed)
alicloud_cs_kubernetes.k8s: Still creating... (25m40s elapsed)
alicloud_cs_kubernetes.k8s: Creation complete after 25m42s (ID: cfdaeda40f6b9426e833f6cfc059b3d20)

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

cluster_id = [
    cfdaeda40f6b9426e833f6cfc059b3d20
]
master_nodes = [
    [
        map[id:i-6we4hecn7bodqrq6xsbx name:master-01-k8s-for-cs-cfdaeda40f6b9426e833f6cfc059b3d20 private_ip:192.168.1.5],
        map[private_ip:192.168.1.6 id:i-6web68sjtatfr2o4uhca name:master-02-k8s-for-cs-cfdaeda40f6b9426e833f6cfc059b3d20],
        map[id:i-6we8iuga202nxkttrj2b name:master-03-k8s-for-cs-cfdaeda40f6b9426e833f6cfc059b3d20 private_ip:192.168.1.7]
    ]
]
worker_nodes = [
    [
        map[name:worker-k8s-for-cs-cfdaeda40f6b9426e833f6cfc059b3d20 id:i-6we756j83yg6rsnuzc3n private_ip:192.168.1.8],
        map[private_ip:192.168.1.9 id:i-6we756j83yg6rsnuzc3o name:worker-k8s-for-cs-cfdaeda40f6b9426e833f6cfc059b3d20]
    ]
]


```
<br>






