---
title: "Terraform 25章 example: Multi-AZ Kubernetes"
date: 2019-07-22T00:00:00+09:00
weight: 10
draft: true
---
# 第25章
## example: Multi-AZ Kubernetes

&nbsp; 第8章までは Terraformのインストール方法、コード記載方法、実行方法、第9章-第16章はAlibabaCloudの基本プロダクトサービスの説明をしました。第17章-第27章はTerraformのサンプルコードを交えて解説します。

* [17章 example: ssh踏み台サーバ](docs/17/Bastion-Server.md)
* [18章 example: SLB設定サンプル](docs/18/SLB-Setting-Sample.md)
* [19章 example: RDS設定サンプル](docs/19/RDS-Setting-Sample.md)
* [20章 example: kubernetes設定サンプル](docs/20/Kubernetes-Setting-Sample.md)
* [21章 example: Webアプリケーション](docs/21/Web-Application.md)
* [22章 example: 高速コンテンツ配信](docs/22/Accelerated-Content-Delivery.md)
* [23章 example: オートスケーリング](docs/23/Auto-Scaling.md)
* [24章 example: KubernetesによるコンテナでWordPress作成](docs/24/Web-Application-on-Kubernetes.md)
* **[25章 example: Multi-AZ Kubernetes](docs/25/Multi-AZ_kubernetes.md)**
* [26章 example: DevOpsによるWebアプリケーション](ddocs/26/DevOps-Web-Application.md)
* [27章 example: ECサイト構築](docs/27/EC-Site-Sample.md)

<br>
### 25.1 Multi-AZ Kubernetes
&nbsp; Txxxxxx


https://www.alibabacloud.com/blog/594492


https://github.com/kin-alibaba/terraform-kubernetes

/Users/hironobu.ohara/Dev/terraform-kubernetes

ターゲット環境
当社のターゲットインフラストラクチャは次のとおりです。

1. 2つのアベイラビリティーゾーンに1つのマルチAZ Kubernetesクラスター（最大3つのゾーンをサポート）
1. 2つのServer Load Balancerインスタンスを持つ2つの可用性ゾーンにまたがる3つのKubernetesマスターノード
1. 2つのアベイラビリティーゾーンにまたがる3つのKubernetesワーカーノード
1. Docker HubからDockerイメージをダウンロードするための1つのNATゲートウェイインスタンス
1. Nginx Ingress Controller用の1つのサーバーロードバランサ（SLB）インスタンス
1. 1 Kubernetes ServiceはAlibaba Cloud ApsaraDB RDS for MySQL（RDS）に接続するサンプルWebアプリケーションを提供します。
1. 1 Alibaba CloudのDNSレコードがKubernetesサービスにバインドされます

![図 24.1](/help/image/d24.1.png)

Terraform - コードとしてのインフラストラクチャ
Terraformにより、ターゲット環境を記述してから、その環境のライフサイクルを管理することができます。この場合、Terraformファイルは、変数が各「config」ファイルに外部化される管理を容易にするために複数のファイルにモジュール化されます。


