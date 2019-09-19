---
title: "Apache FlumeからOSSへ"
description: "Apache FlumeからOSSへデータを集約する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 160
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## はじめに
&nbsp; 本章はApache Flumeを使ってOSSへデータを送ります。ゴールとしては以下のような構成図になります。
また、OSSにデータ収集後、E-MapReduceでHDFSへのETL処理がありますが、こちらは「OSSとE-MapReduce編」「ETL編」にて重複するため、割愛させていただきます。
（この章のゴールは外部データソースをOSSへ集約する、のみとなります）


![BD_Images_Apache_Flume_to_OSS_001](../static_images/BD_Images_Apache_Flume_to_OSS_001.png)
<br>


## Apache Flumeとは
&nbsp; Apache Flumeは堅牢性が高く、耐障害性のある分散データ取り込みツールです。さまざまなデータソース（Webサーバーなど）からHadoop分散ファイルシステム（HDFS）、HDFS上のHBaseやkuduなどの分散データベース、またはElasticsearchなど大量のログファイルをストリーミングすることができます。Flumeはログデータのストリーミングに加えて、Twitter、Facebook、Kafka BrokersなどのWebソースから生成されたEventデータをストリーミングすることもできます。
![BD_Images_Apache_Flume_to_OSS_002](../static_images/BD_Images_Apache_Flume_to_OSS_002.png)
<br>

