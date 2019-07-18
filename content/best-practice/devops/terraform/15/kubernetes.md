---
title: "Kubernetesの作成"
date: 2019-07-01T00:00:00+09:00
description: "Terraformによる、Alibaba CloudのKubernetesリソース作成方法を紹介します。"
weight: 150
draft: false
---

AlibabaCloudの基本プロダクトサービスであるResource Access Managementの作成方法を解説します。

### 1. Kubernetes
&nbsp; Kubernetesは自動デプロイ、スケーリング、アプリ・コンテナの運用自動化のために設計されたオープンソースのプラットフォームです。Kubernetesによって、以下のことが要求に迅速かつ効率良く対応ができます。

* アプリを迅速に予定通りにデプロイする (コンテナをサーバー群へ展開する)
* 稼働中にアプリをスケールする（稼働中にコンテナ数を変更する）
* 新機能をシームレスに提供開始する (稼働中にロールアウトする)
* ハードウェアの利用率を要求に制限する (コンテナで共存させて稼働率を高くする）

&nbsp; Kubernetesのゴールは、下記の様なアプリの運用負担を軽減するためのエコシステムのコンポーネントとツールを整備することです。

* 可搬性: パブリック・クラウド、プライベート・クラウド、ハイブリッド・クラウド、マルチ・クラウド
* 拡張可能: モジュール化、追加可能、接続可能、構成可能
* 自動修復: 自動配置、自動再起動、自動複製、自動スケーリング

&nbsp; 2014年にプロジェクトが開始され、運用経験を基に、本番のワークロードを大規模に実行し、コミュニティのベストプラクティスのアイデアやプラクティスと組み合わせています。 Kubernetesの事例は https://kubernetes.io/case-studies/ にあります。

&nbsp; またAlibabaのKubernetesサービスは非常に便利な上、Container Clustor、kubernetes managed、Container Registryと各方面へ進化段階なので、随時チェックするといいでしょう。


<br>
### 2. コンポーネント
&nbsp; Container Service for Kubernetes はネイティブの Kubernetes をベースに構成、拡張されています。 このサービスは、クラスターの作成および拡張を容易に行うことができ、Alibaba Cloud の機能である、仮想化、ストレージ、ネットワーク、セキュリティ、およびKubernetes コンテナー化したアプリケーションの高品質な実行環境を統合することができます。

![図 1](/help/image/16.1.png)


### 3. KubernetesのTerraformについて
&nbsp; 本題、Kubernetesクラスタ作成に移ります。AZシングルゾーンのKubernetesクラスタを生成するだけの簡単なソースを作ってみます。

```
resource "alicloud_cs_kubernetes" "main" {
  name_prefix = "my-first-k8s"
  availability_zone = "${data.alicloud_zones.default.zones.0.id}"
  new_nat_gateway = true
  master_instance_types = ["ecs.n4.small"]
  worker_instance_types = ["ecs.n4.small"]
  worker_numbers = [3]
  password = "password1234"
  pod_cidr = "192.168.1.0/16"
  service_cidr = "192.168.2.0/24"
  enable_ssh = true
  install_cloud_monitor = true
}
```

#### **alicloud_cs_kubernetes**
・`name` - （オプション）kubernetesクラスタ名。
・`name_prefix` - （オプション）kubernetesクラスタ名のプレフィックス。
・`availability_zone` - （オプション）新しいkubernetesクラスタが配置されるゾーン。指定されていない場合はvswitch_idsを設定する必要あり。
・`new_nat_gateway` - （オプション）kubernetesクラスタの作成中に新しいNATゲートウェイを作成するかどうか。
・`master_instance_types` - （必須）マスターノードのインスタンスタイプ。
・`worker_instance_types` - （必須）ワーカーノードのインスタンスタイプ。
・`worker_number` - （必須）kubernetesクラスターのワーカーノード番号。デフォルトは3。
・`password` - （オプション）sshログインクラスタノードのパスワード。
・`cluster_network_type` - （必須）クラスタのネットワークタイプ。
・`pod_cidr` - （オプション）ポッドネットワークのCIDRブロック。
・`service_cidr` - （任意）サービスネットワークのCIDRブロック。
・`enable_ssh` - （オプション）SSHログインkubernetesを許可するかどうか。デフォルトはfalse。
・`install_cloud_monitor` - （オプション）kubernetesのノードにクラウドモニタをインストールするかどうか。

alicloud_cs_kubernetesリソースを実行することにより、以下の属性情報が出力されます。
・`id` - コンテナクラスタのID。
・`name` - コンテナクラスタの名前。
・`master_nodes` - クラスタマスターノードリスト。
・`worker_nodes` - クラスタワーカーノードのリスト。
・`connections` - kubernetesクラスタ接続情報。
» ブロックノード
・`name` - ノード名
・`private_ip` - ノードのプライベートIPアドレス。
» ブロック接続
・`api_server_internet` - APIサーバーのインターネットエンドポイント。
・`api_server_intranet` - APIサーバーイントラネットエンドポイント。
・`master_public_ip` - マスターノードのSSH IPアドレス。
・`service_domain` - サービスアクセスドメイン。



他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/cs_kubernetes.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/cs_kubernetes.html

### 4. マネージドKubernetesのTerraformについて
&nbsp; 上記、alicloud_cs_kubernetesでkubernetesクラスタを生成しました。
一方、Managed Kubernetesがありますので、今度はalicloud_cs_managed_kubernetes で Managed Kubernetesを作ってみます。

※ Managed Kubernetesはコンテナ一元管理をマネージドで使えるのでメリットがあります。ただしロードバランサなどを自分で対応しないといけないなど色々制約はありますが、構成が比較的シンプルで、扱うコンテナの種類が少なければ便利なサービスです。

```
variable "name" {
    default = "my-first-k8s"
}
data "alicloud_zones" main {
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "default" {
    availability_zone = "${data.alicloud_zones.main.zones.0.id}"
    cpu_core_count = 1
    memory_size = 2
}

resource "alicloud_cs_managed_kubernetes" "k8s" {
  name = "${var.name}"
  availability_zone = "${data.alicloud_zones.main.zones.0.id}"
  new_nat_gateway = true
  worker_instance_types = ["${data.alicloud_instance_types.default.instance_types.0.id}"]
  worker_numbers = [2]
  password = "password1234"
  pod_cidr = "172.20.0.0/16"
  service_cidr = "172.21.0.0/20"
  install_cloud_monitor = true
  slb_internet_enabled = true
  worker_disk_category  = "cloud_efficiency"
}
```

#### **alicloud_cs_managed_kubernetes**
・`name` - （オプション）kubernetesクラスタ名。

・`availability_zone` - （オプション）kubernetesクラスタが配置されるゾーン。

・`new_nat_gateway` - （オプション）kubernetesクラスタの作成中に新しいNATゲートウェイを作成するかどうか。デフォルトはtrue。

・`password` - （必須）sshログインクラスタノードのパスワード。

・`pod_cidr` - （オプション）ポッドネットワークのCIDRブロック。

・`service_cidr` - （任意）サービスネットワークのCIDRブロック。

・`slb_internet_enabled` - （オプション）API Server用のインターネットロードバランサ
を作成するかどうか。デフォルトはfalse。

・`install_cloud_monitor` - （オプション）kubernetesのノードにクラウドモニタをインストールするかどうか。

・`worker_disk_category` - （オプション）ワーカーノードのシステムディスクカテゴリ。

・`worker_numbers` - （必須）kubernetesクラスターのワーカーノード番号。

・`worker_instance_types` - （必須）ワーカーノードのインスタンスタイプ。

alicloud_cs_managed_kubernetesリソースを実行することにより、以下の属性情報が出力されます。
・`name` - コンテナクラスタの名前。

・`availability_zone` - アベイラビリティーゾーンのID。

・`key_name` - sshログインクラスタノードのキーペア、最初にそれを作成する必要があります。

・`worker_numbers` - 現在のコンテナクラスタ内のECSインスタンスノード番号。

・`image_id` - ノードイメージのID。

・`nat_gateway_id` - kubernetesクラスタを起動するために使用されるNATゲートウェイのID。

・`worker_instance_types` - ワーカーノードのインスタンスタイプ。

» ブロックノード
・`id` - ノードのID

・`name` - ノード名

・`private_ip` - ノードのプライベートIPアドレス。


他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/cs_managed_kubernetes.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/cs_managed_kubernetes.html


<br>
以下にKubernetesの実際のサンプルを入れていますので、こちらも参照してみてください。

[example: Kubernetesの構築と設定]({{% relref "scenario/terraform/kubernetes-setting-sample.md" %}})






