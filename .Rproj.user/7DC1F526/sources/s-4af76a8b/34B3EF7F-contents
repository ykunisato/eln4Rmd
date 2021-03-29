library(osfr)

# osf_auth("ThIsIsNoTaReAlPaTbUtYoUgEtIt")

eln4osfr_node <- osf_retrieve_node("https://osf.io/tf2he")
labnote <- osf_create_component(eln4osfr_node, title = "labnote")

#　labnoteが複数できてしまった。コンポーネントにアクセスする方法が必要

# 画像を別にアップする
osf_upload(labnote, path = "demo.png")

# Markdownでどう挿入するかが悩ましい
osf_upload(labnote, path = "2021_03_25.md")

# 画像ファイルをアップロードしたら，そのファイルのリンクアドレスを返す関数がほしい。
# それをmarkdownに貼り付けをすればいい。

# 上書きする場合
osf_upload(labnote, path = "2021_03_22.md",conflicts = "overwrite")

#むむむ。osfにラボノートセクションを作って，そこにmdファイルを追加していく戦略だが，
#画像の連携がまずいな・・・