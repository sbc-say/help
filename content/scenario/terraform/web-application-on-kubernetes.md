---
title: "KubernetesによるコンテナでWordPress作成"
date: 2019-07-01T00:00:00+09:00
description: "Terraformを用いて、Alibaba Cloud上でKubernetesによるWordPress作成方法を紹介します"
weight: 230
draft: false
---

&nbsp; KubernetesによるコンテナでWordPressを作成します。流れは以下の通りになります。
1. AlibabaCloudでKubernetesクラスターを生成
1. kube_configを環境変数にて設定
1. KubernetesクラスターのローカルボリュームにてWordPressとMySQLをインストール


こちらは[AlibabaCloud Terraformのサンプル集](https://github.com/terraform-providers/terraform-provider-alicloud/tree/master/examples/kubernetes-wordpress)を通じての紹介になります。


### Kubernetesでクラスタ生成
&nbsp; KubernetesによるコンテナでWordPressを作成します。流れは以下の通りになります。


<br>
&nbsp; TerraformでWebアプリケーションを作ってみます。step1のゴール構成図は以下の通りです。

![図 1](/help/image/24.1.png)

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
  description = "Enable Web-App on k8s vpc"  
}

resource "alicloud_vswitch" "vsw" {
  name = "${var.project_name}-vswitch"  
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
  description = "Enable Web-App on k8s vswitch"  
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

variable "wordpress_version" {}
variable "mysql_version" {}
variable "mysql_password" {}

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
access_key = "xxxxxxxxxxxxxxxx"
secret_key = "xxxxxxxxxxxxxxxx"
region = "ap-northeast-1"
zone = "ap-northeast-1a"
project_name = "Web-App-on-k8s-for-Terraform"
k8s_password = "!Password2019"

wordpress_version = "5.2.2"
mysql_version = "5.7"
mysql_password = "!Password2019"

```


&nbsp; ソースの準備ができたら実行します。

```
terraform init
terraform play -var-file="confing.tfvars"
terraform apply -var-file="confing.tfvars"
```


<br>
これで問題なく実行できたら、cluster_id、worker_nodes、master_nodesが表示され、こうしてkubernetesクラスター操作、管理ができます。

<br>
### kube_configを環境変数にて設定
&nbsp; 先ほどはKubernetesクラスタを作成しました。このクラスタを使ってwordpressを作成するため、Kubernetesコマンドラインクライアントである `kubectl` を使用します。`kubectl`はk8sクラスタのAPIサーバーと通信するためのコマンドラインツールです。


1. 最新の[kubectl](https://github.com/kubernetes/kubernetes)をダウンロードします。
2. [kubectl](https://github.com/kubernetes/kubernetes)のインストールおよび設定をします。
kubectlの[インストール方法はこちらを参照](https://kubernetes.io/docs/tasks/tools/install-kubectl/)してください。
3. クラスターの資格情報を設定します。設定方法は[こちらを参照](https://jp.alibabacloud.com/help/doc-detail/53755.htm)してください。


![図 3](/help/image/24.3.png)



### KubernetesクラスタにてWordpressインストール
&nbsp; これでKubernetesクラスタのkube_configを環境変数にて設定しました。今度はTerraform on Kubernetesを使ってubernetesクラスタにてWordPressを入れます。ゴールの構成図は以下の通りです。

![図 4](/help/image/24.4.png)

<br>
ソースは以下になります。サンプルソースは[こちら]()にあります。

<br>
confing.tfvars

```
project_name = "Web-App-on-k8s-for-Terraform"
wordpress_version = "5.2.2"
mysql_version = "5.7"
mysql_password = "!Password2019"
```

<br>
variables.tf

```
variable "project_name" {}
variable "wordpress_version" {}
variable "mysql_version" {}
variable "mysql_password" {}

```


<br>
mysql.tf

```
resource "kubernetes_service" "mysql" {
  metadata {
    name = "wordpress-mysql"

    labels {
      app = "wordpress"
    }
  }

  spec {
    port {
      port = 3306
    }

    selector {
      app  = "wordpress"
      tier = "${kubernetes_replication_controller.mysql.spec.0.selector.tier}"
    }

    cluster_ip = "None"
  }
}

resource "kubernetes_persistent_volume_claim" "mysql" {
  metadata {
    name = "mysql-pv-claim"

    labels {
      app = "wordpress"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "20Gi"
      }
    }

    volume_name = "${kubernetes_persistent_volume.mysql.metadata.0.name}"
  }
}

