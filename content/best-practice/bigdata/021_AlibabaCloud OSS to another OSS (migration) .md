---
title: "AlibabaCloud OSSから別のOSSへ（移植）"
description: "AlibabaCloud OSSから別のOSSへ（移植）を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 210
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->


## はじめに
&nbsp; 本ページはAlibabaCloud OSSから別のOSSへデータを移植する方法をまとめます。
本ページは具体的な手法より、どんな手法があるかをメインに記載します。
一部、URLにある手順はAWS S3をメインとしていますが、こちらはAlibabaCloud OSSでも同じことなので、参考にしてください。

![BD_Images_AlibabaCloud_OSS_to_another_OSS_(migration)_001](../static_images/BD_Images_AlibabaCloud_OSS_to_another_OSS_(migration)_001.png)
<br>


### OSSImportツール（スタンドアロン）を使った移植
[OssImportのアーキテクチャと構成、ダウンロードページ](https://jp.alibabacloud.com/help/doc-detail/56990.html)  
https://jp.alibabacloud.com/help/doc-detail/56990.html  
<br>
[AWS S3からAlibaba Cloud OSSへのマイグレーション手順](https://www.sbcloud.co.jp/file/98012380859496046)  
https://www.sbcloud.co.jp/file/98012380859496046  
<br>
[AlibabaCloudへのマイグレーション -ストレージ編-](https://www.sbcloud.co.jp/entry/2018/10/31/migration_oss/)  
https://www.sbcloud.co.jp/entry/2018/10/31/migration_oss/  
<br>

### OSSImportツール（分散モード）を使った移植（分散版）
[OssImportのアーキテクチャと構成、ダウンロードページ](https://jp.alibabacloud.com/help/doc-detail/56990.html)  
https://jp.alibabacloud.com/help/doc-detail/56990.html  
<br>
[OssImport を使用したデータの移行](https://jp.alibabacloud.com/help/doc-detail/59922.htm)  
https://jp.alibabacloud.com/help/doc-detail/59922.htm  
<br>
[分散デプロイについて](https://jp.alibabacloud.com/help/doc-detail/57057.htm)  
https://jp.alibabacloud.com/help/doc-detail/57057.htm  
<br>

### emr-toolを使って移植する方法
AlibabaCloud E-MapReduceにてAlibabaCloudのemr-toolをセットアップ、hdfsデータの保存先(接続先パス、エンドポイント）を目的となるAlibabaCloud OSSへ指定し移植します。  
[HDFS の OSS へのバックアップ](https://jp.alibabacloud.com/help/doc-detail/63822.html)  
https://jp.alibabacloud.com/help/doc-detail/63822.html  
<br>


### Spark分散を使った移植方法
AWS EMRにてSpark分散処理を実施、保存先(接続先パス、エンドポイント）をAlibabaCloud OSSへ指定するだけです。

<br>

## 最後に
OSSからのデータ移植方法は様々な方法があります。ここには書いていない方法もありますので、検証次第、追記したいと思います。

またOSSから別のOSSへ移植するとき、注意したいことが以下の三点です。

* OSSとのNW距離（リージョンが近ければGood）
* NW帯域（データが多いのであれば分散で移植した方がベター）
* （アカウント分離している場合）OSSからの転送料金（データが多いほどOut料金が高くなります）

これを踏まえてOSSから別OSSへ気軽なデータ移植（Import）ができれば幸いです。
<br>



