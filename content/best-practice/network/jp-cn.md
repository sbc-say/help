---
title: "日中の閉域ネットワーク接続"
description: "Alibaba Cloudによる日本リージョンからの閉域網接続パターンを解説します。"
date: 2019-09-30T12:30:18+08:00
weight: 30
draft: false
---

<div id="index">目次</div>

* 日中ネットワーク接続の解説の流れ  

 1. [本記事の狙い](#purpose)
 1. [日中接続パターン](#patterns)
 1. [Alibaba Cloudであるメリット](#pros)
 1. [日中ネットワークの注意点](#cons)
 1. [日中ネットワークの構築例](#example)

<br>
<div id="purpose"></div>

---
## 1. 本記事の狙い
パブリッククラウドの中でのAlibaba Cloudの代表的な強みとして、中国とのネットワークが挙げられます。  
本記事では、Alibaba Cloudを用いて、日本と中国のネットワークをどのように実現できるかのパターンに焦点を当てます。  
<small>具体的な実現手順は後日シナリオにて公開となります</small>

前提としてVPCとリージョンの知識が必要となります。


VPCとは
https://jp.alibabacloud.com/help/doc-detail/34217.htm

https://jp.alibabacloud.com/help/doc-detail/61133.html

<div id="patterns"></div>

---

## 2. 日中接続パターン

  - [Alibaba Cloud同士の接続](#ali-ali)
  - [Alibaba Cloud以外のパブリッククラウドとの接続](#ali-pub)
  - [オンプレミスの接続](#ali-on)

<br>
<div id="ali-ali"></div>

#### Alibaba Cloud同士の接続  
Alibaba Cloud同士で接続する時には、CEN ([Cloud Enterprise Network](https://jp.alibabacloud.com/product/cen)) というサービスを利用するのが一般的です。  
CENは、VPC（仮装ネットワークセグメント）に対して包括的なルーティング機能を提供します。具体的には、以下のURLよりCENインスタンスを作成します。  
https://cen.console.aliyun.com/cen/list
<br>
その後、閉域網接続を実現するVPC（例：日本リージョンのVPCと中国リージョンのVPC）をCENインスタンスと紐付ける事で、VPC同士のプライベートIPアドレスによる疎通が可能となります。ダイナミックルーティング等の複雑な設定は不要です。  
<br>
VPC間での帯域幅については、上限値をパッケージとして購入する事で、購入した分の帯域幅を確実に利用する事が出来ます。  
<br>
■CEN  
SBCDocs  
https://www.sbcloud.co.jp/entry/2018/08/01/cen-introduction/  
AliDocs  
https://jp.alibabacloud.com/help/doc-detail/59870.htm  

想定しているシステム構成

 - 連続性のあるデータ連携
 - タイムリーで確実なデータ連携

<div id="ali-pub"></div>

#### Alibaba Cloud以外のパブリッククラウドとの接続
Alibaba CloudとAlibaba Cloud以外のパブリッククラウド（AWSやAzure）を閉域網接続する時には「双方でVPNゲートウェイを作成」と「IPSec設定情報と相手先のゲートウェイ情報を入力」の2点を実施する事でVPNトンネルを作成出来ます。
VPNトンネル作成後には、VPCに紐づく静的ルーティング情報に相手先のネットワークセグメントを入力して、疎通可能となります。

https://www.sbcloud.co.jp/entry/2018/07/03/alibaba-aws_vpn/
https://www.sbcloud.co.jp/entry/2018/07/04/alibaba-azure_vpn/

Alibaba Cloud Marketplace内のVPCソフトウェア

想定しているシステム構成
 - 非連続なデータ連携
 - 遅延しても問題ない
 - 既存の他社パブリッククラウド上のシステムを流用したい

<div id="ali-on"></div>

#### オンプレミスとの接続
Alibaba CloudとAlibaba Cloud以外のパブリッククラウド（AWSやAzure）を閉域網接続する時にも、CENでの接続が推奨されます。

想定しているシステム構成

VPN ゲートウェイを経由した  
https://jp.alibabacloud.com/help/doc-detail/87042.htm

ダイナミックルーティング
スタティックルーティング
https://jp.alibabacloud.com/help/doc-detail/87041.htm#section-kvd-hqn-l2b

https://www.softbank.jp/biz/nw/nwp/cloud_access/direct_access_for_alibaba/

https://www.sbcloud.co.jp/document/expressconnect_vcp_connection

おすすめの活用方法としてCDNサービスとの組み合わせがあります。Alibaba Cloudは中国国内に500を超えるCDNノードを持っています。Express Connectと組み合わせることで，たとえば日本で開催しているイベントのライブストリーミングをExpress Connectで中国リージョンサーバまで送り，CDNを通じて中国のユーザに配信するといったことが可能になります。

 - 連続、非連続どちらもあり得る
 - 遅延なく、品質を最も重視している
 - 遅延しても問題ない
 - 既存のオンプレミスのシステムを流用したい

   - [オンプレミスの接続](#ali-on)

 
<div id="supplement"></div>

---

#### 補足
スマートアクセスゲートウェイ
ExpressConnect


---

## 3. Alibaba Cloudであるメリット
Alibaba Cloud以外のパブリッククラウドと比較して、何がメリットになるのかを記載します。

 - ネットワーク品質が良い  
あ

 - ネットワークセキュリティの実績が豊富  
 - 中国国内で利用可能なプロダクトおよびリージョン数が多い  

地味な所だと、コンソールが一つだったりします。

https://jp.alibabacloud.com/solutions/china-gateway/networking


<div id="cons"></div>

---

## 4. 日中ネットワークの注意点
CENのネットワークの帯域幅は1Kbpsです。したがってpingでの通信は可能ですが、httpの通信はデフォルトでは疎通しません。
デフォルト1Kbps
VPC間で利用する帯域幅の上限を選択する形で実現できます。


<div id="example"></div>

---

## 5. 日中ネットワークの構築例


■■選択肢  
■ExpressConnect  
VPCコネクション手順書  
https://www.sbcloud.co.jp/document/expressconnect_vcp_connection  
ダイレクトアクセス手順書  
https://www.sbcloud.co.jp/document/expressconnect_vcp_connection  
<br>
<br>
オンプレミスの繋ぎ方。  
https://img.alicdn.com/tfs/TB1XRqRJpGWBuNjy0FbXXb4sXXa-1530-1140.png  

■CEN  
SBCDocs https://www.sbcloud.co.jp/entry/2018/08/01/cen-introduction/  
AliDocs https://jp.alibabacloud.com/help/doc-detail/59870.htm  

ソリューション  
https://jp.alibabacloud.com/solutions/china-gateway/networking  

クロスリージョン  
　https://jp.alibabacloud.com/whitepaper/build-cross-region-hybrid-enterprise-networks_582?spm=a21mg.256118.1339615.2.382e74b3Efv2pZ  

■InnerVPCの考え方  
　全般, AWSとの比較  
　https://www.slideshare.net/sbcloud/awsalibaba-cloudvpc  
　https://www.sbcloud.co.jp/entry/2018/10/11/alibabacloud-vpc/  
　イントラネット  
　https://jp.alibabacloud.com/help/doc-detail/25385.htm  
 クラシックリンク  
　https://jp.alibabacloud.com/help/doc-detail/63906.htm  
　ECSのネットワーク帯域幅  
　https://jp.alibabacloud.com/help/doc-detail/25411.htm  

■ダイレクトアクセス  
Alibaba Cloudをセキュアに閉域接続するなら「ダイレクトアクセス for Alibaba Cloud」が最適です。  
ダイレクトアクセス for Alibaba Cloudとは、Alibaba Cloudの仮想プライベートクラウド「Alibaba Cloud VPC」との高品質な冗長閉域網接続を手軽に構築できるサービスです。「Alibaba Cloud VPC」とソフトバンクの閉域網サービス「SmartVPN」「ULTINA IP-VPN」との閉域接続を素早くリーズナブルに実現いたします。  
<br><br>
■Yamaha  
https://network.yamaha.com/setting/router_firewall/cloud/alibaba_cloud  
https://network.yamaha.com/setting/router_firewall/cloud/alibaba_cloud/setup_cloud  
<br><br>
Smart Access Gateway  
https://www.alibabacloud.com/ja/products/smart-access-gateway  
https://www.alibabacloud.com/help/doc-detail/69227.htm  
https://jp.alibabacloud.com/help/doc-detail/96339.htm  
