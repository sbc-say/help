---
title: "ECSとDjangoの構築例"
description: "AlibabaCloudのIaaSを用いた、Python Djangoアプリケーションの構築例を記載します。"
date: 2019-09-23T16:20:40+09:00
weight: 30
draft: false
---

<span id="index">目次</span>

* ECSとDjangoを用いたWebアプリケーション構築の流れ
 1. [VPCを用いたネットワークセグメント作成](#VPC)
 1. [ECSを用いた仮想マシンの作成](#ECS)
 1. [RDSを用いたPostgresqlインスタンスの作成](#RDS)
 1. [Cent OS上でのDjangoの実装と接続確認](#APP)
 1. [SLBを用いたロードバランサーの作成](#SLB)

---
<span> id="VPC"></span>
## 1. VPCを用いたネットワークセグメント作成
&nbsp; Alibaba Cloudで、VPCとそれに付随するサブネット(VSwitchと呼ばれる)を作成したいと思います。

### 1-1. サービスの選択
&nbsp; ログイン後のコンソールで、[「Virtual Private Cloud」](https://jp.alibabacloud.com/product/vpc)を選択します。
![WS000000.JPG](../img/VPC/VPC_01.jpeg)

### 1-2. VPCの作成
&nbsp; 「VPCの作成」をクリックします。
![WS000001.JPG](../img/VPC/VPC_02.jpeg)
以下のVPCパラメータを入力します。

- VPC名
- IPv4 CIDR ブロック
![WS000003.JPG](../img/VPC/VPC_03.jpeg)

### 1-3. VSwitchの作成
&nbsp; 続けて同じ画面で、VSwitchと呼ばれるサブネットを作成します。
パラメータとしては以下の3つを入力、アベイラビリティゾーン分ける為、計2つのVSwitchを作成します。

- VPC名
- アベイラビリティゾーン
- IPv4 CIDR ブロック  
![WS000004.JPG](../img/VPC/VPC_04.jpeg)
![WS000005.JPG](../img/VPC/VPC_05.jpeg)
「OK」をクリックした後、「完了」をクリックします。
![WS000007.JPG](../img/VPC/VPC_06.jpeg)

### 1-4. VPCとVSwitchの確認
&nbsp; 「完了」をクリック後、VPCが作成されている事が確認できます。
![WS000008.JPG](../img/VPC/VPC_07.jpeg)
&nbsp; また、VSwitchのダッシュボードより、VSWitchが作成されている事も確認できます。
![WS0001000.JPG](../img/VPC/VPC_08.jpeg)

---
<span id="ECS"></span>
## 2. ECSを用いた仮想マシンの作成
&nbsp; Alibaba CloudのECSにおける仮想マシン作成手順を記します。また、AWSに知見のある方向けに、AWSとの違いも一部記します。

### 2-1. ECSサービスの選択
ログイン後のコンソールで[「Elastic Compute Service」](../img/ECS/ECS_00.jpeg)（以下ECS）をクリックします 
![WS000000.JPG](../img/ECS/ECS_01.jpeg)

ECSダッシュボード画面で「インスタンス」をクリックします
　※AWSとの違い: ECSダッシュボード画面では全リージョンのインスタンスの利用状況が表示される
![WS000001.JPG](../img/ECS/ECS_02.jpeg)

### 2-2. リージョン確認
インスタンス画面で初めてリージョンが確認できるので「日本（東京）」である事を確認します
![WS000002.JPG](../img/ECS/ECS_03.jpeg)

### 2-3. インスタンス作成開始
「インスタンスの作成」をクリックします
![WS000003.JPG](../img/ECS/ECS_04.jpeg)

### 2-4. パラメータ入力
以下パラメータを入力して、「次のステップ：ネットワーク」をクリックします

- サブスクリプション（AWSでいうリザーブドインスタンス）か従量課金か
- アベイラビリティゾーン（東京はap-northeast-1）
- インスタンスタイプ
- インスタンスOS
- ルートディスクの種類とサイズ

![WS000005.JPG](../img/ECS/ECS_05.jpeg)
![WS000007.JPG](../img/ECS/ECS_06.jpeg)

以下パラメータを入力して、「次のステップ：システム構成」をクリックします

- 所属するVPCとVSwitch(AWSでいうサブネット)
- パブリックIPの割り当て
- アタッチするセキュリティグループと主要プロトコルの許可設定

![WS000008.JPG](../img/ECS/ECS_07.jpeg)

以下パラメータを入力して、「次のステップ：グループ化」をクリックします

- インスタンスにアクセスする為の秘密鍵もしくはパスワードを指定します  
　※AWSとの違い：デフォルトだと秘密鍵・パスワード共に指定なし  
- コンソール上のインスタンス名と説明、インスタンスOS内部のホスト名を入力します  

![WS000010.JPG](../img/ECS/ECS_08.jpeg)

タグ名とタグ値を入力して、「次のステップ：プレビュー」をクリックします  
![WS000011.JPG](../img/ECS/ECS_09.jpeg)

### 2-5. インスタンス作成の完了
「ECS SLAと利用規約に同意します」にチェックを入れて、「インスタンスの作成」をクリックします  
![WS000013.JPG](../img/ECS/ECS_10.jpeg)

### 2-6. 作成されたインスタンスの確認
有効と表示されたら、「コンソール」をクリックして、当該インスタンスが作成されている事を確認します  
![WS000015.JPG](../img/ECS/ECS_11.jpeg)
![WS0000166.JPG](../img/ECS/ECS_12.jpeg)

パブリックIP/EIPを割り当てている場合は、IPアドレスの列にグローバルIPアドレスが表示されます

![WS000009.JPG](../img/ECS/ECS_13.jpeg)

---
<span id="RDS"></span>
## 3. RDSを用いたPostgresqlインスタンスの作成
Alibaba CloudのRDSを用いて、ECSのアプリケーションから接続するPostgresqlインスタンスを作成します。流れとしては以下となります。

1. サービスの選択
1. Postgresqlインスタンスの起動
1. ネットワーク許可設定
1. データベースユーザの作成
1. データベースの作成と権限付与

### 3-1. サービスの選択
![RDS_01.JPG](../img/RDS/RDS_01.png)

### 3-2. Postgresqlインスタンスの起動
インスタンスの作成をクリックします。
![RDS_02.JPG](../img/RDS/RDS_02.png)

作成画面にて、リージョン/ゾーン、データベースエンジン、インスタンスタイプ、ストレージ容量、VPC/VSwitch を選択します。
![RDS_03.JPG](../img/RDS/RDS_03.png)
![RDS_04.JPG](../img/RDS/RDS_04.png)
![RDS_05.JPG](../img/RDS/RDS_05.png)
「いますぐ購入」をクリックして、利用規約に同意にチェックをして、「今すぐ支払いをクリックします。
![RDS_06.JPG](../img/RDS/RDS_06.png)
![RDS_07.JPG](../img/RDS/RDS_07.png)

購入ができたら、Consoleをクリックして、Home画面より再びRDSを選択して、インスタンスリストより当該Postgresqlインスタンスが「作成中」となっている箏を確認します。
![RDS_08.JPG](../img/RDS/RDS_08.png)
![RDS_09.JPG](../img/RDS/RDS_09.png)

RDS インスタンスが「実行中」になったら、そのインスタンスIDをクリックして、詳細を確認できます。
![RDS_10.JPG](../img/RDS/RDS_10.png)

### 3-2. ネットワーク許可設定
インスタンス立ち上げただけではRDSにアドレスが付与されません。その為、インスタンスの詳細より、「ホワイトリストの設定」をクリックして、ネットワーク許可設定を施す事で、アドレスが付与されて、接続可能となります。
![RDS_11.JPG](../img/RDS/RDS_11.png)

「セキュリティコントロール」のメニューに移動するので、「ホワイトリストグループを作成」をクリックします。

![RDS_13.JPG](../img/RDS/RDS_13.png)

ECS/RDSインスタンスが所属するVPCのネットワークセグメント（172.16.0.0/12）を指定します。

![RDS_14.JPG](../img/RDS/RDS_14.png)


ホワイトリストが正しく設定された事を確認します。

![RDS_15.JPG](../img/RDS/RDS_15.png)

### 3-3. データベースユーザの作成
次に「アカウント管理」メニューをクリックして、アカウントを作成します。
![RDS_16.JPG](../img/RDS/RDS_16.png)

まずは特権ユーザである「root」というアカウントを作成しました。（必須ではない）
![RDS_17.JPG](../img/RDS/RDS_17.png)
![RDS_18.JPG](../img/RDS/RDS_18.png)

次に同じ容量で「djangouser」というアカウントを作成しました。「許可済みデータベース」は、まだデータベースを作成していないので、選択不要です。

![RDS_19.JPG](../img/RDS/RDS_19.png)
![RDS_20.JPG](../img/RDS/RDS_20.png)

### 3-4. データベースの作成と権限付与
最後に「データベースの管理」よりデータベースを作成します。
![RDS_21.JPG](../img/RDS/RDS_21.png)
任意のデータベース名（デモアプリの仕様上ここではdb_example）を入力します。そして、「許可されたアカウント」と「アカウントタイプ」にて先程作ったユーザに読み取り書き込み権限を付与します。
![RDS_22.JPG](../img/RDS/RDS_22.png)
そのまま作成して、正常に「実行中」となっている事を確認します。
![RDS_23.JPG](../img/RDS/RDS_23.png)

これによりECS上からPostgresqlへアクセス可能となりました。

---
<span id="APP"></span>
## 4. OS上でのDjangoの実装と接続確認
ECSのCentOS上で、簡単なDjangoアプリケーションを実装します。
### 4-1. PythonとGitのインストール
まずは実行環境で必要なツールをパッケージインストールします。
```

```
### 4-2. Djangoのインストール・設定

Djangoでデフォルトで作成されるプロジェクトを利用します。

```

```

下記の画面が表示できれば完了です。
`curl localhost:8080/demo/add -d name=First -d email=someemail@someemailprovider.com `  

### 4-3. Nginxのインストール・設定

Nginx公式の手順を参考に、Djangoへのリバースプロキシを設定します。  
https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/

```
[root@iZ6we1q7wbpd4lko5h41ueZ ~]# yum install -y nginx
読み込んだプラグイン:fastestmirror
インストール処理の設定をしています
Loading mirror speeds from cached hostfile
依存性の解決をしています
--> トランザクションの確認を実行しています。
# 中略
インストール:
  nginx.x86_64 0:1.10.3-1.el6                                                                                                                                                        

依存性関連をインストールしました:
  GeoIP.x86_64 0:1.6.5-1.el6                                  GeoIP-GeoLite-data.noarch 0:2018.04-1.el6                    GeoIP-GeoLite-data-extra.noarch 0:2018.04-1.el6           
  gd.x86_64 0:2.0.35-11.el6                                   geoipupdate.x86_64 0:3.1.1-2.el6                             libXpm.x86_64 0:3.5.10-2.el6                              
  libxslt.x86_64 0:1.1.26-2.el6_3.1                           nginx-all-modules.noarch 0:1.10.3-1.el6                      nginx-filesystem.noarch 0:1.10.3-1.el6                    
  nginx-mod-http-geoip.x86_64 0:1.10.3-1.el6                  nginx-mod-http-image-filter.x86_64 0:1.10.3-1.el6            nginx-mod-http-perl.x86_64 0:1.10.3-1.el6                 
  nginx-mod-http-xslt-filter.x86_64 0:1.10.3-1.el6            nginx-mod-mail.x86_64 0:1.10.3-1.el6                         nginx-mod-stream.x86_64 0:1.10.3-1.el6                    

完了しました!
[root@iZ6we1q7wbpd4lko5h41ueZ ~]# 
[root@iZ6we1q7wbpd4lko5h41ueZ ~]# vim /etc/nginx/conf.d/default.conf 
# proxy_passを追記します。 
[root@iZ6we1q7wbpd4lko5h41ueZ ~]# service nginx start
```

そして、ECSサーバにHTTPアクセスすると以下の画面が表示されるようになります。  
![APP_01.JPG](../img/APP/APP_01.png)

---
<span id="SLB"></span>
## 5. SLBを用いたロードバランサーの作成
Alibaba Cloudでは、仮想ロードバランサの事を[Server Load Balancer](../img/SLB/SLB_01.jpeg)と呼称しており、その利用手順を記載します。

### 5-1. サービスの選択
ログイン後のコンソールで、「Server Load Balancer」をクリックします。  
![WS000000.JPG](../img/SLB/SLB_02.jpeg)
### 5-2. ロードバランサの作成
「ロードバランサの作成」をクリックします。
![WS000001.JPG](../img/SLB/SLB_03.jpeg)
ロードバランサのパラメータとして、以下を入力して、「今すぐ購入」をクリックします。

- リージョン
- プライマリーゾーン
- バックアップゾーン
- インスタンス名
- インスタンスタイプ（外部公開/内部公開）
- インスタンススペック
- 個数
![WS000003.JPG](../img/SLB/SLB_04.jpeg)
利用規約に同意して、「有効化」をクリックします。
![WS000004.JPG](../img/SLB/SLB_05.jpeg)

### 5-3. ロードバランサのリスナー設定
先程作成したロードバランサで「リスナーの設定」をクリックします。
![WS000005.JPG](../img/SLB/SLB_06.jpeg)
接続することプロトコルとポート番号（今回はHTTPと80）を入力して、「次へ」をクリックします。
![WS000007.JPG](../img/SLB/SLB_07.jpeg)
### 5-4. ロードバランサのバックエンド設定
VServerグループが選択されている事を確認して、「VServerグループの作成」をクリックします。
![WS000009.JPG](../img/SLB/SLB_08.jpeg)
VServerグループ名を入力して、「追加」をクリックします。
![WS000010.JPG](../img/SLB/SLB_09.jpeg)
既存のECSインスタンスの中から、バックエンドとなるインスタンスにチェックを入れて、「次のステップ：重みとポートの設定」をクリックします。
![WS000012.JPG](../img/SLB/SLB_10.jpeg)
バックエンドがリッスンしているポート番号（80)と、重み（100）を入力して「次へ」をクリックします。
![WS000013.JPG](../img/SLB/SLB_11.jpeg)
### 5-5. ロードバランサのヘルスチェック設定
ヘルスチェックの項目を確認、必要であれば変更して、「次へ」をクリックします。
![WS000014.JPG](../img/SLB/SLB_12.jpeg)
確認画面が表示されるので、「送信」をクリックします。
![WS000015.JPG](../img/SLB/SLB_13.jpeg)
作成が完了したら、「OK」をクリックします。
![WS000017.JPG](../img/SLB/SLB_14.jpeg)
### 5-6. ロードバランサの動作確認
ステータスは実行中であっても、ヘルスチェックが通るまでは利用不可と表示されます
![WS000018.JPG](../img/SLB/SLB_15.jpeg)
ヘルスチェックが正常になったら、バックエンドにアクセス可能です。
SLB経由でのNginxの動作確認は以下の通りです。
![APP_02.JPG](../img/APP/APP_02.png)
SLBおよびNginx経由でのDjangoの動作確認は以下の通りです。
![APP_03.JPG](../img/APP/APP_03.png)