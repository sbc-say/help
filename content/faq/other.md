---
title: "その他"
description:  "Alibaba Cloudの製品に関するよくある質問を紹介します。"
date: 2019-10-04T15:30:00+09:00
weight: 100
draft: false
---
<h4 id="index">目次</h4>

* NAS
 * [NASの使用可能容量の表示について](#NASの使用可能容量の表示について)
* RAM
 * [RAMユーザの権限を特定のリージョンに制限する方法について](#RAMユーザの権限を特定のリージョンに制限する方法について)
 * [RAMユーザの権限をECS操作のみ可能、購入不可に制限する方法について](#RAMユーザの権限をECS操作のみ可能、購入不可に制限する方法について)
 * [RAMユーザでSSL Certifcate Serviceを利用時の権限について](#RAMユーザでSSL Certifcate Serviceを利用時の権限について)
 * [RAMユーザでコンテナのコンソールを操作させる方法について](#RAMユーザでコンテナのコンソールを操作させる方法について)
* Logservice
 * [Logstore の「internal-alert-history」ログについて](#Logstore の「internal-alert-history」ログについて)
 * [Logtailの履歴ログのインポートモードについて](#Logtailの履歴ログのインポートモードについて)
* ExpressConnect
 * [ExpressConnect同じリージョン内VPC-VPC接続の料金について](#ExpressConnect同じリージョン内VPC-VPC接続の料金について)
* CDN
 * [CDNでのAlibaba Cloud の無料証明書申請について](#CDNでのAlibaba Cloud の無料証明書申請について)
 * [CDNオリジンへのリクエストタイムアウト値について](#CDNオリジンへのリクエストタイムアウト値について)
 * [CDN + OSS 構成の静的ウェブサイトホスティングについて](#CDN + OSS 構成の静的ウェブサイトホスティングについて)
* Imagesearch
 * [Image SearchのインポートQPS制限について](#Image SearchのインポートQPS制限について)
* VPNGAteway
 * [VPNGAtewayのSSL証明書作成仕様について](#VPNGAtewayのSSL証明書作成仕様について)
 * [VPNGatewayにて作成可能なSSL証明書数について](#VPNGatewayにて作成可能なSSL証明書数について)
 * [VPN Gatewayのヘルスチェック設定について](#VPN Gatewayのヘルスチェック設定について)
 * [SSL-VPNに払い出されるIPアドレスの仕様について](#SSL-VPNに払い出されるIPアドレスの仕様について)
* SSL Certifcate
 * [SSL証明書の更新について](#SSL証明書の更新について)
 * [SSL証明書申請後のドメイン変更について](#SSL証明書申請後のドメイン変更について)
* DataV
 * [DataVでの「コールバックID」の呼び出し範囲について](#DataVでの「コールバックID」の呼び出し範囲について)
* CEN
 * [CENの帯域幅変更時の通信断発生について](#CENの帯域幅変更時の通信断発生について)
* Function Compute
 * [Function Computeの時間トリガーのタイムゾーンについて](#Function Computeの時間トリガーのタイムゾーンについて)
 * [Function ComputeからRDSのイントラネット接続について](#Function ComputeからRDSのイントラネット接続について)
* IoT
 * [IoT Platformのデバイス監視機能について](#IoT Platformのデバイス監視機能について)
* Redis
 * [Redisのパスワードでの接続方法について](#Redisのパスワードでの接続方法について)
 * [ApsaraDB for Redisの強制アップグレードについて](#ApsaraDB for Redisの強制アップグレードについて)

<h4 id="NASの使用可能容量の表示について"></h4>
{{%panel theme="default" header="NASの使用可能容量の表示について"%}}
各NASストレージの容量上限は10.0PBになります。<br>

ストレージパッケージのご購入容量はNASのストレージ容量上限ではなく、購入した容量までを定額でご利用いただけるサービスとなり、
購入いただいた設定額を超えた分は、従量課金として請求されます。<br>

そのため、ストレージパッケージのご購入もしくは従量課金でのご利用にかかわらず、NASの容量は10.0PBとなります。
{{% notice note %}}
NASの料金表は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/product/nas/pricing<br><br>

NASの課金シナリオは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/27523.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>


<h4 id="RAMユーザの権限を特定のリージョンに制限する方法について"></h4>
{{%panel theme="default" header="RAMユーザの権限を特定のリージョンに制限する方法について"%}}
RAMユーザの権限を特定のリージョンに制限することは可能です。<br>

下記例を参考して、お客様のニーズに合わせて、cn-shanghaiのところを対象リージョンIDに変更する必要です。

{{% notice tip %}}
以下は上海リージョンの一例です。<br><br>

```
{
  ""Statement"": [
    {
      ""Action"": ""*"",
      ""Effect"": ""Allow"",
      ""Resource"": ""*:*:cn-shanghai:*:*""
    }
  ],
  ""Version"": ""1""
}
```
{{% /notice %}}

{{% notice note %}}
ポリシーの基本要素は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28663.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="RAMユーザの権限をECS操作のみ可能、購入不可に制限する方法について"></h4>
{{%panel theme="default" header="RAMユーザの権限をECS操作のみ可能、購入不可に制限する方法について"%}}
RAMユーザの権限をECS操作のみ可能、購入不可に制限することは可能です。

下記例を参考して、お客様のニーズに合わせて、cn-shanghaiのところを対象リージョンIDに変更する必要です。

{{% notice tip %}}
以下は上海リージョンの一例です。<br><br>

CreateInstanceはサブスクリプション、RunInstancesは従量課金の購入を制限しています。購入ページまでアクセスはできますが、最後支払う段階で、権限のない旨のエラーが発生しますので、実際には購入できません。


```
{
  ""Statement"": [
    {
      ""Action"": ""ecs:*"",
      ""Effect"": ""Allow"",
      ""Resource"": ""*:*:cn-shanghai:*:*""
    },
    {
      ""Action"": ""ecs:CreateInstance"",
      ""Effect"": ""Deny"",
      ""Resource"": ""*:*:cn-shanghai:*:*""
    },
    {
      ""Action"": ""ecs:RunInstances"",
      ""Effect"": ""Deny"",
      ""Resource"": ""*:*:cn-shanghai:*:*""
    }
  ],
  ""Version"": ""1""
}
```
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="RAMユーザでSSL Certifcate Serviceを利用時の権限について"></h4>
{{%panel theme="default" header="RAMユーザでSSL Certifcate Serviceを利用時の権限について"%}}
RAMユーザでSSL証明書をご購入いただく場合、`AliyunYundunCertReadOnlyAccess`と`AliyunBSSFullAccess`の権限が必要です。<br>

SLBに証明書をバインドする場合は、`AliyunYundunCertReadOnlyAccess`と`AliyunSLBFullAccess`の権限がそれぞれ必要となります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="RAMユーザでコンテナのコンソールを操作させる方法について"></h4>
{{%panel theme="default" header="RAMユーザでコンテナのコンソールを操作させる方法について"%}}
RAMユーザでコンテナのコンソールを操作させるには、RAMユーザへのコンテナサービスコンソール権限付与、とコンテナサービス内で指定クラスタ権限の付与が必要です。

{{% notice info %}}
承認手順は下記をご参考ください。<br>

①新規RAMユーザーを作成します。<br>
②対象RAMユーザーに`AliyunCSFullAccess`権限を追加します。<br>
③コンテナーサービスのクラスター項目を選択します。<br>
④承認を選択します。<br>
⑤対象RAMユーザーを確認して、承認ボタンをクリックします。<br>
⑥対象クラスーを選択して、名前空間を選択して、RBACのロールを選択します。<br>
⑦「次のステップ」をクリックします。<br>
⑧「承認ポリシーの更新」をクリックします。<br>
⑨[承認成功]が表示されます。
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="Logstore の「internal-alert-history」ログについて"></h4>
{{%panel theme="default" header="Logstore の「internal-alert-history」ログについて"%}}
アラートルールを設定する際に、Log Serviceは自動的に対象アラートが所属されているプロジェクトにinternal-alert-historyを作成します。<br>
このプロジェクト内に全てのアラートルールが実施される時にアラートが発生したかどうか関わらず、LogStoreのinternal-alert-historyに記録されます。<br><br>

「internal-alert-history」により料金は発生しませんが、直接削除することもできません。対象プロジェクトを削除するとinternal-alert-historyも削除されます。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="Logtailの履歴ログのインポートモードについて"></h4>
{{%panel theme="default" header="Logtailの履歴ログのインポートモードについて"%}}
履歴ログのインポートモード（ローカルイベントを追加した状態）と、通常のログ収集モードに違いがあります。<br><br>

名前の通り、通常のログ収集モードは、「Logtail 設定」完了後に、指定されたログファイルからリアルタイムでログを吸い上げます。<br>
過去のログも一部取れますが、限度は1MBまでです。履歴ログのインポートモードは指定されたログファイルを一度のみ丸ごと吸い上げます。<br>

また、ローカルイベントで指定するログディレクトリは「Logtail 設定」で指定するディレクトリと一致する必要がありません。<br><br>
ただし、重要なのは履歴ログのインポートモードのログディレクトリはローカルイベントにて指定されます。<br>
コンソールの「Logtail 設定」には存在しないディレクトリでもOKです。"

{{% notice note %}}
ログ収集は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/89928.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="ExpressConnect同じリージョン内VPC-VPC接続の料金について"></h4>
{{%panel theme="default" header="ExpressConnect同じリージョン内VPC-VPC接続の料金について"%}}
以前は有料でしたが、2019/02/25のExpress Connect料金改定に伴い、同じリージョン内（異なるアカウントのVPC間を含め）のVPC接続をする場合は料金不要となりました。

{{% notice note %}}
Express Connect 料金表は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/notice/expressconnect-price-notice-20190225<br><br>

Express Connect 料金改定案内は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/product/express-connect/pricing
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="CDNでのAlibaba Cloud の無料証明書申請について"></h4>
{{%panel theme="default" header="CDNでのAlibaba Cloud の無料証明書申請について"%}}
CDN無料証明書の取得条件は、DNS設定にてCDN用ドメインとCDNで払い出されているCNAMEとバインドすることですが、
CDN用ドメインはトップドメイン、またはwwwドメインでCDN無料証明書を取得する場合、トップドメインとwwwドメイン両方をCDNで払い出されているCNAMEとバインドする必要があります。

{{% notice info %}}
DNS設定にて以下のようなCNAMEレコードを追加していただく、CDNコンソールにて無料証明書を取得可能になります。                                 
```
例：
                　CNAME
hugo.com       ----------->  www.hugo.com.w.cdngslb.com

                  CNAME
www.hugo.com   ----------> www.hugo.com.w.cdngslb.com"
```
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>


<h4 id="CDNオリジンへのリクエストタイムアウト値について"></h4>
{{%panel theme="default" header="CDNオリジンへのリクエストタイムアウト値について"%}}
AlibabaCloud CDN/DCDNに対して、オリジンへのリクエストタイムアウト値上限はデフォルトで30秒となります。<br><br>

オリジンサーバから応答時間は「30秒」以上かかる場合、チケットの申請により、該当上限値を引き上げることは可能です。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="CDN + OSS 構成の静的ウェブサイトホスティングについて"></h4>
{{%panel theme="default" header="CDN + OSS 構成の静的ウェブサイトホスティングについて"%}}
OSSを非公開し、CDNの設定にて、プライベートバケットの Back-to-Originの設定を有効化した場合、下記の制限があります。

{{% notice info %}}
インデックスドキュメントの設定が利用できません。<br>
```
http://example.com/
とアクセスしても、403や404になり、
http://example.com/index.html
へリダイレクトされません。
```

制限を回避するには、CDNキャッシュ設定のカスタムページの設定で、403や404になると、
http://example.com/index.html
を返すような設定することは可能です。

```
http://example.com/
へアクセスすると、
http://example.com/index.html
としてアドレスバーにも表示されます。
```
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="Image SearchのインポートQPS制限について"></h4>
{{%panel theme="default" header="Image SearchのインポートQPS制限について"%}}
Image Searchのプラン毎にAPIコードのQPSが定められています。APIからの画像アップロードではこのQPSの制限が受けられます。<br><br>

大量の画像をインポートする場合、OSSからのインポートはAPIのQPS制限を受けられませんので、ご利用ください。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="VPNGAtewayのSSL証明書作成仕様について"></h4>
{{%panel theme="default" header="VPNGAtewayのSSL証明書作成仕様について"%}}
1つVPNGatewayに作成可能なSSLクライアント証明書の上限数は50件となります。<br>
同じ証明書は複数クライアントから同時使用可能のため、50のSSL証明書に対して最大1000人が同時利用（同時接続）可能です。<br><br>

SSLクライアント証明書の作成可能な回数は100回です。<br>

{{% notice tip %}}
例えば、50件証明書を作成して、全部削除して、もう一度50件作成して、作成回数は100回上限に達します。
それから、また1件を削除して49件証明書になっても、新規 SSL 証明書は作成できません。
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="VPNGatewayにて作成可能なSSL証明書数について"></h4>
{{%panel theme="default" header="VPNGatewayにて作成可能なSSL証明書数について"%}}
VPN GatewayのSSLサーバでは、クライアント向けのSSL証明書を作成できますが、作成可能な上限数があり、VPN Gatewayインスタンスあたり50個まで証明書を保存できます。<br><br>

VPN Gateway作成時に指定する「SSL接続数」が最大で1,000となりますが、これは複数のSSLクライアントでSSL証明書を共有することを想定しています。<br><br>

なお、スペックの「SSL接続数」と関係なく、50証明書を作成することは可能です。「SSL接続数」が10のVPN Gatewayインスタンスでも、20個の証明書を作ることが可能です。ただし、この場合、同時接続数は10です。<br><br>

また、最大 SSL クライアント作成数は100となります。これは、「累計で作成できる証明書数」が、VPN Gatewayインスタンスあたり100まで、を意味します。したがって、「作成／削除」を繰り返すと上限に達する恐れがあります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="VPN Gatewayのヘルスチェック設定について"></h4>
{{%panel theme="default" header="VPN Gatewayのヘルスチェック設定について"%}}
VPN Gatewayヘルスチケットは該当IPsec Connection経由の往復通信を両方検知した場合、正常となります。<br><br>

冗長構成で、複数IPsec Connectionが構築された場合、トラフィックの往路はバックアップのIPsec Connection経由となっても、復路はマスターのIPsec Connectionとなることもありますので、バックアップ側に複路のトラフィックを検出できず、ヘルスチェックが失敗となるケースがあります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SSL-VPNに払い出されるIPアドレスの仕様について"></h4>
{{%panel theme="default" header="SSL-VPNに払い出されるIPアドレスの仕様について"%}}
AlibabaCloud SSL-VPNを利用する場合、設定されたクライアントレンジから払い出されるIP数に制限があります。<br>
制限数は、「レンジIP総数/4-2」となります。<br><br>

192.168.0.0/28の場合は「2^4/4-2 = 2」で2つのIPアドレスが利用可能です。<br><br>

また、リリースしたクライアントアドレスはすぐ再取得できなく、１−２分おいてから、再取得可能です。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SSL証明書の更新について"></h4>
{{%panel theme="default" header="SSL証明書の更新について"%}}
Alibaba Cloud SSL Certificates Serviceでは、 新規のSSL証明書購入のみをサポートしています。更新をサポートしていません。<br><br>

そのため、既存のSSL証明書を継続してご利用になさりたい場合、再度、購入し直していただく必要がございます。

{{% notice note %}}
期限切れに伴う新規購入は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28544.htm<br><br>

購入ガイドは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28542.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SSL証明書申請後のドメイン変更について"></h4>
{{%panel theme="default" header="SSL証明書申請後のドメイン変更について"%}}
審査が完了し、発行済みとなったSSL証明書の対象ドメインは変更することができません。<br><br>

ただし、対象証明書IDの右側で[取り消し]ボタンが表示される場合、申請した内容をキャンセルし、ドメイン変更後に再度申請することは可能です。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="DataVでの「コールバックID」の呼び出し範囲について"></h4>
{{%panel theme="default" header="DataVでの「コールバックID」の呼び出し範囲について"%}}
DataVで「コールバックID」を利用して、パラメータを別のウィジェットに渡すことが便利です。<br><br>

ただし、コールバックのパラメータを呼び出すウィジェットにデータソースの制限があります。現在利用可能なデータソースは「API」または「データベース」のみとなります。<br>
「CSV」、「静的データ」、「TableStore」などはコールバックのパラメータを呼び出せませんので、ご注意ください。

{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="CENの帯域幅変更時の通信断発生について"></h4>
{{%panel theme="default" header="CENの帯域幅変更時の通信断発生について"%}}
CENでの帯域幅課金は２つの概念があります。<br>
1つは「帯域幅パッケージ」もう1つは「リージョンの接続」です。<br>
前者は、あるリージョンエリア（中国本土・アジア太平洋など）間で使用する帯域幅全体を指定します。これは購入を伴うものです。<br>
後者は、その帯域幅パッケージの配分先となるリソースで、具体的に接続するリージョンを指定します。<br>

{{% notice tip %}}
例えば「帯域幅パッケージ」として【中国本土・アジア太平洋】を『10Mbps』購入し、「リージョン接続」において【上海ー日本】に『4Mbps』を配分、【杭州ー香港】に『4Mbps』配分するといったイメージです。<br><br>
ICMPベースの通信定義として、CENの帯域幅変更時に通信断は発生しません。

{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="Function Computeの時間トリガーのタイムゾーンについて"></h4>
{{%panel theme="default" header="Function Computeの時間トリガーのタイムゾーンについて"%}}
Function Computeの時間トリガーのタイムゾーンはUTCとなります。<br><br>

時間トリガーを`0:30（0 30 0 * * *）`で設定した場合、北京時間の8:30、日本時間の9:30に実行されます。<br>
日本標準時の時刻(JST/UTC+0900）を基準として考える必要があります。

{{% notice note %}}
詳細は下記ドキュメントをご参考ください。<br>
https://jp.alibabacloud.com/help/doc-detail/68172.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="Function ComputeからRDSのイントラネット接続について"></h4>
{{%panel theme="default" header="Function ComputeからRDSのイントラネット接続について"%}}
Function Compute サービスはダイナミック IP アドレスを使用します。<br>
したがって、ホワイトリストを使用して Function Compute の ApsaraDB for RDSへのアクセスを許可することは推奨していません。<br>
ホワイトリストにすべての IP アドレスを許可することは、危険性を高めてしまいます。<br><br>

尚、Function Compute は、VPC機能に対応しております。<br>
VPC アクセスを有効にすることで、安全に VPC 内のリソース(RDS)にアクセスすることが可能になります。<br>
ただし、Function Computeサービスおよびリソースは、同一リージョンで稼働している必要があります。<br><br>

なお、RDSのホワイトリストにて、Function Computeが所属するVPCのIPv4 CIDR Block、もしくはFunction Computeが所属するVSwitchのIPv4 CIDR Blockを許可する必要があります。

{{% notice note %}}
Function Compute に VPC へのアクセス詳細は下記ドキュメントをご参考ください。<br>
https://jp.alibabacloud.com/help/doc-detail/84514.htm<br>
https://jp.alibabacloud.com/help/doc-detail/84516.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="IoT Platformのデバイス監視機能について"></h4>
{{%panel theme="default" header="IoT Platformのデバイス監視機能について"%}}
IoT Platformにデバイス監視の機能があり、デバイスからのパケット受信間隔で死活を判断しています。<br><br>

仕組みとして、IoT Platformからデバイスへキープアライブパケットを送信することではなく、
デバイスからMQTT接続の確立時に、ヘッダにKeep Alive時間を30-1200sの間に指定する必要があります。<br><br>

設定されたKeep Alive時間の1.5倍を経って、もしPUBLISH, SUBSCRIBE, PING, or PUBACKの動作がなければ、
MQTT接続が切断され、該当デバイスのステータスを「オフライン」に判断されます。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="Redisのパスワードでの接続方法について"></h4>
{{%panel theme="default" header="Redisのパスワードでの接続方法について"%}}
Redis購入後に、コンソールに表示されたデフォルトアカウントの場合、ユーザー名不要、パスワードのみで接続可能です。<br><br>

コンソールにて別のアカウントを新規作成した場合、下記のようにauthコマンドを使用してデータベースにログインする必要があります。
新規アカウントのパスワードのみで認証するとエラーになりますので、ご注意ください。

{{% notice tip %}}
```
# redis-cli -h 接続先エンドポイント
> auth account:password"
```
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="ApsaraDB for Redisの強制アップグレードについて"></h4>
{{%panel theme="default" header="ApsaraDB for Redisの強制アップグレードについて"%}}
強制アップグレードの用途として、クラスタ構成とHA構成にサポートするコマンドに差異があり、一部クラスタ構成でサポートしないコマンドがあります。<br><br>

該当コマンドが含まれるHA構成からクラスタ構成にアップグレードする際に、「強制アップグレード」を選択する必要があります。

{{% notice note %}}
Redis対応可能なコマンドは下記ドキュメントをご参考ください。<br>
https://jp.alibabacloud.com/help/doc-detail/26356.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>
