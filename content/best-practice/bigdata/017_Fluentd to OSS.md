---
title: "FluentdからOSSへ"
description: "FluentdからOSSへデータを集約する方法を説明します。"
date: 2019-08-30T00:00:00+00:00
weight: 170
draft: false
---
<!-- descriptionがコンテンツの前に表示されます -->

<!-- コンテンツを書くときはこの下に記載ください -->

## はじめに
&nbsp; 本章はAlibabaCloud LogServiceを使ってOSSへデータを送ります。ゴールとしては以下のような構成図になります。
また、OSSにデータ収集後、E-MapReduceでHDFSへのETL処理がありますが、こちらは「OSSとE-MapReduce編」「ETL編」にて重複するため、割愛させていただきます。
（この章のゴールは外部データソースをOSSへ集約する、のみとなります）

![BD_Images_Fluend_to_OSS_001](/static_images/BD_Images_Fluend_to_OSS_001.png)
<br>


## Fluend とは
&nbsp; Fluendはデーモン上で動作する、データのやりとりを管理するソフトウェアです。
Fluentd は input, buffer, output という以下の役割を持っています。

* 必要なデータを取り出す (input)
  * そのデータを必要に応じて分解(パース)する
  * データのタイムスタンプを管理する
* 必要なところにデータを届ける (output)
  * そのデータを必要に応じて整形(フォーマット)して保存する
* データを紛失しないよう管理する (buffer)
  * やりとりの途中で何かエラーが起きたらリトライする

他、特徴として、以下があります。
* ログはタグで管理される
* JSON形式
* 様々なプラグインがあり、OSSやMySQL、Hadoop HDFSなど自由に接続が可能

