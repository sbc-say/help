+++
title = "他社クラウドサービスとの比較一覧"
description = ""
weight = 2000
date= 2019-06-05T12:30:18+08:00
draft= false
+++

# AlibabaCloudでどんなサービスがあるか
AlibabaCloudというクラウドサービスにて2019年5月現在、中国版、国際版、日本版の３つのサービスが展開されているので、それぞれのサービス比較をまとめてみました。

[AlibabaCloudのサービスiconはこちら](https://www.iconfont.cn/plus/user/detail?&uid=41718)からダウンロードになります
https://www.iconfont.cn/plus/user/detail?&uid=41718

### 他クラウドサービスとの比較について
※ AlibabaCloud公式によるAWSとの比較は[こちらを参照](https://help.aliyun.com/document_detail/65455.html)。
https://help.aliyun.com/document_detail/65455.html

※ AlibabaCloud公式によるAzureとの比較は[こちらを参照](https://help.aliyun.com/document_detail/74242.html)。
https://help.aliyun.com/document_detail/74242.html

以降、GCP、AzureはAWSをベースに割り当ててみました。こちら@hayao_k 様のqitta記事も参考になりました。
参考：[AWS/Azure/GCPサービス比較 2019.05](https://qiita.com/hayao_k/items/906ac1fba9e239e08ae8)
https://qiita.com/hayao_k/items/906ac1fba9e239e08ae8

参考：AWS to Azure services comparison
https://docs.microsoft.com/ja-jp/azure/architecture/aws-professional/services

参考：AWS プロフェッショナルのための Google Cloud Platform
https://cloud.google.com/docs/compare/aws


## コンピューティング（弹性计算）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="ecs.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/786d26d5-c2bd-b7f6-f12c-2259031f26e0.png">|[云服务器 ECS](https://www.aliyun.com/product/ecs)|クラウドサーバ|[Elastic Compute Service](https://www.alibabacloud.com/product/ecs)|[Elastic Compute Service](https://jp.alibabacloud.com/product/ecs)|EC2|Virtual Machines|Compute Engine|
|<img width="80px" alt="ebm.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/a3fadfee-b994-be73-ef36-45ed8f133daf.png">|[弹性裸金属服务器（神龙）](https://www.aliyun.com/product/ebm)|Bare Metalクラウドサーバ|[ECS Bare Metal Instance](https://www.alibabacloud.com/product/ebm)|[ECS Bare Metal Instance](https://jp.alibabacloud.com/product/ebm)|EC2 Bare Metal|Virtual Machines|Compute Engine|
|<img width="80px" alt="swas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e61b6f71-89f0-69ed-e9e8-ccc1c79a4be3.png">|[轻量应用服务器](https://www.aliyun.com/product/swas)|軽量アプリケーションサーバー|[Simple Application Server](https://www.alibabacloud.com/product/swas)||||
|<img width="80px" alt="gpu.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e6b86ab6-de7a-673c-1102-29c80c2ecaaf.png">|[GPU 云服务器](https://www.aliyun.com/product/ecs/gpu)|GPUクラウドサーバ|[Elastic GPU Service](https://www.alibabacloud.com/product/gpu)|[Elastic GPU Service](https://jp.alibabacloud.com/product/gpu)|EC2 Elastic GPUs|Virtual Machines|Compute Engine|
|<img width="80px" alt="fpga.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/b78d5548-1563-b9cc-7750-ad55080bef5b.png">|[FPGA 云服务器](https://www.aliyun.com/product/ecs/fpga)|FPGAクラウドサーバ|||AWS EC2 FPGA|Virtual Machines|Compute Engine|
|<img width="80px" alt="ddh.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/11341987-9dfa-35e5-256a-7dbb9920adce.png">|[专有宿主机](https://www.aliyun.com/product/ddh)|専有ホスト|[Dedicated Host](https://www.alibabacloud.com/product/ddh)|[Dedicated Host](https://jp.alibabacloud.com/product/ddh)|||
|<img width="80px" alt="scc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/5828ba2c-98de-b63d-0589-a5a24aaed8db.png">|[超级计算集群](https://www.aliyun.com/product/scc)|スーパーコンピューティングクラスター（SCC）|[Super Computing Cluster](https://www.alibabacloud.com/product/scc)|[Super Computing Cluster](https://jp.alibabacloud.com/product/scc)|||
|<img width="80px" alt="ehpc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fea001fe-065c-770a-c503-9a6dccc7a211.png">|[弹性高性能计算 E-HPC](https://www.aliyun.com/product/ehpc)|高性能コンピューティング（E-HPC）|[E-HPC](https://www.alibabacloud.com/product/ehpc)|[E-HPC](https://jp.alibabacloud.com/product/ehpc)|High Performance Computing (HPC)||
|<img width="80px" alt="batchcompute.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/af6b6561-a486-1ec4-4b34-c26a2a524abe.png">|[批量计算](https://www.aliyun.com/product/batchcompute)|バッチ計算|[Batch Compute](https://www.alibabacloud.com/product/batch-compute)||||
|<img width="80px" alt="ContainerServie.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f8b4065a-cb32-f90b-ef17-8ee18d7187d4.png">|[容器服务](https://www.aliyun.com/product/containerservice)|コンテナサービス|[Container Service](https://www.alibabacloud.com/product/container-service)|[Container Service](https://jp.alibabacloud.com/product/container-service)|AWS ECS|Container Service|-|
|<img width="80px" alt="ContainerServie.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/263ab63a-1392-042d-b678-8b0d213a7ca0.png">|[容器服务 Kubernetes 版](https://www.aliyun.com/product/kubernetes)|コンテナサービスKubernetes版|[Container Service for Kubernetes](https://www.alibabacloud.com/product/kubernetes)|[Container Service for Kubenetes](https://jp.alibabacloud.com/product/kubernetes)|Elastic Container Service for Kubernetes|Kubernetes Service|Google Kubernetes Engine|
|<img width="80px" alt="ContainerServie.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/caa1a8fb-971e-0534-35da-9228034791d6.png">|[弹性容器实例 ECI](https://www.aliyun.com/product/eci)|サーバレスコンテナサービス|[Elastic Container Instance](https://www.alibabacloud.com/products/elastic-container-instance)||Fargate|Container Instance|-|
|<img width="80px" alt="acr.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/56b37b5a-aab7-657c-592a-0c018ad6e8e9.png">|[容器镜像服务](https://www.aliyun.com/product/acr)|コンテナミラーリングサービス|[Container Registry](https://www.alibabacloud.com/product/container-registry)||Elastic Container Registry|Container Registry|Google Container Registry|
|<img width="80px" alt="ess.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/02855f9d-bb16-90db-76e3-63cbcdeb9109.png">|[弹性伸缩](https://www.aliyun.com/product/ess)|Auto Scaling|[Auto Scaling](https://www.alibabacloud.com/product/auto-scaling)|[Auto Scaling](https://jp.alibabacloud.com/product/auto-scaling)|EC2 Auto Scaling|Virtual Machine Scale Sets|Autoscaling|
|<img width="80px" alt="ros.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/594c61fd-4fbe-0989-8063-4665db9a697f.png">|[资源编排](https://www.aliyun.com/product/ros)|リソースの作成と管理サービス|[Resource Orchestration Service](https://www.alibabacloud.com/product/ros)|[Resource Orchestration Service](https://jp.alibabacloud.com/product/ros)|AWS CloudFormation|Resource Manager|Cloud Deployment Manager|
|<img width="80px" alt="fc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/eff8057b-0abe-170d-896e-f97a6d2d0378.png">|[函数计算](https://www.aliyun.com/product/fc)|Function as a Service|[Function Compute](https://www.alibabacloud.com/product/function-compute)|[Function Compute](https://jp.alibabacloud.com/product/function-compute)|AWS Lambda|Functions|Cloud Functions|
|<img width="80px" alt="gws.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fe884fb5-c0e1-4c7a-c083-d0b3387f497b.png">|[图形工作站](https://www.aliyun.com/product/gws)|GPUワークステーション|||||


## ストレージ（存储服务）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="oss.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d2ddd85e-84e1-5c87-1e14-3f85954320e9.png">|[对象存储 OSS](https://www.aliyun.com/product/oss)|オブジェクトストレージ|[Object Storage Service](https://www.alibabacloud.com/product/oss)|[Object Storage Service](https://jp.alibabacloud.com/product/oss)|S3|Blob Storage|Cloud Storage|
|<img width="80px" alt="disk.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/a8479e12-76f1-2fba-5169-7b8433049c28.png">|[块存储](https://www.aliyun.com/product/disk)|ブロックストレージ|[Block Storage](https://www.alibabacloud.com/help/doc-detail/63136.htm)|[Block Storage](https://jp.alibabacloud.com/help/doc-detail/63136.htm)|EBS|Managed Disk|永続ディスク|
|<img width="80px" alt="nas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1a38366a-4045-70d8-7526-091b00cbc813.png">|[文件存储 NAS](https://www.aliyun.com/product/nas)|ファイルストレージNAS|[Network Attached Storage](https://www.alibabacloud.com/product/nas)|[Network Attached Storage](https://jp.alibabacloud.com/product/nas)|Elastic File System (EFS)|File Storage|Cloud Filestore|
|<img width="80px" alt="nas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1aed598e-1fff-568b-9678-ce15e0e51583.png">|[文件存储 CPFS](https://www.aliyun.com/product/nas_cpfs)|クラウドパラレルファイルストレージ|||||
|<img width="80px" alt="alidfs.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/817da01f-3122-335b-087f-dfde5930930d.png">|[文件存储 HDFS](https://www.aliyun.com/product/alidfs)|HDFSファイルストレージ|||||
|<img width="80px" alt="cloudphoto.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f197973c-5ebd-e646-255d-91a39d657994.png">|[智能云相册](https://www.aliyun.com/product/cloudphoto)|クラウドフォトアルバム|||||
|<img width="80px" alt="imm.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/cd5d4711-225e-ac2e-639d-7deaa84f8673.png">|[智能媒体管理](https://www.aliyun.com/product/imm)|インテリジェントメディア管理|||||
|<img width="80px" alt="hcs_sgw.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c70c4c33-97db-eaac-45b1-e7c4c6dcc7c3.png">|[云存储网关](https://www.aliyun.com/product/hcs)|クラウドストレージゲートウェイ|||AWS Storage Gateway|StorSimple|
|<img width="80px" alt="hgw.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1a2e36ac-6438-2c20-325f-ba963725b6c4.png">|[混合云存储阵列](https://www.aliyun.com/product/hgw)|ハイブリッドクラウドストレージアレイ|[Hybrid Cloud Storage Array](https://www.alibabacloud.com/product/storage-array)||||

## CDN配信（CDN与边缘）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="cdn.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fc168d4e-d47d-45cc-39a5-7f051405ed96.png">|[CDN](https://cn.aliyun.com/product/cdn)|Content Delivery Network|[Alibaba Cloud CDN](https://www.alibabacloud.com/product/cdn)|[Alibaba Cloud CDN](https://jp.alibabacloud.com/product/cdn)|CloudFront|CDN|Cloud CDN|
|<img width="80px" alt="SCDN.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e0a53701-f504-8b38-2e39-5c506a1b969a.png">|[安全加速 SCDN](https://cn.aliyun.com/product/scdn)|Secure Content Delivery Network|||||
|<img width="80px" alt="dcdn.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/4e09da62-8a10-b7ee-1d73-166b26cba156.png">|[全站加速 DCDN](https://cn.aliyun.com/product/dcdn)|Dynamic Route for CDN|[Dynamic Route for CDN](https://www.alibabacloud.com/products/dcdn)|[Dynamic route for CDN](https://jp.alibabacloud.com/products/dcdn)|||
|<img width="80px" alt="PCDN.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e4af9a1c-08b4-3ef6-08c8-66ffaee52e44.png">|[PCDN](https://cn.aliyun.com/product/pcdn)|P2P CDN|||||
|<img width="80px" alt="ens.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f96dd0d2-3cb7-5c0b-d5ee-2128d78f3760.png">|[边缘节点服务 ENS](https://cn.aliyun.com/product/ens)|Edge Node Service|||||

## データベース（数据库）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="100px" alt="POLARDB.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/635d4fa3-9bd6-4533-f2dc-c6a4c6ef9b21.png">|[云数据库 POLARDB](https://www.aliyun.com/product/polardb)|MySQL、Oracle、PostgreSQLの互換性があるクラウドデータベース|||Aurora||Cloud Spanner|
|<img width="100px" alt="rds_mysql.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d1242e82-a873-165e-d158-4b213ca40556.png">|[云数据库 RDS MySQL 版](https://www.aliyun.com/product/rds/mysql)|MySQL|[ApsaraDB RDS for MySQL](https://www.alibabacloud.com/product/apsaradb-for-rds-mysql)|[ApsaraDB for RDS(MySQL)](https://jp.alibabacloud.com/product/apsaradb-for-rds-mysql)|RDS for MySQL/Aurora|Database for MySQL|Cloud SQL for MySQL|
|<img width="100px" alt="rds_mariadb.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/a7f20415-5f94-d31d-196d-9403d5c22432.png">|[云数据库 RDS MariaDB TX 版](https://www.aliyun.com/product/rds/mariadb)|MariaDB|[ApsaraDB for MariaDB TX](https://www.alibabacloud.com/products/apsaradb-for-rds-mariadb)||RDS for MariaDB|Database for MariaDB|
|<img width="100px" alt="rds_sqlserver.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ccda4d73-2d92-0b48-761a-155886edad5b.png">|[云数据库 RDS SQL Server 版](https://www.aliyun.com/product/rds/sqlserver)|SQLServer|[ApsaraDB RDS for SQL Server](https://www.alibabacloud.com/product/apsaradb-for-rds-sql-server)|[ApsaraDB for RDS(SQL Server)](https://jp.alibabacloud.com/product/apsaradb-for-rds-sql-server)|RDS for SQL Server|SQL Database|Cloud SQL for SQL Server|
|<img width="100px" alt="rds_postgresql.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d9cbb39f-6290-8324-8cd1-d3cc4f349cb7.png">|[云数据库 RDS PostgreSQL 版](https://www.aliyun.com/product/rds/postgresql)|PostgreSQL|[ApsaraDB RDS for PostgreSQL](https://www.alibabacloud.com/product/apsaradb-for-rds-postgresql)|[ApsaraDB for RDS(PostgreSQL)](https://jp.alibabacloud.com/product/apsaradb-for-rds-postgresql)|RDS for PostgreSQL/Aurora|Database for PostgreSQL|Cloud SQL for PostgreSQL|
|<img width="100px" alt="rds_ppas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/9b6b9f73-14d6-8888-7e5e-14cc66dc4e6f.png">|[云数据库 RDS PPAS 版](https://www.aliyun.com/product/rds/ppas)|Oracle|[ApsaraDB RDS for PPAS](https://www.alibabacloud.com/product/apsaradb-for-rds-ppas)|[ApsaraDB for RDS(PPAS)](https://jp.alibabacloud.com/product/apsaradb-for-rds-ppas)|RDS for Oracle||
|<img width="100px" alt="drds.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0b21ed09-c6e7-99db-85ba-10a6ee88f734.png">|[分布式关系型数据库服务 DRDS](https://www.aliyun.com/product/drds)|分散リレーショナルデータベースサービス|[Distributed Relational Database Service](https://www.alibabacloud.com/product/drds)||Aurora||Cloud Spanner|
|<img width="100px" alt="redis.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ed455f7a-d446-c82c-ada1-5e3b18a73568.png">|[云数据库 Redis 版](https://www.aliyun.com/product/kvstore)|Redis|[ApsaraDB for Redis](https://www.alibabacloud.com/product/apsaradb-for-redis)|[ApsaraDB for Redis](https://jp.alibabacloud.com/product/apsaradb-for-redis)|ElastiCache (Redis)|Cache for Redis|Cloud Memorystore|
|<img width="100px" alt="mongodb.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0cdf7e6f-1e65-1694-4cfc-3b37c460766a.png">|[云数据库 MongoDB 版](https://www.aliyun.com/product/mongodb)|MongoDB|[ApsaraDB for MongoDB](https://www.alibabacloud.com/product/apsaradb-for-mongodb)|[ApsaraDB for MongoDB](https://jp.alibabacloud.com/product/apsaradb-for-mongodb)|DocumentDB (with MongoDB compatibility)|Cosmos DB(API for MongoDB)|
|<img width="100px" alt="hitsdb.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0053ad89-f4ac-10d1-8d44-c07dd6516da4.png">|[TSDB 时序时空数据库](https://www.aliyun.com/product/hitsdb)|時系列データベース|[High-Performance Time Series Database](https://www.alibabacloud.com/product/hitsdb)||Timestream|Time Series Insights|
|<img width="100px" alt="hbase.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e89a1a3c-4385-98ed-4cf7-5025090b4a9e.png">|[云数据库 HBase 版](https://cn.aliyun.com/product/hbase)|Apache Hbase|||||Cloud Bigtable|
|iconなし|[图数据库 GDB](https://www.aliyun.com/product/gdb)|グラフデータベース|||Neptune|Cosmos DB(API for Gremlin)|
|<img width="100px" alt="memcache.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/8837673c-29ce-6c8b-9b0e-d47430a8878f.png">|[云数据库 Memcache 版](https://www.aliyun.com/product/ocs)|Memcache|[ApsaraDB for Memcache](https://www.alibabacloud.com/product/apsaradb-for-memcache)|[ApsaraDB for Memcache](https://jp.alibabacloud.com/product/apsaradb-for-memcache)|ElastiCache (Memcached)||Cloud Memorystore|
|<img width="100px" alt="ots.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/46dbb2b4-324e-c106-6559-351fdfc9c78b.png">|[表格存储 TableStore](https://www.aliyun.com/product/ots)|TableStore(NoSQL)|[Table Store](https://www.alibabacloud.com/product/table-store)|[Table Store](https://jp.alibabacloud.com/product/table-store)|DynamoDB|Cosmos DB|Cloud Datastore|
|<img width="100px" alt="ads-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/2c74b5ff-f782-38d5-62d1-cd4902ccaab9.png">|[分析型数据库 MySQL版](https://www.aliyun.com/product/ads)|MySQLをベースにした分析データベース|||||
|<img width="100px" alt="HybridDB_for_Postgre.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1d0fafc4-b077-596f-c176-66a1a1ee4007.png">|[分析型数据库 PostgreSQL版](https://www.aliyun.com/product/gpdb)|DWH分析データベース|[HybridDB for PostgreSQL](https://www.alibabacloud.com/product/hybriddb-postgresql)|[AnalyticDB for PostgreSQL](https://jp.alibabacloud.com/product/hybriddb-postgresql)|Redshift|SQL Data Warehouse|Google BigQuery|
|<img width="100px" alt="HybridDB_for_MySQL.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/8123c91f-68dc-6927-4ea5-5f06e000fa6a.png">|[HybridDB for MySQL](https://www.aliyun.com/product/petadata)|HybridDB for MySQL|||||
|<img width="100px" alt="data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/8f129fec-3ad4-28c4-145f-58775a9cea75.png">|[Data Lake Analytics](https://www.aliyun.com/product/datalakeanalytics)|データレイクアナリティクス|[Data Lake Analytics](https://www.alibabacloud.com/products/data-lake-analytics)||Athena|Data Lake Analytics|Google BigQuery|
|<img width="100px" alt="dms.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/2bde9894-ec16-2751-563b-93376bcf7cef.png">|[数据管理 DMS](https://www.aliyun.com/product/dms)|データ管理サービス|||||
|<img width="100px" alt="hdm.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/670d788d-900d-145c-6654-85ad3425408f.png">|[混合云数据库管理 HDM](https://www.aliyun.com/product/hdm)|ハイブリッドクラウドデータベース管理サービス|||||


## クラウド通信サービス（云通信）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="dysms.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ee6d6441-75e7-98ce-4f52-b3fe203e9fb3.png">|[短信服务](https://www.aliyun.com/product/sms)|ショートメッセージサービス|||||
|<img width="80px" alt="dyvms.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1cea41fe-caef-33cc-6421-5e90db02eba8.png">|[语音服务](https://www.aliyun.com/product/vms)|音声メッセージサービス|||||
|<img width="80px" alt="dycdp.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/017f88c2-0c4a-23f3-29b9-32115287c939.png">|[流量服务](https://www.aliyun.com/product/cdps)|移動体通信データパッケージ|||||
|<img width="80px" alt="dyiot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f639c458-ba18-4d83-365d-b3d3bae48ddf.png">|[物联网无线连接服务](https://www.aliyun.com/product/olddyiot)|IoT無線通信接続サービス|||||
|iconなし|[号码隐私保护](https://www.aliyun.com/product/pls)|モバイルプライバシー保護サービス|||||
|<img width="80px" alt="dypns.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/15bee3ae-5fb9-484a-759d-e0038e93e351.png">|[号码认证服务](https://www.aliyun.com/product/dypns)|番号認証サービス|||||


## ネットワーク（网络）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[云通信网络加速](https://www.aliyun.com/product/snsu)|クラウド通信ネットワーク高速化サービス|||||
|<img width="80px" alt="vpc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f1d3f723-8c3a-c5c4-30ec-fe2632693229.png">|[专有网络 VPC](https://www.aliyun.com/product/vpc)|専用ネットワークVPC|[Virtual Private Cloud](https://www.alibabacloud.com/product/vpc)|[Virtual Private Cloud](https://jp.alibabacloud.com/product/vpc)|VPC|Virtual Network|Cloud VPN|
|<img width="80px" alt="pvtz.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e0077554-3e1d-a0fe-b98c-5b45dc58f3dc.png">|[云解析 PrivateZone](https://www.aliyun.com/product/pvtz)|VPCのDNSサービス|[Alibaba Cloud PrivateZone](https://www.alibabacloud.com/products/private-zone)||||
|<img width="80px" alt="slb.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1c98e9b5-2561-56a4-d408-7c4a8052b3ba.png">|[负载均衡 SLB](https://www.aliyun.com/product/slb)|負荷分散ロードパランサ|[Server Load Balancer](https://www.alibabacloud.com/product/server-load-balancer)|[Server Load Balancer](https://jp.alibabacloud.com/product/server-load-balancer)|AWS Global Accelerator|Traffic Manager|Cloud Load Balancing|
|<img width="80px" alt="nat.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/b42178cb-55c7-c6f0-7187-dae964b87c2f.png">|[NAT 网关](https://www.aliyun.com/product/nat)|NATゲートウェイ|[NAT Gateway](https://www.alibabacloud.com/product/nat)|[NAT Gateway](https://jp.alibabacloud.com/product/nat)|Internet Gateway、NAT Instance、NAT Gateway||
|<img width="80px" alt="eip.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c3eceb88-6ba2-c4a2-d0d2-a0dd85eb2a3f.png">|[弹性公网 IP](https://www.aliyun.com/product/eip)|パブリックIPリソース|[Elastic IP](https://www.alibabacloud.com/product/eip)|[Elastic IP](https://jp.alibabacloud.com/product/eip)|Elastic IP Addresses||
|iconなし|[IPv6 转换服务](https://www.aliyun.com/product/ipv6)|IPv6変換サービス|||||
|<img width="80px" alt="ipv6gateway.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/841d7d7e-e055-7360-9844-c089784a0e2e.png">|[IPv6 网关](https://cn.aliyun.com/product/ipv6gateway)|IPv6ゲートウェイ|||||
|<img width="80px" alt="alidnsgtm.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/26bd1d39-3b30-b16a-b83f-d0cb87d0bf37.png">|[全局流量管理](https://help.aliyun.com/product/85188.html)|Global Traffic Manager|[Global Traffic Manager](https://www.alibabacloud.com/help/doc-detail/86630.htm)|[Global Traffic Manager](https://jp.alibabacloud.com/products/global-traffic-manager)|Route 53（Traffic policy)|Traffic Manager|Global Load Balancing|
|iconなし|[共享带宽](https://www.aliyun.com/product/cbwp)|帯域幅共有サービス|||||
|<img width="80px" alt="flowbag.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f66e8fb9-5883-52a1-c3b3-0bf672ac9819.png">|[共享流量包](https://www.aliyun.com/product/flowbag)|クラウド間のデータ転送|[Data Transfer Plan](https://www.alibabacloud.com/products/data-transfer-plan)||||Cloud Storage Transfer Service|
|<img width="80px" alt="cen.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/29826467-8bfc-e1f8-7cec-e86b71321df5.png">|[云企业网](https://www.aliyun.com/product/cbn)|Cloud Enterprise Network|[Cloud Enterprise Network](https://www.alibabacloud.com/product/cen)|[Cloud Enterprise Network](https://jp.alibabacloud.com/product/cen)|||
|<img width="80px" alt="VPN.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/71a561d9-f193-e9f1-3ef8-ece1394b15e8.png">|[VPN 网关](https://www.aliyun.com/product/vpn)|VPNゲートウェイ|[VPN Gateway](https://www.alibabacloud.com/product/vpn-gateway)|[VPN Gateway](https://jp.alibabacloud.com/product/vpn-gateway)|VPN Gateway||
|<img width="80px" alt="smartag.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e251eada-b40b-3816-4bc5-0701bf59dfba.png">|[智能接入网关（邀测中）](https://www.aliyun.com/product/smartag)|オンプレミスからのデータ転送|[Smart Access Gateway](https://www.alibabacloud.com/products/smart-access-gateway)||AWS DataSync||
|<img width="80px" alt="expressconnect.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/00d7366e-e040-76ea-7b0e-794e18309e92.png">|[高速通道](https://www.aliyun.com/product/expressconnect)|専用線接続|[Express Connect](https://www.alibabacloud.com/product/express-connect)|[Express Connect](https://jp.alibabacloud.com/product/express-connect)|AWS Direct Connect|ExpressRoute|Dedicated Interconnect|


## 基本的なセキュリティ（基础安全）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="ddospro.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/574b71e3-e415-fda4-7ca3-6fac5e43b6fb.png">|[DDoS高防IP](https://www.aliyun.com/product/ddos)|DDoS 対策 (DDoS Pro)|[Anti-DDoS Pro](https://www.alibabacloud.com/product/ddos-pro)||||
|<img width="80px" alt="ddos.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f9b13f87-de96-7aae-ba53-3c9a7731f9ac.png">|[DDoS基础防护服务](https://www.aliyun.com/product/ddos)|DDoS 対策 (DDoS Basic)|[Anti-DDoS Basic](https://www.alibabacloud.com/product/anti-ddos)|[Anti-DDoS Basic](https://jp.alibabacloud.com/product/anti-ddos)|AWS Shield Standard|DDoS Protection|
|<img width="80px" alt="ddosdip.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/136b5b70-23ca-1de3-297f-08862d30057d.png">|[DDoS高防（国际）](https://www.aliyun.com/product/ddos)|DDoS 対策 (Premium)|[Anti-DDoS Premium](https://www.alibabacloud.com/products/ddosdip)||AWS Shield Advanced|DDoS Protection|Cloud Armor|
|<img width="80px" alt="ddosbgp.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/76dbd5c5-03af-f471-baa9-6605d796f733.png">|[新BGP高防IP](https://cn.aliyun.com/product/ddos)|DDoS 対策 (DDoS BGP)|||||
|<img width="80px" alt="waf.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/a529cb94-59d0-eeb6-1626-b37e19966b3f.png">|[Web应用防火墙](https://www.aliyun.com/product/waf)|Webアプリケーションファイアウォール|[Web Application Firewall](https://www.alibabacloud.com/product/waf)|[Web Application Firewall](https://jp.alibabacloud.com/product/waf)|AWS WAF|Application Gateway|Cloud Armor|
|<img width="80px" alt="sas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e9f1944d-8eb0-bdff-a989-1172badfb1a6.png">|[云安全中心（态势感知）](https://www.aliyun.com/product/sas)|クラウドセキュリティセンター|[Threat Detection Service](https://www.alibabacloud.com/products/sas)||||
|<img width="80px" alt="shc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0c7bee7a-605a-7acb-d072-fadfde012256.png">|[云盾混合云](https://cn.aliyun.com/product/shc)|クラウド、IDC、ハイブリッドクラウドでのセキュリティ保護サービス|||||
|<img width="80px" alt="aegis.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e7ee9f21-b5d3-fb1d-b6fd-cc89e48dd9cb.png">|[云安全中心（安骑士）](https://www.aliyun.com/product/aegis)|ホストセキュリティソフトウェア|[Server Guard](https://www.alibabacloud.com/product/server-guard)||||
|<img width="80px" alt="cfw.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0f24f82f-9179-4be2-a0ca-36d46180184d.png">|[云防火墙](https://www.aliyun.com/product/cfw)|クラウドファイアウォール|||AWS Firewall Manager|Firewall|
|<img width="80px" alt="bastionhost.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/84495313-e809-11d9-85c1-ec39bd8c569c.png">|[堡垒机](https://www.aliyun.com/product/bastionhost)|セキュリティ監査管理プラットフォーム|||||
|<img width="80px" alt="avds.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/bb8231a7-856d-d5ee-bb28-dd113dbe3645.png">|[漏洞扫描](https://www.aliyun.com/product/wti)|脆弱性スキャンサービス|||||
|<img width="80px" alt="avds.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1d4a37b7-ad73-5b26-e2b9-55d58dd8e623.png">|[网站威胁扫描系统](https://cn.aliyun.com/product/avds)|Webサイト脅威スキャンサービス|[Website Threat Inspector](https://www.alibabacloud.com/product/avds)||GuardDuty|Security Center|Cloud Security Command Center|


## アイデンティティ管理（身份管理）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="ram.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fc5e5304-26fd-1514-2067-3487515959b5.png">|[访问控制](https://www.aliyun.com/product/ram)|アカウント権限管理|[Resource Access Management](https://www.alibabacloud.com/product/ram)|[Resource Access Management](https://jp.alibabacloud.com/product/ram)|AWS Identity and Access Management|Active Directory|Cloud IAM|

## データセキュリティ（数据安全）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="cas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0ce10e46-2398-f36e-9477-b3dc02cb09a6.png">|[SSL 证书](https://www.aliyun.com/product/cas)|SSL/TLS証明書管理サービス|[SSL Certificates Service](https://www.alibabacloud.com/product/certificates)|[SSL Certificates Service](https://jp.alibabacloud.com/product/certificates)|AWS Certificate Manager|App Service Certificates|Google-managed SSL certificates|
|<img width="80px" alt="dbaudit.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/5603f9d5-5dd7-7b14-a570-a1d90b9018ea.png">|[数据库审计](https://www.aliyun.com/product/dbaudit)|データベース監査サービス|||||
|<img width="80px" alt="hsm.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c0fe57d8-87e1-bce5-0bbd-bbb9f58b0222.png">|[加密服务](https://www.aliyun.com/product/hsm)|暗号化サービス|||||
|iconなし|[敏感数据保护](https://cn.aliyun.com/product/sddp)|機密データ保護サービス|||AWS Secrets Manager|Key Vault|
|<img width="193" alt="kms.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/8a4cfa4a-c096-1f89-6468-8d09279ce141.png">|[密钥管理服务](https://www.aliyun.com/product/kms)|キー管理|[Key Management Service](https://www.alibabacloud.com/product/key-management-service)|[Key Management Service](https://jp.alibabacloud.com/product/key-management-service)|AWS Key Management Service, AWS CloudHSM, AWS Secrets Manager|Key Vault|Cloud Key Management Service|

## ビジネスセキュリティ（业务安全）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="gameshield.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1ea8de78-c06c-3b35-b0ca-d4d6e22617c0.png">|[游戏盾](https://www.aliyun.com/product/GameShield)|ゲームシールド|[GameShield](https://www.alibabacloud.com/product/gameshield)||||
|<img width="80px" alt="lvwang.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/66737843-c9e7-cc87-65b9-b295361d3d39.png">|[内容安全](https://www.aliyun.com/product/lvwang)|コンテンツセキュリティ|[Content Moderation](https://www.alibabacloud.com/product/content-moderation)||||
|<img width="80px" alt="saf.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/7dbc6e01-02e4-fd73-8d8d-dfd32790ed4f.png">|[风险识别](https://www.aliyun.com/product/saf)|リスク識別と特定サービス|||||
|<img width="80px" alt="cloudauth.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/283f4d30-3dc4-4f99-0681-192e147b7d72.png">|[实人认证](https://www.aliyun.com/product/cloudauth)|人物識別・認証サービス|||||
|<img width="80px" alt="antibot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f075ca8d-cdfe-47b8-37dd-266f6f7e39fc.png">|[爬虫风险管理](https://www.aliyun.com/product/antibot)|Webクローラーやbotから防御するサービス|[Anti-Bot Service](https://www.alibabacloud.com/product/antibot)||||

## セキュリティサービス(安全服务)
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="sos.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/6fc0e10f-7741-f4a0-e0a2-0469ecdf8045.png">|[安全管家](https://www.aliyun.com/product/sos)|セキュリティテクノロジおよびコンサルティングサービス|[Managed Security service](https://www.alibabacloud.com/product/mss)||||
|iconなし|[渗透测试](https://www.aliyun.com/product/pt)|侵入テスト|||||
|<img width="80px" alt="xianzhi.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/6c3bcaa6-f17a-3a26-bbaa-ae5b06c37206.png">|[安全众测](https://www.aliyun.com/product/xianzhi)|セキュリティテスト|||Inspector|Security Center|Cloud Security Command Center|
|iconなし|[等保咨询](https://www.aliyun.com/product/xianzhi/mlpse)|セキュリティコンサルティングサービス|||Inspector|Security Center|Cloud Security Command Center|
|iconなし|[应急响应](https://www.aliyun.com/product/yundun_incident_response)|セキュリティ緊急対応サービス|||||
|iconなし|[漏洞扫描](https://www.aliyun.com/product/xianzhi_Vulnerabilityscanning)|脆弱性スキャンサービス|||||
|iconなし|[安全培训](https://www.aliyun.com/product/xianzhi_securitytrain)|セキュリティトレーニング|||||
|iconなし|[安全评估](https://www.aliyun.com/product/xianzhi_online_car-hailing)|セキュリティ評価サービス|||||
|iconなし|[代码审计](https://www.aliyun.com/product/xianzhi_codeaudit)|ソースコード監査|||||
|iconなし|[安全加固](https://www.aliyun.com/product/xianzhi_securityconsolidate)|セキュリティ強化サービス|||||
|iconなし|[安全通告](https://www.aliyun.com/product/xianzhi_SecurityNotificationService)|セキュリティ監視通知サービス|||||
|iconなし|[PCI DSS合规咨询](https://www.aliyun.com/product/xianzhi_PCIDSS)|PCI DSSサービス|||||

## ビッグデータ計算（大数据计算）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|:--:|---|---|---|---|---|---|---|
|<img width="80px" alt="odps-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/7c8da502-9179-55ba-b2ef-29fc14e479f2.png">|[MaxCompute](https://www.aliyun.com/product/odps)|MaxCompute|[MaxCompute](https://www.alibabacloud.com/product/maxcompute)|[MaxCompute](https://jp.alibabacloud.com/product/maxcompute)|Redshift|SQL Data Warehouse|BigQuery|
|<img width="80px" alt="emr.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/34774a4b-4d75-c493-6475-8ac87a4f3202.png">|[E-MapReduce](https://www.aliyun.com/product/emapreduce)|E-MapReduce、Hadoopクラスタの展開|[E-MapReduce](https://www.alibabacloud.com/products/emapreduce)|[E-Mapreduce](https://jp.alibabacloud.com/products/emapreduce)|EMR|HDInsight|Cloud Datalab, Cloud Dataproc|
|<img width="80px" alt="sc-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1f4e3b9b-b0a8-b8ac-4ddc-7d07e5553a44.png">|[实时计算](https://data.aliyun.com/product/sc)|Realtime Compute（元はApache Flink）|[Realtime Compute](https://www.alibabacloud.com/products/realtime-compute)|[Realtime Compute](https://jp.alibabacloud.com/products/realtime-compute)|||

## データの可視化（数据可视化）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="datav-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d7f96014-0d07-5d6c-6077-74c1dc21e7d7.png">|[DataV数据可视化](https://data.aliyun.com/visual/datav)|DataV、データの可視化|[DataV](https://www.alibabacloud.com/product/datav)|[DataV](https://jp.alibabacloud.com/product/datav)|||

## ビッグデータの検索と分析（大数据搜索与分析）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="graphanalytics.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/8a254707-e3cd-6b0b-0ecd-a5a4e9d923d3.png">|[开放搜索](https://www.aliyun.com/product/opensearch)|分散検索エンジンプラットフォーム|||CloudSearch|Search|
|<img width="80px" alt="sls.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/249941ab-4225-2f75-6a39-919810622f62.png">|[日志服务](https://www.aliyun.com/product/sls)|各種ログの一元管理|[Log Service](https://www.alibabacloud.com/product/log-service)|[Log Service](https://jp.alibabacloud.com/product/log-service)|Kinesis, SQS|Event Hubs, Stream Analytics|Cloud Dataflow, Cloud Pub/Sub|
|<img width="80px" alt="elasticsearch.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fd3f288b-183d-18f9-cdb0-933c7801024b.png">|[Elasticsearch](https://data.aliyun.com/product/elasticsearch)|ElasticSearch|[Elasticsearch](https://www.alibabacloud.com/product/elasticsearch)|[Elasticsearch](https://jp.alibabacloud.com/product/elasticsearch)|Elasticserach Service||
|<img width="80px" alt="graphanalytics-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f55b1052-c62a-d840-c864-985085cac01e.png">|[关系网络分析](https://data.aliyun.com/product/graphanalytics)|リレーショナルネットワーク分析|||||
|<img width="80px" alt="porana-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/7ed239b1-ccb0-c5ee-dbaf-505adc15edcc.png">|[画像分析](https://data.aliyun.com/product/porana)|画像分析サービス|||||
|<img width="80px" alt="prophet-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ff02ba86-7472-3c05-c4cf-21a34065b6cb.png">|[公众趋势分析](https://data.aliyun.com/product/prophet)|トレンド分析サービス|||||
|<img width="80px" alt="bi-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/4a83e7b6-3373-4a0b-fccf-55317c0991ea.png">|[Quick BI](https://data.aliyun.com/product/bi)|BIツール|[Quick BI](https://www.alibabacloud.com/product/quickbi)|[Quick BI](https://jp.alibabacloud.com/product/data-integration)|QuickSight|Power BI|Data Studio|

## データ開発（数据开发）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="dide.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f80d2e38-66eb-07c7-eddf-d2dfb6a167e6.png">|[DataWorks](https://data.aliyun.com/product/ide)|データの可視化|[DataWorks](https://www.alibabacloud.com/product/ide)|[DataWorks](https://jp.alibabacloud.com/product/ide)|||
|<img width="80px" alt="dataphin.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/7c864e0d-b298-d248-9008-6e3f6caf9df8.png">|[Dataphin](https://www.aliyun.com/product/dataphin)|データ構築と管理サービス|[Dataphin](https://www.alibabacloud.com/product/dataphin)||||
|<img width="80px" alt="datahub-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/367d0a8b-4d67-d4d7-cf90-1c9c3cda242f.png">|[阿里云DataHub](https://data.aliyun.com/product/datahub)|ストリーム処理|||Kinesis, SQS|Event Hubs, Stream Analytics|Cloud Dataflow, Cloud Pub/Sub|
|<img width="80px" alt="cdp-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ab3a679d-e76f-804e-e9d1-8651bd1c87e4.png">|[数据集成](https://www.aliyun.com/product/cdp)|データ統合|[Data Integration](https://www.alibabacloud.com/product/data-integration)|[Data Integration](https://jp.alibabacloud.com/product/data-integration)|||

## データのレコメンデーション（数据开发）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="eprofile-data.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/92a0c839-14f4-d023-5044-efdf076d4bca.png">|[企业图谱](https://data.aliyun.com/product/eprofile)|コーポレートマップ|||||
|iconなし|[智能推荐](https://www.aliyun.com/product/airec)|スマートレコメンデーション|||||

## インテリジェントな音声対話（智能语音交互）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="nlsfilebag.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/dea74dd2-c010-0230-2cd0-b53da671d169.png">|[录音文件识别](https://ai.aliyun.com/nls/filetrans)|録音ファイルの認識（Speech-to-Text）|||Transcribe|Speech Services|Cloud Speech-to-Text|
|<img width="80px" alt="nlsasrbag.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/0eed050a-a46e-7c77-de68-b8eedb95ecbf.png">|[实时语音转写](https://ai.aliyun.com/nls/trans)|リアルタイム音声転写|||||
|<img width="80px" alt="nlsshortasrbag.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/727720b0-e6d5-48c5-1d8f-4d7865a061cc.png">|[一句话识别](https://ai.aliyun.com/nls/asr)|一文認識（Text-to-Speech）|||Polly|Speech Services|Cloud Text-to-Speech|
|<img width="80px" alt="nlsttsbag.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/6885e59c-ad19-c1a3-dc02-bf9b48411beb.png">|[语音合成](https://ai.aliyun.com/nls/tts)|音声合成|||||
|<img width="80px" alt="nls.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/40cb7ff0-ad80-0531-c4dc-148c439cf8e4.png">|[语音合成声音定制](https://ai.aliyun.com/nls/customtts)|音声データの合成およびカスタマイズ|||||
|<img width="80px" alt="nlsasrcustommodel.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d49690c0-7c3f-b239-8f3e-484ad7992a4c.png">|[语音模型自学习工具](https://ai.aliyun.com/nls/lmlearning)|音声モデル自己学習ツール|||||

## 画像検索（图像搜索）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="imagesearch.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/aa4600fe-70ee-3e81-69a8-beb25c161e9d.png">|[图像搜索](https://ai.aliyun.com/imagesearch)|画像検索|[Image Search](https://www.alibabacloud.com/product/imagesearch)|[Image Search](https://jp.alibabacloud.com/product/imagesearch)|||

## 自然言語処理（自然语言处理）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="nlpws.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/880a4480-ee90-c603-4fbd-123c56414289.png">|[多语言分词](https://ai.aliyun.com/nlp/ws)|テキスト上の多言語の単語・分詞の分割サービス|||Comprehend|Language Understanding|Cloud Natural Language|
|<img width="80px" alt="nlppos.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fd19d307-5e99-bd3c-f168-41b8d1e4c2fc.png">|[词性标注](https://ai.aliyun.com/nlp/pos)|品詞タグ付けの一部|||||
|<img width="80px" alt="nlpner.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f86cb395-5faf-da5f-0b39-1050caeec1ce.png">|[命名实体](https://ai.aliyun.com/nlp/ner)|名前付きエンティティ|||||
|<img width="80px" alt="nlpsa.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/7b19e9a4-8b3a-b4d2-6f72-cb86f07981d9.png">|[情感分析](https://ai.aliyun.com/nlp/sa)|感情分析|||||
|<img width="80px" alt="nlpke.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ca4487f6-36ed-79f2-ed5f-cfd854890094.png">|[中心词提取](https://ai.aliyun.com/nlp/ke)|中心語抽出|||||
|<img width="80px" alt="nlpke.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/96dca141-1958-93fb-2066-2c6720c46881.png">|[智能文本分类](https://ai.aliyun.com/nlp/tc)|インテリジェントテキスト分類|||||
|<img width="80px" alt="nlpke.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/08ed447c-5f6f-9dce-8bd3-4bc02e91f8c1.png">|[文本信息抽取](https://ai.aliyun.com/nlp/ie)|テキスト情報抽出|||||
|<img width="80px" alt="nlpra.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e56efb0b-c962-a20c-6f17-18708bcfcf89.png">|[商品评价解析](https://ai.aliyun.com/nlp/ra)|製品レビューの評価分析|||||

## 印刷テキスト認識（印刷文字识别）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/eee1f5e3-df77-688d-cc24-ec9bd365f14a.png">|[通用型卡证类](https://ai.aliyun.com/ocr/card)|IDカード、銀行カード、パスポートなどカード識別サービス|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/58025451-45ee-b12d-d376-bf796b09677b.png">|[汽车相关识别](https://ai.aliyun.com/ocr/vehicle)|免許証・ナンバープレートなど自動車関連データの識別サービス|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c7b7b252-8cf4-5228-7640-b503a11adc2d.png">|[行业票据识别](https://ai.aliyun.com/ocr/invoice)|請求書・領収書の識別サービス|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c7b7b252-8cf4-5228-7640-b503a11adc2d.png">|[资产类识别](https://ai.aliyun.com/ocr/certification)|資産証明書など各証明書識別サービス|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c7b7b252-8cf4-5228-7640-b503a11adc2d.png">|[通用文字识别](https://ai.aliyun.com/ocr/general)|画像データのテキスト認識|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c7b7b252-8cf4-5228-7640-b503a11adc2d.png">|[行业文档类识别](https://ai.aliyun.com/ocr/document)|業界文書データのテキスト認識サービス|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c7b7b252-8cf4-5228-7640-b503a11adc2d.png">|[视频类文字识别](https://ai.aliyun.com/ocr/video)|ビデオデータ内の字幕および文字テキスト認識サービス|||||
|<img width="80px" alt="ocr_card.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c7b7b252-8cf4-5228-7640-b503a11adc2d.png">|[自定义模板识别](https://ai.aliyun.com/ocr/template)|ORCカスタムテンプレートを作成し認識するサービス|||||

## 顔認識（人脸识别）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="face.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/5e296e57-0fb0-70fb-77aa-5884dae83c47.png">|[人脸识别](https://ai.aliyun.com/face)|顔認識|||||

## 機械翻訳（机器翻译）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="alimt.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/45db3399-c150-e820-0445-72399e5d6f38.png">|[机器翻译](https://ai.aliyun.com/alimt)|機械翻訳|||Translate|Translator Text|Cloud Translation|

## 画像認識（图像识别）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/94fc3c89-33a4-68ae-3726-232ab001b998.png">|[图像识别](https://ai.aliyun.com/image)|画像認識|||Rekognition|Computer Vision|Cloud Vision|

## コンテンツセキュリティ（内容安全）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[图片鉴黄](https://ai.aliyun.com/lvwang/imgadult)|ポルノコンテンツ認識|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[图片涉政暴恐识别](https://ai.aliyun.com/lvwang/imgterrorism)|写真データからテロ画像や政治的問題画像識別サービス|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[图片Logo商标检测](https://ai.aliyun.com/lvwang/imglogo)|画像からロゴ検出サービス|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[图片垃圾广告识别](https://ai.aliyun.com/lvwang/imgad)|画像スパム認識|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[图片不良场景识别](https://ai.aliyun.com/lvwang/imglive)|薬物使用、ギャンブルなどの不適切なコンテンツ認識サービス|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[图片风险人物识别](https://ai.aliyun.com/lvwang/imgsface)|画像から人物特定リスク識別サービス|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[视频风险内容识别](https://ai.aliyun.com/lvwang/video)|ビデオリスクのコンテンツ認識|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[文本反垃圾识别](https://ai.aliyun.com/lvwang/text)|テキストリスクのコンテンツ認識|||||
|<img width="80px" alt="Image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/90d6060f-6572-45c7-efc3-3578f53efbc2.png">|[语音垃圾识别](https://ai.aliyun.com/lvwang/audio)|音声データのリスク識別サービス|||||

## 機械学習プラットフォーム（机器学习平台）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="learn.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/6199513d-f6c8-552c-243a-5498cff69e63.png">|[机器学习平台 PAI](https://data.aliyun.com/product/learn)|機械学習プラットフォームPAI|[Machine Learning Platform For AI](https://www.alibabacloud.com/product/machine-learning)||SageMaker|Machine Learning Service|Cloud ML Engine|
|iconなし|[人工智能众包](https://www.aliyun.com/product/aicrowd)|AIによるクラウドソーシング|||||

## ドメイン名とウェブサイト（域名与网站）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="wanwang.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/085216a2-05da-d6eb-4ed0-9a27fd0ab8fe.png">|[域名注册](https://wanwang.aliyun.com/)|ドメイン登録サービス|||||
|<img width="80px" alt="ews.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/06cfd452-4fd2-40ef-8e4a-18e7c4250cff.png">|[域名交易](https://mi.aliyun.com/)|ドメイン名取引サービス|||||
|<img width="80px" alt="jianzhan.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/3f65e58e-132d-e2ee-65fc-41384b75c9d3.png">|[网站建设](https://www.aliyun.com/jianzhan)|ウェブサイト構築サポートサービス|||||
|<img width="80px" alt="hosting.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d7533c4c-2910-e5a6-6c16-a32831ae7b7d.png">|[云虚拟主机](https://wanwang.aliyun.com/hosting)|クラウド仮想ホスト|[Web Hosting](https://www.alibabacloud.com/product/hosting)||||
|<img width="80px" alt="chinaglobal_promotion_virtual2017.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/255cef16-34b0-afb8-57e1-c32170de3c05.png">|[海外云虚拟主机](https://www.aliyun.com/chinaglobal/promotion/virtual2017)|国外Webホスティング設置サービス|||||
|<img width="80px" alt="domain_dns.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/bbaa510a-3d55-9708-6dab-1baa3def28be.png">|[云解析 DNS](https://wanwang.aliyun.com/domain/dns)|DNS|[Domains](https://www.alibabacloud.com/domain)|[Alibaba Cloud DNS](https://jp.alibabacloud.com/product/dns)|Route 53|DNS|Cloud DNS|
|<img width="80px" alt="hosting_elastic.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/57df5f05-4fb7-f5ce-1b25-e65676063d1e.png">|[弹性Web托管](https://wanwang.aliyun.com/hosting/elastic)|柔軟なWebホスティング|||Elastic Beanstalk|App Service|App Engine|
|iconなし|[备案](https://beian.aliyun.com/)|ドメイン登録(IPC)のためのICP代替申請サービス|||||

## 知的財産サービス（知识产权服务）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="trademark.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/9b3a172e-3bc6-ed7e-15ed-f0b4fa92f8eb.png">|[商标注册](https://tm.aliyun.com/)|商標登録サービス|||||
|<img width="80px" alt="trademark.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/5a9d5b99-0c41-ee86-c1ab-892036741e99.png">|[商标交易](https://www.aliyun.com/acts/domain/tmtransaction)|商標登録されてるものを購入するサービス|||||

## 申請サービス（应用服务）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[机器人流程自动化 RPA](https://www.aliyun.com/product/codestore)|RPA|||||
|<img width="80px" alt="clouddesktop.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/a6537aeb-451a-9874-2525-e422d7b3e5b4.png">|[云桌面](https://www.aliyun.com/product/clouddesktop)|クラウドデスクトップ|||||
|<img width="80px" alt="cloudap.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/bfea7215-2fc6-37ce-3375-e020cbc9f604.png">|[云AP](https://www.aliyun.com/product/cloudap)|クラウドAP|||||
|<img width="80px" alt="apigatewayapi.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/37d88447-7d8f-4123-211f-c849761c56a3.png">|[API 网关](https://www.aliyun.com/product/apigateway)|API管理|[API Gateway](https://www.alibabacloud.com/product/api-gateway)|[API Gateway](https://jp.alibabacloud.com/product/api-gateway)|API Gateway|API Management|Cloud Endpoints/Apigee|
|<img width="80px" alt="mail.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/bb294c83-f0b6-65cb-b1ea-382741d43db3.png">|[企业邮箱](https://wanwang.aliyun.com/mail)|ビジネスメールボックス|[Alibaba Mail](https://www.alibabacloud.com/products/alibaba-mail)||||
|<img width="80px" alt="directmail.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1ce0dc55-8165-89c9-83e5-d5388bdfcd5f.png">|[邮件推送](https://www.aliyun.com/product/directmail)|メール送受信サービス|[DirectMail](https://www.alibabacloud.com/product/directmail)||Simple Email Service||

## インテリジェントデザインサービス（智能设计服务）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[鹿班](https://www.aliyun.com/product/luban)|画像自動生成サービス|||||

## モバイルクラウド（移动云）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="cps.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/617b9c66-a6bf-3f22-4117-d979086ca96e.png">|[移动推送](https://www.aliyun.com/product/cps)|モバイルアプリの通知とメッセージングサービス|||||
|<img width="80px" alt="hotfix.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1f4ee9ab-3c33-1d72-305a-c738a7f788b7.png">|[移动热修复](https://www.aliyun.com/product/hotfix)|モバイルサービスのhot-fixサービス|||||
|<img width="80px" alt="mobiletesting.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/79920f43-0fa1-2195-b6c6-f388884f3e00.png">|[移动测试](https://www.aliyun.com/product/mqc)|モバイルテストサービス|||AWS Device Farm||Cloud Test Lab|
|<img width="80px" alt="mas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e779636e-75f0-e1c9-349a-89a8bae21c4b.png">|[移动数据分析](https://www.aliyun.com/product/man)|モバイルアプリデータ統計サービス|||||
|<img width="80px" alt="feedback.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/423e20f0-ace0-04a0-5f91-8f0c1015fdd2.png">|[移动用户反馈](https://www.aliyun.com/product/feedback)|モバイルアプリからのフィードバックサービス|||||
|iconなし|[HTTPDNS](https://www.aliyun.com/product/httpdns)|モバイル開発者向けのドメイン名解決サービス|||||

## ビデオクラウド（视频云）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="120px" alt="rtc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ac6d7ff8-2bfd-4fdb-9a00-b74bd65a824c.png">|[音视频通信 RTC](https://www.aliyun.com/product/rtc)|オーディオとビデオ通信RTC|||||
|<img width="120px" alt="live.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e7fa7163-5b3f-b028-8ca5-256bc2300e87.png">|[视频直播](https://www.aliyun.com/product/live)|ライブビデオ|[ApsaraVideo Live](https://www.alibabacloud.com/product/apsaravideo-for-live)|[ApsaraVideo Live](https://jp.alibabacloud.com/product/apsaravideo-for-live)|AWS Elemental MediaLive|Media Services - Live and On-demand Streaming|
|<img width="120px" alt="vs.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e1538a21-6f13-4d8a-a9d8-62adf98b7da7.png">|[视频监控](https://www.aliyun.com/product/vs)|ビデオ監視サービス|||||
|<img width="120px" alt="vod.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/5168d95d-bab1-0b93-eba7-698ce81be637.png">|[视频点播](https://www.aliyun.com/product/vod)|オンデマンドオーディオ/ビデオストリーミングサービス|[ApsaraVideo VOD](https://www.alibabacloud.com/products/apsaravideo-for-vod)||AWS Elemental MediaPackage|Media Services|
|<img width="120px" alt="mts.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e2acc65f-602f-7dd3-abe8-590c49241080.png">|[媒体处理](https://www.aliyun.com/product/mts)|メディア変換|[ApsaraVideo for Media Processing](https://www.alibabacloud.com/product/mts)|[ApsaraVideo for Media Processing](https://jp.alibabacloud.com/product/mts)|Elastic Transcoder/AWS Elemental MediaConvert|Media Services - Encoding|(Anvato)|
|<img width="120px" alt="mtscensor.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/7366c747-a467-d2b3-cdeb-d5c97e084f61.png">|[视频审核](https://ai.aliyun.com/vi/censor)|ビデオ検閲サービス。ポルノや政治など禁止事項の特定をメイン|||||
|<img width="120px" alt="mtsdna.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/2d318c08-99c3-c834-87b0-4853819cc2f4.png">|[视频DNA](https://ai.aliyun.com/vi/dna)|ビデオ監査サービス。映像データから重複排除をメイン|||||
|<img width="120px" alt="mtsproduce.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/83a65660-974b-d562-0c6f-1e788d4a3c77.png">|[视频智能生产](https://ai.aliyun.com/vi/produce)|ビデオ制作サービス。映像を識別しリアルタイムでハイライトを生成|||||
|<img width="120px" alt="mtsmultimod.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/16f93292-d1d7-f352-b48f-a18eba776be4.png">|[视频多模态内容理解](https://ai.aliyun.com/vi/multimodal)|ビデオコンテンツ識別サービス。視覚情報、テキスト、音声および動作から家庭用品、自動車、動物、植物など1000以上のカテゴリを特定|||||
|<img width="120px" alt="mtscover.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/3a6f6836-dbf7-ab94-8357-ec2cf1b280f9.png">|[智能封面](https://ai.aliyun.com/vi/cover)|ビデオデータやコンテンツから最適なビデオカバー提供|||||
|<img width="120px" alt="ivision.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/53e46c0b-a86e-85b3-12c3-b12547e3351d.png">|[智能视觉](https://ai.aliyun.com/vi/ivision)|ビデオインテリジェント。画像分類、画像検出、ビデオ分類、ビデオ認識、ライブ識別|||||

## プライベートクラウド（专有云）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="ApsaraStack.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/5cb155f0-425a-da77-f9e9-003fb84b6e35.png">|[Apsara Stack](https://www.aliyun.com/product/apsara-stack)|オンプレミスによるAlibabaCloudサービス|[Apsara Stack](https://www.alibabacloud.com/product/apsara-stack)||AWS Outposts|Stack|Cloud Platform Service|

## メッセージキューMQ（消息队列 MQ）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="100px" alt="mq.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/294b227a-5813-d3e6-5c8d-656285523f4f.png">|[消息队列 RocketMQ](https://www.aliyun.com/product/rocketmq)|分散メッセージミドルウェア|||Simple Queue Service|Queue Storage|
|<img width="100px" alt="amqp.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/2504b0b7-91cb-ff99-9fdd-68503062e1b2.png">|[消息队列 AMQP](https://www.aliyun.com/product/amqp)|RabbitMQによるメッセージキュー|||||
|<img width="100px" alt="onsmqtt.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f93cef54-6384-34bf-143f-edac53e535b8.png">|[微消息队列 for IoT](https://www.aliyun.com/product/mq4iot)|IoT向けマイクロメッセージキュー|||||
|<img width="100px" alt="alikafka.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1ea3ae39-782f-8e88-ae8c-467a446d1919.png">|[消息队列 Kafka](https://www.aliyun.com/product/kafka)|kafkaによるメッセージキュー|||Managed Streaming for Kafka||
|<img width="100px" alt="mns.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/52bc83cc-37b4-23ee-d378-466fd25df243.png">|[消息服务 MNS](https://www.aliyun.com/product/mns)|分散型メッセージキューサービス|[Message Service](https://www.alibabacloud.com/product/message-service)|[Message Service](https://jp.alibabacloud.com/product/message-service)|SQS (Simple Queue Service), SNS (Simple Notification Service), MQ|Queue Storage, Service Bus|Google Pub/Sub, GAE の Task Queue|
|iconなし|[微服务](https://www.aliyun.com/product/microservice)|マイクロサービス|||||
|<img width="100px" alt="edas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/edd679b9-ee4d-c546-4e0b-6818348bf71f.png">|[企业级分布式应用服务 EDAS](https://www.aliyun.com/product/edas)|エンタープライズ分散アプリケーションサービスEDAS|[Enterprise Distributed Application Service](https://www.alibabacloud.com/product/edas)||||
|<img width="100px" alt="acm.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1c95eabe-96c8-60d4-c776-370fb27ba6f0.png">|[应用配置管理 ACM](https://www.aliyun.com/product/acm)|アプリケーション構成管理ACM|[Application Configuration Management](https://www.alibabacloud.com/product/acm)||||
|<img width="100px" alt="gts.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e7856833-34c0-47d3-7402-6042cb37eb95.png">|[全局事务服务 GTS](https://www.aliyun.com/aliware/txc)|グローバルトランザクションサービス|||||


## インテリジェントカスタマーサービス（智能客服）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="ccc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1f8eb82e-42fc-f817-1e20-c4b2357d4317.png">|[云呼叫中心](https://www.aliyun.com/product/ccc)|クラウドコールセンター|||||
|<img width="80px" alt="beebot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1272a16b-7d02-c7a7-6940-5e70f6c32938.png">|[云小蜜](https://www.aliyun.com/product/beebot)|NLPベースの会話ロボットサービス|||Lex|Bot Service|(Dialogflow)|
|<img width="80px" alt="sca.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/77164623-62d1-ad96-2b3f-3d38923a9c36.png">|[智能对话分析](https://www.aliyun.com/product/sca)|知的対話分析|||||
|<img width="80px" alt="ccs.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1fd52d33-becd-b76b-56c5-9b4cc0b90e77.png">|[云客服](https://www.aliyun.com/product/ccs)|クラウドカスタマーサービス|||||

## ブロックチェーン（区块链）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="baas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/435cd1db-dbb9-6533-3834-45725eacdfa4.png">|[区块链服务](https://www.aliyun.com/product/baas)|ブロックチェーンサービス|[Blockchain as a Service](https://www.alibabacloud.com/products/baas)|[Blockchain as a Service](https://jp.alibabacloud.com/product/baas)|Managed Blockchain、Quantum Ledger Database|Blockchain Service、Blockchain Workbench|

## SaaSアクセラレータ（SaaS加速器）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="yida.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/bbe02e19-d347-e24e-53b0-a689a7be8479.png">|[宜搭](https://www.aliyun.com/product/yida)|GUIベース開発サービス|||||

## モノのインターネットプラットフォーム（物联网平台）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="iot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/b14ddc3d-3c83-3719-8c69-2f414462c891.png">|[物联网设备接入](https://www.aliyun.com/product/iot-deviceconnect)|IoTデバイスへのアクセス|||||
|<img width="80px" alt="livinglink.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/8d71da1d-5eb9-219d-ddd1-55c09b05525d.png">|[生活物联网平台](https://iot.aliyun.com/products/livinglink)|Life Internet of Thingsプラットフォーム|||||
|<img width="80px" alt="iot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/d71d995c-6427-e63e-c677-e1931adf01ab.png">|[物联网设备管理](https://www.aliyun.com/product/iot-devicemanagement)|IoTデバイス管理|||||
|<img width="80px" alt="iot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fc1311a9-e026-dd01-ead5-c106d54f30f0.png">|[物联网数据分析](https://www.aliyun.com/product/iot-dataanalytics)|モノのインターネットデータ分析|||AWS IoT Analytics|Stream Analytics/Time Series Insights|
|iconなし|[物联网一站式开发](https://iot.aliyun.com/products/linkdevelop)|IoT 開発Studio|||AWS IoT Things Graph|IoT Central|

## 低電力WAN（低功耗广域网）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="linkwan.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/23849ee6-a4da-e698-dbc1-4b7197d0f238.png">|[物联网络管理平台](https://www.aliyun.com/product/linkwan)|IoTネットワーク管理プラットフォーム|||||
|<img width="80px" alt="dyiot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/9e275fb6-9ad2-9c58-fad6-7598d76ba628.png">|[物联网无线连接服务](https://www.aliyun.com/product/olddyiot)|IoT無線通信接続サービス|||||

## エッジサービス（边缘服务）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="iot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/3d586f54-e817-33a6-26f7-60f8701db586.png">|[物联网边缘计算](https://www.aliyun.com/product/iotedge)|IoTエッジコンピューティング|||AWS Greengrass|IoT Edge|Cloud IoT Edge|
|iconなし|[视频边缘智能服务](https://www.aliyun.com/product/linkvisual)|ビデオエッジインテリジェンスサービス|||||

## 設備サービス（设备服务）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[AliOS Things](https://iot.aliyun.com/products/aliosthings)|Alibaba Cloud用IoTオペレーティングシステム|||||

## IoTセキュリティ（物联安全）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[物联网设备身份认证](https://www.aliyun.com/product/iotid)|IoTデバイスアイデンティティ認証|||AWS IoT Core|IoT Hub|Cloud IoT Core|
|iconなし|[物联网安全运营中心](https://www.aliyun.com/product/iot-devicedefender)|IoTセキュリティオペレーションセンター|||AWS IoT Device Defender||
|iconなし|[物联网可信执行环境](https://iot.aliyun.com/products/tee)|IoT実行環境アプリケーション|||AWS IoT 1-Click||
|iconなし|[物联网可信服务管理](https://iot.aliyun.com/products/tsm)|IoTサービス集約管理プラットフォーム|||AWS IoT Device Management|IoT Hub|Cloud IoT Core|

## ソフトとハードの統合アプリケーション（软硬一体化应用）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[魔笔](https://iot.aliyun.com/products/linkmopen)|手書きデータの認識サービス（マジックペン）|||||
|<img width="80px" alt="cd.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/484dea7a-cabf-a867-75fa-731db8c1fd25.png">|[云投屏](https://www.aliyun.com/product/cd)|クラウドプロジェクションスクリーン|||||

## 関連クラウド製品（相关云产品）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="iovcc.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/47428d08-cc4c-5a31-4734-14fc4a12baa3.png">|[智联车管理云平台](https://www.aliyun.com/product/iovcc)|Zhilian自動車メーカー向けの自動車管理クラウドプラットフォーム|||||

## エコロジー（生态）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[物联网市场](https://linkmarket.aliyun.com)|IoTアプリケーション購入市場|||||
|iconなし|[ICA物联网标准联盟](https://www.ica-alliance.org/)|IoTConnectivityAlliance、IoTアライアンス|||||
|iconなし|[物联网测试认证服务](https://iot.aliyun.com/linkcertification)|IoTテストおよび認証サービス|||||

## バックアップ、移行、および災害復旧（备份、迁移与容灾）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="hbr.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/bdd86b02-670e-b2ec-d8aa-5edc07596f8e.png">|[混合云备份服务](https://www.aliyun.com/product/hbr)|ハイブリッドクラウドのバックアップサービス|||||
|<img width="80px" alt="hdr.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/80942dda-d737-7e06-abfe-749bcc271d24.png">|[混合云容灾服务](https://www.aliyun.com/product/hdr)|ハイブリットクラウドの災害復旧サービス|||||
|<img width="80px" alt="dbs.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/06df550c-1e9d-720e-d318-61a63cae4c35.png">|[数据库备份 DBS](https://www.aliyun.com/product/dbs)|データベースバックアップ|[Database Backup](https://www.alibabacloud.com/products/database-backup)|[Database Backup](https://jp.alibabacloud.com/products/database-backup)|||
|<img width="80px" alt="dts.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/20661f4c-40b7-2d6f-b392-dc0f423a9563.png">|[数据传输 DTS](https://www.aliyun.com/product/dts)|データ転送サービス|[Data Transmission Service](https://www.alibabacloud.com/product/data-transmission-service)|[Data Transmission Service](https://jp.alibabacloud.com/product/data-transmission-service)|AWS Database Migration Service, AWS Schema Conversion Tool|Database Migration Service|
|<img width="80px" alt="adam.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/28dfa327-51ff-19ac-02b6-ff3823f32428.png">|[数据库和应用迁移 ADAM](https://www.aliyun.com/product/adam)|データベースとアプリケーション移植サービス|||||
|<img width="80px" alt="mgw.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/04916a86-3898-d587-40ea-440ed16d13cd.png">|[闪电立方](https://www.aliyun.com/product/mgw)|オンラインとオフラインのデータ転送サービス（Lightning Cube）|||||
|iconなし|[迁移工具](https://help.aliyun.com/document_detail/62394.html)|Qianyun移植ツール|||||

## 開発者プラットフォーム（开发者平台）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="yunxiao.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/082c6ab4-1ac8-66d5-f4e3-f473c4b413a1.png">|[云效](https://www.aliyun.com/product/yunxiao)|DevOpsサービス|||||
|iconなし|[开发者中心](https://developer.aliyun.com/index)|デベロッパーセンター|||||
|<img width="80px" alt="iot.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ab01725e-63d1-9ecf-d490-b1e6b0a7f441.png">|[物联网开发者平台](https://www.aliyun.com/product/iot)|IoTプラットフォーム|||||

## APIとツール（API与工具）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[Cloud Toolkit](https://www.aliyun.com/product/cloudtoolkit)|クラウド開発ツールキット|||AWS CodeStar|DevOps|
|<img width="80px" alt="openapiexplorer.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/3f76dbdf-63c8-6ea6-e8ec-384a57067409.png">|[OpenAPI Explorer](https://www.aliyun.com/product/openapiexplorer)|OpenAPI Explorer|||||
|iconなし|[API 控制中心](https://developer.console.aliyun.com/)|APIコンソール|||||
|iconなし|[API 全集](https://developer.aliyun.com/api)|APIプラットフォーム|||||
|iconなし|[API 错误中心](https://error-center.aliyun.com/)|APIエラーセンター|||||
|iconなし|[SDK 全集](https://developer.aliyun.com/sdk)|Alibaba Cloud SDKプラットフォーム|||AWS Cloud9|(Visual Studio Online)|(Cloud Shell Code editor)|
|<img width="80px" alt="cloudshell.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/3afaf253-f79e-8e73-ef1b-24005669a0c3.png">|[云命令行](https://www.aliyun.com/product/cloudshell)|Cloud Shell|[Cloud Shell](https://www.alibabacloud.com/products/cloud-shell)|[Cloud Shell](https://jp.alibabacloud.com/help/doc-detail/74637.html)|AWS Systems Manager Session Manager|Cloud Shell|Cloud Shell|

## プロジェクトコラボレーション（项目协作）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[项目协作](https://www.aliyun.com/product/yunxiao-project)|クラウドエンタープライズコラボレーション|||||

## コードホスティング、倉庫（代码托管、仓库）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="codepipeline.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/4d06b065-5013-10a5-208b-65d97b88ee1f.png">|[代码托管](https://promotion.aliyun.com/ntms/act/code.html)|Gitライブラリホスティングサービス|||AWS CodeCommit|Repos|Cloud Source Repositories|
|iconなし|[Maven公共仓库](https://m.aliyun.com/markets/aliyun/ali-repo)|Maven Public Warehouse|||||
|iconなし|[制品仓库](https://m.aliyun.com/markets/aliyun/repo-manage)|Maven製品管理サービス|||||

## 統合配送（集成交付）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|iconなし|[持续交付](https://www.aliyun.com/product/yunxiao-cd)|継続的配信サービス|||||
|<img width="80px" alt="codepipeline.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/91d62987-a7f0-af71-7602-64b555a75bee.png">|[CodePipline](https://www.aliyun.com/product/codepipeline)|パイプライン|||AWS CodePipeline|Pipelines|Cloud Build|

## テスト（测试）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="pts.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/1dd7ef9d-28f9-347c-ab3b-ee88c224d7a7.png">|[性能测试 PTS](https://www.aliyun.com/product/pts)|パフォーマンステストサービス||||
|iconなし|[测试平台](https://www.aliyun.com/product/yunxiao-testing)|クラウドサービス上のテストプラットフォーム|||||


## 開発と運用（开发与运维）
|icon|中国サイト|コメント|国際サイト|日本サイト|AWS|Azure|GCP|
|---|---|---|---|---|---|---|---|
|<img width="80px" alt="arms.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/ad90a6a3-2b91-d952-a73b-65a9a29ffff0.png">|[应用实时监控服务](https://www.aliyun.com/product/arms)|アプリケーションリアルタイム監視サービス|||||
|<img width="80px" alt="cms.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/e7624d63-f2ca-3e85-dc5b-9df7cdeb598f.png">|[云监控](https://www.aliyun.com/product/jiankong)|クラウドモニタリング|[CloudMonitor](https://www.alibabacloud.com/product/cloud-monitor)|[CloudMonitor](https://jp.alibabacloud.com/product/cloud-monitor)|CloudWatch Events|Event Grid、Monitor|Stackdriver Monitoring|
|iconなし|[智能顾问](https://www.aliyun.com/product/advisor)|AlibabaCloudコンサルティングサービス|||||
|<img width="80px" alt="ahas.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/f278e919-de95-373e-e7f2-0e7676a0df55.png">|[应用高可用服务 AHAS](https://www.aliyun.com/product/ahas)|Application High Availability Service|||||
|<img width="80px" alt="node-js.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/c12d3c8d-d5dd-8bb4-8791-a45deb0ab82d.png">|[Node.js性能平台](https://www.aliyun.com/product/nodejs)|Node.jsパフォーマンスプラットフォーム|||||
|<img width="80px" alt="xtrace.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/355017/fb051f34-526b-73c7-a948-a142d7ee38e8.png">|[链路追踪](https://www.aliyun.com/product/xtrace)|TracingAnalysis|||||