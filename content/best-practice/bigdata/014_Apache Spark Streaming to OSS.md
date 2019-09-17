---
title: "ApacheSpark（Streaming）からOSSへ"
description: "ApacheSpark（Streaming）からOSSへデータを集約する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 140
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## はじめに
&nbsp; 本章はApache Spark（Streaming）を使ってAlibabaCloud OSSへデータを送ります。ゴールとしては以下のような構成図になります。
また、OSSにデータ収集後、E-MapReduceでHDFSへのETL処理がありますが、こちらは「OSSとE-MapReduce編」「ETL編」にて重複するため、割愛させていただきます。
（この章のゴールは外部データソースをOSSへ集約する、のみとなります）


![BD_Images_Apache_Spark_Streaming_to_OSS_001](../static_images/BD_Images_Apache_Spark_Streaming_to_OSS_001.png)
<br>




## Apache Spark Streaming とは
&nbsp; Apache Spark Streamingは大規模ストリーム処理フレームワークです。
Spark APIを拡張し、データサイエンティスト、エンジニアがKafka、Flume、Ignite、などのさまざまなソースからのリアルタイムデータを処理できるようにします。この処理されたデータは、OSS、MySQLなどのデータベース、ElasticSearchなどライブダッシュボードに出力できます。また、Spark Streamingは、MLlibやSpark SQLなど他のSparkコンポーネントとシームレスに統合できるので、加工処理、抽出、など様々な応用ができます。
![BD_Images_Apache_Spark_Streaming_to_OSS_002](../static_images/BD_Images_Apache_Spark_Streaming_to_OSS_002.png)
<br>

さてPythonを使ってSpark Streamingのテストをしてみます。今回、手頃にいいデータがなかったので、TCPソースからストリームデータを作成し、その結果をOSSへ書き込むという処理を目指します。

SocketTextStreamメソッドはTCPソース(hostname:port)からinputデータを生成、データはTCPソケットを使用して受け取とられ、UTF-8でエンコードし、¥nをデリミタとした行単位でバイトで受け取ります。
今回はAlibabaCloud E-MapReduceで実施するため、TCPソース(hostname:port)はE-MapReduceのHostname、使われてないPort 9999を使用します。

###### 環境について
|Clustor|instance|Type|台数|
|---|---|---|---|
|Hadoop EMR-3.22.0|MASTER|ecs.sn2.large|1|
|       |CORE|ecs.sn2.large|2|

E-MapReduceのHostは以下コマンドで取得します。
```bash
[root@emr-header-1 ~]# 
[root@emr-header-1 ~]# hostname
emr-header-1.cluster-44076
[root@emr-header-1 ~]# 

```
続いて、Pythonソースにて、コードを記載します。
```python
# -*- coding:utf-8 -*-
import sys
from pyspark.context import SparkContext
from pyspark.streaming import StreamingContext

if len(sys.argv) != 3:
    print("Usage: network_wordcount.py <hostname> <port>", file=sys.stderr)
    exit(-1)

sc = SparkContext(appName="StreamingTest")
ssc = StreamingContext(sc, 10)

lines = ssc.socketTextStream(sys.argv[1], int(sys.argv[2]))

counts = lines.flatMap(lambda line: line.split(" "))\
              .map(lambda word: (word, 1))\
              .reduceByKey(lambda a, b: a+b)

counts.saveAsTextFiles("oss://bigdata-prod-tech/nyc-taxi/yellow_tripdata/StreamingTest/", "txt")

ssc.start()
ssc.awaitTermination()
```
Pythonソースで書き込みが終わったら、別ターミナルで Netcat でつなぎます。
```bash
$ nc -lk 9999
```
そのあと、以下コマンドでストリーミングを実行します
```bash
spark-submit network_wordcount.py emr-header-1.cluster-44076 9999
```
これによりSparkのLogメッセージが表示され、Spark Streamingが恒久的に実施されます。
```bash
[root@emr-header-1 ~]# 
[root@emr-header-1 ~]# spark-submit network_wordcount.py emr-header-1.cluster-44076 9999
19/08/15 20:40:21 INFO SparkContext: Running Spark version 2.4.3
19/08/15 20:40:21 INFO SparkContext: Submitted application: StreamingTest
19/08/15 20:40:21 INFO SecurityManager: Changing view acls to: root,*
19/08/15 20:40:21 INFO SecurityManager: Changing modify acls to: root
19/08/15 20:40:21 INFO SecurityManager: Changing view acls groups to: 
〜略〜
```
その結果、OSSにてStreming結果（TCPソースのデータ）が出力されてることが確認できます。

![BD_Images_Apache_Spark_Streaming_to_OSS_003](../static_images/BD_Images_Apache_Spark_Streaming_to_OSS_003.png)
<br>

## まとめ
Spark Streamingはストリームデータを加工処理できるため（DStreams) 非常に便利です。ただ、Spark Streaming単体だけでは、TCPソケット接続を介してテキストデータを生成するsocketTextStream、ファイルデータを生成するtextFileStreamと、使用方法が少し限られています。そのため、これに加えてkafka、Ignite、などと連携することで更なるストリーミング応用ができます。
<br>

参考：
[Spark Streamingガイド](https://spark.apache.org/docs/latest/streaming-programming-guide.html)
https://spark.apache.org/docs/latest/streaming-programming-guide.html

[Spark Structured Streamingガイド](https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html)
https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html

[Spark Structured Streamingについて](https://databricks.com/blog/2016/07/28/structured-streaming-in-apache-spark.html)
https://databricks.com/blog/2016/07/28/structured-streaming-in-apache-spark.html

<br>