他、詳しいことは[Fluend公式サイト](https://www.fluentd.org/architecture)を参照してください。
また、[Fluentdのガイドブック](https://docs.fluentd.org/)もありますので、使用方法はこちらを参考にしてください。
https://docs.fluentd.org/
<br>

## Fluendの導入
ECSにFluendをインストールし、OSSへデータを送ってみます。ECSはCentOS 7.6です。

Step1. td-agentをインストールするshellを入手し、Shellを実行
```bash
[root@bigdatatest ~]# curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent3.sh | sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   849  100   849    0     0   5773      0 --:--:-- --:--:-- --:--:--  5815
==============================
 td-agent Installation Script 
==============================
This script requires superuser access to install rpm packages.
You will be prompted for your password by sudo.
読み込んだプラグイン:fastestmirror
Determining fastest mirrors
base                                                                                                                                       | 3.6 kB  00:00:00     
epel                                                                                                                                       | 5.4 kB  00:00:00     
extras                                                                                                                                     | 3.4 kB  00:00:00     
treasuredata                                                                                                                               | 2.9 kB  00:00:00     
updates                                                                                                                                    | 3.4 kB  00:00:00     
(1/8): base/7/x86_64/group_gz                                                                                                              | 166 kB  00:00:00     
(2/8): epel/x86_64/group_gz                                                                                                                |  88 kB  00:00:00     
(3/8): epel/x86_64/updateinfo                                                                                                              | 1.0 MB  00:00:00     
(4/8): treasuredata/7/x86_64/primary_db                                                                                                    |  27 kB  00:00:00     
(5/8): base/7/x86_64/primary_db                                                                                                            | 6.0 MB  00:00:00     
(6/8): extras/7/x86_64/primary_db                                                                                                          | 215 kB  00:00:00     
(7/8): epel/x86_64/primary_db                                                                                                              | 6.8 MB  00:00:00     
(8/8): updates/7/x86_64/primary_db                                                                                                         | 7.4 MB  00:00:00     

〜略〜

インストール:
  td-agent.x86_64 0:3.5.0-0.el7                                                                                                                                   

完了しました!

Installation completed. Happy Logging!

[root@bigdatatest ~]# 
```

Step2. td-agentのruby-develとgccコンパイル（ライブラリ）をインストール
```bash
[root@bigdatatest ~]# yum install gcc gcc-c++ ruby-devel
読み込んだプラグイン:fastestmirror
Loading mirror speeds from cached hostfile
パッケージ gcc-4.8.5-36.el7_6.2.x86_64 はインストール済みか最新バージョンです
依存性の解決をしています
--> トランザクションの確認を実行しています。
---> パッケージ gcc-c++.x86_64 0:4.8.5-36.el7_6.2 を インストール

〜略〜

インストール:
  gcc-c++.x86_64 0:4.8.5-36.el7_6.2                                             ruby-devel.x86_64 0:2.0.0.648-35.el7_6                                            

依存性関連をインストールしました:
  libstdc++-devel.x86_64 0:4.8.5-36.el7_6.2              libyaml.x86_64 0:0.1.4-11.el7_0                   ruby.x86_64 0:2.0.0.648-35.el7_6                      
  ruby-irb.noarch 0:2.0.0.648-35.el7_6                   ruby-libs.x86_64 0:2.0.0.648-35.el7_6             rubygem-bigdecimal.x86_64 0:1.2.0-35.el7_6            
  rubygem-io-console.x86_64 0:0.4.2-35.el7_6             rubygem-json.x86_64 0:1.7.7-35.el7_6              rubygem-psych.x86_64 0:2.0.0-35.el7_6                 
  rubygem-rdoc.noarch 0:4.0.0-35.el7_6                   rubygems.noarch 0:2.0.14.1-35.el7_6              

完了しました!
[root@bigdatatest ~]# 
```
Step3. AlibabaCloud ossへデータを流すためのFluentdプラグインをインストール
$ td-agent-gem install fluent-plugin-aliyun-oss

またfluent-plugin-aliyun-ossがインストールされてるか、以下のコマンドも実施
$ td-agent-gem list fluent-plugin-aliyun-oss
```bash
[root@bigdatatest ~]# td-agent-gem install fluent-plugin-aliyun-oss
Fetching: http-accept-1.7.0.gem (100%)
Successfully installed http-accept-1.7.0
Fetching: unf_ext-0.0.7.6.gem (100%)
Building native extensions.  This could take a while...
Successfully installed unf_ext-0.0.7.6
〜略〜
Installing ri documentation for aliyun-sdk-0.7.0
Parsing documentation for fluent-plugin-aliyun-oss-0.0.1
Installing ri documentation for fluent-plugin-aliyun-oss-0.0.1
Done installing documentation for http-accept, unf_ext, unf, domain_name, http-cookie, mime-types-data, mime-types, netrc, rest-client, aliyun-sdk, fluent-plugin-aliyun-oss after 14 seconds
11 gems installed
[root@bigdatatest ~]# 
[root@bigdatatest ~]# 
[root@bigdatatest ~]# 
[root@bigdatatest ~]# td-agent-gem list fluent-plugin-aliyun-oss

*** LOCAL GEMS ***

fluent-plugin-aliyun-oss (0.0.1)
[root@bigdatatest ~]# 
[root@bigdatatest ~]# 

```

Step4. td-agent.confを編集

```bash
vi /etc/td-agent/td-agent.conf
```

td-agent.conf にて、Output PluginとしてAlibabaCloud OSSへのエンドポイント、バケット、Access Key/Secret Keyを入力します。
入力に必要な項目、オプション設定もありますので、詳しくは[こちらを参照](https://github.com/aliyun/fluent-plugin-oss)してください。
https://github.com/aliyun/fluent-plugin-oss
```bash
####
## Output descriptions:
##

# Treasure Data (http://www.treasure-data.com/) provides cloud based data
# analytics platform, which easily stores and processes data from td-agent.
# FREE plan is also provided.
# @see http://docs.fluentd.org/articles/http-to-td
#
# This section matches events whose tag is td.DATABASE.TABLE
<match debug.*>
  @type oss
  endpoint ＜OSSのendpointを入力＞
  bucket ＜OSSのbucketを入力＞
  access_key_id ＜access_key_idを入力＞
  access_key_secret ＜access_key_secretを入力＞
  path fluentd/logs
  auto_create_bucket true
  key_format %{path}/%{time_slice}_%{index}_%{thread_id}.%{file_extension}
  store_as gzip
  <buffer tag,time>
    @type file
    path /var/log/fluent/oss
    timekey 60 # 1 min partition
    timekey_wait 20s
    #timekey_use_utc true
  </buffer>
  <format>
    @type json
  </format>
</match>


# HTTP input
# POST http://localhost:8888/<tag>?json=<json>
# POST http://localhost:8888/td.myapp.login?json={"user"%3A"me"}
# @see http://docs.fluentd.org/articles/in_http
<source>
  @type http
  @id input_http
  port 8888
</source>
```
収集ログに対する権限エラー対策として、`/etc/init.d/td-agent` の設定ファイルを更新します。

```bash
vi /etc/init.d/td-agent
```
```
# 更新箇所
TD_AGENT_DEFAULT=/etc/sysconfig/td-agent
TD_AGENT_USER=root
TD_AGENT_GROUP=root
TD_AGENT_RUBY=/opt/td-agent/embedded/bin/ruby
```

Step5. td-agent.confファイルの編集が終われば、設定ファイルをリロードし、サーバを再起動します。
```bash
[root@bigdatatest ~]# sudo /etc/init.d/td-agent reload
Reloading td-agent configuration (via systemctl):          [  OK  ]
[root@bigdatatest ~]# 
[root@bigdatatest ~]# sudo /etc/init.d/td-agent reload
Reloading td-agent configuration (via systemctl):          [  OK  ]
[root@bigdatatest ~]# 
```
再起動すれば変更が反映されます。
今回はApacheのAccess_Logとerror_Logを収集、OSSへ入れたいので、`/etc/td-agent/td-agent.conf`にて、以下の設定を付け加えます。
```bash
<source>
 type tail
 format none
 path /var/log/httpd/access_log
 pos_file /var/log/td-agent/httpd.access.pos
 tag td.httpd.access
</source>

<source>
 type tail
 format none
 path /var/log/httpd/error_log
 pos_file /var/log/td-agent/httpd.error.pos
 tag td.httpd.error
</source>
```
終わればリロード・リスタートします。
```bash
[root@bigdatatest ~]# sudo /etc/init.d/td-agent reload
Reloading td-agent configuration (via systemctl):          [  OK  ]
[root@bigdatatest ~]# 
[root@bigdatatest ~]# sudo /etc/init.d/td-agent reload
Reloading td-agent configuration (via systemctl):          [  OK  ]
[root@bigdatatest ~]# 
```

Step6. fluentdのsystemdを有効化します。

```bash
[root@bigdatatest ~]# sudo systemctl enable td-agent
Created symlink from /etc/systemd/system/multi-user.target.wants/td-agent.service to /usr/lib/systemd/system/td-agent.service.
[root@bigdatatest ~]# sudo systemctl start td-agent
[root@bigdatatest ~]# sudo systemctl status td-agent
● td-agent.service - td-agent: Fluentd based data collector for Treasure Data
   Loaded: loaded (/usr/lib/systemd/system/td-agent.service; enabled; vendor preset: disabled)
   Active: active (running) since 月 2019-08-30 17:10:15 CST; 21min ago
     Docs: https://docs.treasuredata.com/articles/td-agent
 Main PID: 5941 (fluentd)
   CGroup: /system.slice/td-agent.service
           ├─ 5941 /opt/td-agent/embedded/bin/ruby /opt/td-agent/embedded/bin/fluentd --log /var/log/td-agent/td-agent.log --daemon /var/run/td-agent/td-agent....
           └─12152 /opt/td-agent/embedded/bin/ruby -Eascii-8bit:ascii-8bit /opt/td-agent/embedded/bin/fluentd --log /var/log/td-agent/td-agent.log --daemon /va...

 8月 30 17:10:15 bigdatatest.test systemd[1]: Starting td-agent: Fluentd based data collector for Treasure Data...
 8月 30 17:10:15 bigdatatest.test systemd[1]: Started td-agent: Fluentd based data collector for Treasure Data.
[root@bigdatatest ~]# 
```

Step7. ちゃんと実現できてるかテストしてみます。
```bash
[root@bigdatatest ~]# curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test
[root@bigdatatest ~]# tail -3 /var/log/td-agent/td-agent.log
2019-08-30 17:17:27 +0900 [info]: listening fluent socket on 0.0.0.0:24224
2019-08-30 17:17:27 +0900 [info]: listening dRuby uri="druby://127.0.0.1:24230" object="Engine"
2019-08-30 17:23:52 +0900 debug.test: {"json":"message"}
[root@bigdatatest ~]# 
[root@bigdatatest ~]# 
```
ちなみにLogファイルの場所は以下の通りになります（CentOSの場合）
|ファイル名|場所|
|---|---|
|設定ファイル|/etc/td-agent/td-agent.conf|
|ログファイル|/var/log/td-agent/td-agent.log|
<br>

OSSのバケットでも、Logがあることを確認できます。これで以上です。
![BD_Images_Fluend_to_OSS_002](/static_images/BD_Images_Fluend_to_OSS_002.png)
<br>



