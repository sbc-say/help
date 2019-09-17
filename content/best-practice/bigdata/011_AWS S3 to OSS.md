---
title: "AWS S3からOSSへ"
description: "AWS S3からOSSへデータを移植する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 110
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## はじめに
&nbsp; 本ページはAWS S3からAlibabaCloud OSSへデータを移植する方法をまとめます。
本ページは具体的な手法より、どんな手法があるかをメインに記載します。

![BD_Images_AWS_S3_to_OSS_001](/static_images/BD_Images_AWS_S3_to_OSS_001.png)
<br>


### Data Migration Serviceを使った移植方法
※Data Migration Serviceは国際サイト専用のサービスです
[Data Migration Serviceを使った移植方法](https://www.alibabacloud.com/blog/migrating-from-aws-s3-to-alibaba-cloud-oss-using-data-migration-service_594382)
https://www.alibabacloud.com/blog/migrating-from-aws-s3-to-alibaba-cloud-oss-using-data-migration-service_594382
<br>

### VPN経由でS3からOSSへ移植
[VPN経由でS3からOSSへのマイグレーション](https://www.sbcloud.co.jp/entry/2018/12/03/s3-vpn-oss/)
<br>

### OSSImportツール（スタンドアロン）を使った移植
[OssImportのアーキテクチャと構成、ダウンロードページ](https://jp.alibabacloud.com/help/doc-detail/56990.html)
https://jp.alibabacloud.com/help/doc-detail/56990.html

[AWS S3からAlibaba Cloud OSSへのマイグレーション手順](https://www.sbcloud.co.jp/file/98012380859496046)
https://www.sbcloud.co.jp/file/98012380859496046

[AlibabaCloudへのマイグレーション -ストレージ編-](https://www.sbcloud.co.jp/entry/2018/10/31/migration_oss/)
https://www.sbcloud.co.jp/entry/2018/10/31/migration_oss/
<br>

### OSSImportツール（分散モード）を使った移植（分散版）
[OssImportのアーキテクチャと構成、ダウンロードページ](https://jp.alibabacloud.com/help/doc-detail/56990.html)
https://jp.alibabacloud.com/help/doc-detail/56990.html

https://jp.alibabacloud.com/help/doc-detail/59922.htm

[分散デプロイについて](https://jp.alibabacloud.com/help/doc-detail/57057.htm)
https://jp.alibabacloud.com/help/doc-detail/57057.htm
<br>

### emr-toolを使って移植する方法
AWS EMRにてAlibabaCloudのemr-toolをセットアップ、hdfsデータの保存先(接続先パス、エンドポイント）をAlibabaCloud OSSへ指定し移植します。
[HDFS の OSS へのバックアップ](https://jp.alibabacloud.com/help/doc-detail/63822.html)
https://jp.alibabacloud.com/help/doc-detail/63822.html
<br>


### Spark分散を使った移植方法
AWS EMRにてSpark分散処理を実施、保存先(接続先パス、エンドポイント）をAlibabaCloud OSSへ指定するだけです。

<br>

## 最後に
AWS S3からの移植方法は様々な方法があります。ここには書いていない方法もありますので、検証次第、追記したいと思います。

またS3からOSSへ移植するとき、注意したいことが以下の三点です。
* S3とOSSとのNW距離（リージョンが近ければGood）
* NW帯域（データが多いのであれば分散で移植した方がベター）
* S3からの転送料金（データが多いほどOut料金が高くなります）

これを踏まえてS3からOSSへ気軽なデータ移植（Import）ができれば幸いです。
<br>