main.tf
```
resource "alicloud_vpc" "vpc" {
name = "${var.vpc_name}"
cidr_block = "${var.vpc_cidr}"
}

resource "alicloud_vswitch" "vswitch1" {
availability_zone = "${var.azone1}"
name = "${var.vswitch_name1}"
cidr_block = "${var.vswitch_cidr1}"
vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_vswitch" "vswitch2" {
availability_zone = "${var.azone1}"
name = "${var.vswitch_name2}"
cidr_block = "${var.vswitch_cidr2}"
vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_vswitch" "vswitch3" {
availability_zone = "${var.azone3}"
name = "${var.vswitch_name3}"
cidr_block = "${var.vswitch_cidr3}"
vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group" "sg" {
name = "${var.sg_name}"
vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "22_rule" {
security_group_id = "${alicloud_security_group.sg.id}"
type = "ingress"
policy = "accept"
port_range = "22/22"
ip_protocol = "tcp"
nic_type = "intranet"
priority = 1
cidr_ip = "0.0.0.0/0"
}


resource "alicloud_nat_gateway" "nat_gateway" {
  vpc_id = "${alicloud_vpc.vpc.id}"
  specification   = "Small"
  name   = "kin-k8s-tf-nat-gw"
  depends_on = [
     "alicloud_vswitch.vswitch1",
     "alicloud_vswitch.vswitch2",
     "alicloud_vswitch.vswitch3"
  ]
}


resource "alicloud_eip" "eip1" {
  bandwidth            = "20"
}

resource "alicloud_eip_association" "eip1_asso" {
  allocation_id = "${alicloud_eip.eip1.id}"
  instance_id   = "${alicloud_nat_gateway.nat_gateway.id}"
}

resource "alicloud_snat_entry" "snat1" {
  snat_table_id     = "${alicloud_nat_gateway.nat_gateway.snat_table_ids}"
  source_vswitch_id = "${alicloud_vswitch.vswitch1.id}"
  snat_ip           = "${alicloud_eip.eip1.ip_address}"
}

resource "alicloud_snat_entry" "snat2" {
  snat_table_id     = "${alicloud_nat_gateway.nat_gateway.snat_table_ids}"
  source_vswitch_id = "${alicloud_vswitch.vswitch2.id}"
  snat_ip           = "${alicloud_eip.eip1.ip_address}"
}

resource "alicloud_snat_entry" "snat3" {
  snat_table_id     = "${alicloud_nat_gateway.nat_gateway.snat_table_ids}"
  source_vswitch_id = "${alicloud_vswitch.vswitch3.id}"
  snat_ip           = "${alicloud_eip.eip1.ip_address}"
}


resource "alicloud_db_instance" "rdsinstance" {
	engine = "MySQL"
	engine_version = "5.6"
	instance_type = "rds.mysql.t1.small"
	instance_storage = "5"
	vswitch_id = "${alicloud_vswitch.vswitch1.id}"
	security_ips = ["${var.vswitch_cidr1}", "${var.vswitch_cidr2}", "${var.vswitch_cidr3}", "${alicloud_eip.eip1.ip_address}"]
	#depends_on = ["alicloud_cs_kubernetes.k8s-cluster"]
}

resource "alicloud_db_database" "rdsdb" {
	instance_id = "${alicloud_db_instance.rdsinstance.id}"
	name = "demodb"
	character_set = "utf8"
}

resource "alicloud_db_account" "mysqlroot" {
	instance_id = "${alicloud_db_instance.rdsinstance.id}"
	name = "${var.db_credential["username"]}"
	password = "${var.db_credential["password"]}"
}

resource "alicloud_db_account_privilege" "default" {
	instance_id = "${alicloud_db_instance.rdsinstance.id}"
	account_name = "${alicloud_db_account.mysqlroot.name}"
	privilege = "ReadWrite"
	db_names = ["${alicloud_db_database.rdsdb.name}"]
}

resource "alicloud_cs_kubernetes" "k8s-cluster" {
	name = "${var.k8clu_name}"
	vswitch_ids = [                             #Indicates Multiple Availability Zone
		"${alicloud_vswitch.vswitch1.id}",
		"${alicloud_vswitch.vswitch2.id}",
		"${alicloud_vswitch.vswitch3.id}"
	]
	master_instance_types = ["${var.master_type["zone1"]}","${var.master_type["zone1"]}","${var.master_type["zone2"]}"]
	master_disk_category = "cloud_efficiency"          #cloud_ssd or cloud_efficiency
	master_disk_size = "40"
	worker_instance_types = ["${var.worker_type["zone1"]}","${var.worker_type["zone1"]}","${var.worker_type["zone2"]}"]
	worker_disk_category = "cloud_efficiency"         #cloud_ssd or cloud_efficiency
	worker_disk_size = "40"
	worker_data_disk_category = "cloud_ssd"           #cloud_ssd or cloud_efficiency
	worker_data_disk_size = "40"
	worker_numbers = [1,1,1]
	key_name = "${alicloud_key_pair.k8s-ssh-key.key_name}"  #for ECS ssh key auth, either key_name or password 
	#password = "${var.k8ssh["password"]}"  #for ECS password auth, either key_name or password 
	new_nat_gateway = "false"
	pod_cidr = "172.20.0.0/16"
	service_cidr = "172.30.0.0/16"
	slb_internet_enabled = "true"           #for SLB of K8S API Server
	enable_ssh = "true"						#SSH login kubernetes
	install_cloud_monitor = "true"
	cluster_network_type = "terway"
	kube_config = "${var.kube_cli["cfg"]}"
	client_cert = "${var.kube_cli["client_cert"]}"
	client_key = "${var.kube_cli["client_key"]}"
	cluster_ca_cert = "${var.kube_cli["k8s_ca"]}"
	depends_on = [
	"alicloud_eip_association.eip1_asso", 
	"alicloud_snat_entry.snat1", 
	"alicloud_snat_entry.snat2", 
	"alicloud_snat_entry.snat3"
	]
	
}

variable "app1"{
	default = 
	{
	name = "todo"
	namespace = "default"
	min_replicas = 2
	max_replicas = 10
	cpu_threshold = 80
	#image_repo = "registry-intl.ap-southeast-1.aliyuncs.com/kin-test-acr/demo"
	image_repo = "seyantszkin/demo"			#
	image_ver = "v1.0"
	svc_port = 80
	container_port = 8080
	svc_type = "LoadBalancer"
	}
}


resource "kubernetes_deployment" "app1" {
	
	metadata {
		name = "${var.app1["name"]}"
		labels {
			app = "${var.app1["name"]}"
		}
		namespace = "${var.app1["namespace"]}"
	}
	
	spec {
		replicas = "${var.app1["min_replicas"]}"
		
		selector {
			match_labels {
				app = "${var.app1["name"]}"
			}
		}
		
		template {
			metadata {
				labels {
					app = "${var.app1["name"]}"
				}
			}
			spec {
				container {
					env {
						name = "MYSQL_HOST"
						value = "${alicloud_db_instance.rdsinstance.connection_string}"
						}
					env	{
						name = "MYSQL_PORT"
						value = "3306"
						}
					env	{
						name = "DB_USERNAME"
						value = "${var.db_credential["username"]}"
						}
					env	{
						name = "DB_PASSWORD"
						value = "${var.db_credential["password"]}"
						}						
					image = "${var.app1["image_repo"]}:${var.app1["image_ver"]}"
					name = "${var.app1["name"]}"
					port {
						container_port = "${var.app1["container_port"]}"
						protocol = "TCP"
					}
					#resources {
					#	requests {}
					#}
				}
				#image_pull_secrets {
				#	name = "${kubernetes_secret.reg_secret.metadata.0.name}"
				#}
			
			}
		}
	
	}
	depends_on = [
	"alicloud_cs_kubernetes.k8s-cluster", 
	"alicloud_db_database.rdsdb"
	]
}


resource "kubernetes_horizontal_pod_autoscaler" "hpa1" {
  
  metadata {
    name = "${var.app1["name"]}"
  }
  spec {
    max_replicas = "${var.app1["max_replicas"]}"
    min_replicas = "${var.app1["min_replicas"]}"
	target_cpu_utilization_percentage = "${var.app1["cpu_threshold"]}"
    scale_target_ref {
      kind = "Deployment"
      name = "${var.app1["name"]}"
    }
  }
  depends_on = ["kubernetes_deployment.app1"]
}

resource "kubernetes_service" "svc1" {
	metadata {
		name = "${var.app1["name"]}-svc"
		namespace = "${var.app1["namespace"]}"
	}
	spec {
		selector {
			app = "${var.app1["name"]}"
		}		
		port {
			port = "${var.app1["svc_port"]}"
			target_port = "${var.app1["container_port"]}"
			protocol = "TCP"
		}
		session_affinity = "None"
		type = "${var.app1["svc_type"]}"
	}
	depends_on = ["kubernetes_deployment.app1"]
}


variable "app2"{
	default = 
	{
	name = "bread"
	namespace = "default"
	min_replicas = 2
	max_replicas = 10
	cpu_threshold = 80
	#image_repo = "registry-intl.ap-southeast-1.aliyuncs.com/kin-test-acr/bread"
	image_repo = "seyantszkin/bread"    	#the image is for test only, all rights reserved by Nginx
	image_ver = "v1.0"
	svc_port = 80
	container_port = 80
	svc_type = "LoadBalancer"
	}
}



resource "kubernetes_deployment" "app2" {
	
	metadata {
		name = "${var.app2["name"]}"
		labels {
			app = "${var.app2["name"]}"
		}
		namespace = "${var.app2["namespace"]}"
	}
	
	spec {
		replicas = "${var.app2["min_replicas"]}"
		
		selector {
			match_labels {
				app = "${var.app2["name"]}"
			}
		}
		
		template {
			metadata {
				labels {
					app = "${var.app2["name"]}"
				}
			}
			spec {
				container {
					image = "${var.app2["image_repo"]}:${var.app2["image_ver"]}"
					name = "${var.app2["name"]}"
					port {
						container_port = "${var.app2["container_port"]}"
						protocol = "TCP"
					}
					#resources {
					#	requests {}
					#}
				}
				#image_pull_secrets {
				#	name = "${kubernetes_secret.reg_secret.metadata.0.name}"
				#}
			
			}
		}
	
	}
	depends_on = [
	"alicloud_cs_kubernetes.k8s-cluster", 
	"alicloud_db_database.rdsdb"
	]
}


resource "kubernetes_horizontal_pod_autoscaler" "hpa2" {
  
  metadata {
    name = "${var.app2["name"]}"
  }
  spec {
    max_replicas = "${var.app2["max_replicas"]}"
    min_replicas = "${var.app2["min_replicas"]}"
	target_cpu_utilization_percentage = "${var.app2["cpu_threshold"]}"
    scale_target_ref {
      kind = "Deployment"
      name = "${var.app2["name"]}"
    }
  }
  depends_on = ["kubernetes_deployment.app2"]
}

resource "kubernetes_service" "svc2" {
	metadata {
		name = "${var.app2["name"]}-svc"
		namespace = "${var.app2["namespace"]}"
	}

	spec {
		selector {
			app = "${var.app2["name"]}"
		}
		port {
			port = "${var.app2["svc_port"]}"
			target_port = "${var.app2["container_port"]}"
			protocol = "TCP"
		}
		session_affinity = "None"
		type = "${var.app2["svc_type"]}"
		
	}
	depends_on = ["kubernetes_deployment.app2"]
}


variable "app3"{
	default = 
	{
	name = "butter"
	namespace = "default"
	min_replicas = 2
	max_replicas = 10
	cpu_threshold = 80
	#image_repo = "registry-intl.ap-southeast-1.aliyuncs.com/XXXXXX/butter"
	image_repo = "seyantszkin/butter"   #the image is for test only, all rights reserved by Nginx
	image_ver = "v1.0"
	svc_port = 80
	container_port = 80
	svc_type = "LoadBalancer"
	}
}



resource "kubernetes_deployment" "app3" {
	
	metadata {
		name = "${var.app3["name"]}"
		labels {
			app = "${var.app3["name"]}"
		}
		namespace = "${var.app3["namespace"]}"
	}
	
	spec {
		replicas = "${var.app3["min_replicas"]}"
		
		selector {
			match_labels {
				app = "${var.app3["name"]}"
			}
		}
		
		template {
			metadata {
				labels {
					app = "${var.app3["name"]}"
				}
			}
			spec {
				container {
					image = "${var.app3["image_repo"]}:${var.app3["image_ver"]}"
					name = "${var.app3["name"]}"
					port {
						container_port = "${var.app3["container_port"]}"
						protocol = "TCP"
					}
					#resources {
					#	requests {}
					#}
				}
				#image_pull_secrets {
				#	name = "${kubernetes_secret.reg_secret.metadata.0.name}"
				#}
			
			}
		}
	
	}
	depends_on = [
	"alicloud_cs_kubernetes.k8s-cluster", 
	"alicloud_db_database.rdsdb"
	]
}


resource "kubernetes_horizontal_pod_autoscaler" "hpa3" {
  
  metadata {
    name = "${var.app3["name"]}"
  }
  spec {
    max_replicas = "${var.app3["max_replicas"]}"
    min_replicas = "${var.app3["min_replicas"]}"
	target_cpu_utilization_percentage = "${var.app3["cpu_threshold"]}"
    scale_target_ref {
      kind = "Deployment"
      name = "${var.app3["name"]}"
    }
  }
  depends_on = ["kubernetes_deployment.app3"]
}

resource "kubernetes_service" "svc3" {
	metadata {
		name = "${var.app3["name"]}-svc"
		namespace = "${var.app3["namespace"]}"
	}

	spec {
		selector {
			app = "${var.app3["name"]}"
		}
		port {
			port = "${var.app3["svc_port"]}"
			target_port = "${var.app3["container_port"]}"
			protocol = "TCP"
		}
		
		session_affinity = "None"
		type = "${var.app3["svc_type"]}"
		
	}
	depends_on = ["kubernetes_deployment.app3"]
}



resource "alicloud_dns_record" "svc1" {
  name = "seyantszkin.xyz"			# A domain name (e.g. alicloud.org) registered under your Alibaba Cloud account
  host_record = "${var.app1["name"]}"
  type = "A"
  value = "${kubernetes_service.svc1.load_balancer_ingress.0.ip}"
}

resource "alicloud_dns_record" "svc2" {
  name = "seyantszkin.xyz"			# A domain name registered under your Alibaba Cloud account
  host_record = "${var.app2["name"]}"
  type = "A"
  value = "${kubernetes_service.svc2.load_balancer_ingress.0.ip}"
}

resource "alicloud_dns_record" "svc3" {
  name = "seyantszkin.xyz"			# A domain name registered under your Alibaba Cloud account
  host_record = "${var.app3["name"]}"
  type = "A"
  value = "${kubernetes_service.svc3.load_balancer_ingress.0.ip}"
}

provider "alicloud" {
access_key = "${var.access_key}"
secret_key = "${var.secret_key}"
region = "${var.region}"
}

provider "kubernetes" {			#Make it depends on a another resources
	host = "https://${alicloud_cs_kubernetes.k8s-cluster.connections["master_public_ip"]}:6443"
	client_certificate     = "${file("${var.kube_cli["client_cert"]}")}"
	client_key             = "${file("${var.kube_cli["client_key"]}")}"
	cluster_ca_certificate = "${file("${var.kube_cli["k8s_ca"]}")}"
}



```


