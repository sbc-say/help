#CloudMonitorを用いたAlibabaCloudリソースの監視

##本記事の狙い
パブリッククラウドのメリットは、インフラ作業から開放し、サービス自体に集中できると言われていますが、基盤監視が不要ということではありません。オンプレミス環境と同様に、システム全体におけるパフォーマンス変化の把握、異常動作の検知、アラームの設定、自動バッチの実行、ログの可視化などを行う必要があります。

AlibabaCloudが提供する無料監視プロダクトCloudMonitorを利用することにより、コンソール操作、または簡単なバッチ仕込むことから、AlibabaCloud上のリソースを監視することができます。本文は、下記5つのポイントからCloudMonitorの利用方法を紹介します。

- 性能監視
  - ECS編
  - RDS編
  - SLB編
- イベント監視
  - ECS編
  - RDS編
  - SLB編
- カスタム監視
- APIにより監視データの外部連携
- Grafanaにより監視データの可視化

##性能監視
AlibabaCloudの製品を利用するだけで、無料で付いてくるCloudMonitor監視です。手間かかる設定が必要ありません。CloudMonitorのコンソールにて、下記リストされた各製品のメトリック項目の時系列監視図の確認はもちろん、アラームを設定することも可能です。ECS製品の場合、エージェントをECSにインストールすることにより、監視可能なメトリックが更に豊富になります。

###ECS編
####・基本監視（エージェント不要）
|メトリック項目|説明|単位|
|---|---|---|
| ECS.CPUUtilization |CPUの使用率|％|
| ECS.InternetInRate |インターネットインバウンドの帯域幅|ビット/秒|
| ECS.IntranetInRate |イントラネットインバウンドの帯域幅|ビット/秒|
| ECS.InternetOutRate |インターネットアウトバウンドの帯域幅|ビット/秒|
| ECS.IntranetOutRate |イントラネットアウトバウンドの帯域幅|ビット/秒|
| ECS.SystemDiskReadbps |1秒あたりのシステムディスク読取バイト数|バイト/秒|
| ECS.SystemDiskWritebps |1秒あたりのシステムディスク書込バイト数|バイト/秒|
| ECS.SystemDiskReadOps |1秒あたりのシステムディスク読取回数|回/秒|
| ECS.SystemDiskWriteOps |1秒あたりのシステムディスク書込回数|回/秒|
| ECS.InternetIn |インターネットインバウンドのトラフィック量|バイト|
| ECS.InternetOut |インターネットアウトバウンドのトラフィック量|バイト|
| ECS.IntranetIn |イントラネットインバウンドのトラフィック量|バイト|
| ECS.IntranetOut |イントラネットアウトバウンドのトラフィック量|バイト|


####・CPU監視
|メトリック項目|説明|単位|
|---|---|---|
| Host.cpu.idle |CPUのアイドル率|％|
| Host.cpu.system |カーネルプロセスのCPU使用率|％|
| Host.cpu.user |ユーザープロセスのCPU使用率|％|
| Host.cpu.iowait |I/O操作待ちプロセスのCPU使用率|％|
| Host.cpu.other |Nice + SoftIrq + Irq + StolenプロセスのCPU使用率|％|
| Host.cpu.total |CPUの使用率|％|

####・メモリ監視
|メトリック項目|説明|単位|
|---|---|---|
| Host.mem.total |メモリの容量|バイト|
| Host.mem.used |使用中のメモリ容量| バイト |
| Host.mem.actualused |ユーザーが使用中のメモリ容量|バイト|
| Host.mem.free |使用可能のメモリ容量|バイト|
| Host.mem.freeutilization |メモリのアイドル率|％|
| Host.mem.usedutilization |メモリの使用率|％|

####・システム負荷監視（Linux専用）
|メトリック項目|説明|単位|
|---|---|---|
| Host.load1 |1分間の平均システム負荷|-|
| Host.load5 |5分間の平均システム負荷|-|
| Host.load15 |15分間の平均システム負荷|-|

####・ディスク監視
|メトリック項目|説明|単位|
|---|---|---|
| Host.diskusage.used |使用中のディスク容量|バイト|
| Host.disk.utilization |ディスクの使用率|％|
| Host.diskusage.free |使用可能のディスク容量|バイト|
| Host.diskussage.total |ディスクの容量|バイト|
| Host.disk.readbytes |1秒あたりのディスク読取バイト数|バイト/秒|
| Host.disk.writebytes |1秒あたりのディスク書込バイト数|バイト/秒|
| Host.disk.readiops |1秒あたりのディスク読取回数|回/秒|
| Host.disk.writeiops |1秒あたりのディスク書込回数|回/秒|

