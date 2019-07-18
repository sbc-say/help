---
title: "AutoScalingの作成"
date: 2019-07-01T00:00:00+09:00
description: "Terraformによる、Alibaba CloudのAutoscalingリソース作成方法を紹介します。"
weight: 110
draft: false
---

AlibabaCloudの基本プロダクトサービスであるAutoscalingの作成方法を解説します。

### 1. AutoScaling
&nbsp; Auto Scaling はECSリソースの容量を自動的にスケールイン/スケールアウト調整してくれます。
![図 1](/help/image/12.1.png)
※ESSとは、SDK名やパッケージ名で用いられるAuto Scalingの略称です。（Elastic Scaling Service）

<br>

### 2. コンポーネント
&nbsp; VPCは、CIDRブロック、VRouter、及びVSwitchで構成されます。

・スケールアウト
ECSリソースが増加した際、自動的にECSインスタンスが作成されるので、アクセス遅延や過度のリソース負荷を回避できます。
![図 2](/help/image/12.2.png)

・スケールイン
ビジネスニーズに伴い、基盤となるECAリソースが低下した場合、自動的にECSインスタンスが削除され、リソースの無駄を省いてくれます。
![図 3](/help/image/12.3.png)

・柔軟なリカバリ
異常なECSインスタンスを検知し、自動的にリリースされ、代わりに新規ECSインスタンスが作成されます。
![図 4](/help/image/12.4.png)

### 3. AutoScalingのTerraformについて
&nbsp; 本題、AutoScaling作成に移ります。以下の構成図通り、簡単なソースを作ってみます。
```
resource "alicloud_ess_scaling_group" "scaling" {
  min_size = 2
  max_size = 10
  scaling_group_name = "tf-scaling"
  vswitch_ids=["${alicloud_vswitch.vsw. *.id}"]
  loadbalancer_ids = ["${alicloud_slb.slb. *.id}"]
  removal_policies   = ["OldestInstance", "NewestInstance"]
  depends_on = ["alicloud_slb_listener.http"]
}

resource "alicloud_ess_scaling_configuration" "config" {
  scaling_group_id = "${alicloud_ess_scaling_group.scaling.id}"
  image_id = "ubuntu_140405_64_40G_cloudinit_20161115.vhd"
  instance_type = "ecs.n2.small"
  security_group_id = "${alicloud_security_group.default.id}"
  active=true
  enable=true
  user_data = "#! /bin/bash\necho \"Hello, World\" > index.html\nnohup busybox httpd -f -p 8080&"
  internet_max_bandwidth_in=10
  internet_max_bandwidth_out= 10
  internet_charge_type = "PayByTraffic"
  force_delete= true
}

resource "alicloud_ess_scaling_rule" "rule" {
  scaling_group_id = "${alicloud_ess_scaling_group.scaling.id}"
  adjustment_type  = "TotalCapacity"
  adjustment_value = 2
  cooldown = 60
}
```
AutoScalingを作成する時は`alicloud_ess_scaling_group`、`alicloud_ess_scaling_configuration`、`alicloud_ess_scaling_rule`の３つの組み合わせが必要になります。

#### **alicloud_ess_scaling_group**
同じアプリケーションシナリオを持つECSインスタンスにてAutoScalingグループリソースを提供するために必要なパラメータです。グループ内のECSインスタンスの最大数と最小数、関連付けられたSLB、RDSインスタンス、およびその他の属性を定義します。
* `min_size` - （必須）スケーリンググループ内のECSインスタンスの最小数。
* `max_size` - （必須）スケーリンググループ内のECSインスタンスの最大数。
* `scaling_group_name` - （オプション）スケーリンググループに表示される名前。
* `vswitch_ids` - （オプション）ecsインスタンスが起動されるVSwitchのID。 
* `loadbalancer_ids` - （オプション）スケーリンググループでServer Load Balancerインスタンスが指定されている場合、スケーリンググループは自動的にそのECSインスタンスをServer Load Balancerインスタンスに接続します。
* `removal_policies` - （オプション）RemovalPolicyは、複数の削除候補が存在する場合にスケーリンググループから削除するECSインスタンスを選択するために使用されます。

他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/ess_scaling_group.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/ess_scaling_group.html


#### **alicloud_ess_scaling_configuration**
alicloud_ess_scaling_configurationはAutoScalingを設定するパラメータです。
* `scaling_group_id` - （必須）スケーリングルールのスケーリンググループのID。
* `image_id` - （オプション）ECSインスタンスのイメージID。
* `instance_type` - （オプション）ECSインスタンスタイプ。
* `active` - （オプション）指定されたスケーリンググループの現在のスケーリング設定をアクティブにするかどうか。デフォルトはfalse。
* `enable` - （オプション）現在のスケーリング設定が属する指定されたスケーリンググループを有効にするかどうか。
* `internet_max_bandwidth_in` - （オプション）パブリックネットワークからの最大着信帯域幅。
* `internet_max_bandwidth_out` - （オプション）パブリックネットワークからの最大発信帯域幅。

他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/ess_scaling_configuration.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/ess_scaling_configuration.html

#### **alicloud_ess_scaling_rule**
AutoScalingのルールリソースを設定するパラメータです。
* `scaling_group_id` - （必須）スケーリングルールのスケーリンググループのID。
* `adjustment_type` - （必須）スケーリングルールの調整モード。
* `adjustment_value` - （必須）スケーリングルールの調整値。
* `cooldown` - （オプション）スケーリングルールのクールダウン時間。


<br>
以下にAutoScalingの実際のサンプルを入れていますので、こちらも参照してみてください。

[example: オートスケーリング]({{%relref "scenario/terraform/auto-scaling.md" %}})

