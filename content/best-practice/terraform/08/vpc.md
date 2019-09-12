---
title: "VPCの作成"
date: 2019-07-22T00:00:00+09:00
description: "Terraformによる、Alibaba CloudのVPCリソース作成方法を紹介します。"
weight: 80
draft: false
---

&nbsp; ここまではTerraformのインストール方法、コード記載方法、実行方法を説明しました。  
ここからはユーザ各自でコード作成、応用ができるよう、AlibabaCloudの基本プロダクトサービスの説明を通じて解説します。

### 1. VPC
&nbsp; VPCは、Alibaba Cloudに設置されたプライベートネットワークです。 VPCはAlibaba Cloudの他のアカウントを含む仮想ネットワークと論理的に分離されています。

&nbsp; VPCはAlibaba Cloud でお客様専用のプライベートネットワークです。 CIDRというIPアドレス範囲の指定で経路、ルートテーブルとネットワークゲートウェイの設定など、VPCを完全に制御できます。VPC環境があることで、ECS、RDS、SLBなど外部インターネットからアクセスしないAlibaba Cloudリソースを使用することができます。

&nbsp; システムをセキュアにするため、パブリックネットワークには必要最小限のリソースのみ配置し、それ以外はプライベートネットワークに置くのがベストプラクティスです。

![図 1](/help/image/9.1.png)

<br>

### 2. コンポーネント
&nbsp; VPCは、CIDRブロック、VRouter、及びVSwitchで構成されます。

・CIDRブロック・・・IPアドレスの空間を指定することで通信経路を出す設定情報。プライベートIPアドレス範囲をCIDR（Classless Inter-Domain Routing）ブロックの形式で指定する必要があります。
・VRouter・・・VPCのハブ。VPC内の各VSwitchを接続でき、ゲートウェイとしてもVPCを他のネットワークに接続することもできます。
・VSwitch・・・VPCの基本的なネットワークデバイス、様々なクラウド製品インスタンスに接続するために使用されます。

VPCコンポーネントは以下のような構成図になります。
![図 2](/help/image/9.2.png)

<br>
また、VPC作成には以下の通り制限事項がありますので、注意が必要です。