####・ファイルシステム監視（Linux専用）
|メトリック項目|説明|単位|
|---|---|---|
| Host.fs.inode |inodeの使用率|％|

####・ネットワーク監視
|メトリック項目|説明|単位|
|---|---|---|
| Host.netin.rate |インバウンドの帯域幅|ビット/秒|
| Host.netout.rate |アウトバウンドの帯域幅|ビット/秒|
| Host.netin.packages |インバウンドのパケット数|パケット/秒|
| Host.netout.packages |アウトバウンドのパケット数|パケット/秒|
| Host.netin.errorpackage |インバウンドエラーのパケット数|パケット/秒|
| Host.netout.errorpackages |アウトバウンドエラーのパケット数|パケット/秒|
| Host.tcpconnection |TCP接続数 `LISTEN、SYN_SENT、ESTABLISHED、SYN_RECV、FIN_WAIT1、CLOSE_WAIT、FIN_WAIT2、LAST_ACK、TIME_WAIT、CLOSING、CLOSEDを含む`|接続数|

####・プロセス監視
|メトリック項目|説明|単位|
|---|---|---|
| Host.process.cpu |プロセスのCPU使用率|％|
| Host.process.memory |プロセスのメモリ使用率|％|
| Host.process.openfile |プロセスの使用中ファイル数|ファイル数|
| Host.process.number |キーワードと一致するプロセスの数|プロセス数|

---

###RDS編
|メトリック項目|説明|単位|
|---|---|---|
| Disk usage |ディスクの使用率|％|
| Connection usage |接続数の使用率|％|
| CPU usage |CPUの使用率|％|
| Memory usage |メモリの使用率|％|
| MySQL Incoming network traffic |1 秒あたりのMySQLインバウンドトラフィック|ビット/秒|
| MySQL Outgoing network traffic |1 秒あたりのMySQLアウトバウンドトラフィック|ビット/秒|
| SQLServer Incoming network traffic |1 秒あたりのSQLServerインバウンドトラフィック|ビット/秒|
| SQLServer Outgoing network traffic |1 秒あたりのSQLServerアウトバウンドトラフィック|ビット/秒|
| MySQL Active connections |MySQLのアクティブセッション数|セッション数|
| Read-only instance latency |リードレプリカの遅延|秒|

---

###SLB編
####・レイヤー4監視
|メトリック項目|説明|単位|
|---|---|---|
|Port inbound traffic|	特定ポートのインバウンドトラフィック|ビット/秒|
|Port outbound traffic|	特定ポートのアウトバウンドトラフィック|ビット/秒|
|Number of inbound data packets by port|特定ポートのインバウンドパケット数|回/秒|
|Number of outbound data packets by port|特定ポートのアウトバウンドパケット数|回/秒|
|Number of new port connections|特定ポートの新規接続数|接続数|
|Number of active port connections|特定ポートのアクティブ接続数|接続数|
|Number of inactive port connections|特定ポートの非アクティブ接続数|接続数|
|Number of concurrent port connections|特定ポートの総接続数|接続数|
|Number of backend healthy ECS instances by port|特定ポートのヘルスチェック正常のECS数|台|
|Number of backend unhealthy ECS instances by port|特定ポートのヘルスチェック異常のECS数|台|
|Number of discarded port connections|特定ポートの廃棄接続数|回/秒|
|Number of discarded inbound data packets by port|特定ポートのインバウンド廃棄接続数|回/秒|
|Number of discarded outbound data packets by port|特定ポートのアウトバウンド廃棄接続数|回/秒|
|Number of discarded inbound bandwidth by port|特定ポートのインバウンド廃棄トラフィック|ビット/秒|
|Number of discarded outbound bandwidth by port|特定ポートのアウトバウンド廃棄トラフィック|ビット/秒|
|Number of active instance connections|アクティブ接続数|回/秒|
|Number of inactive instance connections|非アクティブ接続数|回/秒|
|Number of discarded instance connections|廃棄接続数|回/秒|
|Number of discarded inbound data packets by instance|廃棄インバウンドパケット数|回数/秒|
|Number of discarded outbound data packets by instance|廃棄アウトバウンドパケット数|回数/秒|
|Discarded inbound bandwidth by instance|廃棄インバウンドトラフィック|ビット/秒|
|Discarded outbound bandwidth by instance|廃棄アウトバウンドトラフィック|ビット/秒|
|Number of concurrent instance connections|接続総数|回/秒|
|Number of new instance connections|新規接続数|回/秒|
|Number of inbound data packets by instance|インバウンドパケット数|回/秒|
|Number of outbound data packets by instance|アウトバウンドパケット数|回/秒|
|Number of inbound bandwidth by instance|インバウンドトラフィック|ビット/秒|
|Number of outbound bandwidth by instance|アウトバウンドトラフィック|ビット/秒|

