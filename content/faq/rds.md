---
title: "RDS"
description: ""
date: 2019-07-19T15:30:00+09:00
weight: 100
draft: false
---
<h4 id="index">目次</h4>

* 一般仕様
 * [RDSのトラフィック料金について](#RDSのトラフィック料金について)
 * [sysadminの権限提供について](#sysadminの権限提供について)
 * [カスタマイズ可能なパラメーターについて](#カスタマイズ可能なパラメーターについて)
 * [RDSのストレージ容量の拡張方法について](#RDSのストレージ容量の拡張方法について)
 * [ホワイトリストの設定方法について](#ホワイトリストの設定方法について)
 * [インターネットアドレスとイントラネットアドレスの違いについて](#インターネットアドレスとイントラネットアドレスの違いについて)
 * [VPCとVswitchの変更方法について](#VPCとVswitchの変更方法について)
* バックアップ
 * [バックアップ取得時の性能影響について](#バックアップ取得時の性能影響について)
 * [RDSバックアップの保存先について](#RDSバックアップの保存先について)
 * [リカバリ時に指定可能な時刻について](#リカバリ時に指定可能な時刻について)
 * [RDSリリース後のバックアップ提供について](#RDSリリース後のバックアップ提供について)
* マルチゾーン
 * [マルチゾーンの確認方法について](#マルチゾーンの確認方法について)
 * [マルチゾーンの切り替え方法について](#マルチゾーンの切り替え方法について)
 * [レプリカのマルチゾーン対応について](#レプリカのマルチゾーン対応について)
* 暗号化
 * [保存データの暗号化方法について](#保存データの暗号化方法について)
 * [SSLを利用するデータ転送方法について](#SSLを利用するデータ転送方法について)

#### 一般仕様
<h4 id="RDSのトラフィック料金について"></h4>
{{%panel theme="default" header="RDSのトラフィック料金について"%}}
RDS現在トラフィック（インバウンド、アウトバウンド含む）料金は無料です。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="sysadminの権限提供について"></h4>
{{%panel theme="default" header="sysadminの権限提供について"%}}
インスタンスの安定性とセキュリティを保証するために、RDS for SQL Server では、sysadmin 権限を提供しておりません。

{{% notice note %}}
RDSの制限詳細は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/26141.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="カスタマイズ可能なパラメーターについて"></h4>
{{%panel theme="default" header="カスタマイズ可能なパラメーターについて"%}}
RDSはマネジメントサービスのため、カスタマイズ可能なパラメーターはRDSコンソールのパラメーターの設定ページに表示されているパラメーターのみとなります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="RDSのストレージ容量の拡張方法について"></h4>
{{%panel theme="default" header="RDSのストレージ容量の拡張方法について"%}}
RDSのストレージ容量は下記メニューから拡張することができます。

{{% notice tip %}}
コンソール > RDS > インスタンスの「詳細」> 設定を変更する > 容量
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="ホワイトリストの設定方法について"></h4>
{{%panel theme="default" header="ホワイトリストの設定方法について"%}}
RDSにはホワイトリストを利用してアクセスIPを制限することができます。

{{% notice note %}}
RDSのホワイトリストの設定は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/43186.html
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="インターネットアドレスとイントラネットアドレスの違いについて"></h4>
{{%panel theme="default" header="インターネットアドレスとイントラネットアドレスの違いについて"%}}
RDSにインターネットアドレスとイントラネットアドレスがあります。<br><br>

イントラネットアドレスは同じVPC内のインスタンスのみアクセスすることができます。<br>
インターネットアドレスはインターネットからアクセスすることができます。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="VPCとVswitchの変更方法について"></h4>
{{%panel theme="default" header="VPCとVswitchの変更方法について"%}}
RDS作成後のVPCとVSwitchの変更を対応していません。既存RDSのバックアップからVPCとVSwitchを指定して新規RDSを作成することになります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

#### バックアップ
<h4 id="バックアップ取得時の性能影響について"></h4>
{{%panel theme="default" header="バックアップ取得時の性能影響について"%}}
RDSのバックアップはスレーブインスタンスから取得するため、取得時にスレーブインスタンスへ影響がありますが、マスターインスタンスの性能に影響がありません。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="RDSバックアップの保存先について"></h4>
{{%panel theme="default" header="RDSバックアップの保存先について"%}}
RDSバックアップはアーキテクチャ上にOSS上に保存されますが、お客様のOSS領域ではありませんので、ダウンロードする際には、RDSコンソールからとなります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="リカバリ時に指定可能な時刻について"></h4>
{{%panel theme="default" header="リカバリ時に指定可能な時刻について"%}}
バックアップからリカバリ時に希望時刻を指定することができます。<br>
指定可能の時刻は最初のフルバックアップ時刻から現時刻の間となります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="RDSリリース後のバックアップ提供について"></h4>
{{%panel theme="default" header="RDSリリース後のバックアップ提供について"%}}
RDSのリリースに伴い、バックアップもリリースされます。RDSのバックアップをお客様のOSSに移管する機能は現在ありません。必要な場合、リリース前にRDSコンソールからダウンロードする必要があります。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

#### マルチゾーン
<h4 id="マルチゾーンの確認方法について"></h4>
{{%panel theme="default" header="マルチゾーンの確認方法について"%}}
下記メニューからマスターインスタンスとスレーブインスタンスの所在ゾーンを確認することができます。

{{% notice tip %}}
コンソール > RDS > インスタンス > インスタンスの可用性 > マスターノード ID/スレーブノード ID
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="マルチゾーンの切り替え方法について"></h4>
{{%panel theme="default" header="マルチゾーンの切り替え方法について"%}}
下記メニューからマスターインスタンスとスレーブインスタンスを切り替えることができます。マスターノード ID/スレーブノード IDにて切り替え前後のゾーンを確認することができます。

{{% notice tip %}}
コンソール > RDS > インスタンス > インスタンスの可用性 > スイッチオーバー
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="レプリカのマルチゾーン対応について"></h4>
{{%panel theme="default" header="レプリカのマルチゾーン対応について"%}}
RDSのレプリカインスタンスは現在シングルゾーンのみ対応しています。
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

#### 暗号化
<h4 id="保存データの暗号化方法について"></h4>
{{%panel theme="default" header="保存データの暗号化方法について"%}}
RDSのデータ暗号化TDEを対応しています。<br>
TDEの場合 Key Management Service（KMS）は、 Alibaba Cloud によって提供される安全で使いやすい管理サービスです。 KMS を用いて安全かつ便利にキーを管理することで、暗号化/復号化機能の開発に集中できます。

{{% notice note %}}
TDEの設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/33510.htm<br><br>
Key Management Serviceは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28935.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>

<h4 id="SSLを利用するデータ転送方法について"></h4>
{{%panel theme="default" header="SSLを利用するデータ転送方法について"%}}
RDSの通信暗号化にはSSLを対応しています。<br>
SSLの秘密鍵はお客様自身で管理することができますが、Alibaba Cloud SSL Certificates Serviceを利用することで、RSA秘密鍵の一元管理することが可能になります。

{{% notice note %}}
SSLの設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/32474.htm<br><br>
Alibaba Cloud Certificates Serviceは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28553.htm
{{% /notice %}}
{{%/panel%}}
<a href="#index">[⬆ 目次へ]</a>
