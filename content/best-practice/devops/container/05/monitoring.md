---
title: "ログ管理とモニタリング"
description: "Alibaba Cloudでコンテナを活用する際のログ管理とモニタリング手法を紹介します。"
date: 2019-08-13T16:20:40+09:00
weight: 50
draft: false
---
本記事では、ログ管理とモニタリングについて紹介いたします。

1. 開発環境
1. コンテナイメージの作成・管理
1. コンテナデプロイ管理
1. ログ管理とモニタリング

ログ管理とモニタリングでは、OSS/Enterprise製品とパブリックサービスの２点に焦点を当てて紹介します。その後、Alibaba Cloudにおける推奨を紹介します。

## ログ管理・モニタリング
- OSS/Enterprise製品の活用
- パブリックサービスの活用
- Alibaba Cloudでの選択肢

### OSS/Enterprise製品の活用
Container環境においてアプリケーションログとインフラログを対象にして、ログ管理・集計の製品と、それらをGUIとして可視化する製品の組み合わせがあります。

- Fluentd + Elasticsearch + Kibana  
- Prometheus/Grafana
- Loki/Grafana

### パブリックサービスでの活用
クラウド型のサービスとしてDatadogやNew Relicを活用するのも広がっています。これらはパブリッククラウドの読み取り権限のアクセスキーを登録する事で、パブリッククラウドインフラ全体のログを収集・可視化する事ができます。また、APMの機能も提供しており、アプリケーションログも並行して取得する事ができます。

- Datadog
- New Relic

### Alibaba Cloudにおける選択肢
Alibaba Cloudにおいてコンテナ内のログとコンテナ外のログを確認する事があります。コンテナ内のログはLogServiceを有効化して、同ログをObject Storage Service(OSS)に蓄積する形が一般的です。ECSやKubernetes等のサーバに関するメトリックはCloudMonitorで確認する事が出来ますが、インフラ全体のログはPrometheusを利用して、Grafanaで可視化する形が推奨されています。また、パブリックサービスの中ではDatadogがAlibaba CloudとのIntegrationを提供しており、同サービス内で一括監視する事も可能です。

アプリケーションログ
  - LogService
  - Datadog APM
インフラログ
  - CloudMonitor/Grafana
  - Datadog Alibaba Cloud Integration
ログ全般
  - Prometheus/Grafana

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
| Best Practices of Log Analysis and Monitoring by Using Kubernetes Ingress | https://www.alibabacloud.com/blog/595084 |
| Technical Best Practices for Container Log Processing | https://www.alibabacloud.com/blog/594955 |