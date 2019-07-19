---
title: "ECS、EIPの作成"
date: 2019-07-01T00:00:00+09:00
description: "Terraformによる、Alibaba CloudのECS、EIPリソース作成方法を紹介します。"
weight: 90
draft: false
---

AlibabaCloudの基本プロダクトサービスであるECS、EIPの作成方法を解説します。

### 1. ECS
&nbsp; ECSは、Alibaba Cloudによる仮装コンピューティングサービスです。ECS インスタンスは、ECS のコアコンポーネントであり、CPU、メモリ、およびその他の基本的なコンピューティングコンポーネントを含む仮想コンピューティング環境です。ディスク、イメージ、スナップショットなどの他のリソースは、ECS インスタンスと組み合わせてのみ使用できます。
&nbsp; Alibaba CloudのECSはビジネスやWebアプリケーションなど様々なニーズに対応しており、即時に作れることが特徴です。

&nbsp; ECSインスタンス生成リソースは多くのオプション（任意）でパラメータや構成を指定できます。ECSインスタンスはVPCやセキュリティグループとは少し異なり、OSやバージョン選定、起動時データ引き渡しやECS使い捨て利用など様々な利用方法が実現出来るため、ここは抑えておきましょう。

<br>

### 2. ECSインスタンス生成のTerraformについて
&nbsp; 本題、ECSインスタンス生成作成に移ります。ECSインスタンス生成するだけの簡単なソースを作ってみます。

``` 
resource "alicloud_instance" "ECS_instance" {
  instance_name   = "ECS_instance_for_terraform"
  host_name       = "ECS_instance_for_terraform"
  instance_type   = "ecs.n4.small"
  image_id        = "centos_7_06_64_20G_alibase_20190218.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
}
```
#### **alicloud_instance**

・`instance_name` - （オプション）ECSインスタンスの名前。このパラメータを指定しない場合、デフォルト名のECS-Instanceを自動生成します。
・`host_name` - （オプション）ECSのホスト名。
・`instance_type` - （必須）起動するインスタンスの種類。
・`image_id` - （必須）ECSインスタンスに使用するイメージ。ECSインスタンスのイメージは `image_id`を変更することで置き換えることができます。

***image_idの種類や取得方法は後述します。***

・`system_disk_category` - （オプション）ストレージの種類。有効な値はcloud_efficiency 、 cloud_ssd 、およびcloudです。デフォルトはcloud_efficiency。
・`security_groups` - （必須）関連付けるセキュリティグループIDのリスト。
・`availability_zone` - （オプション）インスタンスを起動するゾーン。
・`vswitch_id` - （オプション）接続したいVSwitchのID。 
・`user_data` - （オプション）ユーザーデータ。起動直後、実行したいコマンドがあればこちらにて入れます。

このalicloud_instanceリソースを実行することにより、以下の属性情報が出力されます。

・`id` - ECSインスタンスのID。
・`status` - ECSインスタンスの起動ステータス。
・`public_ip` - ECSインスタンスのパブリックIP。


他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/instance.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/instance.html

<br>

### 3. ECSインスタンスTypeの取得について
&nbsp; Alibaba CloudのECSインスタンスタイプ`instance_type`一覧はサイトの[ECSインスタンスリスト](https://jp.alibabacloud.com/product/ecs)から選定し取得する必要があります。
https://jp.alibabacloud.com/product/ecs

![図 3](/help/image/10.3.png)

ここで使いたいECSインスタンスタイプがあれば、そのinstance_type名を選定し、先述のTerraform ECSインスタンス生成リソースへ記載します。

<br>

### 4. ECSインスタンスimage_idの取得について
&nbsp; Alibaba CloudのECSインスタンスイメージ`image_id`一覧は `aliyun cli`か `aliyun shell`で取得する必要があります。

今回は`aliyun shell`で取得してみましょう。以下 `aliyun shell`をブラウザで開いてみてください。
https://shell.alibabacloud.com/#/

Webブラウザにて`aliyun shell`が使えるようになります。こちらにて以下コマンドを入力します。
これは東京リージョン(`ap-northeast-1 `)、表示件数100件で 使えるECSインスタンスのImageIdとOSNameリスト一覧を表示するコマンドです。
```
aliyun ecs DescribeImages --region ap-northeast-1 --language en --pager 100 | jq '[.Images.Image[] | { status: .Status , ImageId: .ImageId ,OSName: .OSName } ] | sort_by(.OSName) '
```
すると のようにECSインスタンスのImage_Idが表示されます。

![図 4](/help/image/10.4.png)
このImage_IDリストから使いたいOS（Image_ID）を選定し、先述のTerraform ECSインスタンス生成リソースへ記載します。

他にAliyun CliでのECSインスタンス一覧取得方法もあります。詳しくは以下を参照してみてください。
[qitta:aliyuncliでimage_idを調べてみた](https://qiita.com/eterao/items/4fec15b4e8a7567e270b)

<br>

### 5. EIP
&nbsp; EIP（Elastic IP）はAlibaba Cloud の VPCネットワーク の ECS、SLB インスタンスや、NATゲートウェイにパブリック IP アドレスリソースをバインドできるサービスです。
EIP使用を宣言（`alicloud_eip`）するだけでなく、返り値を利用した連結処理が必要なので、ここは抑えておきましょう。


```
# ECSインスタンスを宣言（VPC関連は省略）
resource "alicloud_instance" "ECS_instance" {
  instance_name   = "ECS_instance_for_terraform"
  host_name       = "ECS_instance_for_terraform"
  instance_type   = "ecs.n4.small"
  image_id        = "centos_7_06_64_20G_alibase_20190218.vhd"
  system_disk_category = "cloud_efficiency"
  security_groups = ["${alicloud_security_group.sg.id}"]
  availability_zone = "${var.zone}"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
}

# EIPを宣言
resource "alicloud_eip" "eip" {
  internet_charge_type = "PayByTraffic"
}

# EIPの返り値をECSインスタンスへ紐付ける
resource "alicloud_eip_association" "eip_ecs_association" {
  allocation_id = "${alicloud_eip.eip.id}"
  instance_id   = "${alicloud_instance.ECS_instance.id}"
}
```

#### **alicloud_eip**

・`bandwidth` - EIPの帯域幅。デフォルト時は5Mbps。
・`internet_charge_type` - EIPのインターネット料金タイプ。PayByBandwidth、PayByTrafficのどれかで、デフォルトはPayByBandwidth。
・`instance_charge_type` - Elastic IPインスタンスの課金タイプ。PrePaidと PostPaidのどれかで、デフォルトはPostPaid。


<!-- 
現状、cn-hangzhou、ap-south-1、me-east-1、eu-central-1、ap-northeast-1、ap-southheast-2のみサポートなので、将来的 日本リージョンでサポートできるようになったら追記
### 10.6 HTTP

### 10.7 HTTPS

### 10.8 DNS
https://www.terraform.io/docs/providers/alicloud/r/dns.html


 -->




