#!/usr/bin/env bash

# エラー時、実行を止める
set -e

# OSS Configuration
cat <<EOL >> ~/.ossutilconfig
[Credentials]
language=EN
endpoint=oss-ap-northeast-1.aliyuncs.com
accessKeyID=$OSS_ACCESS_KEY_ID
accessKeySecret=$OSS_ACCESS_KEY_SECRET
EOL

## Replace HTML output for OSS deployment
find ./docs/* -type f -name index.html -exec sed -i -e  's/\/">/\/index.html">/g' {} \;
find ./docs/* -type f -name index.html -exec sed -i -e  's/\/" title=/\/index.html" title=/g' {} \;

## Deploy to OSS bucket
ossutil ls oss://technical-reference/help
ossutil ls oss://technical-reference/
ossutil cp -f  ./docs oss://technical-reference/help  --recursive
ossutil cp -f  ./docs/index.html oss://technical-reference/
ossutil cp -f  ./docs/404.html oss://technical-reference/
ossutil ls oss://technical-reference/help
ossutil ls oss://technical-reference/

# EOF
