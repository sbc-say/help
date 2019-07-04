---
title: "Terraform 23章 example: オートスケーリング"
date: 2019-07-01T00:00:00+09:00
weight: 10
draft: false
---

# 第23章
## example: オートスケーリング

&nbsp; 第8章までは Terraformのインストール方法、コード記載方法、実行方法、第9章-第16章はAlibabaCloudの基本プロダクトサービスの説明をしました。第17章-第24章はTerraformのサンプルコードを交えて解説します。

* [17章 example: ssh踏み台サーバ](docs/17/Bastion-Server.md)
* [18章 example: SLB設定サンプル](docs/18/SLB-Setting-Sample.md)
* [19章 example: RDS設定サンプル](docs/19/RDS-Setting-Sample.md)
* [20章 example: kubernetes設定サンプル](docs/20/Kubernetes-Setting-Sample.md)
* [21章 example: Webアプリケーション](docs/21/Web-Application.md)
* [22章 example: 高速コンテンツ配信](docs/22/Accelerated-Content-Delivery.md)
* **[23章 example: オートスケーリング](docs/23/Auto-Scaling.md)**
* [24章 example: KubernetesによるコンテナでWordPress作成](docs/24/Web-Application-on-Kubernetes.md)
* [25章 example: ECサイト構築](docs/25/EC-Site-Sample.md)