variables.tf
```
variable "region" {
default = "ap-northeast-1"
}

variable "azone1" {
default = "ap-northeast-1a"
}

variable "azone2" {
default = "ap-northeast-1b"
}

variable "azone3" {
default = "ap-northeast-1a"
}

variable "vpc_name" {
default = "kin-tf-k8s-vpc-hk"
}

variable "vpc_cidr" {
default = "10.0.0.0/8"
}

variable "vswitch_name1" {
default = "kin-tf-k8s-vsw1"
}

variable "vswitch_cidr1" {
default = "10.0.1.0/24"
}

variable "vswitch_name2" {
default = "kin-tf-k8s-vsw2"
}

variable "vswitch_cidr2" {
default = "10.0.2.0/24"
}

variable "vswitch_name3" {
default = "kin-tf-k8s-vsw3"
}

variable "vswitch_cidr3" {
default = "10.0.3.0/24"
}

variable "sg_name" {
default = "kin-tf-k8s-sg"
}

variable "k8clu_name" {
default = "kin-k8s-tf-maz"			#K8S cluster name
}

variable "master_type" {
	default = {
	zone1 = "ecs.sn2ne.large"		#Please make sure the ECS type is available in the specified Availability Zone 
	zone2 = "ecs.sn2ne.large"		#Please make sure the ECS type is available in the specified Availability Zone 
	}
}

variable "worker_type" {
	default = {
	zone1 = "ecs.sn2ne.large"		#Please make sure the ECS type is available in the specified Availability Zone 
	zone2 = "ecs.sn2ne.large"		#Please make sure the ECS type is available in the specified Availability Zone 
	}
}

variable "k8ssh" {
	default = {
	keypair = "k8s-ssh-key" #key pair in KMS	
	password = "Password#3"	#SSH password if not using SSH Key
	}
}

resource "alicloud_key_pair" "k8s-ssh-key" {
	key_name = "${var.k8ssh["keypair"]}"
	key_file = "./k8s-ssh-key.pem"		#key file output path in your local machine
}

variable "kube_cli" {			#K8S config & key files output path in your local machine
	default = {
	cfg = "~/.kube/config"
	client_cert = "~/.kube/client-cert.pem"
	client_key = "~/.kube/client-key.pem"
	k8s_ca = "~/.kube/cluster-ca-cert.pem"
	}
}
```



confing.tfvars
```
variable "db_credential" {
	default = {
	username = "mysqlroot"
	password = "Password#3"
	}
}

```

run.sh
```
#!/bin/bash

terraform init 

###It is critical to clear the .kube directory and create empty files for Terraform to proceed

rm -rf ~/.kube.old/*
mv ~/.kube ~/.kube.old.`date +%s`
mv ./k8s-ssh-key.pem ./k8s-ssh-key.pem.`date +%s`
mkdir ~/.kube
touch ~/.kube/cluster-ca-cert.pem
touch ~/.kube/client-key.pem
touch ~/.kube/client-cert.pem

if [ ! `terraform state list` ]; then
	terraform apply -auto-approve
else
	terraform apply
fi

#for resource in `terraform state list`
#do
#	terraform state rm ${reosurce}
#done
un.
```




