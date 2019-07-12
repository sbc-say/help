---
title: "ECS"
description: "Alibaba CloudのECSに関するよくある質問を紹介します。"
date: 2019-04-04T15:31:42+09:00
weight: 10
draft: false
---

## 一般仕様	
#### Q. アベイラビリティゾーン（AZ）識別文字と実際のロケーションに関するマッピング仕様について
Alibaba Cloudでは、アベイラビリティゾーン（AZ）識別文字と実際のロケーションのマッピングは、全てのアカウントで共通しています。

（注：AWSにおいては、アカウント毎に個別にマップされます。
https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
『リソースがリージョンの複数のアベイラビリティーゾーンに分散するように、アベイラビリティーゾーンは各 AWS アカウントの名前に個別にマップされます。たとえば、ご使用の AWS アカウントのアベイラビリティーゾーン us-east-1a は別の AWS アカウントのアベイラビリティーゾーン us-east-1a と同じ場所にはない可能性があります。』）
#### Q. 1つのアカウント/リージョン配下のECS購入台数制限について
従量課金でのECSインスタンス購入上限は、vCPU数により制限されています。従量課金型ECSインスタンスの購入は各リージョン「50vCPU」までとなっております。
例）お客様が1台のECSに対して4vCPUで利用する場合は、12台の従量課金ECSを購入することができます。

なお、サブスクリプション型ECSの場合は、購入上限数を設けておりません。
#### Q. サブスクリプションECSのライフサイクルについて
サブスクリプションインスタンスの期間を更新しない、また更新失敗で有効期限切れとなった場合、そのインスタンスはライフサイクルに入ります。

期間切れから〜15日まで：通常稼働
15日から〜30日まで：インスタンス停止
30日：インスタンスリリース（削除）
#### Q. RDSCALとクライアントCALの必要性について
Alibaba Cloud が提供する Windows 仮想サーバーにて、RDS CALとクライアントCALの必要性は下記のとおりです。

Alibaba Cloud が提供する Windows 仮想サーバーの CAL ライセンスについて、リモートデスクトップユーザーのRDS CALはデフォルト2本付きです。
3本以上が必要な場合、お客様にてご購入いただく必要があります。

クライアントCALについて、Alibaba Cloud は Microsoft 社と SPLA 契約しているため、Alibaba Cloud が提供する Windows 仮想サーバーは、別途クライアントCALを購入することなくご利用いただけます。
#### Q. ECSのデフォルトタイムゾーンについて
リージョンに関わらず、ECSインスタンスのデフォルトタイムゾーンは、中国時間（UTC+8）になります。

なお、カスタムイメージのタイムゾーンはイメージ作成した際のものとなりますが、初回ECS作成直後でも中国ローカル時間になりますので、個別に時間自動同期（NTP）設定が必要となります。
#### Q. スナップショット取得時の性能影響について
スナップショットの作成時は、ストレージのIO性能（最大10%低下）に影響します。 
通常、稼働中のサービスへの影響はないと想定されますが、ストレージIOが少ない時間帯での取得を勧めします。
#### Q. 購入可能な従量課金インスタンスの上限について
従量課金でのECSインスタンス購入上限は、vCPU数により制限されています。従量課金型ECSインスタンスの購入は各リージョン「50vCPU」までとなっております。
例）お客様が1台のECSに対して4vCPUで利用する場合は、12台の従量課金ECSを購入することができます。

なお、サブスクリプション型ECSの場合は、購入上限数を設けておりません。
#### Q. 25番ポートの制限について
Alibaba Cloud では、MTAとしてメール送信（25 番ポートの外部接続）することが制限されております。

MUAとして、外部SMTPの25番ポートを利用する場合のみ、宛先をご指定いただいての部分的解除は可能です。

25番ポートの制限は下記のドキュメントをご参照ください。
https://jp.aliyun.com/help/doc-detail/49123.htm
#### Q. ICP必要性の判断方法について
中国本土にサーバを設置し、ウェブサービス提供する場合は、ICPライセンスが必要になります。

ICPライセンスを申請する前提として、中国国内に法人を持つ必要があります。該当する場合、弊社パートナーによりICP申請支援も可能ですので、チケットでご連絡ください。

