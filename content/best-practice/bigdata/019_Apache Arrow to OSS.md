---
title: "Apache ArrowからOSSへ"
description: "Apache ArrowからOSSへデータを集約する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 30
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->
## はじめに
&nbsp; 本章はAlibabaCloud LogServiceを使ってOSSへデータを送ります。ゴールとしては以下のような構成図になります。
また、OSSにデータ収集後、E-MapReduceでHDFSへのETL処理がありますが、こちらは「OSSとE-MapReduce編」「ETL編」にて重複するため、割愛させていただきます。
（この章のゴールは外部データソースをOSSへ集約する、のみとなります）


![BD_Images_Apache_Arrow_to_OSS_001](/static_images/BD_Images_Apache_Arrow_to_OSS_001.png)
<br>


## Apache Arrow とは
&nbsp; Apache Arrowは様々な言語で使えるIn-Memoryデータ変換処理プラットフォームです。大規模なBigDataでSpark以外の手法の一つです。見た目、Sparkにちょっと似ていますが、こちらの利点としては以下の通りです。

* インメモリの列指向データフォーマット。[PythonのPandas問題](https://qiita.com/tamagawa-ryuji/items/3d8fc52406706ae0c144)を解決するために開発
* CPU/GPUのキャッシュメモリを利用して大量のデータの処理効率化
* データ交換（シリアライズ、転送、デシリアライズ）の高速化に特化
* 実装コストは非常に低い
* PySparkなどSparkと連携することで、CPU、NW転送の観点上、今より数十倍高速化が可能
* OLAP、OLTP、DeepLearningなど様々な分野で活躍
* データの交換をするならArrow、データの永続化をするならSpark

![BD_Images_Apache_Arrow_to_OSS_002](/static_images/BD_Images_Apache_Arrow_to_OSS_002.png)
<br>

参考：PythonのPandas問題
https://qiita.com/tamagawa-ryuji/items/3d8fc52406706ae0c144

より詳しくは[Apache Arrowの公式ガイドライン](https://arrow.apache.org/)を参照してください。
https://arrow.apache.org/
https://arrow.apache.org/docs/format/README.html

<br>

それではApache Arrowを使ってECSにあるcsvファイルをhdfs_Parquetへ変換します。
>注意として、ECSはOSSへのアクセス権限を持ってることが前提となります。

Apache ArrowのParquet形式変換で様々なオプションがありますので、こちらを参考にしてください。
https://arrow.apache.org/docs/python/parquet.html


## Apache Arrowの使い方
Arrowは多くの言語をサポートしています。（[現在も様々な言語へ開発中](https://github.com/apache/arrow)） 今回はPythonを使います。
https://github.com/apache/arrow

Step1. `pip install arrow`でインストールします。また`pandas`も必要なのでなければ`pip install pandas`とインストールしましょう。
```bash
[root@metabase ~]# pip install arrow
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Looking in indexes: http://jp.mirrors.cloud.aliyuncs.com/pypi/simple/
Collecting arrow
  Downloading http://jp.mirrors.cloud.aliyuncs.com/pypi/packages/5d/c7/468bb95a10fb8ddb5f3f80e1aef06b78f64d6e5df958c39672f80581381f/arrow-0.13.0.tar.gz (92kB)
     |████████████████████████████████| 102kB 22.9MB/s 
Collecting python-dateutil (from arrow)
  Downloading http://jp.mirrors.cloud.aliyuncs.com/pypi/packages/74/68/d87d9b36af36f44254a8d512cbfc48369103a3b9e474be9bdfe536abfc45/python_dateutil-2.7.5-py2.py3-none-any.whl (225kB)
     |████████████████████████████████| 235kB 19.6MB/s 
Collecting backports.functools_lru_cache>=1.2.1 (from arrow)
  Downloading http://jp.mirrors.cloud.aliyuncs.com/pypi/packages/03/8e/2424c0e65c4a066e28f539364deee49b6451f8fcd4f718fefa50cc3dcf48/backports.functools_lru_cache-1.5-py2.py3-none-any.whl
Collecting six>=1.5 (from python-dateutil->arrow)
  Downloading http://jp.mirrors.cloud.aliyuncs.com/pypi/packages/73/fb/00a976f728d0d1fecfe898238ce23f502a721c0ac0ecfedb80e0d88c64e9/six-1.12.0-py2.py3-none-any.whl
Building wheels for collected packages: arrow
  Building wheel for arrow (setup.py) ... done
  Stored in directory: /root/.cache/pip/wheels/b5/ee/e0/5238ee875bb4565c8c2070c4fd84c3c1640684b30b7bd04762
Successfully built arrow
Installing collected packages: six, python-dateutil, backports.functools-lru-cache, arrow
Successfully installed arrow-0.13.0 backports.functools-lru-cache-1.5 python-dateutil-2.7.5 six-1.12.0
[root@metabase ~]# 
```


Step2. 今回はローカルにあるcsvファイルをparquetへETLしOSSヘ保存します。
```python
import pyarrow as pa
import pyarrow.parquet as pq
import pandas as pd

# CSVをDataFrameへ読み込ませる
df = pd.read_csv('./test.csv')

# DataFrameをArrow Tableへ代入
table = pa.Table.from_pandas(df)

# Arrow TableデータをOSSのParquetへ保存。
pq.write_table(table, 'oss://bigdata-prod-tech/arrow/test.pq')

#`write_to_dataset`を使ってOSSヘパーティションつけて保存することも可能です。詳しくはArrowドキュメントを参照してください。
pq.write_to_dataset(table, bucket_uri, filesystem=fs, partition_cols=['year', 'month', 'day'], use_dictionary=True,  compression='snappy', use_deprecated_int96_timestamps=True)
```

以上です。Arrowを使えば、逆のパターンも可能です。

```python
# ParquetをArrow Tableへ読み込ませる
oss_parquet = pq.read_table('oss://bigdata-prod-tech/arrow/test.pq')

# Arrow TableからDataFrameへ変換
df2 = oss_parquet.to_pandas()

# DataFrameをCSVファイルとして出力
df2.to_csv("test2.csv")
```

## 番外編
Pandasを使わずにcsvファイルをparquetへETLすることもできます。
```python
import pyarrow as pa
import pyarrow.parquet as pq

df = pd.read_csv('./test.csv')
table = pa.Table.from_pandas(train)
pq.write_table(table, './parquet/test.parquet')
```

<br>

他にこちらも参考にいただければ幸いです。
[PyArrowでテキストファイルからParquetファイルを作成する方法](https://qiita.com/kusanoiskuzuno/items/eef36ba8dc23cd0828b1)
https://qiita.com/kusanoiskuzuno/items/eef36ba8dc23cd0828b1

[Apache SparkとPandasを使用したApache Arrowの使用方法](https://towardsdatascience.com/a-gentle-introduction-to-apache-arrow-with-apache-spark-and-pandas-bb19ffe0ddae)
https://towardsdatascience.com/a-gentle-introduction-to-apache-arrow-with-apache-spark-and-pandas-bb19ffe0ddae




