#!/usr/bin/env bash

# エラー時、実行を止める
set -e

#DEPLOY_DIR=oss-deploy

# gitの諸々の設定
#git config --global push.default simple
#git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
#git config --global user.name $CIRCLE_USERNAME

# oss-deployブランチをossdeployディレクトリにクローン
#git clone -q --branch=oss-deploy $CIRCLE_REPOSITORY_URL $DEPLOY_DIR

# 作業Directoryへ移動
#cd $DEPLOY_DIR

## Replace HTML output for OSS deployment
$ find ./docs/* -type f -name index.html -exec sed -i -e  's/\/">/\/index.html">/g' {} \;
$ find ./docs/* -type f -name index.html -exec sed -i -e 's/help\/image/image/g' {} \;

## Deploy to OSS bucket
ossutil ls oss://technical-reference
ossutil cp -f  ./docs oss://technical-reference/  --recursive
ossutil ls oss://technical-reference

# EOF
