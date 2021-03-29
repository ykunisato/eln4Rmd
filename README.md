
# eln4Rmd

<!-- badges: start -->
<!-- badges: end -->

eln4Rmdは，電子ラボノートのためのRmdテンプレート用Rパッケージです。まだ開発中ですので，生暖かく見守っていただけたらと思います。

## Installation
インストール
以下のコマンドをRコンソールに打ち込んで，Github経由でインストールしてください(remotesがない方はinstall.packages()でインストールください)。

``` r
# install.packages("remotes")
remotes::install_github("ykunisato/eln4Rmd")
```

## 使用法

new_elsjp()で日付のついた電子ラボノート用Rmdファイルが作成されます。

``` r
library(eln4Rmd)
new_elsjp()
```

## 作成したMarkdownファイルを電子ラボノートとして機能させるには

＜準備中＞

## GitHubにアップロードして，osfと連携させる方法


＜準備中＞


## osfrを使ってosfにアップロードする方法
### 使用準備

``` r
library(osfr)
osf_auth("OSFのPAT(Personal Access Token)をコピペする")
```

### コンポーネントの追加

``` r
eln4osfr_node <- osf_retrieve_node("OSFのプロジェクトのURL")
osf_create_component(eln4osfr_node, title = "labnote")
```

### 作成したlabnoteコンポーネントの情報を取得

``` r
labnote <- osf_retrieve_node("OSFのプロジェクト内のlanoteコンポーネントのURL")
```

### labnoteコンポーネントにファイルをアップロード

``` r
# 画像を別にアップする
osf_upload(labnote, path = "demo.png")
# ラボノートをアップする
osf_upload(labnote, path = "2021_03_25.md")
# 上書きする場合
osf_upload(labnote, path = "2021_03_22.md",conflicts = "overwrite")
```
pathを"."と指定するとカレントディレクトリのファイルがまるごとosfにアップロードされる。ラボノートが複数ある場合は便利です。ただ，conflictsを"overwrite"とすると毎回ファイルを上書きするので，バージョン管理として不適切になります。新規にファイルを作成して，既存のファイルに変更を加えてない場合は，conflictsを"skip"にすると良いかと思います。より高度なバージョン管理をする場合は，GitHubの利用をオススメします。

``` r
osf_upload(my_project,path=".", conflicts = "skip")
```
