---
title: "Terraform 19章 example: RDS設定サンプル"
date: 2019-07-01T00:00:00+09:00
weight: 10
draft: false
---

# 第19章
## example: RDS設定サンプル

&nbsp; 第8章までは Terraformのインストール方法、コード記載方法、実行方法、第9章-第16章はAlibabaCloudの基本プロダクトサービスの説明をしました。第17章-第24章はTerraformのサンプルコードを交えて解説します。

* [17章 example: ssh踏み台サーバ](docs/17/Bastion-Server.md)
* [18章 example: SLB設定サンプル](docs/18/SLB-Setting-Sample.md)
* **[19章 example: RDS設定サンプル](docs/19/RDS-Setting-Sample.md)**
* [20章 example: kubernetes設定サンプル](docs/20/Kubernetes-Setting-Sample.md)
* [21章 example: Webアプリケーション](docs/21/Web-Application.md)
* [22章 example: 高速コンテンツ配信](docs/22/Accelerated-Content-Delivery.md)
* [23章 example: オートスケーリング](docs/23/Auto-Scaling.md)
* [24章 example: KubernetesによるコンテナでWordPress作成](docs/24/Web-Application-on-Kubernetes.md)
* [25章 example: ECサイト構築](docs/25/EC-Site-Sample.md)


<br>
### 19.1 SLB設定サンプル
&nbsp; Terraformで踏み台サーバ、本番サーバを作ってみます。ゴールの構成図は以下の通りです。

![図 19.1.1](image/19.1.1.png)

なおECSからRDS for MySQLへへ接続するためのdocker-compose.ymlファイルは以下の通りです。
![図 19.1.2](image/19.1.2.png)

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
  description = "Enable RDS Setting Sample vpc"  
}

resource "alicloud_vswitch" "vsw" {
  name              = "${var.project_name}-vswitch"  
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
  description = "Enable RDS Setting Sample vswitch"  
}


# DBを作成する
resource "alicloud_db_instance" "db_instance" {
  engine = "MySQL"
  engine_version = "5.7"
  instance_type = "rds.mysql.t1.small"
  instance_storage = 5
  vswitch_id = "${alicloud_vswitch.vsw.id}"
}

resource "alicloud_db_database" "default" {
  name = "${var.database_name}"
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
  connection_prefix = "slb-sample"
  port = "3306"
}


resource "alicloud_security_group" "sg_server" {
  name   = "${var.project_name}_security_group"
  description = "Enable RDS Setting Sample security group"  
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_server.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg_server.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "ECS_instance" {
  instance_name   = "${var.project_name}-SLB-Setting-Sample"
  host_name       = "${var.project_name}-SLB-Setting-Sample"
  instance_type   = "ecs.xn4.small"
  image_id        = "centos_7_04_64_20G_alibase_201701015.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg_server.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  password = "${var.ecs_password}"
  internet_max_bandwidth_out = 20
  user_data = "${file("provisioning.sh")}"
}

resource "alicloud_slb" "default" {
  name = "${var.project_name}-SLB"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  internet = true
  internet_charge_type = "paybytraffic"  
}

resource "alicloud_slb_listener" "http" {
  load_balancer_id = "${alicloud_slb.default.id}"
  backend_port              = 80
  frontend_port             = 80
  health_check_connect_port = 80
  bandwidth                 = 10
  protocol = "http"
  sticky_session = "on"
  sticky_session_type = "insert"
  cookie = "slblistenercookie"
  cookie_timeout = 86400
}

resource "alicloud_slb_attachment" "default" {
  load_balancer_id = "${alicloud_slb.default.id}"
  instance_ids = ["${alicloud_instance.ECS_instance.id}"]
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
variable "database_name" {}
variable "ecs_password" {}
variable "db_user" {}
variable "db_password" {}
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
output "rds_host" {
  value = "${alicloud_db_instance.db_instance.connection_string}"
}
```

<br>
confing.tfvars
```
access_key = "xxxxxxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "RDS-Setting-Sample-for-Terraform"
database_name = "rds_setting_sample"
ecs_password = "!Password2019"
db_user = "test_user"
db_password = "!Password2019"
```

<br>
provisioning.sh
```
#!/bin/sh
export MYSQL_HOST='rds-sample.mysql.japan.rds.aliyuncs.com'
export MYSQL_DATABASE='rds_setting_sample'
export MYSQL_USER='test_user'
export MYSQL_PASSWORD='!Password2019'

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install docker-ce
curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "version: '3'" >> docker-compose.yml
echo "services:" >> docker-compose.yml
echo "  # MySQL" >> docker-compose.yml
echo "  db:" >> docker-compose.yml
echo "    image: mysql:5.7" >> docker-compose.yml
echo "    container_name: mysql_host" >> docker-compose.yml
echo "    environment:" >> docker-compose.yml
echo "     - MYSQL_HOST=db_host" >> docker-compose.yml
echo "     - MYSQL_DATABASE=db_name" >> docker-compose.yml
echo "     - MYSQL_USER=db_user" >> docker-compose.yml
echo "     - MYSQL_PASSWORD=db_password" >> docker-compose.yml
echo "     - TZ='Asia/Tokyo'" >> docker-compose.yml
echo "    command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci" >> docker-compose.yml
echo "    volumes:" >> docker-compose.yml
echo "      - ./docker/db/data:/var/lib/mysql" >> docker-compose.yml
echo "      - ./docker/db/my.cnf:/etc/mysql/conf.d/my.cnf" >> docker-compose.yml
echo "      - ./docker/db/sql:/docker-entrypoint-initdb.d" >> docker-compose.yml
echo "    ports:" >> docker-compose.yml
echo "    - 3306:3306" >> docker-compose.yml
sed -i "s/=db_host/='$MYSQL_HOST'/g" docker-compose.yml
sed -i "s/=db_name/='$MYSQL_DATABASE'/g" docker-compose.yml
sed -i "s/=db_user/='$MYSQL_USER'/g" docker-compose.yml
sed -i "s/=db_password/='$MYSQL_PASSWORD'/g" docker-compose.yml

sudo service docker start
docker-compose up -d
```

<br>
### 19.2 実行
&nbsp; ソースの準備ができたら実行します。

```
terraform init
terraform play -var-file="confing.tfvars"
terraform apply -var-file="confing.tfvars"
```
<br>
これで完了です。問題なく実行できたら、ECSとSLBそれぞれのIP、DBのhostが表示されます。

<br>


