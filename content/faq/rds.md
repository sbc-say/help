---
title: "RDS"
description: ""
date: 2019-07-15T15:32:14+09:00
weight: 40
draft: false
---

#### 一般仕様
{{%panel theme="default" header="RDSのトラフィック料金について"%}}
RDS現在トラフィック（インバウンド、アウトバウンド含む）料金は無料です。
{{% /panel%}}

{{%panel theme="default" header="sysadminの権限提供について"%}}
インスタンスの安定性とセキュリティを保証するために、RDS for SQL Server では、sysadmin 権限を提供しておりません。

{{% notice note %}}
RDSの制限詳細は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/26141.htm
{{% /notice %}}
{{%/panel%}}

{{%panel theme="default" header="カスタマイズ可能なパラメーターについて"%}}
RDSはマネジメントサービスのため、カスタマイズ可能なパラメーターはRDSコンソールのパラメーターの設定ページに表示されているパラメーターのみとなります。
{{% /panel%}}

{{%panel theme="default" header="RDSのストレージ容量の拡張方法について"%}}
RDSのストレージ容量は下記メニューから拡張することができます。

{{% notice tip %}}
コンソール > RDS > インスタンスの「詳細」> 設定を変更する > 容量
{{% /notice %}}
{{%/panel%}}

{{%panel theme="default" header="ホワイトリストの設定方法について"%}}
RDSにはホワイトリストを利用してアクセスIPを制限することができます。

{{% notice note %}}
RDSのホワイトリストの設定は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/43186.html
{{% /notice %}}
{{%/panel%}}

{{%panel theme="default" header="インターネットアドレスとイントラネットアドレスの違いについて"%}}
RDSにインターネットアドレスとイントラネットアドレスがあります。<br><br>

イントラネットアドレスは同じVPC内のインスタンスのみアクセスすることができます。<br>
インターネットアドレスはインターネットからアクセスすることができます。
{{% /panel%}}

{{%panel theme="default" header="VPCとVswitchの変更方法について"%}}
RDS作成後のVPCとVSwitchの変更を対応していません。既存RDSのバックアップからVPCとVSwitchを指定して新規RDSを作成することになります。
{{% /panel%}}

#### バックアップ
{{%panel theme="default" header="バックアップ取得時の性能影響について"%}}
RDSのバックアップはスレーブインスタンスから取得するため、取得時にスレーブインスタンスへ影響がありますが、マスターインスタンスの性能に影響がありません。
{{% /panel%}}

{{%panel theme="default" header="RDSバックアップの保存先について"%}}
RDSバックアップはアーキテクチャ上にOSS上に保存されますが、お客様のOSS領域ではありませんので、ダウンロードする際には、RDSコンソールからとなります。
{{% /panel%}}

{{%panel theme="default" header="リカバリ時に指定可能な時刻について"%}}
バックアップからリカバリ時に希望時刻を指定することができます。<br>
指定可能の時刻は最初のフルバックアップ時刻から現時刻の間となります。
{{% /panel%}}

{{%panel theme="default" header="RDSリリース後のバックアップ提供について"%}}
RDSのリリースに伴い、バックアップもリリースされます。RDSのバックアップをお客様のOSSに移管する機能は現在ありません。必要な場合、リリース前にRDSコンソールからダウンロードする必要があります。
{{% /panel%}}

#### マルチゾーン
{{%panel theme="default" header="マルチゾーンの確認方法について"%}}
下記メニューからマスターインスタンスとスレーブインスタンスの所在ゾーンを確認することができます。

{{% notice tip %}}
コンソール > RDS > インスタンス > インスタンスの可用性 > マスターノード ID/スレーブノード ID
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="マルチゾーンの切り替え方法について"%}}
下記メニューからマスターインスタンスとスレーブインスタンスを切り替えることができます。マスターノード ID/スレーブノード IDにて切り替え前後のゾーンを確認することができます。

{{% notice tip %}}
コンソール > RDS > インスタンス > インスタンスの可用性 > スイッチオーバー
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="レプリカのマルチゾーン対応について"%}}
RDSのレプリカインスタンスは現在シングルゾーンのみ対応しています。
{{% /panel%}}

#### 暗号化
{{%panel theme="default" header="保存データの暗号化方法について"%}}
RDSのデータ暗号化TDEを対応しています。<br>
TDEの場合 Key Management Service（KMS）は、 Alibaba Cloud によって提供される安全で使いやすい管理サービスです。 KMS を用いて安全かつ便利にキーを管理することで、暗号化/復号化機能の開発に集中できます。

{{% notice note %}}
TDEの設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/33510.htm<br><br>
Key Management Serviceは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28935.htm
{{% /notice %}}
{{% /panel%}}

{{%panel theme="default" header="SSLを利用するデータ転送方法について"%}}
RDSの通信暗号化にはSSLを対応しています。<br>
SSLの秘密鍵はお客様自身で管理することができますが、Alibaba Cloud SSL Certificates Serviceを利用することで、RSA秘密鍵の一元管理することが可能になります。

{{% notice note %}}
SSLの設定方法は下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/32474.htm<br><br>
Alibaba Cloud Certificates Serviceは下記のドキュメントをご参照ください。<br>
https://jp.alibabacloud.com/help/doc-detail/28553.htm
{{% /notice %}}
{{% /panel%}}