####・レイヤー7監視
|メトリック項目|説明|単位|
|---|---|---|
|Port QPS|特定ポートのQPS	|回/秒|
|Port RT|特定ポートの平均要求待ち時間|ミリ秒|
|Status codes of the format 2xx|特定ポートの2xxのステータスコードの数|回/秒|
|Status codes of the format 3xx|特定ポートの3xxのステータスコードの数|回/秒|
|Status codes of the format 4xx|特定ポートの4xxのステータスコードの数|回/秒|
|Status codes of the format 5xx|特定ポートの5xxのステータスコードの数|回/秒|
|Other status codes	SLB|特定ポートのその他ステータスコードの数|回/秒|
|Upstream status codes of the format 4xx|特定ポートのRSから返す4xxのステータスコードの数|回/秒|
|Upstream status codes of the format 5xx|特定ポートのRSから返す5xxのステータスコードの数|回/秒|
|Upstream RT|	特定ポートのRSからプロキシへの平均リクエスト遅延|ミリ秒|
|Instance QPS|SLBのQPS|回/秒|	
|Instance RT|SLBの平均リクエストレイテンシ|回/秒|
|Instance Status codes of the format 2xx|SLBの2xxのステータスコードの数|回/秒|
|Instance Status codes of the format 3xx|SLBの3xxのステータスコードの数|回/秒|
|Instance Status codes of the format 4xx|SLBの4xxのステータスコードの数|回/秒|
|Instance Status codes of the format 5xx|SLBの5xxのステータスコードの数|回/秒|
|Instance Other status codes	SLB|SLBのその他ステータスコードの数|回/秒|
|Instance Upstream status codes of the format 4xx|SLBのRSから返す4xxのステータスコードの数|回/秒|
|Instance Upstream status codes of the format 5xx|SLBのRSから返す5xxのステータスコードの数|回/秒|
|Instance Upstream RT|SLBのRSからプロキシへの平均リクエスト遅延|ミリ秒|

---

##イベント監視
CloudMonitorの性能監視と同様に、各製品のシステムイベント監視をも無料で提供しています。製品インスタンスが実行中発生したシステムイベントを確認し、もっと簡単に問題を特定することができます。もちろん監視イベントに対するアラーム設定も可能です。使用可能なシステムイベント監視項目は下記となります。

###ECS編
|イベント名|説明|イベントタイプ|イベントステータス|重要度|
|---|---|---|---|---|
|Instance:InstanceFailure.Reboot|フェイラーにより再起動開始|Exception|Executing|CRITICAL|
|Instance:InstanceFailure.Reboot|フェイラーにより再起動終了|Exception|Executed|CRITICAL|
|Instance:SystemFailure.Reboot|システムエラーにより再起動開始|Exception|Executing|CRITICAL|
|Instance:SystemFailure.Reboot|システムエラーにより再起動終了|Exception|Executed|CRITICAL|
|Instance:SystemMaintenance.Reboot|メンテナンスにより再起動予定|Maintenance|Scheduled|CRITICAL|
|Instance:SystemMaintenance.Reboot|メンテナンスにより再起動回避|Maintenance|Avoided|CRITICAL|
|Instance:SystemMaintenance.Reboot|メンテナンスにより再起動中|Maintenance|Executing|CRITICAL|
|Instance:SystemMaintenance.Reboot|メンテナンスにより再起動終了|Maintenance|Executed|CRITICAL|
|Instance:SystemMaintenance.Reboot|メンテナンスにより再起動取消|Maintenance|Canceled|CRITICAL|
|Instance:SystemMaintenance.Reboot|メンテナンスにより再起動失敗|Maintenance|Failed|CRITICAL|
|Disk:Stalled|ディスク性能影響受ける開始|Exception|Executing|CRITICAL|
|Disk:Stalled|ディスク性能影響受ける終了|Exception|Executed|CRITICAL|
|Instance:StateChange|インスタンスステータス変更 `Running、Stopped、Deleted`|StatusNotification|Normal|INFO|
|Instance:PreemptibleInstanceInterruption|スポットインスタンス中断|StatusNotification|Normal|WARN|
|Snapshot:CreateSnapshotCompleted|スナップショット作成終了|StatusNotification|Normal|INFO|

