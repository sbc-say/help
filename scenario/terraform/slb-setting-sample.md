---
title: "SLBの構築と設定"
date: 2019-07-01T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でSLBを作成します"
weight: 170
draft: false
---

### SLBの構築と設定
&nbsp; SLB（Server Load Balancer）は、外部インターネット、もしくは内部イントラネットからパブリックIPまたはプライベートIPへ届くインバウンドトラフィックを予め設定したSLBの転送ルールに従って、複数のECSインスタンス間のインバウンドトラフィックを分散および制御し、アプリケーションの可用性を高めるサービスです。SLBを使うことで、以下のメリットがあります。

* 高可用性・・・完全冗長モードとして障害や災害時でもで稼働します。
* スケーラブル・・・サービスニーズに合わせて必要な台数分へサーバを増減します。
* 費用対効果・・・必要なリソースの分だけ使用なので、通常の負荷分散ハードウェアと比べてコスト削減します。
* セキュリティ・・・SLBはトラフィックを分散するだけでなくHTTP Flood攻撃やSYN Flood攻撃など、最大5GbitsのDDoS攻撃から防御できます。


SLBのより詳しい詳細は[こちらを参照](https://jp.alibabacloud.com/help/doc-detail/27539.htm)ください。


&nbsp; TerraformでSLBを使ったECSインスタンスを作成してみます。ゴールの構成図は以下の通りです。

![図 1](/help/image/18.1.png)
<br>

それぞれのパラメータは以下の通りです。

ネットワーク構成:


|リソース|リソース名|パラメータ|必須|設定値|内容|
|---|---|---|---|---|---|
|alicloud_vpc|vpc|name|任意|${var.project_name}-vpc|VPC の名称。この例の場合、SLB-Sample-for-Terraform-vpc として表示されます。|
||vpc|cidr_block|必須|192.168.1.0/24|VPC の CIDR ブロック|
||vpc|description|任意|Enable SLB-Setteing-Sample vpc|VPC の説明。|
|alicloud_vswitch|vsw|name|任意|${var.project_name}-vswitch|vswitch の名称。この例の場合、SLB-Sample-for-Terraform-vswitch として表示されます。|
||vsw|vpc_id|必須|${alicloud_vpc.vpc.id}|アタッチするVPCのID|
||vsw|cidr_block|必須|192.168.1.0/28|vswitch の CIDR ブロック|
||vsw|availability_zone|必須|${var.zone}|使用するアベイラビリティゾーン|
||vsw|description|任意|Enable SLB-Setteing-Sample vswitch|vswitch の説明。|


ECSインスタンスセキュリティグループ構成:


|リソース|リソース名|パラメータ|必須|設定値|内容|
|---|---|---|---|---|---|
|alicloud_security_group|sg|name|任意|${var.project_name}_sg"|セキュリティグループ の名称。この例の場合、SLB-Sample-for-Terraform_sgとして表示されます。|
||sg|vpc_id|必須|${alicloud_vpc.vpc.id}|アタッチするVPCのID|
||sg|description|任意|Enable SSH access via port 22|セキュリティグループ の説明。|
|alicloud_security_group_rule|allow_http|type|必須|ingress|セキュリティグループのタイプ。 ingress（受信） かegress（送信） のいずれかになります。|
||allow_http|ip_protocol|必須|tcp|通信プロトコル。 tcp, udp, icmp, gre, all のいずれかになります。|
||allow_http|nic_type|必須|intranet|ネットワークタイプ。 internet か intranet のいずれかになります。|
||allow_http|policy|必須|accept|許可ポリシー。 acceptか drop のいずれかになります。|
||allow_http|port_range|必須|80⁄80|通信プロトコルのポート範囲。値が「- 1/-1」の場合は無効になります。|
||allow_http|priority|必須|1|許可ポリシーの優先順位。|
||allow_http|security_group_id|必須|${alicloud_security_group.sg.id}|アタッチするセキュリティグループのID|
||allow_http|cidr_ip|任意|0.0.0.0/0|ターゲットとなるIPアドレス。デフォルトは「0.0.0.0/0」。値が「0.0.0.0/0」の場合は無制限状態となります。|


ECSインスタンス構成:


|リソース|リソース名|パラメータ|必須|設定値|内容|
|---|---|---|---|---|---|
|alicloud_instance|ECS_instance_for_SLB_Sample|instance_name|任意|${var.project_name}-ECS-instance|ECSインスタンスの名称。この例の場合、SLB-Sample-for-Terraform-ECS-instance として表示されます。|
||ECS_instance_for_SLB_Sample|host_name|任意|${var.project_name}-ECS-instance|ECSインスタンスのHost名称。この例の場合、SLB-Sample-for-Terraform-ECS-instance として表示されます。|
||ECS_instance_for_SLB_Sample|instance_type|必須|ecs.xn4.small|ECSインスタンスのタイプ。今回は ecs.xn4.smallを選定します。|
||ECS_instance_for_SLB_Sample|image_id|必須|centos_7_04_64_20G_alibase_201701015.vhd|ECSインスタンスのImageID。今回は centos_7_04_64_20G_alibase_201701015.vhd を選定します。|
||ECS_instance_for_SLB_Sample|system_disk_category|任意|cloud_efficiency|ECSインスタンスのディスクタイプ。デフォルトは cloud_efficiency です。|
||ECS_instance_for_SLB_Sample|security_groups|必須|”${alicloud_security_group.sg.id}”|アタッチするセキュリティグループのID|
||ECS_instance_for_SLB_Sample|availability_zone|必須|${var.zone}|使用するアベイラビリティゾーン|
||ECS_instance_for_SLB_Sample|vswitch_id|必須|${alicloud_vswitch.vsw.id}|アタッチするVSwitchのID|
||ECS_instance_for_SLB_Sample|password|任意|"${var.ecs_password}"|EC インスタンスのログインパスワード。|
||ECS_instance_for_SLB_Sample|internet_max_bandwidth_out|任意|5|パブリックネットワークへの最大帯域幅。デフォルトは0ですが、0より大きい値を入れるとパブリックIPアドレスがアタッチされます。|
||ECS_instance_for_SLB_Sample|user_data|任意|"${file("provisioning.sh")}"|ECSインスタンス起動後に実行するshell内容もしくはファイル名。今回はprovisioning.shにて記載しています。|


SLB構成:


|リソース|リソース名|パラメータ|必須|設定値|内容|
|---|---|---|---|---|---|
|alicloud_slb|default|name|任意|"${var.project_name}-slb"|SLBの名称。この例の場合、SLB-Sample-for-Terraform-slb として表示されます。|
||default|internet|必須|true|SLB addressのインターネットタイプ。Trueのインターネットにするか、falseのイントラネットいずれかになります。|
||default|internet_charge_type|必須|paybytraffic|インターネットチェンジタイプ。PayByBandwidth、PayByTrafficのいずれかになります。|
||default|bandwidth|任意|5|最大帯域幅。|
|alicloud_slb_listener|tcp_http|load_balancer_id|必須| "${alicloud_slb.slb.id}"|新しいリスナーを起動するために使用されるロードバランサID。|
||tcp_http|backend_port|必須|80|Server Load Balancerインスタンスバックエンドが使用するポート。|
||tcp_http|frontend_port|必須|80|Server Load Balancerインスタンスフロントエンドが使用するポート。|
||tcp_http|protocol|必須|"tcp"|使用するプロトコル。http、https、tcp、udpのいずれかになります。|
||tcp_http|bandwidth|任意|10|Listenerの最大帯域幅。|
||tcp_http|health_check_type|任意|"tcp"|ヘルスチェックのタイプ。tcpとhttpのいずれかになります。|
|alicloud_slb_attachment|slb_attachment|load_balancer_id|必須|"${alicloud_slb.slb.id}"|ロードバランサID。|
||slb_attachment|instance_ids|必須|"${alicloud_instance.ECS_instance_for_SLB_Sample.*.id}"|アタッチするECSインスタンスID。|



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


