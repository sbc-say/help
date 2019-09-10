---
title: "イントロダクション"
description: "Alibaba Cloudを用いたWeb三層アーキテクチャを紹介します。"
date: 2019-09-04T16:20:40+09:00
weight: 10
draft: false
---

### 本記事の狙い
パブリッククラウドの中でもAlibaba Cloudは日本での認知度が低いと言えます。
そんな中、本記事で一般的なWeb三層アプリケーションをAlibaba Cloudでどのように実現できるかを紹介する事で、読者の方々にAlibaba Cloudの基本サービスを理解を深めてもらう事を狙いとしています。言い換えれば、認知度を上げて「Alibaba Cloudが良い意味で他社クラウドサービスと変わらない事」を伝える為となります。

### Web三層モデルによるアプリケーションアーキテクチャ
以下のWeb三層アプリケーションアーキテクチャの構成図に沿って解説します。

![Show as JPEG](/help/image/23.1.png)

上記システム構成を以下の4つのレイヤーに分けて、それぞれAlibaba Cloudでどのような選択肢があり、どのように活用できるのかを説明いたします。

1. 名前解決
1. 負荷分散
1. Web/APサーバ
1. データベース

### 参考リンク
|タイトル|URL|
| ---- | ---- |
|Alibaba Cloud Solution Infrastructure Web Application Hosting.pdf | http://alicloud-common.oss-ap-southeast-1.aliyuncs.com/Alibaba%20Cloud%20Solution%20Infrastructure%20-%20Web%20Application%20Hosting.pdf|
|How to Set up a Website (FTP Server) with Alibaba Cloud Web Hosting and Domains| https://www.alibabacloud.com/getting-started/projects/how-to-set-up-a-website-with-alibaba-cloud-web|
