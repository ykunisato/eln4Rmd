
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

elnjp()で日付のついた電子ラボノート用Rmdファイルが作成されます。

``` r
library(eln4Rmd)
elnjp()
```

例えば，研究した日に記録するのを忘れていて記入忘れをしている場合は，replace_dayで日付を指定できます。以下の場合は，2021-04-01に指定しています。また，分かりやすいようにファイル名に名前を足すこともadd_nameでできます。以下の場合は，april_fool_expを指定しています。結果として，"2021-04-01_april_fool_exp.Rmd"という名前のファイルができます。

``` r
library(eln4Rmd)
elnjp(add_name = "april_fool_exp" , replace_day = "2021-04-01")
```

作成したラボノートにはタイムスタンプが必要です。タイムスタンプをつけないと，その日（もしくは後日に）に記録したのかの保証ができないので，電子ラボノートとして機能させる場合は，以下のようにOSFもしくはGitHubと連携をさせてください。

### osfと連携させる場合

#### (1) OSFのPAT(Personal Access Token)の登録

- OSF(https://osf.io)のアカウントを作って，OSFのPAT(Personal Access Token)を以下のsettingsページで作成します。"Create Token"をクリックして，"Token name"に適当な名前を英語でつけます。Scopesのところのチェックボックスにチェックをいれます。出てきた英数字の文字列をコピーします。なお，これはOSFへのアクセスを許可するトークンですので，パスワードなどと同様に厳重に保管をしてください（パスワード管理ソフトの使用を推奨します）。

https://osf.io/settings/tokens

- 上記のOSFのPAT(Personal Access Token)を.Renvironに登録します。以下のようにusethisパッケージを使うと.Renvironがなければ作成した開いてくれます。

``` r
library(usethis)
edit_r_environ()
```

- 以下を開いた.Renvironに貼り付けます。そして，"＜ご自身のOSFのPATに差し替えください＞"の部分を，上記で作成したOSFのPATに差し替えます。

```
OSF_PAT=＜ご自身のOSFのPATに差し替えください＞
```

- PATの登録を機能させるために，以下のコードでRを再起動します。

``` r
.rs.restartR()
```

#### (2) OSFのプロジェクトページを作成して，ラボノートを置くコンポーネントを作る

- ブラウザからOSFでプロジェクトを作成します。
- Labnoteなどの名前でコンポーネントを作ります。そして，そのコンポーネントをクリックして，そのURLをコピーしておきます(次で使います)。

#### (3) elnjp_osf()でOSF用の電子ラボノートを作成する

- elnjp_osf()で電子ラボノート用Rmdファイルが作成されます。その際に，上記で作成したOSFのLabnoteコンポーネントのURLを引数に入れてください。以下を実行すると，カレントディレクトリーに日付のついたRmdファイルが生成されて，開かれます。

``` r
library(eln4Rmd)
elnjp_osf(osf="https://osf.io/hq8d9/")
```

- 今日以外の日付でラボノートを作りたい場合は，replace_dateに別の日付をいれると，その日付でラボノートが作られます。

``` r
elnjp_osf(replace_date = "2021-03-25", osf="https://osf.io/5yrhf/")
``` 

#### (4) ラボノートの内容を書いてknitする。

- 開いたRmdファイル形式のラボノートに内容を記載ができたら，Knitしてください。すると，PDF形式で出力され，それがOSFの指定したURLにアップロードされます（PDFのみがアップロードされます）。

- 以降は，同じOSFのコンポーネントにアップロードするのであれば，(3)と(4)を実行するだけで良いです。以下のようにするとより短縮できます。

``` r
eln4Rmd::elnjp_osf(osf="OSFのURL")
```

### GitHubと連携させる場合


#### (1) GitHubアカウントとリポジトリの作成する

- GitHubアカウントを作成します。作成方法の解説は多いので，読みやすいものを参考に作成ください。
- ラボノートをアップする用のGitHubリポジトリを作成ください。最初から公開することはないと思うので，プライベートリポジトリで作成ください。
- 以下を参考にして，GitHubのPersonal Access Token(PAT)を作成します。PATはパスワードと同じ情報なので，厳重に管理ください。

https://docs.github.com/ja/github/authenticating-to-github/creating-a-personal-access-token


#### (2) RStudioでユーザー名，メールアドレス，PATを登録する

- Rstudio上で，use_git_config()を使って，ユーザー名とメールアドレスを登録してください。

``` r
usethis::use_git_config(user.name = "Taro Yamada", user.email = "tyamada@example.com")
```

- Rstudio上で，gitcreds_set()を使って，PATを登録してください。"? Enter password or token: "と聞かれるので，上記のPATを貼り付けます。

``` r
gitcreds::gitcreds_set()
```

#### (3) elnjp_git()でGitHub用の電子ラボノートを作成する

- elnjp_git()で電子ラボノート用Rmdファイルが作成されます。以下を実行すると，カレントディレクトリーに日付のついたRmdファイルが生成されて，開かれます。

``` r
library(eln4Rmd)
elnjp_git()
```

- 今日以外の日付でラボノートを作りたい場合は，replace_dateに別の日付をいれると，その日付でラボノートが作られます。

``` r
elnjp_git(replace_date = "2021-03-25")
``` 

#### (4) ラボノートの内容を書いてknitする。

- 開いたRmdファイル形式のラボノートに内容を記載ができたら，Knitしてください。すると，PDF形式で出力され，Rmdや関連するファイルを含めてコミットをして，GitHubリポジトリにプッシュします。

- 以降は，(3)と(4)を実行するだけで良いです。以下のようにするとより短縮できます。

``` r
eln4Rmd::elnjp_git()
```