なお、香港リージョンではICPは必要がございません。ICP の取得が困難な場合、香港リージョンのご利用をご検討ください。
#### Q. インスタンススペックのアップグレード方法について
サブスクリプションECSのアップグレード手順は以下のドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/25438.htm

ない、スターターパッケージとして購入されたECSはアップグレードできません。

（注：操作上はアップグレードできてしまいますが、スターターパッケージの特典（データ転送量付で低価格）を得ることはできなくなります。）

## ネットワーク
#### Q. VPCとVswitchの変更方法について
ECSを作成後、そのECSのVPCとVswitchは変更できません。
変更する必要がある場合、そのECSのカスタムイメージ作成、その後、希望のVPCとVswitchを選択しECSを新規作成することになります。
#### Q. VPCで指定可能なCIDRブロックについて
VPCのIP CIDRは10.0.0.0/8、172.16.0.0/12及び192.168.0.0/16から選択いただく必要があります。
コンソールから上記3つしか作成できませんが、APIを利用した場合、上記CIDRのサブCIDRを指定することができます。

APIでのVPC作成は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/35737.html
#### Q. EIPとパブリックIPの違いについて
ECSでは、インターネット通信用に「パブリックIP」と「EIP」を利用できます。

ECS購入時に「パブリック IP の割り当て」にチェックを入れインスタンスを作成すると「パブリックIP」が付与されます。
このパブリックIP付きのECSを削除した場合、パブリックIPも同時に削除されます。ECSを削除後、IPアドレスに関する料金は発生することがありません。

ECS購入時に「パブリック IP の割り当て」にチェックを入れずにインスタンスを作成すると「パブリックIP」が付与されません。
この場合、別途「EIP」を購入・用意しECSにバインドして使用する必要があります。
EIPをバインドしたECSを削除しても、EIPは自動的に削除されません。不要になったEIPは、お客様自身で削除する必要があります。また、インスタンスにバインドされていないEIPは、そのインスタンス保有料金が発生します。
#### Q. EIPとパブリックIPの帯域幅の変更方法について
EIPとパブリックIPの帯域幅の変更方法は下記となります。

EIPの帯域幅の変更方法は下記ドキュメントをご参照ください。 
https://jp.alibabacloud.com/help/doc-detail/27769.htm

パブリックIPの帯域幅は変更することができませんが、パブリックIPをEIPに変更することができます。
このため、パブリックIPをEIPに変更後に帯域幅の変更が可能となります。

パブリックIPをEIPへの変更する方法は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/faq-detail/68010.html
#### Q. プライベートIPの変更方法について
ECSのプライベートIPを同じVswitch内の空きIPに限って変更することができます。

プライベートIPの変更方法は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/27733.html
#### Q. インバウンドとアウトバウンド帯域幅の制限値について
ECSのインバウンドとアウトバウンド帯域幅の制限値は下記となります。

■アウトバウンド
・サブスクリプションインスタンスの場合：最大ピーク帯域幅は 200 Mbpsです。
・従量課金インスタンスの場合：最大ピーク帯域幅は 100 Mbpsです。
上記範囲内に設定することができます。

ECSのネットワークインターフェースが対応する場合、チケット申請により最大800 Mbpsまで引き上げ可能です。

■インバウンド
アウトバウンドが100 Mbps以下の場合：最大ピーク帯域幅は 100 Mbpsです。
アウトバウンドが100 Mbps以上の場合：最大ピーク帯域幅はアウトバウンドの帯域幅と同じです。

インバウンド制限値の指定、及び引き上げをすることはできません。

## イメージ
#### Q. イメージのインポート方法について
インポートする方法は下記ドキュメントをご参照ください。

◎イメージのインポート
https://jp.alibabacloud.com/help/doc-detail/25464.html
ドキュメント内「前提条件」にご注意ください

◎イメージをインポートする際の注意事項
https://jp.alibabacloud.com/help/doc-detail/48226.htm
#### Q. クラウド移転ツールについて
Alibaba Cloud 移行ツールのご利用により、物理的なデスクトップおよびサーバを変換したり、
ECS への仮想マシン、クラウドホストを移行することができます。 

詳細については、下記ドキュメントをご参照ください。

◎Alibaba Cloud 移行ツールとは
https://jp.alibabacloud.com/help/doc-detail/62349.html 

