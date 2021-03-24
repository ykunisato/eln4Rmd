library(osfr)

# osf_auth("ThIsIsNoTaReAlPaTbUtYoUgEtIt")

eln4osfr_node <- osf_retrieve_node("https://osf.io/tf2he")
labnote <- osf_create_component(eln4osfr_node, title = "labnote")
labnote_fig <- osf_create_component(labnote, title = "fig")
osf_upload(labnote, path = "2021_03_24.md")

osf_upload(labnote, path = "demo.png")
osf_upload(labnote, path = "2021_03_22.md")

#むむむ。osfにラボノートセクションを作って，そこにmdファイルを追加していく戦略だが，
#画像の連携がまずいな・・・