resource "kubernetes_secret" "mysql" {
  metadata {
    name = "mysql-pass"
  }

  data {
    password = "${var.mysql_password}"
  }
}

resource "kubernetes_replication_controller" "mysql" {
  metadata {
    name = "wordpress-mysql"

    labels {
      app = "wordpress"
    }
  }

  spec {
    selector {
      app  = "wordpress"
      tier = "mysql"
    }

    template {
      container {
        image = "mysql:${var.mysql_version}"
        name  = "mysql"

        env {
          name = "MYSQL_ROOT_PASSWORD"

          value_from {
            secret_key_ref {
              name = "${kubernetes_secret.mysql.metadata.0.name}"
              key  = "password"
            }
          }
        }

        port {
          container_port = 3306
          name           = "mysql"
        }

        volume_mount {
          name       = "mysql-persistent-storage"
          mount_path = "/var/lib/mysql"
        }
      }

      volume {
        name = "mysql-persistent-storage"

        persistent_volume_claim {
          claim_name = "${kubernetes_persistent_volume_claim.mysql.metadata.0.name}"
        }
      }
    }
  }
}
```

<br>
wordpress.tf

```
resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"

    labels {
      app = "wordpress"
    }
  }

  spec {
    port {
      port = 80
    }

    selector {
      app  = "wordpress"
      tier = "${kubernetes_replication_controller.wordpress.spec.0.selector.tier}"
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_persistent_volume_claim" "wordpress" {
  metadata {
    name = "wp-pv-claim"

    labels {
      app = "wordpress"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "20Gi"
      }
    }

    volume_name = "${kubernetes_persistent_volume.wordpress.metadata.0.name}"
  }
}

resource "kubernetes_replication_controller" "wordpress" {
  metadata {
    name = "wordpress"

    labels {
      app = "wordpress"
    }
  }

  spec {
    selector {
      app  = "wordpress"
      tier = "frontend"
    }

    template {
      container {
        image = "wordpress:${var.wordpress_version}-apache"
        name  = "wordpress"

        env {
          name  = "WORDPRESS_DB_HOST"
          value = "wordpress-mysql"
        }

        env {
          name = "WORDPRESS_DB_PASSWORD"

          value_from {
            secret_key_ref {
              name = "${kubernetes_secret.mysql.metadata.0.name}"
              key  = "password"
            }
          }
        }

        port {
          container_port = 80
          name           = "wordpress"
        }

        volume_mount {
          name       = "wordpress-persistent-storage"
          mount_path = "/var/www/html"
        }
      }

      volume {
        name = "wordpress-persistent-storage"

        persistent_volume_claim {
          claim_name = "${kubernetes_persistent_volume_claim.wordpress.metadata.0.name}"
        }
      }
    }
  }
}
```


<br>
localvolumes.tf

```
provider "kubernetes" {}

resource "kubernetes_persistent_volume" "mysql" {
  metadata {
    name = "local-pv-mysql"

    labels {
      type = "local"
    }
  }

  spec {
    capacity {
      storage = "20Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      host_path {
        path = "/tmp/data/pv-mysql"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "wordpress" {
  metadata {
    name = "local-pv-wordpress"

    labels {
      type = "local"
    }
  }

  spec {
    capacity {
      storage = "20Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      host_path {
        path = "/tmp/data/pv-wordpress"
      }
    }
  }
}
```

<br>
output.tf

```
output "slb_ip" {
  value = "${kubernetes_service.wordpress.load_balancer_ingress.0.ip}"
}
```

<br>
&nbsp; ソースの準備ができたら実行します。

```
terraform init
terraform play -var-file="confing.tfvars"
terraform apply -var-file="confing.tfvars"
```


<br>
これで完了です。問題なく実行できたら、SLBのIPが表示されます。

<br>









