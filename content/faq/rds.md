---
title: "RDS"
description: ""
date: 2019-04-04T15:32:14+09:00
weight: 40
draft: false
---

## 一般仕様
#### Q. RDSのトラフィック料金について
RDS現在トラフィック（インバウンド、アウトバウンド含む）料金は無料です。
#### Q. sysadminの権限提供について
インスタンスの安定性とセキュリティを保証するために、RDS for SQL Server では、sysadmin 権限を提供しておりません。

RDSの制限詳細は下記ドキュメントをご参照ください。 
https://jp.alibabacloud.com/help/doc-detail/26141.htm
#### Q. カスタマイズ可能なパラメーターについて
RDSはマネジメントサービスのため、カスタマイズ可能なパラメーターはRDSコンソールのパラメーターの設定ページに表示されているパラメーターのみとなります。
#### Q. RDSのストレージ容量の拡張方法について
RDSのストレージ容量は下記メニューから拡張することができます。
コンソール > RDS > インスタンスの「詳細」> 設定を変更する > 容量
#### Q. ホワイトリストの設定方法について
RDSにはホワイトリストを利用してアクセスIPを制限することができます。

RDSのホワイトリストの設定は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/43186.html
#### Q. インターネットアドレスとイントラネットアドレスの違いについて
RDSにインターネットアドレスとイントラネットアドレスがあります。

イントラネットアドレスは同じVPC内のインスタンスのみアクセスすることができます。
インターネットアドレスはインターネットからアクセスすることができます。
#### Q. VPCとVswitchの変更方法について
RDS作成後のVPCとVSwitchの変更を対応していません。既存RDSのバックアップからVPCとVSwitchを指定して新規RDSを作成することになります。

## バックアップ
#### Q. バックアップ取得時の性能影響について
RDSのバックアップはスレーブインスタンスから取得するため、取得時にスレーブインスタンスへ影響がありますが、マスターインスタンスの性能に影響がありません。
#### Q. RDSバックアップの保存先について
RDSバックアップはアーキテクチャ上にOSS上に保存されますが、お客様のOSS領域ではありませんので、ダウンロードする際には、RDSコンソールからとなります。
#### Q. リカバリ時に指定可能な時刻について
バックアップからリカバリ時に希望時刻を指定することができます。
指定可能の時刻は最初のフルバックアップ時刻から現時刻の間となります。
#### Q. RDSリリース後のバックアップ提供について
RDSのリリースに伴い、バックアップもリリースされます。RDSのバックアップをお客様のOSSに移管する機能は現在ありません。必要な場合、リリース前にRDSコンソールからダウンロードする必要があります。

## マルチゾーン
#### Q. マルチゾーンの確認方法について
下記メニューからマスターインスタンスとスレーブインスタンスの所在ゾーンを確認することができます。
コンソール > RDS > インスタンス > インスタンスの可用性 > マスターノード ID/スレーブノード ID
#### Q. マルチゾーンの切り替え方法について
下記メニューからマスターインスタンスとスレーブインスタンスを切り替えることができます。マスターノード ID/スレーブノード IDにて切り替え前後のゾーンを確認することができます。
コンソール > RDS > インスタンス > インスタンスの可用性 > スイッチオーバー
#### Q. レプリカのマルチゾーン対応について
RDSのレプリカインスタンスは現在シングルゾーンのみ対応しています。

## 暗号化
#### Q. 保存データの暗号化方法について
RDSのデータ暗号化TDEを対応しています。
TDEの設定方法は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/33510.htm

TDEの場合 Key Management Service（KMS）は、 Alibaba Cloud によって提供される安全で使いやすい管理サービスです。 KMS を用いて安全かつ便利にキーを管理することで、暗号化/復号化機能の開発に集中できます。
Key Management Serviceは下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/28935.htm
#### Q. SSLを利用するデータ転送方法について
RDSの通信暗号化にはSSLを対応しています。
SSLの設定方法は下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/32474.htm

SSLの秘密鍵はお客様自身で管理することができますが、Alibaba Cloud SSL Certificates Serviceを利用することで、RSA秘密鍵の一元管理することが可能になります。
Alibaba Cloud Certificates Serviceは下記ドキュメントをご参照ください。
https://jp.alibabacloud.com/help/doc-detail/28553.htm