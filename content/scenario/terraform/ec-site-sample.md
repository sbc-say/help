---
title: " MagentoでECサイト構築"
date: 2019-07-22T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でMagentoのECサイト構築作成方法を紹介します。"
weight: 240
draft: false
---

&nbsp; インターネットを通じて自社商品を販売、宣伝するのにおすすめなのが、ECサイトを作るという方法です。ECは Electronic Commerce（電子商取引）の略です。
ECサイトの一つとして、オープンソースの電子商取引アプリケーション `Magento`と`Woo Commerce` を使った構築方法がメインとなっています。`Magento`、もしくは`Woo Commerce` を使用すると、コーディングを一切行わなくてもオンラインストアをすばやく設定できます。それだけでなく多くの拡張機能、プラグイン、そしてテーマでカスタマイズすることもできます。今回は AlibabaCloud上にて高可用性アーキテクチャで`Magento Community Edition`をIaCで自動実装してみます。

* [Magento](https://magento.com/)
* [Woo Commerce](https://woocommerce.com)
![図 1](/help/image/25.1.png)
![図 2](/help/image/25.2.png)

<br>
ちなみに、Amazonや楽天のように一つのWebサイトに複数の商店の商品やサービスがまとまっているものはオンラインモールといい、オープンソースのオンラインショッピング Webサイト管理システム `EC-CUBE`などの方法があります。

* [EC-CUBE](https://www.ec-cube.net/)
![図 3](/help/image/25.3.png)

<br>
### ECサイトMagentoの構築について
&nbsp; ECサイト MagentoをTerraformを使って一発で構築してみます。ゴールの構成図は以下の通りです。

![図 4](/help/image/25.4.png)
<br>
ソースは以下になります。サンプルソースは[こちら]()にあります。

<br>

* [GUIでの操作方法](https://jp.alibabacloud.com/getting-started/projects/deploy-magento-on-alibaba-cloud)もありますのでこちらも参考にしてください。

  https://jp.alibabacloud.com/getting-started/projects/deploy-magento-on-alibaba-cloud?spm=a21mg.172235.898935.4.7b89497bUXnkWz

* ECSインスタンス１台にてMySQL、PHP、Magentoを入れる方法もあります。軽量でスモールスタートする場合、こちらも是非参照ください。
  https://www.alibabacloud.com/help/doc-detail/50704.html

<br>

STEP1: Magentoを利用するにあたり、アカウント発行が必要です。
<br>

1.[Magentoサイト](https://magento.com/)に入ります。
![図 5](/help/image/25.5.png)
<br>

2.初回のみユーザ登録をします。
![図 6](/help/image/25.6.png)
<br>

3.ユーザ登録で必要なフィールドを記載します。
![図 7](/help/image/25.7.png)
<br>

4.設定が終わったらTopページに戻り、プロフィールのページを選定します。
![図 8](/help/image/25.8.png)
<br>

5.Access Keyを選定します。
![図 9](/help/image/25.9.png)
<br>

6.新規でAccess Keyを発行します。
![図 10](/help/image/25.10.png)
<br>

7.Access Keyは用途ごとに使い分けられてるため、ここでPJ名など案件名を記載します。
![図 11](/help/image/25.11.png)
<br>

8.これでMagento作成に必要なKey２種類の発行完了です。こちらは後々必要になるのでメモを残してください。
![図 12](/help/image/25.12.png)

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
  description       = "Enable EC-site web vswitch"    
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.zone}"
}

resource "alicloud_vswitch" "app" {
  name              = "${var.project_name}-app-vswitch"    
  description       = "Enable EC-site app vswitch"       
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.zone}"
}

resource "alicloud_vswitch" "db" {
  name              = "${var.project_name}-db-vswitch"    
  description       = "Enable EC-site db vswitch"      
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "192.168.3.0/24"
  availability_zone = "${var.zone}"
}

resource "alicloud_ess_scaling_group" "web" {
  scaling_group_name = "${var.project_name}-ec-site-web"
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
  scaling_configuration_name = "EC-site-web"
  system_disk_category       = "cloud_efficiency"
  security_group_id          = "${alicloud_security_group.web.id}"
  active                     = true
}

resource "alicloud_ess_scaling_rule" "web" {
  scaling_rule_name = "${var.project_name}-ec-site-rule-web"
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

resource "alicloud_security_group_rule" "allow_ssh_for_web" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
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
  scaling_group_name = "${var.project_name}-ec-site-app"
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
  scaling_configuration_name = "EC-site-app"
  system_disk_category       = "cloud_efficiency"
  security_group_id          = "${alicloud_security_group.app.id}"
  active                     = true
}

resource "alicloud_ess_scaling_rule" "app" {
  scaling_rule_name = "${var.project_name}-ec-site-rule-app"
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
  connection_prefix = "ecsitedatabase"
  port = "3306"
}


data "template_file" "user_data" {
  template = "${file("provisioning.sh")}"
  vars {
    DB_HOST_IP = "${alicloud_db_connection.default.0.ip_address}"
    DB_NAME = "${var.db_layer_name}"
    DB_USER = "${var.db_user}"
    DB_PASSWORD = "${var.db_password}"
    DOMAIN_URL = "${var.domain_url}"
    MAGENTO_AUTH_PUBLIC_KEY = "${var.magento_auth_public_key}"
    MAGENTO_AUTH_PRIVATE_KEY = "${var.magento_auth_private_key}"
    MAGENTO_ADMIN_USER = "${var.magento_auth_user}"
    MAGENTO_ADMIN_PASSWORD = "${var.magento_auth_password}"
    MAGENTO_ADMIN_EMAIL = "${var.magento_auth_email}"
    MAGENTO_ADMIN_FIRSTNAME = "${var.magento_auth_firstname}"
    MAGENTO_ADMIN_LASTNAME = "${var.magento_auth_lastname}"
  }
}

```

<br>
confing.tfvars

```
access_key = "xxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "EC-Site-Sample-for-Terraform"

ecs_password = "!Password2019"
db_user = "test_user"
db_password = "!Password2019"

web_layer_name = "web-server"
web_availability_zone = "ap-northeast-1a"
web_instance_count = 1
web_instance_min_count = 1
web_instance_max_count = 4
web_instance_type = "ecs.sn1ne.large"
web_instance_port = 80
web_instance_image_id = "centos_7_06_64_20G_alibase_20190218.vhd"
web_instance_user_data = "${file("provisioning.sh")}"

app_layer_name = "app-server"
app_availability_zone = "ap-northeast-1a"
app_instance_count = 1
app_instance_min_count = 1
app_instance_max_count = 4
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

magento_auth_public_key = "xxxxxxxxxxxxxxxx"
magento_auth_private_key = "xxxxxxxxxxxxxxxx"

magento_auth_user = "admin"
magento_auth_password = "admin123"
magento_auth_email = "xxxxxxx@hoge.com"
magento_auth_firstname = "foo"
magento_auth_lastname = "bar"

domain_url = "localhost"





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
variable "web_instance_min_count" {}
variable "web_instance_max_count" {}
variable "web_availability_zone" {}
variable "web_instance_type" {}
variable "web_instance_port" {}
variable "web_instance_image_id" {}
variable "web_instance_user_data" {}

variable "app_layer_name" {}
variable "app_instance_count" {}
variable "app_instance_min_count" {}
variable "app_instance_max_count" {}
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

variable "magento_auth_public_key" {}
variable "magento_auth_private_key" {}

variable "magento_auth_user" {}
variable "magento_auth_password" {}
variable "magento_auth_email" {}
variable "magento_auth_firstname" {}
variable "magento_auth_lastname" {}
variable "domain_url" {}
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

output "rds_host_connection_string" {
  value = "${alicloud_db_instance.db_instance.connection_string}"
}

output "rds_host_ip" {
  value = "${alicloud_db_connection.default.0.ip_address}"
}


```

<br>
provisioning.sh

```
#!/bin/bash

apt-get update


yum -y install epel-release
yum -y install nginx net-tools
yum -y install unzip
systemctl start nginx
systemctl enable nginx
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php70w-fpm php70w-mcrypt php70w-curl php70w-cli php70w-mysql php70w-gd php70w-xsl php70w-json php70w-intl php70w-pear php70w-devel php70w-mbstring php70w-zip php70w-soap
mkdir -p /var/lib/php/session/
chown -R nginx:nginx /var/lib/php/session/
systemctl start php-fpm
systemctl enable php-fpm

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin --filename=composer
cd /var/www/
wget https://github.com/magento/magento2/archive/2.1.zip

unzip 2.1.zip
mv magento2-2.1 magento2
cd magento2
composer install -v

cd /etc/nginx/
vim conf.d/magento.conf
----
upstream fastcgi_backend {
        server  unix:/run/php/php-fpm.sock;
}
 
server {
 
        listen 80;
        server_name magento.hakase-labs.com;
        set $MAGE_ROOT /var/www/magento2;
        set $MAGE_MODE developer;
        include /var/www/magento2/nginx.conf.sample;
}
----
nginx -t
systemctl restart nginx





]










yum install -y nginx php7.0-mcrypt php7.0-fpm php7.0-curl php7.0-mysql \
  php7.0-cli php7.0-xsl php7.0-json php7.0-intl php7.0-dev php-pear php7.0-mbstring \
  php7.0-common php7.0-zip php7.0-gd php-soap curl libcurl3


curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer >> /var/log/bootstrap.log 2>&1
composer config http-basic.repo.magento.com ${MAGENTO_AUTH_PUBLIC_KEY} ${MAGENTO_AUTH_PRIVATE_KEY} >> /var/log/bootstrap.log 2>&1
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/magento2 >> /var/log/bootstrap.log 2>&1
composer create-project --repository=https://repo.magento.com/ magento/project-community-edition /var/www/magento2 >> /var/log/bootstrap.log 2>&1

https://repo.magento.com/magento/project-community-edition
chown -R www-data:www-data /var/www/magento2 

cat > /etc/nginx/sites-available/magento << EOF
upstream fastcgi_backend {
    server  unix:/run/php/php7.0-fpm.sock;
}

server {
    listen 80;
    server_name ${DOMAIN_URL};
    set \$MAGE_ROOT /var/www/magento2;
    set \$MAGE_MODE developer;
    include /var/www/magento2/nginx.conf.sample;
}
EOF

ln -s /etc/nginx/sites-available/magento /etc/nginx/sites-enabled/

systemctl restart nginx

/var/www/magento2/bin/magento setup:install --backend-frontname="admin" \
--key=${MAGENTO_AUTH_PUBLIC_KEY} \
--db-host=${DB_HOST_IP} \
--db-name=${DB_NAME} \
--db-user=${DB_USER} \
--db-password=${DB_PASSWORD} \
--use-rewrites=1 \
--use-secure=0 \
--base-url="http://${DOMAIN_URL}" \
--base-url-secure="https://${DOMAIN_URL}" \
--admin-user=${MAGENTO_ADMIN_USER} \
--admin-password=${MAGENTO_ADMIN_PASSWORD} \
--admin-email=${MAGENTO_ADMIN_EMAIL} \
--admin-firstname=${MAGENTO_ADMIN_FIRSTNAME} \
--admin-lastname=${MAGENTO_ADMIN_LASTNAME} >> /var/log/bootstrap.log 2>&1



bin/magento setup:install --backend-frontname="adminlogin" \
--key="234923058412cc6ae7f42f9afb15032f" \
--db-host="localhost" \
--db-name="magentodb" \
--db-user="magentouser" \
--db-password="Magento123@" \
--use-rewrites=1 \
--use-secure=0 \
--base-url="http://magento.test.terraform.com" \
--base-url-secure="https://magento.test.terraform.com" \
--admin-user=adminuser \
--admin-password=admin123@ \
--admin-email=hironobu.ohara@g.softbank.co.jp \
--admin-firstname=admin \
--admin-lastname=user \
--cleanup-database

```

<br>
これでmagentoへログインできます。

![図 13](/help/image/25.13.png)


