# eln4Rmd

<!-- badges: start -->
<!-- badges: end -->

## eln4Rmdは2022/3/15をもって開発を終了しました。eln4Rmdに含まれている関数は，今後，[psyinfr](https://github.com/ykunisato/psyinfr)パッケージでメンテナンスをする予定です。

eln4Rmdは，電子ラボノートのためのRmdテンプレート用Rパッケージです。まだ開発中ですので，生暖かく見守っていただけたらと思います。

## Installation
インストール
以下のコマンドをRコンソールに打ち込んで，Github経由でインストールしてください(remotesがない方はinstall.packages()でインストールください)。

``` r
# install.packages("remotes")
remotes::install_github("ykunisato/eln4Rmd")
```

## 使用法

### 電子ラボノートを作る

elnjp_pdf()で日付のついた電子ラボノート用Rmdファイルが作成されます。これをknitするとPDFファイルが出力されます（markdownを出力したい場合は，elnjp_md()もありますが，こちらはOSFへのアップロードには対応していません）。

``` r
eln4Rmd::elnjp_pdf()
```

例えば，研究した日に記録するのを忘れていて記入忘れをしている場合は，replace_dayで日付を指定できます。以下の場合は，2021-04-01に指定しています。また，分かりやすいようにファイル名に名前を足すこともadd_nameでできます。以下の場合は，april_fool_expを指定しています。結果として，"2021-04-01_april_fool_exp.Rmd"という名前のファイルができます。

``` r
eln4Rmd::elnjp_pdf(add_name = "april_fool_exp" , replace_day = "2021-04-01")
```

作成したラボノートにはタイムスタンプが必要です。タイムスタンプをつけないと，その日（もしくは後日に）に記録したのかの保証ができないので，電子ラボノートとして機能させる場合は，以下のようにOSFもしくはGitHubと連携をさせてください。

### osfと連携させる方法

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

#### (3) ラボノートの内容を書いてknitして，OSFにアップする。

- 電子ラボノートは以下の関数で作れます。内容を書いて，knitすれば，PDF形式で出力されます。

``` r
eln4Rmd::elnjp_pdf()
```

- 作成したPDFを確認してから，(2)で調べたOSFでのURLをいれて，以下の関数を実行するとOSFにアップロードされます（OSFに上でタイムスタンプが押されます）。

``` r
eln4Rmd::up_elnjp_osf(eln_osf = "OSFのラボノート用コンポーネントのURL")
```

さらに，OSFのラボノートコンポーネントにラボノートをアップするのと同時に，Research Compendiumの内容のバックアップをOSFにとりたい場合は，OSFにResearch Compendium用のコンポーネントを作成して，そのURLを使って以下のように実行します。なお，以下を実行する場合は，Research Compendiumをカレントディレクトリに指定して，そのサブディレクトリにlabnoteフォルダが存在することが前提になります。

``` r
eln4Rmd::up_elnjp_osf(eln_osf = "OSFのラボノート用コンポーネントのURL", rc_osf = "OSFのResearch Compendium用コンポーネントのURL")
```

- 一度(1)と(2)の設定ができていれば，あとは，毎日(3)を行うだけです（関数としては２回実行するだけ）。
- なお，elnjp_pdf()で，add_nameやreplace_dayを指定している場合は，up_elnjp_osf()でも同様の指定をしてください。


### GitHubと連携させる方法


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

#### (3) ラボノートの内容を書いてknitして，GitHubにアップ（コミット＆プッシュ）する

- 電子ラボノートは以下の関数で作れます。内容を書いて，knitすれば，PDF形式で出力されます。

``` r
eln4Rmd::elnjp_pdf()
```

- 作成したPDFを確認してから，以下の関数を実行するとPDFという名前のフォルダを作ってそこにPDFをを保存したうえ，コミットをした上で，GitHubにプッシュしてくれます(GitHubにタイムスタンプが残ります）。

``` r
eln4Rmd::up_elnjp_git()
```
- 一度(1)と(2)の設定ができていれば，あとは，毎日(3)を行うだけです（関数としては２回実行するだけ）。
- なお，elnjp_pdf()で，add_nameやreplace_dayを指定している場合は，up_elnjp_git()でも同様の指定をしてください。
