---
title: "OSS"
description: "Alibaba CloudのOSSに関するよくある質問を紹介します。"
date: 2019-07-17T09:33:15+09:00
weight: 20
draft: false
---

#### 一般仕様
{{%panel theme="default" header="中国東部1のOSSを利用しなくても課金される事象について"%}}
OSSコンソールでのパケット操作は実質上にAPIで実行されています。<br>

`GetBucket`などのようなパケットを特定しないに操作以外、共通な属性を取得するようなリクエストを実行された場合、デフォルトで`中国東部１`リージョンのエンドポイントが利用される仕様となります。

{{% notice info %}}
コンソールからのAPIリクエストにより発生した料金は`中国東部1`のパケットに記録されますので、中国東部1のOSSを利用しなくても課金される事象の原因となります。
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="標準、IA、アーカイブの違いについて"%}}
標準ストレージと比較する場合、低頻度アクセスストレージに保存したファイルを30日以内、アーカイブストレージは60日以内に削除した場合、料金がかかります。<br>
そして、アーカイブストレージからファイルを取り出す場合、解凍時間が必要となります。<br><br>

{{% notice tip %}}
標準ストレージ<br>
高パフォーマンス、高信頼性、高可用性を実現する OSS インスタンス<br>
特徴：高スループット、ホットファイル、頻繁なアクセスを特徴とするサービスシナリオに適用可能<br>
信頼性: 99.999999999%<br>
最小保存期間：なし<br>
適用シナリオ: モバイルアプリケーション、大規模な Web サイト、画像共有、アクセス頻度の高いオーディオとビデオ<br><br>

低頻度アクセスストレージ<br>
比較的低いストレージコストとリアルタイムのアクセスを特徴とする OSS インスタンス<br>
特徴： リアルタイムの低頻度データアクセスをサポートするサービスシナリオに適用可能<br>
信頼性: 99.999999999%<br>
最小保存期間：30 日<br>
適用シナリオ： アプリケーションデータとエンタープライズデータのバックアップ、モニタリングデータ、オンラインストレージアプリケーション<br><br>

アーカイブストレージ<br>
低単価で長期のアーカイブデータストレージをサポートする OSS インスタンス<br>
特徴: データ復元の待機時間が発生し、データ保管期間に関する要件があるサービスシナリオに適用可能<br>
信頼性: 99.999999999%<br>
最小保存期間：60 日<br>
適用シナリオ: 長期のアーカイブデータストレージ、医療用画像、ビデオ映像
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="クロスリージョンレプリケーションの利用制限について"%}}
クロスリージョンレプリケーションは対応していますが、中国本土リージョン間、またはアメリカ東部、西部間のみとなります。その以外のリージョンでは、現状中間サーバーを経由する必要があります。

{{% notice note %}}
クロスリージョンレプリケーションは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/31864.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="パケット間のファイル複製方法について"%}}
下記の前提条件であれば、OSSBrowserを利用してコピー/移動することが可能です。<br>
・同じリージョンの別バケット間のコピー/移動<br>
・標準パケットからアーカイブパケットへのコピー/移動<br>
※アーカイブパケットから標準パケットへのコピー/移動も可能ですが、事前にアーカイブファイルを解凍する必要があります。 一括解凍機能がないため、多数ファイルの場合、手間かかります。<br><br>

手順は下記となります。<br>
・ソースパケットのルートディレクトリにて全ファイルを選択し、「コピー」または「移動」をクリック<br>
・ターゲットのアーカイブパケットのルートディレクトリにて、「ペースト」をクリック

{{% notice note %}}
OSSBrowserのダウンロードは下記のドキュメントをご参照ください。<br> https://jp.alibabacloud.com/help/doc-detail/61872.html
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="5G以上のファイルのアップロード方法について"%}}
コンソールからアップロード可能のファイルサイズは5GBまでなります。5GB以上のファイルをアップロードする場合、APIまたはSDKを利用する必要があります。

{{% notice note %}}
アップロード方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/31850.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="同名ファイルを入れ替え後の即時反映について"%}}
OSS上に同名ファイルを入れ替え後に即時全ノードに反映することを保証していません。一定期間内に入れ替え前のファイルが取り出させる可能性があります。

