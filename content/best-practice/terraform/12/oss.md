---
title: "OSSの作成"
date: 2019-07-22T00:00:00+09:00
description: "Terraformによる、Alibaba CloudのObject Storage Serviceリソース作成方法を紹介します。"
weight: 120
draft: false
---

AlibabaCloudの基本プロダクトサービスであるObject Storage Serviceの作成方法を解説します。

### 1. OSS
&nbsp; Object Storage Service （OSS）は、クラウド内の任意の量のデータの保存、バックアップ、およびアーカイブを可能にするストレージサービスです。

<br>

### 2. コンポーネント
&nbsp; OSSはTerraform モジュールを使用して、バケットとオブジェクトを管理できます。
例として、

* バケット管理機能
* バケットの作成
* バケットの ACL を設定
* バケットに CORS (Cross-Origin Resource Sharing) を設定
* バケットのログ記録を設定
* バケットの静的 Web サイトホスティングを設定
* バケットのリファラを設定
* バケットのライフサイクルルールを設定
* オブジェクト管理機能
* オブジェクトをアップロード
* オブジェクトのサーバー側の暗号化を設定
* オブジェクトに ACL を設定
* オブジェクトメタを設定

などが上げられます。

<br>

### 3. OSSのTerraformについて
&nbsp; 本題、OSS作成に移ります。プライベートバケットを作成するという簡単なソースを作ってみます。

```
resource "alicloud_oss_bucket" "bucket-acl"{
  bucket = "bucket-170309-acl"
  acl = "private"
}
```
#### **alicloud_oss_bucket**

* `bucket` - （オプション）バケットの名前。
* `acl` - （任意）ACL。デフォルトは "private"。

他、OSSに関しては**alicloud_oss_bucket**だけで色々なリソース作成が可能です。例えば以下の例があります。

<br>
静的Webサイト

```
resource "alicloud_oss_bucket" "bucket-website" {
  bucket = "bucket-170309-website"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```

<br>
ロギングを有効化

```
resource "alicloud_oss_bucket" "bucket-target"{
  bucket = "bucket-170309-acl"
  acl = "public-read"
}

resource "alicloud_oss_bucket" "bucket-logging" {
  bucket = "bucket-170309-logging"

  logging {
    target_bucket = "${alicloud_oss_bucket.bucket-target.id}"
    target_prefix = "log/"
  }
}
```

<br>
参照元の構成確認

```
resource "alicloud_oss_bucket" "bucket-referer" {
  bucket = "bucket-170309-referer"
  acl = "private"

  referer_config {
      allow_empty = false
      referers = ["http://www.aliyun.com", "https://www.aliyun.com"]
  }
}
```

<br>
OSSライフサイクルルールの設定

```
resource "alicloud_oss_bucket" "bucket-lifecycle" {
  bucket = "bucket-170309-lifecycle"
  acl = "public-read"

  lifecycle_rule {
    id = "rule-days"
    prefix = "path1/"
    enabled = true

    expiration {
      days = 365
    }
  }
  lifecycle_rule {
    id = "rule-date"
    prefix = "path2/"
    enabled = true

    expiration {
      date = "2018-01-12"
    }
  }
}
```

<br>
バケットのアクセスポリシー設定

```
resource "alicloud_oss_bucket" "bucket-policy" {
  bucket = "bucket-170309-policy"
  acl = "private"

  policy = <<POLICY
  {"Statement":
      [{"Action":
          ["oss:PutObject", "oss:GetObject", "oss:DeleteBucket"],
        "Effect":"Allow",
        "Resource":
            ["acs:oss:*:*:*"]}],
   "Version":"1"}
  POLICY
}
```

<br>
低コストアクセスソリューション（IA）を実施

```
resource "alicloud_oss_bucket" "bucket-storageclass"{
  bucket = "bucket-170309-storageclass"
  storage_class = "IA"
}
```
<br>
バケットにて暗号化ルールを付与

```
resource "alicloud_oss_bucket" "bucket-sserule"{
  bucket = "bucket-170309-sserule"
  acl = "private"

  server_side_encryption_rule {
    sse_algorithm = "AES256"
  }
}
```

<br>
バケットにタグを付与

```
resource "alicloud_oss_bucket" "bucket-tags"{
  bucket = "bucket-170309-tags"
  acl = "private"

  tags {
    key1 = "value1"
    key2 = "value2"
  }
}
```

<br>
バケットのバージョニングを有効化

```
resource "alicloud_oss_bucket" "bucket-versioning"{
  bucket = "bucket-170309-versioning"
  acl = "private"

  versioning {
    status = "Enabled"
  }
}
```

他に入力パラメータ、出力パラメータがいくつかありますので、[こちらも是非参照](https://www.terraform.io/docs/providers/alicloud/r/oss_bucket.html)してみてください。
https://www.terraform.io/docs/providers/alicloud/r/oss_bucket.html

<br>
以下にOSSの実際のサンプルを入れていますので、こちらも参照してみてください。

[example: Webアプリケーションの構築]({{% relref "scenario/terraform/web-application.md" %}})

