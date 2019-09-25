---
title: "VPNの実装手段"
description: "Alibaba Cloudで日本リージョンと各所をVPN接続する時のフォーマットを紹介します。"
date: 2019-09-24T12:30:18+08:00
weight: 30
draft: true
---
日中ネットワークノウハウ

1. VPNサービス
概要
Alibaba Cloudがパブリッククラウドの中で優れている点といえば、中国とのネットワークが挙げられます。
本記事では、中国とのネットワークに焦点を当てて、以下の要素を解説します。

1. 日中ネットワーク接続の手段
  - 日本・中国・米国
  - 日本・中国・アジア
1. 日中ネットワークの最適化
1. 日中ネットワークの構築例と注意点
1. 日中以外のネットワーク接続
  - 日本と米国
  - 日本とアジア
  - 日本と欧州
1. 日中と日中以外とのネットワーク接続
  - 日本・中国・米国
  - 日本・中国・アジア

 - リージョンが多い
 - 単一コンソール
 - サービスが多い


https://jp.alibabacloud.com/solutions/china-gateway/networking

2. 注意点

対象
　Alibaba Cloud VPC
　オンプレミス
　他社クラウド

日本〜中国
 - リージョンが多い
 - 単一コンソール
 - サービスが多い
 - ネットワークセキュリティの充実
 - 品質が良い

日本〜アジア

日本〜米国

日本〜欧州

中国〜日本〜アジア

中国〜日本〜米国

■■ECS利用


■■選択肢
■ExpressConnect
VPCコネクション手順書
https://www.sbcloud.co.jp/document/expressconnect_vcp_connection
ダイレクトアクセス手順書
https://www.sbcloud.co.jp/document/expressconnect_vcp_connection


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

■Yamaha
https://network.yamaha.com/setting/router_firewall/cloud/alibaba_cloud
https://network.yamaha.com/setting/router_firewall/cloud/alibaba_cloud/setup_cloud


Smart Access Gateway
https://www.alibabacloud.com/ja/products/smart-access-gateway
https://www.alibabacloud.com/help/doc-detail/69227.htm
https://jp.alibabacloud.com/help/doc-detail/96339.htm
