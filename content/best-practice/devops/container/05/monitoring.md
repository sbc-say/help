---
title: "ログ管理とモニタリング"
description: "Alibaba Cloudでコンテナを活用する際のログ管理とモニタリング手法を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 50
draft: false
---
本記事では、ログ管理とモニタリングについて紹介いたします。

1. 開発環境
1. コンテナイメージ管理
1. コンテナデプロイ管理
1. ログ管理とモニタリング

ログ管理とモニタリングでは、OSS/Enterprise製品とパブリックサービスの２点に焦点を当てて紹介します。

## ログ管理・モニタリング
- OSS/Enterprise製品の活用
- パブリックサービスの活用
- Alibaba Cloudでの選択肢

### OSS/Enterprise製品の活用
Container環境においてアプリケーションログとインフラログを対象にして、
ログ管理・集計の製品と、それらをGUIとして可視化する製品の組み合わせがあります。

- Fluentd + Elasticsearch + Kibana  
- Prometheus/Grafana
- Loki/Grafana

### パブリックサービスでの活用
クラウド型のサービスとしてDatadogやNew Relicを活用するのも広がっています。

- Datadog
- New Relic

### Alibaba Cloudにおける選択肢
Alibaba Cloudにおいてコンテナ内のログとコンテナ外のログを確認する事があります。
コンテナ内のログはLogServiceを有効化して、同ログを蓄積するように設定する事が一般的です。
コンテナ外のログ、例えばECSやKubernetesのログに関してはCloudMonitorで確認する事が出来ます。
CloudMonitorに加えて、Prometheusの利用も推奨されており、共にGrafanaを利用して可視化します。
ReadOnlyのアクセスキーを払い出す事がルール上許されれば、Datadogを利用して監視する事も可能です。

アプリケーションログ
  - LogService
  - Datadog
インフラログ
  - CloudMonitor/Grafana
  - Prometheus/Grafana
  - Datadog

### 参考リンク一覧
|タイトル|URL|
| ---- | ---- |
|Prometheusモニタリングシステムのデプロイ|https://jp.alibabacloud.com/help/doc-detail/94622.htm|
|System Monitoring using Prometheus and Grafana|https://www.alibabacloud.com/blog/system-monitoring-using-prometheus-and-grafana_594356|
| Deploy the Prometheus monitoring system | https://www.alibabacloud.com/help/doc-detail/94622.htm |
| Kubernetes Cluster Monitoring Using Prometheus | https://www.alibabacloud.com/blog/kubernetes-cluster-monitoring-using-prometheus_594722 |
| Alibaba Cloud Container Service for Kubernetes （ACK)）徹底解説 | https://www.slideshare.net/sbcloud/alibaba-cloud-container-service-for-kubernetes-ack |
| Connect CloudMonitor to Grafana | https://www.alibabacloud.com/help/doc-detail/109434.htm |
| Log Service Best Practice (PDF) | http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/pdf/sls-best-practices-intl-en-2018-01-24.pdf |
