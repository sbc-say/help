---
title: "Terraform 26章 example: DevOpsによるWebアプリケーション"
date: 2019-07-22T00:00:00+09:00
weight: 10
draft: true
---
# 第26章
## example: DevOpsによるWebアプリケーション

&nbsp; 第8章までは Terraformのインストール方法、コード記載方法、実行方法、第9章-第16章はAlibabaCloudの基本プロダクトサービスの説明をしました。第17章-第27章はTerraformのサンプルコードを交えて解説します。

* [17章 example: ssh踏み台サーバ](docs/17/Bastion-Server.md)
* [18章 example: SLB設定サンプル](docs/18/SLB-Setting-Sample.md)
* [19章 example: RDS設定サンプル](docs/19/RDS-Setting-Sample.md)
* [20章 example: kubernetes設定サンプル](docs/20/Kubernetes-Setting-Sample.md)
* [21章 example: Webアプリケーション](docs/21/Web-Application.md)
* [22章 example: 高速コンテンツ配信](docs/22/Accelerated-Content-Delivery.md)
* [23章 example: オートスケーリング](docs/23/Auto-Scaling.md)
* [24章 example: KubernetesによるコンテナでWordPress作成](docs/24/Web-Application-on-Kubernetes.md)
* [25章 example: Multi-AZ Kubernetes](docs/25/Multi-AZ_kubernetes.md)
* **[26章 example: DevOpsによるWebアプリケーション](ddocs/26/DevOps-Web-Application.md)**
* [27章 example: ECサイト構築](docs/27/EC-Site-Sample.md)


<br>
### 26.1 DevOpsによるWebアプリケーション
&nbsp; 

main.tf
```
variable "access_key" {
  type = "string"
  default = "XXXXX"
}
variable "secret_key" {
  type = "string"
  default = "XXXXX"
}
variable "region" {
  type = "string"
  default = "ap-southeast-2"
}
variable "vswitch" {
  type = "string"
  default = "XXX-XXXXX"
}
variable "sgroups" {
  type = "list"
  default = [
    "XX-XXXXX"
  ]
}
variable "name" {
  type = "string"
  default = "multi-tenant"
}
variable "password" {
  type = "string"
  default = "Test1234!"
}

provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

data "alicloud_images" "search" {
  name_regex = "^ubuntu_16.*_64"
}
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.xn4"
  cpu_core_count = 1
  memory_size = 1
}
data "template_file" "user_data" {
  template = "${file("user-data.sh")}"
}

resource "alicloud_instance" "web" {
  instance_name = "${var.name}"
  image_id = "${data.alicloud_images.search.images.0.image_id}"
  instance_type = "${data.alicloud_instance_types.default.instance_types.0.id}"

  vswitch_id = "${var.vswitch}"
  security_groups = "${var.sgroups}"
  internet_max_bandwidth_out = 100

  password = "${var.password}"

  user_data = "${data.template_file.user_data.template}"
}

output "ip" {
  value = "${alicloud_instance.web.public_ip}"
}
```

user_data.sh
```
#!/bin/bash -v

# Create docker-compose.yml
cat <<- 'EOF' > /opt/docker-compose.yml
version: '3.6'
services:
  proxy:
    image: neilpang/nginx-proxy
    network_mode: bridge
    container_name: proxy
    restart: on-failure
    ports:
      - "80:80"
      - "443:443"
    environment:
      - ENABLE_IPV6=true
    volumes:
      - ./certs:/etc/nginx/certs
      - /var/run/docker.sock:/tmp/docker.sock:ro
  web1:
    image: php:7.2-apache
    network_mode: bridge
    container_name: web1
    restart: on-failure
    environment:
      - VIRTUAL_HOST=web1.com
  web2:
    image: php:7.2-apache
    network_mode: bridge
    container_name: web2
    restart: on-failure
    environment:
      - VIRTUAL_HOST=web2.com
EOF

apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce docker-compose
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

cd /opt && docker-compose up -d
```
