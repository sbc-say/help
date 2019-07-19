## Hugo Install
 `https://gohugo.io/getting-started/installing/`の写し
### Macでのインストール
1. Golangのインストール:  
`brew install go`

1. HomebrewでHugoを取得:  
`ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"`

1. Hugoのインストール:  
`brew install hugo`

### Linuxでのインストール
1. Golangのインストール:  
https://golang.org/doc/install

1. Snapdのインストール
https://docs.snapcraft.io/installing-snapd

1. Hugoのインストール
https://gohugo.io/getting-started/installing/#linuxbrew-linux


https://github.com/sbcloud/help/blob/master/static/theme-flex/style.css

# Hugoの仕組みの理解
## Hugoのレイアウトとコンテントの関係
https://ousttrue.github.io/hugo/hugo_layout/

## CSSの設定
以下のCSSが一番強く、追記する時はこちらのファイルを編集ください。
https://github.com/sbcloud/help/blob/master/static/css/custom.css

また既存のCSSは主に以下の2つを参照しており、既存変更はこちらのファイルを編集ください。
https://github.com/sbcloud/help/blob/master/static/theme-flex/style.css
https://github.com/sbcloud/help/blob/master/static/css/nucleus.css
　→要素が見つからない場合は、grepするか、custom.cssで無理やりOverrideしてください。

# CircleCIノウハウ
1. 下記エラーが出た際には、Rebuildすれば多分問題ない（7月12日1回発生）  
`fatal error: concurrent map read and map write`  
 https://circleci.com/gh/sbcloud/help/118
 からの  
 https://circleci.com/gh/sbcloud/help/119


1. Conflict解消させる為にGithub Webから変更してコミットすると、
ユーザ名が変な感じ（user.email 45812491+hoge@users.noreply.github.com）になって、  
deployに失敗する。なので、Webから変更した後に、自分のローカルで適当なCommitで上書きすると  
成功する。  
