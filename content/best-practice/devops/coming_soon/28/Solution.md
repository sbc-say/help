---
title: "Terraform 27章 example: DevOpsによるWebアプリケーション"
date: 2019-07-22T00:00:00+09:00
weight: 10
draft: true
---
# 第27章
## ソリューション

&nbsp; ここまで紹介したサンプルのうち、以下ソリューションを満たす方法があります。



[woocommerce](https://woocommerce.com/)
[Magento](https://magento.dekirumonn.com/)

https://blog.universe-web.jp/443/
https://blog.universe-web.jp/4044/


<br>
### 27.1 無料で使えるEC2テンプレートサイト
&nbsp; 


<br>
### 27.2 terraformの設定方法：Woo Commerce
&nbsp; 

<br>
### 27.3 terraformの設定方法：Magento
&nbsp; 

<br>
### 27.4 terraformの設定方法：Magento
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
