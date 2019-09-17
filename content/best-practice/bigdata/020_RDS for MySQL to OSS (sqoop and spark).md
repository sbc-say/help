---
title: "RDS for MySQLからOSSへ"
description: "RDS for MySQLからOSSへデータを集約する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 30
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## はじめに
&nbsp; 本章はSqoopを使ってRDS for MySQLからOSSへデータを送ります。ゴールとしては以下のような構成図になります。
また、OSSにデータ収集後、E-MapReduceでHDFSへのETL処理がありますが、こちらは「OSSとE-MapReduce編」「ETL編」にて重複するため、割愛させていただきます。
（この章のゴールは外部データソースをOSSへ集約する、のみとなります）


![BD_Images_RDS_for_MySQL_to_OSS_(sqoop_and_spark)_001](/static_images/BD_Images_RDS_for_MySQL_to_OSS_(sqoop_and_spark)_001.png)
<br>


## SQOOPとは
&nbsp; Apache SqoopはHadoopとリレーショナルデータベースなどの構造化データストアとの間で、大量のデータを効率的に転送するために設計されたツールです。

|From|To|備考|
|---|---|---|
|MySQL|HDFS||
|MySQL|Hive|--hive-importオプションを付与|
|PostgreSQL|HDFS||
|PostgreSQL|Hive|--hive-importオプションを付与|

他、jdbcドライバがある限り、OracleやSQL ServerからHDFSやHiveテーブルへSqoop移植することも可能です。

## 移植してみる
Sqoopを使ってRDS for MySQLにあるテーブルをHive Tableへ移植します。

###### 環境について
|Clustor|instance|Type|台数|
|---|---|---|---|
|Hadoop EMR-3.22.0|MASTER|ecs.sn2.large|1|
|       |CORE|ecs.sn2.large|2|


Sqoopには様々なオプションがありますので、目的に応じて使い分けてください
|オプション|説明|
|---|---|
|--connect|接続したいjdbcデータソース|
|--table|テーブル名|
|--m|並列タスク数。データが多いならタスク数を増やします|
|--hive-import|Hiveのテーブルへインポート|
|--username|jdbcデータソースのユーザ名|
|-P|jdbcデータソースのパスワード|


```bash
[root@emr-header-1 ~]# sqoop import --connect jdbc:mysql://rm-e9b9y00ci431p741y.mysql.japan.rds.aliyuncs.com/twitter_db --table twitter_db.tweet -m 1 --hive-import --username test_user -P
Warning: /usr/lib/sqoop-current/../hbase does not exist! HBase imports will fail.
Please set $HBASE_HOME to the root of your HBase installation.
Warning: /usr/lib/sqoop-current/../accumulo does not exist! Accumulo imports will fail.
Please set $ACCUMULO_HOME to the root of your Accumulo installation.
19/08/16 12:44:42 INFO sqoop.Sqoop: Running Sqoop version: 1.4.7
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/apps/ecm/service/hadoop/2.8.5-1.4.0/package/hadoop-2.8.5-1.4.0/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/apps/ecm/service/hive/3.1.1-1.1.6/package/apache-hive-3.1.1-1.1.6-bin/lib/log4j-slf4j-impl-2.10.0.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Enter password: 
19/08/16 12:44:47 INFO tool.BaseSqoopTool: Using Hive-specific delimiters for output. You can override
19/08/16 12:44:47 INFO tool.BaseSqoopTool: delimiters with --fields-terminated-by, etc.
19/08/16 12:44:48 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
19/08/16 12:44:48 INFO tool.CodeGenTool: Beginning code generation
〜略〜

Time taken: 49.404 seconds
Loading data to table default.tweet
Table default.tweet stats: [numFiles=10, numRows=4120, totalSize=763103, rawDataSize=6801]
OK
Time taken: 14.094 seconds
```
<br>

これでHive側にテーブルが作成できました。

![BD_Images_RDS_for_MySQL_to_OSS_(sqoop_and_spark)_002](/static_images/BD_Images_RDS_for_MySQL_to_OSS_(sqoop_and_spark)_002.png)
<br>




## 最後に
AlibabaCloud公式blogにもE-MapReduce起動方法、手法、ベストプラクティスが記載されていますので、こちらを参考にするのもありです。

[Sqoopによるデータ移植方法](https://www.alibabacloud.com/blog/drilling-into-big-data-data-ingestion-4_594666)
https://www.alibabacloud.com/blog/drilling-into-big-data-getting-started-with-oss-and-emr-2_594668

* SqoopはORC、RCなどの少数のhadoopファイル形式をサポートしていません
* 大文字でスキーマとテーブル名に言及すると、いくつかの問題に直面することを防ぎます
* 複数のマッパーが必要な場合は分割を使用します
* sqoopのキーワードである列名の使用を避ける
* テーブルに主キーが定義されておらず、コマンドで--split-byが指定されていない場合、マッパーの数が明示的に1に設定されていない限りインポートは失敗します