{{% notice info %}}
リアルタイム反映を求める場合、別ファイル名での利用が必要です。
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="プライベート/パブリックエンドポイントの違いについて"%}}
プライベートエンドポイントは同じリージョン内のインスタンスのみアクセス可能ですが、セキュリティ性が高く、トラフィック料金がかかりません。<br>
パブリックエンドポイントはインターネットからアクセス可能です。
{{% /panel%}}

{{%panel theme="default" header="OSSのアクセスログの取得方法について"%}}
OSSのアクセスログはLogServiceに転送することが可能です。

{{% notice note %}}
ログ転送方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/29002.htm<br><br>
OSSのアクセスログの取得方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/31900.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="OSSのイメージ/ビデオ処理の利用方法について"%}}
OSSのイメージ/ビデオ処理機能により、お客様は好きなイメージ処理(リサイズなど)内容を「スタイル」として保存することができます。その後、保存した「スタイル」を適応することで、任意の画像にイメージ処理を実施することができます。イメージ処理を適応した画像をOSSに保存したい場合は、適応画像のURLより別途、ローカルに保存いただき、再度OSSにアップロードいただく必要があります。<br><br>

また、OSSでは動画のフレームキャプチャー機能も実装されております。動画から任意のフレームを取得して、画像のリサイズ及び保存形式を設定することができます。ただし、上記で作成した画像は自動で保存されないため、手動でローカル上に保存する必要があります。また、上記機能で動画ファイルのサムネイル自動生成はできず、以下の例のように画像URLに対して操作を指定する必要がございます。<br><br>

OSSに保存されている画像、動画にイメージ処理を実施した場合、処理を適応した画像URLにアクセスすることで処理結果画像を取得できます。その際に、OSSのファイルURLの有効期間を設定する必要がありますのでご認識いただければと存じます。画像にイメージ処理を適応した画像URLを利用する場合、この有効期間がサムネイルの利用時間となります。

{{% notice tip %}}
例： 下記の条件で動画から画像を取得します。<br>
対象のBucketドメイン名：a-image-demo.oss-cn-qingdao.aliyuncs.com <br>
対象Bucketに保存された動画ファイル：demo.mp4<br><br>

①動画の7秒目の映像を画像として取得します。 <br>
②取得した画像のサイズを「800×600」にします。 <br>
③エクスポートした画像の形式をjpgにします。 <br>
④画像取得モードをfastにします。(fastは7秒目の直前のフレームを取得します。)<br>
http://a-image-demo.oss-cn-qingdao.aliyuncs.com/demo.mp4?x-oss-process=video/snapshot,t_7000,f_jpg,w_800,h_600,m_fast <br>
※こちらは、サンプルです。<br><br>

上記利用した引数についてvideo/snapshotは操作内容と操作名で、動画処理の場合は、上記リンクのように動画ファイル名の後に?x-oss-process=video/snapshotと記載いただき、パラメータ指定を行なっていいただく必要がございます。<br><br>

t スクリーンショット時間(単位ms) w 画像の横サイズ（Pixel単位） h 画像の高サイズ（Pixel単位） m 画像の取得モード（fast） f 画像のフォーマット（jpg,png）
{{% /notice %}}

{{% notice note %}}
OSSイメージ処理機能は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/31873.htm<br><br>
OSSイメージ処理手順は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/44686.htm<br><br>
URLの有効期間の詳細は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/31912.htm
{{% /notice %}}
{{% /panel%}}

#### 製品連携
{{%panel theme="default" header="OSSをディスクとしてマウントする方法について"%}}
OSSFSツールを利用し、LinuxシステムでAlibaba Cloud OSSバケットをローカルファイルにマウントできます。<br>
ただし、現在「Linux システム」のみ対応可能です。「Windows Server」には対応していません。また、該当仮想ディスクの性能は低く、複数インスタンスの同時マウントに利用できませんので、NASの利用を推奨します。

{{% notice note %}}
OSSFSの利用方法は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/32196.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="FunctionComputeのトリガーとして利用方法について"%}}
OSSのイベントをFcunctionComputeのトリガーに設定することができます。

