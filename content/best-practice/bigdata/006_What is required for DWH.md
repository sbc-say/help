---
title: "DWHには何が必要か"
description: "DWHを構築する上で大事なことを伝えます。"
date: 2019-08-30T00:00:00+00:00
weight: 60
draft: false
---

<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## DataLake、DWH、OLTP、OLAPについて
&nbsp; 本章ではDataLake、DWH、OLTP、OLAPについてを説明します。
* DataLakeとは、様々なデータを一点集約したデータのプールです。
* DWHとは、Data Ware House、二次三次利用できるよう処理済みのデータ基盤（テーブルたち）のことです。
* OLTPとは、Online Transaction Processing、オンライントランザクション処理のことです。
* OLAPとは、Online Analytic Processing、オンライン分析処理のことです。

&nbsp; BigDataを成功するためには、前章で記述した通り、BigDataから新しいビジネス意思決定に必要なデータや価値を発掘する必要があります。その鍵としてDWH構築の設計、基盤構築が必須となっています。以下、DataLakeとDWHの違いを記載します。

| |DataLake|DWH|
|---|---|---|
|構造|未使用データ|処理済み、過去データと連結したデータ|
|目的|外部データソースから集約する場所|分析基盤として利用する場所|
|利用ユーザ|外部データソース|分析エンジニア、データサイエンティスト、機械学習|


![BD_Images_What_is_required_for_DWH_001](../static_images/BD_Images_What_is_required_for_DWH_001.png)
<br>

&nbsp; BigData以前にMySQLやOracleなどリレーショナルデータベースでデータが肥えた時、古いデータを捨てたらいいのではないか？という意見がありますが、答えはNoです。
&nbsp; 過去の古いデータも含めてこれらはビジネス上必要な資産（財産）情報なので、これを捨てることなく蓄積し、これが次の世代や今後のビジネスへ結びつける必要があります。そうすることで、ビジネス上意思決定アプローチ、例えば製造業で過去データから異常製品を検出したり、店舗の売上が下がってる時は過去データと比較して原因追求することができます。同時に、ビジネスへ活かすことでBigDataに対する設備投資の回収も見込めます。MySQLやOracleなどリレーショナルデータベースの場合はデータの範囲が限られてるため、少ないストレージ要領で分析メイン利用であれば設備投資回収が難しいです。

![BD_Images_What_is_required_for_DWH_002](../static_images/BD_Images_What_is_required_for_DWH_002.png)
<br>

&nbsp; DWHを設計する上で特に意識したいことは以下の３点になります。
* データ収集、加工、処理が簡略化できる
* 容量を気にしない、長期的なデータ分できができる
* テーブル一本化（ファクトテーブル）で大規模加工処理や高速検索が可能
この３点を満たせば、DWHは分析基盤としても非常に有利になりますので、これらを意識して構築いただければと思います。

![BD_Images_What_is_required_for_DWH_003](../static_images/BD_Images_What_is_required_for_DWH_003.png)
<br>


## データ分析業務のミッション
&nbsp; データ分析業務のミッションとして、サービスを継続、成功へ導くために、様々なLogをDWHへ収集、蓄積し、KPI、データの見える化を実現、分析し次のステップへ進める様に取り組みます。図の様なワークフローになります。こちらも「収集・蓄積」、「収集・加工」、「分析」ででデータ容量に注目してください。
![BD_Images_What_is_required_for_DWH_004](../static_images/BD_Images_What_is_required_for_DWH_004.png)
<br>

上記、外部データからDataLakeへ収集、蓄積し、これを集計・加工、そして分析へといったワークフローがありますが、数千万レコードとか大規模データとなるとそう簡単には行かないです。そのために、OLTP、OLAPのアーキテクチャを持ったhadoopエコシステムでの処理が必要になります。

・OLTPは更新系（生成/挿入/更新/削除）、１行単位のスキャン
・OLAPは分析処理、select参照、フルスキャン

総じて、DHWがPB〜EB級でも更新できる、TB級の大規模データの分析難易度が鍵となります。

![BD_Images_What_is_required_for_DWH_005](../static_images/BD_Images_What_is_required_for_DWH_005.png)
![BD_Images_What_is_required_for_DWH_006](../static_images/BD_Images_What_is_required_for_DWH_006.png)
<br>

## BigDataプロダクトの組み合わせ例
&nbsp; 外部データソースから、データ分析業務へ結びつけるためには、それぞれのポジションにて様々なプロダクトを配置する必要があります。

![BD_Images_What_is_required_for_DWH_007](../static_images/BD_Images_What_is_required_for_DWH_007.png)
<br>

著書はAlibabaCloudでのDWH構築を軸として実現例をいくつか作成してみましたので、参考にいただければ幸いです。構築手法は別の章にて記載いたします。

![BD_Images_What_is_required_for_DWH_008](../static_images/BD_Images_What_is_required_for_DWH_008.png)
![BD_Images_What_is_required_for_DWH_009](../static_images/BD_Images_What_is_required_for_DWH_009.png)
<br>


![BD_Images_What_is_required_for_DWH_010](../static_images/BD_Images_What_is_required_for_DWH_010.png)
![BD_Images_What_is_required_for_DWH_011](../static_images/BD_Images_What_is_required_for_DWH_011.png)
<br>


![BD_Images_What_is_required_for_DWH_012](../static_images/BD_Images_What_is_required_for_DWH_012.png)
![BD_Images_What_is_required_for_DWH_013](../static_images/BD_Images_What_is_required_for_DWH_013.png)
![BD_Images_What_is_required_for_DWH_014](../static_images/BD_Images_What_is_required_for_DWH_014.png)
<br>


上記の例もありますが、他にプロダクトのアーキテクチャ構成図として以下の組み合わせもあります。汎用的で様々な使い方をイメージしたものですが、参考にしてください。
![BD_Images_What_is_required_for_DWH_015](../static_images/BD_Images_What_is_required_for_DWH_015.png)
<br>
![BD_Images_What_is_required_for_DWH_016](../static_images/BD_Images_What_is_required_for_DWH_016.png)
<br>
![BD_Images_What_is_required_for_DWH_017](../static_images/BD_Images_What_is_required_for_DWH_017.png)
<br>


## まとめ
&nbsp; AlibabaCloudのBigDataはシンプルかつ様々な基盤構築が簡単にできますので、データ分析業務へ結びつけることを意識してリソースを作成いただければと思います。

また、著者の経験上、大規模な分散システムを設計・構築する上で[非常に参考になる情報](https://blog.pragmaticengineer.com/distributed-architecture-concepts-i-have-learned-while-building-payments-systems/)がありますので、こちらも参考にいただければ幸いです。本テクニカルサイトでは記載しませんが、DWH構築〜BigData運用においてReactive Architectureや冪等性の重要さが伝わると思います。
https://blog.pragmaticengineer.com/

[分散アーキテクチャの概念](distributed-architecture-concepts-i-have-learned-while-building-payments-systems/)
distributed-architecture-concepts-i-have-learned-while-building-payments-systems/

[信頼できる方法で大規模な分散システムを運用する方法](https://blog.pragmaticengineer.com/operating-a-high-scale-distributed-system/)
https://blog.pragmaticengineer.com/operating-a-high-scale-distributed-system/
<br>










