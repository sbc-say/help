---
title: "日本と中国のNW接続"
description: "Alibaba Cloudによる日本リージョンからの閉域網接続パターンを解説します。"
date: 2019-09-30T12:30:18+08:00
weight: 30
draft: false
---

<div id="index">目次</div>

* 日本と中国のプライベートネットワーク接続（以下、日中接続）の解説の流れ  <br><br>

 1. [本記事の狙い](#purpose)
 1. [日中接続パターン](#patterns)
 1. [Alibaba Cloudであるメリット](#pros)
 1. [日中接続の注意点](#cons)
 1. [日中接続の構築例](#example)

<span id="purpose"></span>

---
## 1. 本記事の狙い
パブリッククラウドにおけるAlibaba Cloudの代表的な強みとして、中国との安定したネットワーク接続が挙げられます。では<b>Alibaba Cloudで具体的にどのようなサービスを用いれば日中接続を実現できるか</b>を、既存の資料を交えて紹介いたします。  
<br>
本記事を理解する前提として、Alibaba CloudのVPCとリージョンの知識が必要となるので、初見の方は以下のURLも併せてご確認ください。  
<br>
VPCとは: https://jp.alibabacloud.com/help/doc-detail/34217.htm

リージョンとゾーン: https://jp.alibabacloud.com/help/doc-detail/40654.htm


<div id="patterns"></div>

---

## 2. 日中接続パターン

  - [Alibaba Cloud同士の接続](#ali-ali)
  - [Alibaba Cloud以外のパブリッククラウドとの接続](#ali-pub)
  - [オンプレミスの接続](#ali-on)

<div id="ali-ali"></div>

#### Alibaba Cloud同士の接続  
日中のシステムが共にAlibaba Cloud上で構築されている場合には、<b>CEN ([Cloud Enterprise Network](https://jp.alibabacloud.com/product/cen)) というサービスを用いる</b>のが一般的です。  
CENは、VPC（仮想ネットワークセグメント）に対して包括的なルーティング機能を提供します。その為「CENインスタンスの作成」と「CENインスタンスに対してVPC（例：日本リージョンのVPCと中国リージョンのVPC）を紐付ける」の2ステップによって、日中VPC間でのプライベートIPアドレスによる通信が可能となります。ダイナミックルーティング等の複雑な設定は一切不要です。  

##### CEN接続のステップバイステップ手順  
SBCloudドキュメント: https://www.sbcloud.co.jp/entry/2018/08/01/cen-introduction/  
Alibaba Cloudドキュメント: https://jp.alibabacloud.com/help/doc-detail/59870.htm  

##### 本構成が当てはまるシステムの要件

 - データロスが許されないデータ通信
 - リアルタイム性が重要となるデータ通信
 - 新規ビジネス展開に伴う新規システムの構築
 - 既存のAlibaba Cloudリソースの利用
 - シンプルなインフラコードを実現したい

#### 構成例 
![test](https://img.alicdn.com/tfs/TB1XRqRJpGWBuNjy0FbXXb4sXXa-1530-1140.png)  

<div id="ali-pub"></div>

#### Alibaba Cloud以外のパブリッククラウドとの接続
日中のシステムにおいて、他方がAlibaba Cloud以外のパブリッククラウド（AWSやAzure）上で構成されている場合、日中接続する為に<b>IPSecを用いたVPNトンネルを構築する</b>のが一般的です。  

VPNトンネルの構築は以下の2ステップで実現出来ます。 


1. Alibaba CloudおよびAlibaba Cloud以外のアカウント、 この両方でVPNゲートウェイを作成する
2. それぞれのVPNゲートウェイに、IPSec設定情報と対抗のゲートウェイ情報を入力する

VPNトンネルの構築後に、VPNトンネルを介した疎通を可能にする為、以下を実施します。  
<br>
3. VPCのルートテーブルの宛先に、相手先のネットワークセグメントを入力して、静的ルーティング情報を変更する  
<br>
Alibaba Cloud同士での接続と同様、ダイナミックルーティングのような複雑な設定は不要で、上記３ステップで全てが完了します。  

##### VPNトンネル接続のステップバイステップの手順  
SBCloudドキュメント：Alibaba Cloud ~ AWS  
https://www.sbcloud.co.jp/entry/2018/07/03/alibaba-aws_vpn/  
SBCloudドキュメント：Alibaba Cloud ~ Azure  
https://www.sbcloud.co.jp/entry/2018/07/04/alibaba-azure_vpn/  
Alibaba Cloudドキュメント：Alibaba Cloud ~ 汎用  
https://jp.alibabacloud.com/help/doc-detail/65072.htm

##### 本構成が当てはまるシステムの要件

 - 日中の通信で、秒単位での遅延や通信断が発生しても問題ない
 - 開発環境のデータを用いて、Alibaba Cloudを試用したい
 - 他社パブリッククラウド上のシステムを流用したい  
   e.g. 日本リージョンのAWSからコンテンツ配信して、中国リージョンのAlibaba CloudのCDNを利用して低遅延配信する

#### 構成例 
![test](https://img.alicdn.com/tfs/TB1XRqRJpGWBuNjy0FbXXb4sXXa-1530-1140.png)  

<div id="ali-on"></div>

#### オンプレミスとの接続
日中のシステムにおいて、他方がオンプレミス（凡そデータセンタ）で構成されている場合、日中接続する為の手段は2つあります。  
<br>
一つは、他社パブリッククラウド接続と同様に、VPNトンネルを経由した接続です。  
もう一つは、ダイレクトアクセスという回線サービスを用いて、オンプレミスとAlibaba Cloudを直接接続する手法です。  
<br>
ソフトバンク株式会社が持つネットワーク資産とノウハウを利用して、Alibaba CloudのVPCとオンプレミスのシステムを閉域接続します。これによりVPNトンネルによる接続では不安定なネットワーク帯域を、高品質に実現する事が可能となります。
<br>

SBCloudドキュメント：ダイレクトアクセスステップバイステップ手順書
https://www.sbcloud.co.jp/document/expressconnect_direcr_access

Softbankドキュメント：サービス紹介手順書
https://www.softbank.jp/biz/nw/nwp/cloud_access/direct_access_for_alibaba/

Alibaba Cloudドキュメント:VPN ゲートウェイを経由したローカルデータセンターから Alibaba Cloudへの接続  
https://jp.alibabacloud.com/help/doc-detail/87042.htm

##### 本構成が当てはまるシステムの要件
ダイレクトアクセスによる日中接続を前提として、以下の要件に最適と言えます。
 - オンプレミスの基幹システムと連動したAlibaba Cloudの利用
 - オンプレミスからAlibaba Cloudへのシステム移行
 - オンプレミスの基幹システムと連動したAlibaba Cloudの利用
 - 既存のオンプレミスのシステムを流用したい


https://www.softbank.jp/biz/nw/nwp/cloud_access/direct_access_for_alibaba/

■Yamaha  
https://network.yamaha.com/setting/router_firewall/cloud/alibaba_cloud  
https://network.yamaha.com/setting/router_firewall/cloud/alibaba_cloud/setup_cloud  

#### 構成例 
![test](https://img.alicdn.com/tfs/TB1XRqRJpGWBuNjy0FbXXb4sXXa-1530-1140.png)  

---

## 3. Alibaba Cloudであるメリット
Alibaba Cloud以外のパブリッククラウドと比較して、何がメリットになるのかを記載します。

 - ネットワーク品質が保証されている 
 - 日中で単一のコンソールで管理したい
 - ネットワークセキュリティの実績が豊富  
 - 中国国内で利用可能なプロダクトおよびリージョン数が多い  

https://jp.alibabacloud.com/solutions/china-gateway/networking


<div id="cons"></div>

---

## 4. 日中ネットワークの注意点
* CENのネットワークの帯域幅は1Kbpsです。したがってpingでの通信は可能ですが、httpの通信はデフォルトではほぼ疎通しません。VPC間で利用する帯域幅の上限を選択する形で実現できます  
<br>
* VPC間での帯域幅については、上限値をパッケージとして購入する事で、購入した分の帯域幅を確実に利用する事が出来ます  
<br>
* デフォルトだとIPSec IKEv1なので、IKEv2は設定変更を加えてください  
<br>
* IPSecが繋がらない場合には以下の項目をチェックします  
https://jp.alibabacloud.com/help/doc-detail/65802.htm  
<br>
* Alibaba Cloud同士の日中接続は[ExpressConnectでも実現できる](https://www.sbcloud.co.jp/document/expressconnect_vcp_connection)が、同要件については現在CENの利用を推奨しています  
<br>
* SSL-VPNで接続すると、上限に引っかかります。  
<br>
* スマートアクセスゲートウェイは中国リージョンでの利用可能で、2019年9月末時点で日本リージョンでは利用不可です  

<div id="reference"></div>

---

## 参照URL
* クラウドネットワーク接続（中国ビジネス）  
https://jp.alibabacloud.com/solutions/china-gateway/networking  

* プライベートネットワークプロダクトの選び方  
https://jp.alibabacloud.com/help/doc-detail/61133.html

* Smart Access Gateway  
https://www.alibabacloud.com/ja/products/smart-access-gateway  
* What is Smart Access Gateway?  
https://www.alibabacloud.com/help/doc-detail/69227.htm  