{{% notice note %}}
OSSトリガーの利用方法は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/74761.htm<br>
https://jp.alibabacloud.com/help/doc-detail/74762.htm<br>
https://jp.alibabacloud.com/help/doc-detail/74763.htm<br>
https://jp.alibabacloud.com/help/doc-detail/74764.htm<br>
https://jp.alibabacloud.com/help/doc-detail/74765.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="CDNでOSS静的サイトの公開方法について"%}}
CDNのオリジンサイトをOSSに構築された静的サイトに指定することができません。

{{% notice note %}}
OSSで静的サイト構築方法は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/67323.htm<br><br>
CDNのオリジンサイト指定方法は下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/57589.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="OSSに静的サイトを設置した場合のICP必要性について"%}}
中国本土リージョンのOSSを利用し、所有するドメインとバインドし、静的サイトを公開する場合、該当ドメインは事前にICPを取得する必要です。OSSが提供するドメインを利用する場合、ICPを取得する必要がありません。
{{% /panel%}}

{{%panel theme="default" header="OSSにインターネット経由で接続する際のFQDNについて"%}}
API、SDK、またはOSS-browserを利用する場合、OSSへのアクセスにつきましては、OSSコンソールで表示される「エンドポイント（東京リージョンは oss-ap-northeast-1.aliyuncs.com）」
及び「パケットポイント（backetname.oss-ap-northeast-1.aliyuncs.com）」の2つのFQDNを許可する必要があります。<br>
Alibaba CloudアカウントでOSSコンソールにログイン後、該当バケットを選択した際に画面中央に表示される「アクセスドメイン名」の中の「インターネットアクセス」行にある２つのアクセスドメイン名となります。<br>
※東京リージョンの場合、エンドポイントには「oss-ap-northeast-1.aliyuncs.com」と表示されております。

{{% notice info %}}
OSSのIPアドレスは固定ではないため、ファイアウォールでIPフィルタすることができなく、FQDNフィルタする必要があります。
{{% /notice %}}
{{% /panel%}}

#### 権限
{{%panel theme="default" header="RAMユーザー対象にバケットアクセス権限の制御方法について"%}}
下記のようなカスタマイズポリシーを作成し、RAMユーザに適用することで、バケットごとに制御することが可能です。

{{% notice tip %}}
{ “Statement”: [ {<br>
　　 “Effect”: “Allow”,<br>
　　 “Action”: “oss:ListBuckets”,<br>
　　 “Resource”: “acs:oss:\*:\*:\*” },<br>
　　 { “Action”: “oss:\*”,<br>
　　　 “Effect”: “Allow”,<br>
　　　 “Resource”: [ “acs:oss:\*:\*:<bucketname>”,<br>
　　　 “acs:oss:\*:\*:<bucketname>/\*” ]<br>
    } ],<br>
    “Version”: “1” }
{{% /notice %}}

{{% notice note %}}
カスタマイズポリシーは下記ドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28640.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="OSS公開してもディレクトリにアクセスできない事象について"%}}
OSSパケットはフォルダのように見えますが、構造上にオブジェクト方式となります。<br>
ディレクトリがありませんので、OSSに保存されるファイルにアクセスするには、ファイルまでのパスを指定する必要がありますので、ディレクトリを指定して配下の全ファイルを表示する機能がありません。
{{% /panel%}}

{{%panel theme="default" header="RAMユーザー利用時のBucketList権限の必要性について"%}}
RAMユーザーに指定パケットのフル権限を付与した場合、バケット内のオブジェクトの操作に支障がありませんが、OSSコントロールから該当パケットを確認することができません。<br>
コンソールで確認するために、別途全パケットを参照する権限ListBucketsが必要です。また、ListBuckets権限には対象パケットの指定ができなく、全表示/全非表示しかできません。

{{% notice tip %}}
権限ポリシーには、以下のような部分を設定する必要です。<br><br>
　　 “Effect”: “Allow”,<br>
　　 “Action”: “oss:ListBuckets”,<br>
　 　“Resource”: “acs:oss:\*:\*:\*”
{{% /notice %}}
{{% /panel%}}
