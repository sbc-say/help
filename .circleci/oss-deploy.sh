#!/usr/bin/env bash

# エラー時、実行を止める
set -e

DEPLOY_DIR=oss-deploy

# gitの諸々の設定
git config --global push.default simple
git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME

# oss-deployブランチをossdeployディレクトリにクローン
git clone -q --branch=oss-deploy $CIRCLE_REPOSITORY_URL $DEPLOY_DIR

# rsyncでhugoで生成したHTMLをOSSへコピー
cd $DEPLOY_DIR
ossutil ls oss://technical-reference
ossutil cp -f  ./ oss://technical-reference/  --recursive
ossutil ls oss://technical-reference

# EOF