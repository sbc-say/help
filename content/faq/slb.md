---
title: "SLB"
description: ""
date: 2019-07-19T15:30:00+09:00
weight: 100
draft: false
---
<h4 id="index">目次</h4>

* 一般仕様
 * [レイヤー4とレイヤー7のSLBの違いについて](#レイヤー4とレイヤー7のSLBの違いについて)
 * [SLBのアクセスログについて](#SLBのアクセスログについて)
 * [SLBのスペック変更方法と業務影響について](#SLBのスペック変更方法と業務影響について)
 * [VServerグループとマスタースレーブグループの違いについて](#VServerグループとマスタースレーブグループの違いについて)
 * [サードパーティ証明書のアップロード方法について](#サードパーティ証明書のアップロード方法について)
 * [SLB関連の各APIのスロットリング上限について](#SLB関連の各APIのスロットリング上限について)
* ネットワーク
 * [パブリックSLBとプライベートSLBの違いについて](#パブリックSLBとプライベートSLBの違いについて)
 * [パブリックSLBとバックエンドECS間の通信仕様について](#パブリックSLBとバックエンドECS間の通信仕様について)
 * [パブリックIPとプライベートIP付きSLBの作成方法について](#パブリックIPとプライベートIP付きSLBの作成方法について)
 * [ホワイトリストとブラックリストについて](#ホワイトリストとブラックリストについて)
 * [SLBのインバウンド/アウトバウンド帯域幅について](#SLBのインバウンド/アウトバウンド帯域幅について)
 * [証明書をSLB側とECS側に設置の違いについて](#証明書をSLB側とECS側に設置の違いについて)
 * [TCP over SSLの対応について](#TCP over SSLの対応について)
* 負荷分散
 * [ラウンドロビン利用時に分散されない事象について](#ラウンドロビン利用時に分散されない事象について)
 * [バックエンドECSの重み設定について](#バックエンドECSの重み設定について)
 * [APIでVserverグループ追加時の引数書き方について](#APIでVserverグループ追加時の引数書き方について)
 * [SLBの相互認証について](#SLBの相互認証について)
 * [SLBを利用したsorryサーバーの実装方法について](#SLBを利用したsorryサーバーの実装方法について)
* ヘルスチェック
 * [SLBのヘルスチェック頻度の仕様について](#SLBのヘルスチェック頻度の仕様について)
 * [SLBのヘルスチェック用CIDRブロックについて](#SLBのヘルスチェック用CIDRブロックについて)

#### 一般仕様
<h4 id="レイヤー4とレイヤー7のSLBの違いについて"></h4>
{{%panel theme="default" header="レイヤー4とレイヤー7のSLBの違いについて"%}}
SLBはレイヤ4 (TCP、UDP)およびレイヤ7(HTTP、HTTPS)を提供しています。<br><br>

レイヤ 4 SLB は、ロードバランシングを実現するために keepalived のオープンソースソフトウェアの Linux 仮想サーバー（ LVS ）を使用し、クラウドコンピューティングの要件に応じて、いくつかのカスタマイズを行っています。<br>
レイヤ 7 SLB は、ロードバランシングを実現するために Tengine を使用しています。 Tengine、Nginx に基づいて Web サーバープロジェクトは、多量トラフィックのウェブサイトに対応する機能を追加しています。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLBのアクセスログについて"></h4>
{{%panel theme="default" header="SLBのアクセスログについて"%}}
SLBのレイヤ7のアクセスログは提供しています。

{{% notice note %}}
アクセスログの取得は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85974.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLBのスペック変更方法と業務影響について"></h4>
{{%panel theme="default" header="SLBのスペック変更方法と業務影響について"%}}
コンソールにて、SLBのスペック変更をオンラインで実施することができます。また、トラフィックが流れている状態でAPIよりSLBのスペックを変更することもできます。<br>

ただし、スペックを変更している時に、SLBサービスが中断されることあります。スペックの変更が完了になると、SLBが自動的に再開します。

{{% notice info %}}
なお、SLBのスペック変更は「パフォーマンス専有型」から「パフォーマンス専有型」へのインスタンススペック変更、もしくは、「パフォーマンス共通型」から「パフォーマンス専有型」へのインスタンススペック変更となります。「パフォーマンス専有型」から「パフォーマンス共通型」へのスペック変更はできません。
{{% /notice %}}

{{% notice note %}}
スペックの変更は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85942.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="VServerグループとマスタースレーブグループの違いについて"></h4>
{{%panel theme="default" header="VServerグループとマスタースレーブグループの違いについて"%}}
Vserverグループを利用した場合、ディレクトリ転送機能を利用できます。<br>
転送設定されてないディレクトリの場合、デフォルトバックエンドサーバーに分散されます。<br><br>

デフォルトグループまたは、Vserverグループにて重みを0に設定してもマスタースレーブ構成になりませんので、マスタースレーブグループを利用する必要があります。

{{% notice note %}}
VServerグループは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85964.htm<br><br>
マスタースレーブグループは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85965.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="サードパーティ証明書のアップロード方法について"></h4>
{{%panel theme="default" header="サードパーティ証明書のアップロード方法について"%}}
SLBにサードパーティ証明書をアップロードすることができます。

{{% notice note %}}
アップロード方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85971.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLB関連の各APIのスロットリング上限について"></h4>
{{%panel theme="default" header="SLB関連の各APIのスロットリング上限について"%}}
SLBでは、AccessKey１つあたりのAPI呼び出し回数を１日に5000回まで制限されます。

{{% notice note %}}
Server Load Balancer プロダクトの制限は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/32459.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

#### ネットワーク
<h4 id="パブリックSLBとプライベートSLBの違いについて"></h4>
{{%panel theme="default" header="パブリックSLBとプライベートSLBの違いについて"%}}
パブリックSLBはインターネットからのリクエストを受け取るため、パブリックIPアドレスを提供しています。AlibabaCloudの仕様として、パブリックSLBがVPC内にあるバックエンドECSと通信できますが、該当VPCのプライベートIPアドレスを持っていません。<br><br>

プライベートSLBはパブリックIPアドレスを提供しておらず、Alibaba Cloud イントラネットからのリクエストのみ受信できます。AlibabaCloudの仕様として、プライベートSLBはVPCのプライベートIPを持っています。
なお、プライベートSLBにEIPを付与することにより、パブリックSLBとして機能することもできます。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="パブリックSLBとバックエンドECS間の通信仕様について"></h4>
{{%panel theme="default" header="パブリックSLBとバックエンドECS間の通信仕様について"%}}
パブリックSLBとバックエンドECS間はプロクシ通信となります。該当通信は、ECSのセキュリティグループで遮断できない仕様となります。

{{% notice note %}}
SLBのアーキテクチャは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/27544.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="パブリックIPとプライベートIP付きSLBの作成方法について"></h4>
{{%panel theme="default" header="パブリックIPとプライベートIP付きSLBの作成方法について"%}}
パブリックSLBにプライベートIPがない仕様に対して、プライベートIPとパブリックIP両方が必要の場合、プライベートSLBにEIPをバインド機能を利用して実現できます。<br><br>

作成手順<br>
1. 先にイントラネット型のSLBを作成します。<br>
2. 作成したSLBにEIPをバインドします。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="ホワイトリストとブラックリストについて"></h4>
{{%panel theme="default" header="ホワイトリストとブラックリストについて"%}}
SLBはホワイトリストとブラックリスト方式でアクセスを制御しています。

{{% notice note %}}
ホワイトリストとブラックリストの設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85979.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLBのインバウンド/アウトバウンド帯域幅について"></h4>
{{%panel theme="default" header="SLBのインバウンド/アウトバウンド帯域幅について"%}}
SLBのインターネット通信帯域幅はコンソール上で表示されている値に準じます。<br><br>

日本リージョン：インバウンド: 1024Mbps、アウトバウンド: 1024Mbps<br>
中国リージョン：インバウンド: 5120Mbps、アウトバウンド: 5120Mbps
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="証明書をSLB側とECS側に設置の違いについて"></h4>
{{%panel theme="default" header="証明書をSLB側とECS側に設置の違いについて"%}}
証明書の設置場所により、SSL通信空間は違います。<br><br>

証明書をSLB側に設置：　クライアント ---> SLB の間の通信はHTTPSで行います。(SLB-->ECSはHTTPで行います。)<br>
証明書をECS側に設置： SLB ---> バックエンドECS の間の通信はHTTPSで行います。<br><br>

なお、証明書をSLB側に設置した場合、SLBとECS間にHTTP通信のみ設定可能な仕様になります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="TCP over SSLの対応について"></h4>
{{%panel theme="default" header="TCP over SSLの対応について"%}}
日本サイトのSLB現在レイヤー4のTCP over SSLを対応していません。SSL通信が必要な場合、レイヤー7のHTTPSを利用する必要があります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

#### 負荷分散
<h4 id="ラウンドロビン利用時に分散されない事象について"></h4>
{{%panel theme="default" header="ラウンドロビン利用時に分散されない事象について"%}}
SLBの仕様上、セッションの保持時間内に再度SLBアクセスを実施すると 保持されているセッションにアクセスするため、重みと剥離してアクセスが偏ったことがあります。<br><br>

実際にセッションの切り替えを確認する方法は下記となります。<br>
・リスナー設定（HTTP）の場合 　<br>
リスナー設定で「セッションの保持」を無効にし、リロードすることで確認できます。<br>
・リスナー設定（TCP）の場合 　<br>
リスナー設定の「接続タイムアウト」で最小値の10秒と設定し、10秒以上の間隔でリロードすることで確認できます。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="バックエンドECSの重み設定について"></h4>
{{%panel theme="default" header="バックエンドECSの重み設定について"%}}
SLBのバックエンドECSの重みの仕組みは下記となります。

{{% notice tip %}}
例えば ECS インスタンス A の重みを 10 に設定し、ECS インスタンス B の重みを 100 に設定した場合、インスタンス A には総アクセス数の 10/(10+100)％ が転送され、インスタンス B は 100/(10+100)％ が転送されます。
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="APIでVserverグループ追加時の引数書き方について"></h4>
{{%panel theme="default" header="APIでVserverグループ追加時の引数書き方について"%}}
APIでVServerグループを操作する際に、引数に「\」を利用する必要がります。

{{% notice tip %}}
■バックエンドサーバを追加<br>
aliyun slb AddBackendServers --RegionId ap-northeast-1 --LoadBalancerId SLB_ID --BackendServers [{\"ServerId\"\:\"instance_ID\"\,\"Weight\"\:\"100\"}]<br><br>

■バックエンドサーバを削除<br>
aliyun slb RemoveBackendServers --LoadBalancerId SLB_ID --BackendServers [{\"ServerId\"\:\"instance_ID\"\}]
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLBの相互認証について"></h4>
{{%panel theme="default" header="SLBの相互認証について"%}}
SLBでは相互認証のアクセス方式に対応しています。

{{% notice info %}}
なお、SLBの仕様では現在失効リストに対応していません。
{{% /notice %}}

{{% notice note %}}
相互認証の設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/54508.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLBを利用したsorryサーバーの実装方法について"></h4>
{{%panel theme="default" header="SLBを利用したsorryサーバーの実装方法について"%}}
SLB自体はsorryサーバーの実装に対応していませんが、DNSの機能GTM(Global Traffic Management)を利用すれば、Sorryサーバーの切り替えを実現することができます。

{{% notice note %}}
GTMの概要は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/86630.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

#### ヘルスチェック
<h4 id="SLBのヘルスチェック頻度の仕様について"></h4>
{{%panel theme="default" header="SLBのヘルスチェック頻度の仕様について"%}}
SLBヘルスチェックの頻度はコンソール上で設定可能です。<br><br>

なお、監視の信頼性を向上するため、複数台の監視サーバーから同時にヘルスチェックするような仕様となっています。コンソール上のヘルスチェック間隔設定は、1台の監視サーバーに対する設定値となりますので、結果的には、設定値より多いチェックが発生してしています。

{{% notice note %}}
設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/85959.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SLBのヘルスチェック用CIDRブロックについて"></h4>
{{%panel theme="default" header="SLBのヘルスチェック用CIDRブロックについて"%}}
SLBのヘルスチェック用CIDRは下記となります。<br>
・100.64.0.0./10

{{% notice note %}}
ヘルスチェックは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/55205.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>