◎クラウド移行ツールを使用してAlibaba Cloudへの移行
https://jp.alibabacloud.com/help/doc-detail/62394.htm 

◎イメージをインポートする際の注意事項 
https://jp.alibabacloud.com/help/doc-detail/48226.htm
#### Q. イメージのエクスポート方法について
イメージのエクスポート機能を利用するには、制限解除申請が必要です。事前にチケット起票して申請ください。

イメージエクスポートの利用方法は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/58181.html
#### Q. イメージのリージョン間コピー方法について
日本サイトでは現在、制限解除の申請なしでリージョン間のイメージコピーすることができます。

イメージコピーの利用方法は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/25462.html

## ディスク
#### Q. システムディスクとデータディスクの違いについて
システムディスクとデータディスクには下記の違いがあります。

■ECSへのアタッチ数
システムディスク：必ず1台
データディスク：0台から最大16台まで

■ECSへのアタッチ/デタッチ可否
システムディスク：デタッチ不可
データディスク：自由にアタッチ/デタッチ可能（但し、サブスクリプションECSと同時購入のクラウドディスクは対象外）、他のECSにも再利用可能

■ディスクのリリース
システムディスク：ECSのリリースに伴いリリースされる
データディスク：独自にリリース可能（ECSのリリースに依存しない）
#### Q. クラウドディスクの拡張方法について
クラウドディスクはディスクタイプにより拡張方法が異なります。

■システムディスク
稼働中のシステムディスクを直接拡張することはできません。拡張するには、システムディスクを交換する必要があり、ディスク交換時にサイズを指定することができます。
なお、システムディスク交換により、ディスク内のデータは失なわれます。このため、既存ディスクのイメージ作成、このイメージを元にシステムディスクを交換（ディスクの再作成）を行います。
システムディスクの交換方法は、下記のドキュメントをご参照ください。

◎システムディスク交換
https://jp.alibabacloud.com/help/doc-detail/50134.html


■データディスク
データディスクの拡張方法は下記メニューからできます。
コンソール > ECS > クラウドディスク > ディスクの「詳細」> ディスクのサイズ拡張

## VNC
#### Q. VNCで一部記号入力できない事象について
コンソールのVNCを利用する場合に、キーボードのレイアウトにより特殊記号の入力が正確に認識されない事象がありますが、現在回避策がありません。

コンソールのVNC以外のRDPやSSHを利用してログインする場合、上記事象が発生しませんので、特殊記号をご利用することができます。
#### Q. VNCパスワードとECSパスワードの違いと再設定方法について
VNCパスワードとECSパスワードの違いと再設定方法は下記となります。

■VNCパスワード
コンソールのVNC接続を利用時のパスワードとなります。初回VNCを利用時にデフォルトパスワードが表示されます。
パスワードの変更はVNCコンソールからできます。変更後のパスワードは即時反映され、再起動は不要となります。

■ECSパスワード
ECSのパスワードはOSのパスワードとなります。ECS作成時に該当パスワードが指定されます。
ECSパスワードの変更は下記メニューからできます。パスワード変更後に、新しいパスワード有効にするには、ECSインスタンスの再起動が必要です。

◎操作手順
コンソール > ECS > インスタンス > インスタンスの「詳細」> パスワード及びキー > パスワードのリセット

## セキュリティグループ		
#### Q. インバウンドとアウトバウンドのデフォルト動作について
セキュリティグループにルールを設定しなかった場合、デフォルトでは以下のような動作となります。

アウトバウンド方向のトラフィック：全て許可
インバウンド方向のトラフィック：全て拒否

なお、ECS新規作成時に併せて作成されるセキュリティグループののデフォルトルールでは、22番ポート、3389ポート、またはICMPのポートが「0.0.0.0/0」で【許可】されていることがあります。
#### Q. 同じセキュリティグループ内のアクセス制限について
同一セキュリティグループに所属する複数のECS間は、セキュリティグループの制限を受けず全部トラフィック通信可能となります。
#### Q. セキュリティグルールの適用順位について
ECSが複数セキュリティグループに所属する場合、全セキュリティグループルールが同時に適用されます。
しかし、ルール間に競合があった場合、Priorityの値が小さい（＝優先度が高い）方が優先されます。
また、Priorityが同じで競合したルールの場合は、【拒否】が優先されます。