[Apache Flumeでより詳しいことは公式サイト](https://flume.apache.org/)を参照ください。
https://flume.apache.org/
<br>

## Flumeの概要
&nbsp; Apache Flumeはクラスターへのデータの取り込み（ingres）に特化しています。特に数台または数千台のマシンに蓄積されているログファイルを収集、集約、クラスター内の単一のエントリポイントにストリーミングできます。Flumeのコンポーネントと概念についてを以下にて説明します。

* Event：Flumeによって転送されるデータの基本ペイロード。Flumeが発信元から最終目的地まで転送できるデータの単位を表します。オプションのヘッダーはインターセプターを介してチェーン化され、通常はEventの検査と変更に使用されます。
* Client：Eventの起点で動作し、それらをFlumeAgentに配信するインターフェース実装。Clientは通常、データを消費しているアプリケーションのプロセス空間で動作します。
* Agent： Flumeのデータパスのコア要素。ホストは、Source、Channel、Sinkなどのコンポーネントを使用し、Eventを受信、保存、およびネクストホップの宛先に転送する機能を備えています。
* Source：Client経由で配信されるEventを消費します。SourceがEventを受信すると、それを1つ以上のChannelに渡します。
* Channel：Eventの一時ストア。SourceとSinkの間のリンク部分です。Channelは、フローの耐久性を確保する上で重要な役割を果たします。
* Sink：ChannelからEventを削除し、フロー内の次のAgentまたはEventの最終宛先に送信します。Eventを最終宛先に送信するSinkは、ターミナルシンクとも呼ばれます。

EventはClientからSourceへ流れます。Sourceは、Eventを1つ以上のChannel書き込みます。Channelは、処理中のEventデータ保持領域であり、永続的（ファイルバックアップ）または非永続的（メモリバックアップ）に構成できます。Eventデータは、Sinkがそれを処理し、データを最終宛先に送信できるようになるまで、Channelで待機します。

以下は、HDFS（OSS）ターミナルシンクで構成されたシンプルなFlumeエージェントを示しています。


参考：[Apache Flumeガイドライン](http://flume.apache.org/FlumeUserGuide.html)
http://flume.apache.org/FlumeUserGuide.html
<br>


## Flumeを使ってデータを取り込む
&nbsp; 今回はTwitter情報をFlumeで収集しHDFSフォルダをOSSとして格納するという流れを目指します。

###### 環境について
|Clustor|instance|Type|台数|
|---|---|---|---|
|Hadoop EMR-3.22.0|MASTER|ecs.sn2.large|1|
|       |CORE|ecs.sn2.large|2|
<br>

Step1. Twitter APIを発行
こちらはTwitter Developerに申請する必要があります。
https://developer.twitter.com/content/developer-twitter/ja.html
<br>

Step2. EMR マスターノードにログインし、CLIで`flume-twitter.conf`というconfigファイルを作成します。

```
[root@emr-header-1 ~]# vi /etc/flume-twitter.conf
[root@emr-header-1 ~]# 
```

`flume-twitter.conf`の中身は以下の通りになります。

```bash
LogAgent.sources = apache
LogAgent.sinks = fileChannel
LogAgent.channels = HDFS


# twitter data source
LogAgent.sources.apache.type = org.apache.flume.source.twitter.TwitterSource
LogAgent.sources.apache.channels = HDFS
LogAgent.sources.apache.consumerKey = CONSUMER_KEY
LogAgent.sources.apache.consumerSecret = CONSUMER_SECRET
LogAgent.sources.apache.accessToken = ACCESS_TOKEN_KEY
LogAgent.sources.apache.accessTokenSecret = ACCESS_TOKEN_SECRET
LogAgent.sources.apache.maxBatchSize = 50000
LogAgent.sources.apache.maxBatchDurationMillis = 100000

# Describe the sink
LogAgent.sinks.HDFS.channel = fileChannel
LogAgent.sinks.fileChannel.channel = HDFS
LogAgent.sinks.HDFS.type = hdfs
LogAgent.sinks.HDFS.hdfs.path = oss://bigdata-prod-tech/twitter/flume/%Y%m%d
LogAgent.sinks.HDFS.hdfs.fileType = DataStream
LogAgent.sinks.HDFS.hdfs.writeFormat = TEXT
LogAgent.sinks.HDFS.hdfs.filePrefix = %{fileName}.%H:%M:%S
LogAgent.sinks.HDFS.hdfs.fileSuffix = .log
LogAgent.sinks.HDFS.hdfs.batchSize = 1000
LogAgent.sinks.HDFS.hdfs.rollSize = 0
LogAgent.sinks.HDFS.hdfs.rollCount = 0
LogAgent.sinks.HDFS.hdfs.rollInterval = 30
LogAgent.sinks.HDFS.hdfs.useLocalTimeStamp = true

# Use a channel which buffers events in memory
LogAgent.channels.fileChannel.type = memory
LogAgent.channels.fileChannel.capacity = 1000000
LogAgent.channels.fileChannel.transactionCapacity = 10000

```

Step3. 
コマンドを実行します。
```bash
[root@emr-header-1 ~]# /usr/lib/flume-current/bin/flume-ng agent -n LogAgent -c conf -f ~/etc/flume-twitter.conf -Dflume.root.logger=INFO,console -Xmx1g
Info: Including Hadoop libraries found via (/usr/lib/hadoop-current/bin/hadoop) for HDFS access
Info: Including HBASE libraries found via (/usr/lib/hbase-current/bin/hbase) for HBASE access
Info: Including Hive libraries found via (/usr/lib/hive-current) for Hive access
Info: Including HCatalog libraries found via (/usr/lib/hive-current/hcatalog) for Hive access
+ [[ -Dflume.root.logger=INFO,console -Xmx1g != *flume.monitoring.* ]]
+ arr_java_props[${#arr_java_props[@]}]=-Dflume.monitoring.type=log
+ '[' -n LogAgent ']'
+ len=3
+ arr_java_props[$len]=-Dflume.agent.name=LogAgent
+ (( ++len ))
+ flume_gc_props='-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps  -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=128M -Xloggc:/mnt/disk1/log/flume/LogAgent/flume-gc.log'
〜略〜
```

Step4. OSSにてFlumeによって取り込みされたデータを確認できたら完了です。
<br>



## 最後に
Flumeはログ収集基盤の位置付けなので、Spark Streamingと組み合わせてデータを収集することもできます。詳細はこちらを参照ください。

[Apache FlumeとSpark Streamingの統合について](https://www.sbcloud.co.jp/entry/2019/03/18/flumesparkstreaming/)
https://www.sbcloud.co.jp/entry/2019/03/18/flumesparkstreaming/
<br>




