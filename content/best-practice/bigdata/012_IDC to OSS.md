---
title: "IDCからOSSへ"
description: "IDCオンプレミスからOSSへデータを移植する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 30
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## はじめに
&nbsp; 本ページはIDCからAlibabaCloud OSSへデータを移植する方法をまとめます。
本ページは具体的な手法より、どんな手法があるかをメインに記載します。

### ExpressConnectを使用した方法
[物理接続を介したオンプレミス IDC からの VPC への接続](https://jp.alibabacloud.com/help/doc-detail/44844.htm)
https://jp.alibabacloud.com/help/doc-detail/44844.htm

![BD_Images_IDC_to_OSS_001](/static_images/BD_Images_IDC_to_OSS_001.png)
<br>

### Hybrid Cloud Storage Arrayを使用した方法
※ Hybrid Cloud Storage Arrayは国際サイトのみ提供となります。
[Hybrid Cloud Storage Array](https://www.alibabacloud.com/product/storage-array)
https://www.alibabacloud.com/product/storage-array

[オンプレミスとのクロスレプリケーションによるバックアップ方法](https://medium.com/@Alibaba_Cloud/hybrid-cloud-storage-cross-cloud-replication-5b5a3dee8ff1)
https://medium.com/@Alibaba_Cloud/hybrid-cloud-storage-cross-cloud-replication-5b5a3dee8ff1
<br>

### OSSImport（スタンドアロン）を使用した方法

[OssImportのアーキテクチャと構成、ダウンロードページ](https://jp.alibabacloud.com/help/doc-detail/56990.html)
https://jp.alibabacloud.com/help/doc-detail/56990.html

[OssImport を使用したデータの移行](https://jp.alibabacloud.com/help/doc-detail/59922.html)
https://jp.alibabacloud.com/help/doc-detail/59922.html

[AlibabaCloudへのマイグレーション -ストレージ編-](https://www.sbcloud.co.jp/entry/2018/10/31/migration_oss/)
https://www.sbcloud.co.jp/entry/2018/10/31/migration_oss/


![BD_Images_IDC_to_OSS_002](/static_images/BD_Images_IDC_to_OSS_002.png)
<br>


### emr-toolを使って移植する方法
IDCオンプレミスにてAlibabaCloudのemr-toolをセットアップ、hdfsデータの保存先(接続先パス、エンドポイント）をAlibabaCloud OSSへ指定して移植します。
[HDFS の OSS へのバックアップ](https://jp.alibabacloud.com/help/doc-detail/63822.html)
https://jp.alibabacloud.com/help/doc-detail/63822.html
<br>

### Spark分散を使った移植方法
IDCオンプレミス側にてSpark分散処理を実施、そのとき保存先（接続先）パスをAlibabaCloud OSSへ指定するだけです。


<br>

## 最後に
IDCオンプレミスからの移植方法はAWS S3と同様、様々な方法があります。ここには書いていない方法もありますので、検証次第、追記したいと思います。

またIDCからOSSへ移植するとき、注意したいことが以下の三点です。
* IDCオンプレミスとOSSとのNW距離（リージョンが近ければGood）
* NW帯域（データが多いのであれば分散で移植した方がベター）

これを踏まえてIDCオンプレミスからOSSへ気軽なデータ移植（Import）ができれば幸いです。
<br>