---

###RDS編
|イベント名|説明|イベントステータス|重要度|
|---|---|---|---|
|Instance_Failover|フェールオーバ発生|Executed|WARN|
|Instance_Failure_Start	|フェール開始|Executing|CRITICAL|
|Instance_Failure_End|フェール終了|	Executed|CRITICAL|

---

###SLB編
|イベント名|説明|重要度|
|---|---|---|
|CertKeyExpired_1|証明書は1日後に失効|WARN|
|CertKeyExpired_3|証明書は3日後に失効|WARN|
|CertKeyExpired_7|証明書は7日後に失効|WARN|
|CertKeyExpired_15|証明書は15日後に失効|WARN|
|CertKeyExpired_30|証明書は30日後に失効|WARN|
|CertKeyExpired_60|証明書は60日後に失効|WARN|

---

##カスタム監視
ECS製品の性能監視／イベント監視に提供してないメトリック項目、またはAlibabaCloud製品以外の仮想サーバーのデータをCloudMonitorに連携して監視することができます。連携方式はOpenAPI、Java SDK、Aliyun CLI、3つの方式があります。下記はMACでのAliyun CLIの使用例を紹介します。

1.　AccessIDとAccessKeyを作成します。作成方法は[ドキュメント](https://jp.alibabacloud.com/help/doc-detail/53045.html)をご参考ください。

2.　Go言語のAliyun CLIツールの最新版をローカルにダウンロードします。ダウンロード先は[こちら](https://github.com/aliyun/aliyun-cli/releases)です。

3.　MACの場合、ダウンロードしたファイルを`/usr/local/bin`配下に移動します。

4.　Aliyun CLIの環境変数を設定します。

```
$ aliyun configure
Configuring profile 'default' in 'AK' authenticate mode...
Access Key Id []: <Your AccessKey ID>
Access Key Secret []: <Your AccessKey Secret>
Default Region Id []: ap-northeast-1
Default Output Format [json]: json (Only support json)
Default Language [zh|en] en: en
Saving profile[default] ...Done.
Configure Done!!!
```

5.　カスタムデータをCloudMonitorにアップロードします。

```
$ aliyun cms PutCustomMetric --MetricList.1.GroupId "1" --MetricList.1.MetricName cpu_total --MetricList.1.Dimensions '{"sampleName1":"value1","sampleName2":"value2"}' --MetricList.1.Time 20190919T145500.000+0900 --MetricList.1.Type 0 --MetricList.1.Period 60 --MetricList.1.Values '{"value":10.5}' 
{
	"Message": "success",
	"RequestId": "1EBC8667-911A-46FC-88CD-D3BDDBC5B798",
	"Code": "200"
}
```

**パラメータ説明**

|パラメータ名|タイプ|必須かどうか|説明|
|---|---|---|---|
|groupId|long|はい|グループID|
|metricName|string|はい|監視項目名。英文字、数字、符号`_-./\`を利用可能、最大64バイト|
|dimensions|object|はい|ディメンジョンマップ。key-value形式、英文字、数字、符号`_-./\`を利用可能、最大10ペア、keyおよびvalue各最大64バイト|
|time|string|はい|監視時刻。“yyyyMMdd’T’HHmmss.SSSZ”またはlongタイムスタンプ対応。例、“20171012T132456.888+0800”または“1508136760000”|
|type|int|はい|監視値種類、0は生データ、1は集約データ|
|period|string|いいえ|集約期間、単位：秒。type=1の場合、指定必須。値：60、300|
|values|object|はい|監視値。type=0の場合、キーは "value"。type=1の場合、最大値、カウント数、合計値を指定可能|


##APIにより監視データの外部連携
APIにより、CloudMonitorの監視データを取得し、外部監視システムと連携することができます。下記3つのインターフェイスを提供しています。

・[DescribeProjectMeta](https://www.alibabacloud.com/help/doc-detail/114916.htm)

CloudMonitorが時系列で監視可能な製品情報の取得

・[DescribeMetricMetaList](https://www.alibabacloud.com/help/doc-detail/98846.htm)

CloudMonitorが時系列で監視可能なメトリック情報の取得

・[DescribeMetricList](https://www.alibabacloud.com/help/doc-detail/51936.htm)／[DescribeMetricLast](https://www.alibabacloud.com/help/doc-detail/51939.htm)

CloudMonitorが収集したメトリックデータリスト、または最新メトリックデータの取得

```
/**
 * 指定期間内の監視データのクエリ例
 */
 
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.profile.DefaultProfile;
import com.google.gson.Gson;
import java.util.*;
import com.aliyuncs.cms.model.v20190101.*;

public class DescribeMetricList {

    public static void main(String[] args) {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "<accessKeyId>", "<accessSecret>");
        IAcsClient client = new DefaultAcsClient(profile);

        DescribeMetricListRequest request = new DescribeMetricListRequest();
        //namespaceとmetricはDescribeMetricMetaList、DescribeProjectMetaで取得可能
        request.setNamespace("acs_ecs_dashboard");
        request.setMetricName("cpu_total");
        //periodは取得期間は60s
        request.setPeriod("60");
        //レコード数を指定、最大1000まで
        request.setLength("1000");
        //クエリの開始時間
        request.setStartTime("2019-07-22 11:00:00");
        //クエリの終了時間
        request.setEndTime("2019-07-22 12:00:00");
        //クエリdimensionを指定（結果をフィルタ）
        request.setDimensions("[{\"instanceId\":\"i-8vb******\"}]");

        try {
            DescribeMetricListResponse response = client.getAcsResponse(request);
            System.out.println(new Gson().toJson(response));
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            System.out.println("ErrCode:" + e.getErrCode());
            System.out.println("ErrMsg:" + e.getErrMsg());
            System.out.println("RequestId:" + e.getRequestId());
        }

    }
}
```

##Grafanaにより監視データの可視化
CloudMonitorがGrafana連携用のプラグインを提供しています。Grafanaにより監視データの可視化りようには便利です。下記ではGrafana用プラグインのインストールからデータ可視化までの手順を説明します。

1.　AccessIDとAccessKeyを作成します。作成方法は[ドキュメント](https://jp.alibabacloud.com/help/doc-detail/53045.html)をご参考ください。


2.　Grafanaをインストールします。インストール方法は[Grafana公式ドキュメント](https://grafana.com/docs/installation/)をご参考ください。


3.　Grafanaを起動します。

```
 # service grafana-server start
```

4.　GrafanaにCloudMonitor用プラグインをインストールします。

```
# cd /var/lib/grafana/plugins/
# git clone https://github.com/aliyun/aliyun-cms-grafana.git 
# service grafana-server restart
```

5.　Grafanaにログインし、左側メニューの「Configure ー DataSource」をクリックします。
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/1.jpg)

6.　「Add data source」をクリックします。
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/2.jpg)

7.　「CMS Grafana Service」を選択します。
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/3.jpg)

8.　CMS Grafana Service用パラメータを設定し、保存します。

```
Name：CMS Grafana Service
URL：http://metrics.ap-northeast-1.aliyuncs.com
AccessKeyId：<Your AccessKey ID>
AccessKey：<Your AccessKey Secret>
```
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/4.jpg)

9.　左側メニューの「Configure ー Manage」をクリックします。
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/5.jpg)

10.　「New Dashboard ー Add Query」をクリックします。
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/6.jpg)
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/7.jpg)

11.　Grafanaのクエリパラメータを選択/入力し、CloudMonitorのデータを可視化にします。

```
Data Source：CMS Grafana Service
Project：<acs_xxx_dashboard>
Metric：<監視メトリック>
Period：<監視期間メトリック>
Group:<グループモニタリング>
Dimensions:<インスタンス>
Y-column:Minimum/Average/Maximum
X-column:timestamp
Y-column describe:<Y軸カスタマイズ接続語>
```
![](https://jiang-bestpratice.oss-ap-northeast-1.aliyuncs.com/8.jpg)