|リソース|デフォルトの制限|クォータ量の増減|
|---|---|---|
|各リージョンでの最大VPC数|10	||
|使用可能なCIDRブロックの範囲|192.168.0.0/16, 172.16.0.0/12, 10.0.0.0/8,及びそのサブセット|サポートセンターまでお問い合わせください|
|VPC 内の VRouter の最大数|1|申請不可|
|VPC 内の VSwitch の最大数|24|サポートセンターまでお問い合わせください|
|VPC 内のルータテーブルの最大数|1|申請不可|
|ルータテーブル内のルートエントリの最大数|48|サポートセンターまでお問い合わせください|
|VPCで実行できるクラウド製品インスタンスの最大数|15,000|申請不可|
[参考:VPC使用制限](https://jp.alibabacloud.com/help/doc-detail/27750.htm)

<br>

### 3. VPCのTerraformについて
&nbsp; 本題、VPC、VSwitch作成に移ります。VPCリソースを実行すると、VPC構築のためにrouterとroute_tableを自動的に作成されます。まずは以下の構成図通り、簡単なソースを作ってみます。
![図 3](/help/image/9.3.png)

この構成図を満たすVPC、VSwitch を作成するコードです。
```
resource "alicloud_vpc" "vpc" {
  name = "ECS_instance_for_terraform-vpc"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "ap-northeast-1"
}

```

#### **alicloud_vpc**
上記で記載したリソース以外にオプション（任意）でパラメータや構成を指定することもできます。

* `cidr_block` - （必須）VPCのCIDRブロック。VPCのIPv4アドレスの範囲をCIDR形式(XX.XX.XX.XX/XX)で、cidr_blockに指定します。そのため、[VPCピアリング](https://docs.alicloud.amazon.com/ja_jp/vpc/latest/peering/what-is-vpc-peering.html)なども考慮し て、最初にきちんと設計する必要があります。後からの変更も不可です。
* `name` - （オプション）VPCの名前。デフォルトはnullです。
* `description` - （オプション）VPCの説明。デフォルトはnullです。

このリソースを実行することにより、以下の属性情報が出力されます。

* `id` - VPCのID。
* `cidr_block` - VPCのCIDRブロック。
* `name` - VPCの名前。
* `description` - VPCの説明。
* `router_id` - VPC作成時にデフォルトで作成されたルータのID。
* `route_table_id` - VPC作成時にデフォルトで作成されたルータのルートテーブルID。

#### **alicloud_vswitch**
VPC_SWITCHも上記で記載したリソース以外にオプション（任意）でパラメータや構成を指定することもできます。１つのVPCあたりの最大24個までのVSwitchが作成可能です。

* `availability_zone` - （必須）スイッチのAvailabilityZone。
* `vpc_id` - （必須）VPC ID。
* `cidr_block` - （必須）スイッチのCIDRブロック。
* `name` - （任意）スイッチの名前。デフォルトはnullです。
* `description` - （オプション）スイッチの説明。デフォルトはnullです。

このalicloud_vswitchリソースを実行することにより、以下の属性情報が出力されます。

* `id` - スイッチのID。
* `availability_zone` - スイッチのAvailabilityZone。
* `cidr_block` - スイッチのCIDRブロック。
* `vpc_id` - VPC ID。
* `name` - スイッチの名前。
* `description` - スイッチの説明。

他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/vpc.html
https://www.terraform.io/docs/providers/alicloud/r/vswitch.html


<br>
続いて、VRouterを作ってみます。VRouterはVPC内全てのVSwitchが接続でき、ゲートウェイとして他のVPCを他ネットワークへ接続することができます。以下の構成図をゴールに作ってみます。


ルートテーブルを作成、アタッチするコードです。
VSwitchを作成し（alicloud_vswitch）、ルートエントリを作成（alicloud_route_entry）、それを紐付けるルートテーブルを作成（alicloud_route_table）、そしてへVSwitchをアタッチ（alicloud_route_table_attachment）する内容です。

```
resource "alicloud_vpc" "foo" {
    cidr_block = "172.16.0.0/12"
    name = "route_table_attachment"
}
 data "alicloud_zones" "default" {
    "available_resource_creation"= "VSwitch"
}
 resource "alicloud_vswitch" "foo" {
    vpc_id = "${alicloud_vpc.foo.id}"
    cidr_block = "172.16.0.0/21"
    availability_zone = "${data.alicloud_zones.default.zones.0.id}"
    name = "route_table_attachment"
}

resource "alicloud_route_entry" "custom_route_entry" {
  route_table_id        = "${alicloud_vpc.foo.router_table_id}"
  destination_cidrblock = "${var.entry_cidr}"
  nexthop_type          = "Instance"
  nexthop_id            = "${alicloud_instance.snat.id}"
}

resource "alicloud_route_table" "foo" {
    vpc_id = "${alicloud_vpc.foo.id}"
    name = "route_table_attachment"
    description = "route_table_attachment"
}

resource "alicloud_route_table_attachment" "foo" {
    vswitch_id = "${alicloud_vswitch.foo.id}"
    route_table_id = "${alicloud_route_table.foo.id}"
}
```

#### **alicloud_route_entry**
alicloud_route_entryの必須パラメータは以下の通りです。

* `route_table_id` - （必須）ルートテーブルのID。
* `destination_cidrblock` - （必須）RouteEntryのターゲットネットワークセグメント。
* `nexthop_type` - （必須）ネクストホップタイプ
* `nexthop_id` - （必須）ルートエントリのネクストホップ。ECSインスタンスIDまたはVPCルータインターフェイスID。

このalicloud_route_entryリソースを実行することにより、以下の属性情報が出力されます。

* `router_id` - Vpcに接続されている仮想ルータのID。
* `route_table_id` - ルートテーブルのID。
* `destination_cidrblock` - RouteEntryのターゲットネットワークセグメント。
* `nexthop_type` - ネクストホップタイプ。
* `nexthop_id` - ルートエントリのネクストホップ。

#### **alicloud_route_table**
alicloud_route_tableの入力パラメータは以下の通りです。

* `vpc_id` - （必須）ルートテーブルのvpc_id、フィールドは変更できません。
* `name` - （任意）ルートテーブルの名前。
* `description` - （任意）ルートテーブルインスタンスの説明。

このalicloud_route_tableリソースを実行することにより、以下の属性情報が出力されます。

* `id` - ルートテーブルインスタンスIDのID。

#### **route_table_attachment**
route_table_attachmentの入力パラメータは以下の通りです。

* `vswitch_id` - （必須）ルートテーブル添付のvswitch_id、フィールドは変更できません。
* `route_table_id` - （必須）ルートテーブル添付のroute_table_id。フィールドは変更できません。

このroute_table_attachmentリソースを実行することにより、以下の属性情報が出力されます。

* `id` - ルートテーブルのIDとアタッチしたvswitchのID。形式は<route_table_id>:<vswitch_id>で出力されます。


<br>

### 3. セキュリティグループ
&nbsp; VPC関連を作成したら、今度は外部インターネットから様々なアクセス（インバウンド/アウトバインド）をフィルタリングするためにセキュリティグループを設置します。外部ネットワークからの不正アクセスを防ぐ上で重要なので、セキュリティグループも記載しましょう。セキュリティで詳細は[こちら](https://jp.alibabacloud.com/help/doc-detail/25475.htm)を参照してみてください。

##### セキュリティグループの考え方について
ECSインスタンスは少なくとも1つのセキュリティグループに参加する必要があります。
ここは構築したい最終目的に応じて、以下セキュリティグループルールの構成テンプレートに沿って配置がベターです。

|設定|テンプレートノート|注意|
|---|---|---|
|セキュリティグループ内の Linux インスタンスに Web サーバーを展開する。|Web Server Linux|Web Server Linux デフォルトでは、TCP 80、TCP 443、TCP 22、ICMP のインバウンドトラフィックが許可されます。|
|セキュリティグループの Windows インスタンスに Web サーバーを展開する。|Web Server Windows|デフォルトでは、TCP 80、TCP 443、TCP 3389、ICMP のインバウンドトラフィックが許可されます。|
|Web サーバー外|Custom|セキュリティグループを作成したら、ビジネスニーズを満たすセキュリティグループルールを追加する|

<br>

##### Port詳細について
|プロトコルタイプ|ポート範囲|シナリオ|
|---|---|---|
|All|-1/-1 はすべてのポートを示します。|両方のアプリケーションが完全に信頼されるシナリオで使用されます。|
|All ICMP|-1/-1 はすべてのポートを示します。|Pingツールを使用してインスタンスのネットワーク接続ステータスを検出するために使用されます。|
|All GRE|-1/-1 はすべてのポートを示します。|VPNサービスに使用されます。|
|Custom TCP|カスタムポートの場合、有効なポート値は1～65535で、 有効なポート範囲の形式は 開始ポート/ 終了ポート|1つまたは複数の連続するポートを許可または拒否するために使用されます。|
|Custom UDP|カスタムポートの場合、有効なポート値は1～65535で、 有効なポート範囲の形式は 開始ポート/ 終了ポート|1つまたは複数の連続するポートを許可または拒否するために使用されます。|
|SSH|22/22、デフォルトはSSHポート22として表示されます。|Linuxインスタンスへのリモート接続に使用されます。|
|TELNET|23/23と表示されます。|Telnetを使用してインスタンスにリモートログオンするために使用されます。|
|HTTP|80/80と表示されます。|このインスタンスは、WebサイトまたはWebアプリケーションのサーバーとして使用されます。|
|HTTPS|443/443と表示されます。|このインスタンスは、HTTPSプロトコルをサポートするWebサイトまたはWebアプリケーションのサーバーとして使用されます。|
|MS SQL|1433/1433と表示されます。|インスタンスはMS SQLサーバーとして使用されます。|
|Oracle|1521/1521と表示されます。|インスタンスはOracle SQL Serverとして使用されます。|
|MySQL|3306/3306と表示されます。|インスタンスはMySQLサーバーとして使用されます。|
|RDP|3389/3389と表示されます。デフォルトのRDPポートは3389です。|Windowsインスタンスへのリモート接続に使用されます。|
|PostgreSQL|5432/5432と表示されます。|インスタンスはPostgreSQLサーバとして使用されます。|
|Redis|6379/6379と表示されます。|インスタンスはRedisサーバーとして使用されます。|

<br>
&nbsp; 本題、セキュリティグループを設定するコード作成をします。まずは以下の構成図通り、簡単なソースを作ってみます。

![図 4](/help/image/9.4.png)

この構成図からして、２つのセキュリティルールを作成（ルール名： `allow_http` 、 `allow_ssh` ）し、それをセキュリティグループへアタッチする流れになります。
```
resource "alicloud_security_group" "sg" {
  name   = "terraform-sg"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 2
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "outbound_all" {
  type              = "egress"
  ip_protocol       = "All"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 2
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}

```
上記ソースで `allow_http` ルールは HTTP通信できるよう80番ポートを許可します。 `allow_ssh` ルールは ssh接続のためにTCP22番ポートを許可します。 `outbound_all` ルールは 作成したWebサイトらECSから外部インターネットへ展開するために ALLポートを許可します。こちらはWebサイト構築が目的ならアウトバインドのルールはデフォルト設定と変わりないため不要で問題ないです。いずれも `sg` というセキュリティグループへ紐づけています。

#### **alicloud_security_group**

* `name` - （オプション）セキュリティグループの名前。デフォルトはnull。
* `description` - （オプション）セキュリティグループの説明。デフォルトはnull。
* `vpc_id` - （オプション）VPC ID。
* `inner_access` - （オプション）同じセキュリティグループ内のすべてのポートで、両方のマシンが互いにアクセスできるようにするかどうか。
* `tags` - （オプション）リソースに割り当てるタグのマッピング。

このalicloud_security_groupリソースを実行することにより、以下の属性情報が出力されます。

* `id` - セキュリティグループのID
* `vpc_id` - VPC ID
* `name` - セキュリティグループの名前
* `description` - セキュリティグループの説明
* `inner_access` - 内部ネットワークアクセスを許可するかどうか。
* `tags` - インスタンスタグは、jsonencode（item）を使って値を表示します。

#### **alicloud_security_group_rule**
パラメータで、`type` が `ingress` の場合、インバウンド時のルールになります。アウトバインドであれば `egress` です。

* `type` - （必須）作成中のルールの種類。ingress（インバウンド：外部から内部）かegress（アウトバウンド：内部から外部）のいずれかです。
* `ip_protocol` - （必須）プロトコル。tcp、udp、icmp、gre、allのいずれかを選択します。
* `port_range` - （オプション）IPプロトコルに関連するポート番号の範囲。デフォルトは "-1 / -1"です。プロトコルがtcpまたはudpの場合、各サイドポート番号の範囲は1〜65535で、「 - 1 / -1」は無効になります。たとえば1/200、ポート番号の範囲は1〜200です。
* `security_group_id` - （必須）アタッチしたいセキュリティグループID。
* `nic_type` - （オプション）ネットワークタイプ。internetかintranetのいずれかを選択します。デフォルトはinternetです。
* `policy` - （オプション）認可ポリシー。acceptかdropのいずれかを選択します。デフォルトはacceptです。
* `priority` - （オプション）許可ポリシーの優先順位。デフォルトは1です。
* `cidr_ip` - （オプション）ターゲットIPアドレス範囲。デフォルト値は0.0.0.0/0（=無制限）です。

このalicloud_security_group_ruleリソースを実行することにより、以下の属性情報が出力されます。

* `id` - セキュリティグループルールのID
* `type` -ルールのタイプ、ingressまたはegress
* `name` - セキュリティグループの名前
* `port_range` - ポート番号の範囲
* `ip_protocol` - セキュリティグループルールのプロトコル

<br>

<!-- 
### 9.4 BestPractics：VPCの設計について

##### A. 別のVPCと接続したい場合


##### B. オンプレミスのデータセンターと接続したい場合


##### C. 複数のサイトと接続したい場合


------------
------------

### 9.5 BestPractics：VPCの設計について
&nbsp; VPCのベストプラクティスとして、VPCとVSwitchを作成する前に、目的や特定のビジネスに応じてVPCとVSwitchの数量とCIDRブロックを設計する必要があります。


![図 9.2](/help/image/9.8.jpg)
```
resource "alicloud_vpc" "vpc" {
  name = "ECS_instance_for_terraform-vpc"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
}

resource "alicloud_security_group" "sg" {
  name   = "ECS_instance_for_terraform-sg"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}
```
![図 9.3](/help/image/9.9.jpg)
```
resource "alicloud_vpc" "vpc" {
  name = "ECS_instance_for_terraform-vpc"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
}

resource "alicloud_security_group" "sg" {
  name   = "ECS_instance_for_terraform-sg"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}
```
![図 9.4](/help/image/9.10.jpg)
```
resource "alicloud_vpc" "vpc" {
  name = "ECS_instance_for_terraform-vpc"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
}

resource "alicloud_security_group" "sg" {
  name   = "ECS_instance_for_terraform-sg"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}
```
![図 9.5](/help/image/9.5.jpg)

```
resource "alicloud_vpc" "vpc" {
  name = "ECS_instance_for_terraform-vpc"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "192.168.1.0/28"
  availability_zone = "${var.zone}"
}

resource "alicloud_security_group" "sg" {
  name   = "ECS_instance_for_terraform-sg"
  vpc_id = "${alicloud_vpc.vpc.id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}
```
-->
