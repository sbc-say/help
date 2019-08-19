---
title: "Container Architecture"
description: "Alibaba Cloudでコンテナを活用したシステム構成を紹介します。"
date: 2019-08-20T16:20:40+09:00
weight: 30
draft: true
---

そもそもコンテナを利用する事で、どんな事が実現できるか。
 1. 開発スピードが早くなり、機能実装やバグ修正までの時間を短くする
 1. 開発環境と本番環境の差分が最小限となり、人的バグを極小化する
 1. オンプレミスやクラウドを問わず、デプロイが容易になる

これらをAlibaba Cloudのサービスを使って、どのように実現出来るかを紹介いたします。  

## 全体アーキテクチャ

システム構成  
![Show as JPEG](/help/image/23.1.png)

開発フロー  
![Show as JPEG](/help/image/23.1.png)

コンテナを用いる上では、エンドユーザから見た効果はほぼ同じであるが、
開発フローを刷新する事で、コンテナを最大限活用できます。
その為に、開発フローに焦点を当てて、コンテナの活用方式を紹介いたします。

### 開発フロー
1. 開発環境
1. バージョン管理
1. イメージビルド
1. イメージレジストリ
1. デプロイ・管理方式
1. モニタリング

## バージョン管理
- 選択肢
  - Github/Gitlab/Bitbucket
  - Github/Gitlab/Bitbucket以外のレジストリ

### Github/Gitlab/Bitbucket
Alibaba CloudではGithub/Gitlab/Bitbucketのアカウントと連携する事ができ
こちらをベストプラクティスとしております。

Alibaba Cloudのコンテナベストプラクティス
https://www.alibabacloud.com/help/doc-detail/60951.htm

コンテナ自動ビルドの設定
https://www.alibabacloud.com/help/doc-detail/60997.htm

### Github/Gitlab/Bitbucket以外のレジストリ
Github/Gitlab/Bitbucket以外のアカウントでバージョン管理した場合、
自動ビルドが設定されない為、JenkinsやCircleCIで直接スクリプト実行する必要があります。
したがってAlibaba Cloudを活用する上ではGithub/Gitlab/Bitbucketのいずれかを採用する事を推奨いたします。

# それぞれのベストプラクティスを描く感じなので、Kubeをめちゃめちゃ使う感じではない
