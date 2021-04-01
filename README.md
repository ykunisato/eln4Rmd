
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

### OSFやGitHubと連携しない場合

elnjp()で日付のついた電子ラボノート用Rmdファイルが作成されます。なお，日付の後に何か名前を追加したい場合は，add_nameで指定ください。また，今日の日付じゃない日付で作成したい場合は，replace_dayで指定ください。

``` r
library(eln4Rmd)
elnjp()
```

作成したラボノートにはタイムスタンプが必要ですので，手動でOSFやGitHubと連携をさせてください。

### 作成したMarkdownファイルを電子ラボノートとして機能させるには

＜準備中＞



### osfに連携させる場合

ブラウザからOSFでプロジェクトを作成し，Labnoteなどの名前のコンポーネントを作ります。そして，そのコンポーネントをクリックして，そのURLをコピーしておきます。また，OSFでは，PAT(Personal Access Token)を取得しておきます（こちらは厳重に保管ください）。

それができたら，Rで作業します。まずは，osfrのosf_auth()でPATの登録をします。

``` r
library(osfr)
osf_auth("OSFのPAT(Personal Access Token)をコピペする")
```

elnjp_osf()で電子ラボノート用Rmdファイルが作成されます。その際に，上記で作成したOSFのLabnoteコンポーネントのURLを引数に入れてください。

``` r
library(eln4Rmd)
elnjp_osf(osf="https://osf.io/hq8d9/")
```

ラボノートへの記載ができたら，Knitをすると，PDF形式で出力され，それがOSFの指定したURLにアップロードされます（PDFのみがアップロードされます）。

### GitHubにアップロードして，osfと連携させる方法

まず，作業するプロジェクトをGitリポジトリにしておく。そして，gitcredsパッケージのgitcreds_set()で必要事項を追加しておく。

以下を実行すると，Rmdファイルができるので，その日のラボノートを作成して，Knitする。KnitするとMarkdownファイルが出力され，変更されたファイルにコミットして，プッシュします。

``` r
library(eln4Rmd)
elnjp_git()
```
