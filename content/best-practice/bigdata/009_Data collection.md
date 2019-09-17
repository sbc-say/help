---
title: "既存データからの移植について"
description: "既存データからの移植についてを説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 90
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->


## OSSをハブとした運用について
&nbsp; 前述、OSSとE-MapReduceを説明しました。OSSをハブとして運用することで、コスト削減はもちろん、AlibabaCloudの様々なフルマネージドサービスを中心とした構成が可能となります。
![BD_Images_Data_collection_005](../static_images/BD_Images_Data_collection_005.png)
<br>

そのため、全ての処理基盤はAlibabaCloudで初め、AlibabaCloudで終わる、という構成も可能です。
![BD_Images_Data_collection_007](../static_images/BD_Images_Data_collection_007.png)
<br>


同時に、AlibabaCloudのOSSは様々な外部データソースと連携することが可能です。
別の章にてそれぞれのデータソース接続手法を記載します。
![BD_Images_Data_collection_006](../static_images/BD_Images_Data_collection_006.png)


2019/07/20 現状確認されてる外部データソースとの接続方法サマリとしては以下の通りになります。
今後このサマリにてApache Beam、Apache Flink、Apache samza、kinesis、Livy、Oracle on Spark、SQL Server on Spark、MongoDB、他の外部データソースも順次追加したいと思います。

![BD_Images_Data_collection_008](../static_images/BD_Images_Data_collection_008.png)
<br>


## 運用するときの注意点について

### データ構造
&nbsp; データを集約した後、どんな分析を行うのか？これを踏まえて、どんな利用方法があるか？をイメージしたテーブル・スキーマ・フィールドタイプ・データ設計をする必要があります。


### 転送料金
&nbsp; OSSと外部データ（IDCやS3など）でデータやりとりするとき、OSSへInするデータは無料ですが、VPCより先へOutするデータには料金が発生してしまいます。なので、Outするときはデータを圧縮してから移植するなど、工夫が必要です。


### ネットワーク
&nbsp; データを集約・転送するとき、NW距離ら物理的な要因で処理が遅くなることがあります。そのため、OSSおよび周囲プロダクトサービスとのリージョン・配置はできるだけ近い位置で配置が望ましいです。


### ETL
&nbsp; ETLは様々な方法がありますが、データ型やhdfsタイプ、仕様上できることできないことを見極めて全体設計が望ましいです。
ex: 
* HiveやSparkはdate型をサポートしますが、PrestoやImpalaはdate型をサポートしないので読み込み不可
* SparkはORCサポートを打ち切ったため 、代わりの手法はSparkの最新ドキュメントで確認



<br>