<br>
### 23.1 オートスケーリング
&nbsp; こちらはAlibabaCloud公式サイトにある[ソリューション構築例](http://alicloud-common.oss-ap-southeast-1.aliyuncs.com/Updated_Materials/One%20Pager%20-%20Auto%20Scaling.pdf?spm=a3c0i.8269155.598512.5.26b5718fXnIJCz&file=One%20Pager%20-%20Auto%20Scaling.pdf)を通じての紹介になります。

プロビジョニング済みのECSインスタンスをメインとするWebアプリケーションにて、予測が難しいトラフィックニーズに応じて、必要なECSインスタンス台数を増減してくれます。これにより、アプリケーションを止めることなく稼働し続けることが出来ます。同時にリソースに応じた需要増/減から必要なコスト管理も実現出来ます。


* アプリケーションの稼働時間・堅牢性向上
* サーバーの自動プロビジョニング
* ニーズに応じたコスト管理

<br>
&nbsp; TerraformでWebアプリケーションを作ってみます。ゴールの構成図は以下の通りです。

![図 23.1](../../../static/image/23.1.png)

<br>
ソースは以下になります。サンプルソースは[こちら]()にあります。

<br>
main.tf
```
provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "alicloud_vpc" "default" {
  name        = "${var.project_name}-vpc"
  cidr_block  = "192.168.0.0/16"
  description = "VPC for ${var.project_name}"
}

resource "alicloud_vswitch" "web" {
  name              = "${var.project_name}-web-vswitch"    
  description       = "Enable Web-Application web vswitch"    
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.zone}"
}

resource "alicloud_vswitch" "app" {
  name              = "${var.project_name}-app-vswitch"    
  description       = "Enable Web-Application app vswitch"       
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.zone}"
}

resource "alicloud_vswitch" "db" {
  name              = "${var.project_name}-db-vswitch"    
  description       = "Enable Web-Application db vswitch"      
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "192.168.3.0/24"
  availability_zone = "${var.zone}"
}

resource "alicloud_ess_scaling_group" "web" {
  scaling_group_name = "${var.solution_name}-ess-web"
  min_size           = "${var.web_instance_min_count}"
  max_size           = "${var.web_instance_max_count}"
  removal_policies   = ["OldestInstance", "NewestInstance"]
  loadbalancer_ids   = ["${alicloud_slb.web.id}"]
  vswitch_ids       = ["${alicloud_vswitch.web.id}"]
}

resource "alicloud_ess_scaling_configuration" "web" {
  scaling_group_id           = "${alicloud_ess_scaling_group.web.id}"
  image_id                   = "${var.web_instance_image_id}"
  instance_type              = "${var.web_instance_type}"
  scaling_configuration_name = "scaling-configuration-web"
  system_disk_category       = "cloud_efficiency"
  security_group_id          = "${alicloud_security_group.web.id}"
  active                     = true
}

resource "alicloud_ess_scaling_rule" "web" {
  scaling_rule_name = "${var.solution_name}-ess-rule-web"
  scaling_group_id  = "${alicloud_ess_scaling_group.web.id}"
  adjustment_type   = "TotalCapacity"
  adjustment_value  = 2
  cooldown          = 60
}

resource "alicloud_instance" "web" {
  count                      = "${var.web_instance_count}"
  instance_name              = "${var.web_layer_name}-${count.index}"
  host_name                  = "${var.web_layer_name}-${count.index}"
  instance_type              = "${var.web_instance_type}"
  system_disk_category       = "cloud_efficiency"
  image_id                   = "${var.web_instance_image_id}"
  availability_zone          = "${var.web_availability_zone}"
  vswitch_id                 = "${alicloud_vswitch.web.id}"
  security_groups            = ["${alicloud_security_group.web.id}"]
  internet_max_bandwidth_out = 5
  password                   = "${var.ecs_password}"
  user_data                  = "${var.web_instance_user_data}"
}

resource "alicloud_slb" "web" {
  name        = "${var.web_layer_name}-slb"
  internet    = true
  internet_charge_type = "paybytraffic"
  vswitch_id = "${alicloud_vswitch.web.id}"
}

resource "alicloud_slb_listener" "web_listener" {
  load_balancer_id = "${alicloud_slb.web.id}"
  backend_port = "${var.web_instance_port}"
  frontend_port = "${var.web_instance_port}"
  protocol = "http"
  bandwidth = 5
  health_check_type = "tcp"
}


resource "alicloud_slb_attachment" "web" {
  load_balancer_id = "${alicloud_slb.web.id}"
  instance_ids = ["${alicloud_instance.web.*.id}"]
}

resource "alicloud_oss_bucket" "oss"{
  bucket = "${var.project_name}-bucket"    
  acl = "private"
}

resource "alicloud_cdn_domain_new" "domain" {
      domain_name = "terraform.test.webapplication.net"
      cdn_type = "web"
      scope="overseas"
      sources {
         content = "${alicloud_slb.web.address}"
         type = "ipaddr"
         priority = "20"
         port = 80
         weight = "15"
      }
}

resource "alicloud_cdn_domain_config" "config" {
      domain_name = "${alicloud_cdn_domain_new.domain.domain_name}"
      function_name = "ip_allow_list_set"
      function_args {
            arg_name = "ip_list"
            arg_value = "${alicloud_slb.web.address}"
      }
}


resource "alicloud_security_group" "web" {
  name   = "${var.web_layer_name}-sg"
  vpc_id = "${alicloud_vpc.default.id}"
}

resource "alicloud_security_group_rule" "allow_web_access" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "${var.web_instance_port}/${var.web_instance_port}"
  priority          = 1
  security_group_id = "${alicloud_security_group.web.id}"
  cidr_ip           = "0.0.0.0/0"
}


resource "alicloud_instance" "app" {
  count                      = "${var.app_instance_count}"
  instance_name              = "${var.app_layer_name}-${count.index}"
  host_name                  = "${var.web_layer_name}-${count.index}"  
  instance_type              = "${var.app_instance_type}"
  system_disk_category       = "cloud_efficiency"
  image_id                   = "${var.app_instance_image_id}"
  availability_zone          = "${var.app_availability_zone}"
  vswitch_id                 = "${alicloud_vswitch.app.id}"
  security_groups            = ["${alicloud_security_group.app.id}"]
  internet_max_bandwidth_out = 5
  password                   = "${var.ecs_password}"
  user_data                  = "${var.app_instance_user_data}"
}

resource "alicloud_ess_scaling_group" "app" {
  scaling_group_name = "${var.solution_name}-ess-app"
  min_size           = "${var.app_instance_min_count}"
  max_size           = "${var.app_instance_max_count}"
  removal_policies   = ["OldestInstance", "NewestInstance"]
  loadbalancer_ids   = ["${alicloud_slb.app.id}"]
  vswitch_ids       = ["${alicloud_vswitch.app.id}"]
}

resource "alicloud_ess_scaling_configuration" "app" {
  scaling_group_id           = "${alicloud_ess_scaling_group.app.id}"
  image_id                   = "${var.app_instance_image_id}"
  instance_type              = "${var.app_instance_type}"
  scaling_configuration_name = "scaling-configuration-app"
  system_disk_category       = "cloud_efficiency"
  security_group_id          = "${alicloud_security_group.app.id}"
  active                     = true
}

resource "alicloud_ess_scaling_rule" "app" {
  scaling_rule_name = "${var.solution_name}-ess-rule-app"
  scaling_group_id  = "${alicloud_ess_scaling_group.app.id}"
  adjustment_type   = "TotalCapacity"
  adjustment_value  = 2
  cooldown          = 60
}

resource "alicloud_slb" "app" {
  name        = "${var.app_layer_name}-slb"
  internet    = false
  internet_charge_type = "paybytraffic"
  vswitch_id = "${alicloud_vswitch.app.id}"
}

resource "alicloud_slb_listener" "app_listener" {
  load_balancer_id = "${alicloud_slb.app.id}"
  backend_port = "${var.app_instance_port}"
  frontend_port = "${var.app_instance_port}"
  protocol = "tcp"
  bandwidth = 5
  health_check_type = "tcp"
}

resource "alicloud_slb_attachment" "app" {
  load_balancer_id = "${alicloud_slb.app.id}"
  instance_ids = ["${alicloud_instance.app.*.id}"]
}


resource "alicloud_security_group" "app" {
  name   = "${var.web_layer_name}-sg"
  vpc_id = "${alicloud_vpc.default.id}"
}


resource "alicloud_security_group_rule" "allow_app_access" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "${var.app_instance_port}/${var.app_instance_port}"
  priority          = 1
  security_group_id = "${alicloud_security_group.app.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_db_instance" "db_instance" {
  engine = "${var.db_engine}"
  engine_version = "${var.db_engine_version}"
  instance_type = "${var.db_instance_type}"
  instance_storage = "${var.db_instance_storage}"
  vswitch_id = "${alicloud_vswitch.db.id}"
  security_ips = ["10.0.2.0/24"]
}

resource "alicloud_db_database" "default" {
  name = "${var.db_layer_name}"
  instance_id = "${alicloud_db_instance.db_instance.id}"
  character_set = "utf8"
}

resource "alicloud_db_account" "default" {
  instance_id = "${alicloud_db_instance.db_instance.id}"
  name = "${var.db_user}"
  password = "${var.db_password}"
}

resource "alicloud_db_account_privilege" "default" {
  instance_id = "${alicloud_db_instance.db_instance.id}"
  account_name = "${alicloud_db_account.default.name}"
  db_names = ["${alicloud_db_database.default.name}"]
  privilege = "ReadWrite"  
}

resource "alicloud_db_connection" "default" {
  instance_id = "${alicloud_db_instance.db_instance.id}"
  connection_prefix = "alicloud-database"
  port = "3306"
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
variable "db_user" {}
variable "db_password" {}

variable "web_layer_name" {}
variable "web_instance_count" {}
variable "web_availability_zone" {}
variable "web_instance_type" {}
variable "web_instance_port" {}
variable "web_instance_image_id" {}
variable "web_instance_user_data" {}

variable "app_layer_name" {}
variable "app_instance_count" {}
variable "app_availability_zone" {}
variable "app_instance_type" {}
variable "app_instance_port" {}
variable "app_instance_image_id" {}
variable "app_instance_user_data" {}

variable "db_layer_name" {}
variable "db_availability_zone" {}
variable "db_engine" {}
variable "db_engine_version" {}
variable "db_instance_type" {}
variable "db_instance_storage" {}
```
<br>
confing.tfvars
```
access_key = "xxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "Accelerated-Content-Delivery-for-Terraform"
ecs_password = "!Password2019"
db_user = "test_user"
db_password = "!Password2019"

web_layer_name = "web-server"
web_availability_zone = "ap-northeast-1a"
web_instance_count = 3
web_instance_type = "ecs.sn1ne.large"
web_instance_port = 80
web_instance_image_id = "centos_7_06_64_20G_alibase_20190218.vhd"
web_instance_user_data = "${file("provisioning.sh")}"

app_layer_name = "app-server"
app_availability_zone = "ap-northeast-1a"
app_instance_count = 3
app_instance_type = "ecs.sn1ne.large"
app_instance_port = 5000
app_instance_image_id = "centos_7_06_64_20G_alibase_20190218.vhd"
app_instance_user_data = "${file("provisioning.sh")}"

db_layer_name = "db-server"
db_availability_zone = "ap-northeast-1a"
db_engine = "MySQL"
db_engine_version = "5.7"
db_instance_type = "rds.mysql.s1.small"
db_instance_storage = 10
```
<br>
output.tf
```
output "slb_web_public_ip" {
  value = "${alicloud_slb.web.address}"
}

output "ECS_instance_app_ip" {
  value = "${alicloud_instance.app.*.public_ip}"
}

output "ECS_instance_web_ip" {
  value = "${alicloud_instance.web.*.public_ip}"
}

output "rds_host" {
  value = "${alicloud_db_instance.db_instance.connection_string}"
}
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
### 23.2 実行
&nbsp; ソースの準備ができたら実行します。

```
terraform init
terraform play -var-file="confing.tfvars"
terraform apply -var-file="confing.tfvars"
```

<br>
これで完了です。問題なく実行できたら、ECSとSLBそれぞれのIP、RDS Hostが表示されます。

<br>



