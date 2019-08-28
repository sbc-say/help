---
title: "Webアプリケーションのアーキテクチャ"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-05-13T16:20:40+09:00
weight: 10
draft: false
---

Webアプリケーションを構築する上でどのプロダクトを用いれば良いのか。
そして、どのような特徴・設計ポイントがあるのかをレイヤー別に紹介します。

## 全体アーキテクチャ
システム構成  
![Show as JPEG](/help/image/23.1.png)

### Components
1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース/キャッシュ
1. 静的コンテンツ


http://alicloud-common.oss-ap-southeast-1.aliyuncs.com/Alibaba%20Cloud%20Solution%20Infrastructure%20-%20Web%20Application%20Hosting.pdf

How to Set up a Website with Alibaba Cloud Web Hosting and Domains
https://www.alibabacloud.com/getting-started/projects/how-to-set-up-a-website-with-alibaba-cloud-web

