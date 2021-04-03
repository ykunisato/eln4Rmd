#' @title make new Japanese e-labnotebook in Markdown
#' @importFrom utils file.edit
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_date If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @export
elnjp_md <- function(add_name = FALSE, replace_date = FALSE) {
  # set file name
  if(replace_date == FALSE){
    date_name <- strsplit(paste0(as.POSIXlt(Sys.time(), format="%Y-%m-%d %H:%M:%S", tz="Japan")), " +")[[1]][1]
  }else{
    date_name <- replace_date
  }

  if(add_name == FALSE){
    file_name <- paste0(date_name, ".Rmd")
  }else{
    file_name <- paste0(date_name, add_name, ".Rmd")
  }
  # set Rmd template file
  path_skeleton <- system.file("rmarkdown/templates/eln_jp/skeleton/skeleton.Rmd",package = "eln4Rmd")
  text_skeleton <- readLines(path_skeleton, warn = F)
  tmp_rmd <- file(file_name, "w")
  for (i in 1:length(text_skeleton)) {
    st <- text_skeleton[i]
    st <- str_replace(st, pattern = "# date_research",
                      replacement = paste0("date_research <- '",date_name, "'"))
    st <- str_replace(st, pattern = "# date_write",
                      replacement = paste0("date_write <- '",date_name, "'"))
    writeLines(st, tmp_rmd)
  }
  close(tmp_rmd)
  navigateToFile(file_name)
}

#' @title make new Japanese e-labnotebook in PDF
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace
#' @importFrom rstudioapi navigateToFile
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_date If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @export
elnjp_pdf <- function(add_name = FALSE,replace_date = FALSE) {
  # set file name
  if(replace_date == FALSE){
    date_name <- strsplit(paste0(as.POSIXlt(Sys.time(), format="%Y-%m-%d %H:%M:%S", tz="Japan")), " +")[[1]][1]
  }else{
    date_name <- replace_date
  }

  if(add_name == FALSE){
    file_name <- paste0(date_name, ".Rmd")
  }else{
    file_name <- paste0(date_name, "_" ,add_name, ".Rmd")
  }

  # set Rmd template file
  path_skeleton <- system.file("rmarkdown/templates/eln_jp/skeleton/skeleton.Rmd",package = "eln4Rmd")
  text_skeleton <- readLines(path_skeleton, warn = F)

  # set render function
  tmp_rmd <- file(file_name, "w")
  for (i in 1:length(text_skeleton)) {
    st <- text_skeleton[i]
    st <- str_replace(st, pattern = "output: md_document",
                      replacement = paste0("output: eln4Rmd::render_elnjp_pdf(Rmd_file = '",file_name,"')"))
    st <- str_replace(st, pattern = "# date_research",
                      replacement = paste0("date_research <- '",date_name, "'"))
    st <- str_replace(st, pattern = "# date_write",
                      replacement = paste0("date_write <- '",date_name, "'"))
    writeLines(st, tmp_rmd)
  }
  close(tmp_rmd)
  navigateToFile(file_name)
}


#' @title render function for Japanese e-labnotebook in PDF
#' @importFrom rmarkdown render
#' @importFrom rmarkdown pdf_document
#' @importFrom stringr str_replace
#' @param Rmd_file file name of R Markdown file
#' @export
render_elnjp_pdf <- function(Rmd_file) {
  # make pdf firectory
  tmp_wd <- getwd()
  file_name <- strsplit(Rmd_file, ".Rmd")[[1]]
  if(!dir.exists(file.path(tmp_wd, "pdf"))){
    dir.create(file.path(tmp_wd, "pdf"), showWarnings = FALSE)
  }
  # covert Rmd file to PDF file
  template_tex_file <- system.file("rmarkdown/templates/eln_jp/resources/eln_jp.tex",
                                   package = "eln4Rmd")
  format_pdf <- pdf_document(
    latex_engine = "xelatex",
    template = template_tex_file,
    highlight = "tango")
  format_pdf$inherits <- "pdf_document"
  render(Rmd_file, format_pdf)
  # copy PDF
  file.copy(paste0(tmp_wd,"/",file_name,".pdf"),
            paste0(tmp_wd,"/pdf/",file_name,".pdf"), overwrite = TRUE)
}

#' @title upload Japanese e-labnotebook to OSF
#' @importFrom osfr osf_retrieve_node
#' @importFrom osfr osf_upload
#' @importFrom stringr str_replace
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_date If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @param osf URL of pdf directory in OSF
#' @export
up_elnjp_osf  <- function(add_name = FALSE,replace_date = FALSE, osf) {
  # set file name
  if(replace_date == FALSE){
    date_name <- strsplit(paste0(as.POSIXlt(Sys.time(), format="%Y-%m-%d %H:%M:%S", tz="Japan")), " +")[[1]][1]
  }else{
    date_name <- replace_date
  }

  if(add_name == FALSE){
    pdf_file_name <- paste0(date_name, ".pdf")
  }else{
    pdf_file_name <- paste0(date_name, "_" ,add_name, ".pdf")
  }

  labnote_pdf <- osf_retrieve_node(osf)
  osf_upload(labnote_pdf, path = pdf_file_name, conflicts = "overwrite")
}


#' @title upload Japanese e-labnotebook to GitHub
#' @importFrom gert git_add
#' @importFrom gert git_commit_all
#' @importFrom gert git_push
#' @importFrom gert git_info
#' @importFrom gert git_status
#' @importFrom stringr str_replace
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_date If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @export
up_elnjp_git  <- function(add_name = FALSE,replace_date = FALSE) {
  # set file name
  if(replace_date == FALSE){
    date_name <- strsplit(paste0(as.POSIXlt(Sys.time(), format="%Y-%m-%d %H:%M:%S", tz="Japan")), " +")[[1]][1]
  }else{
    date_name <- replace_date
  }

  if(add_name == FALSE){
    file_name <- date_name
  }else{
    file_name <- paste0(date_name, "_" ,add_name)
  }
  # add & commit & push
  git_add(git_status()$file)
  git_commit_all(paste0(file_name, "\u306e\u30e9\u30dc\u30ce\u30fc\u30c8\u3092\u4f5c\u6210\u3057\u307e\u3057\u305f\u3002\u95a2\u9023\u3059\u308b\u30d5\u30a1\u30a4\u30eb\u3082\u30b3\u30df\u30c3\u30c8\u3057\u307e\u3059"))
  git_push()
}
