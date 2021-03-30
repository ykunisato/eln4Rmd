#' @title make new Japanese e-labnotebook
#' @importFrom utils file.edit
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_day If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @export
elnjp <- function(add_name = FALSE, replace_day = FALSE) {
  # set file name
  if(replace_day == FALSE){
    day_name <- Sys.Date()
  }else{
    day_name <- replace_day
  }

  if(add_name == FALSE){
    file_name <- paste0(day_name, ".Rmd")
  }else{
    file_name <- paste0(day_name, add_name, ".Rmd")
  }
  # make and open Rmd file
  path_skeleton <- system.file("rmarkdown/templates/eln_jp/skeleton/skeleton.Rmd",package = "eln4Rmd")
  file.copy(path_skeleton,file_name)
  file.edit(file_name)
}

#' @title make new Japanese e-labnotebook with OSF
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace
#' @importFrom utils file.edit
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_day If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @param osf If you want to upload to OSF, add OSF URL in this argument.
#' @export
elnjp_osf <- function(add_name = FALSE,
                      replace_day = FALSE,
                      osf) {

  if(is.null(osf)){
    stop("Please add the URL of OSF to the osf argument!")
  }
  # set file name
  if(replace_day == FALSE){
    day_name <- Sys.Date()
  }else{
    day_name <- replace_day
  }

  if(add_name == FALSE){
    file_name <- paste0(day_name, ".Rmd")
  }else{
    file_name <- paste0(day_name, add_name, ".Rmd")
  }

  # set Rmd template file
  path_skeleton <- system.file("rmarkdown/templates/eln_jp/skeleton/skeleton.Rmd",package = "eln4Rmd")
  text_skeleton <- readLines(path_skeleton, warn = F)

  # set render function
  tmp_rmd <- file(file_name, "w")
  for (i in 1:length(text_skeleton)) {
    st <- text_skeleton[i]
    st <- str_replace(st, pattern = "output: md_document",
                      replacement = paste0("output: eln4Rmd::render_elnjp_osf(Rmd_file = '",file_name, "' ,osf = '", osf , "')"))
    writeLines(st, tmp_rmd)
  }
  close(tmp_rmd)
  file.edit(file_name)
}


#' @title render function for Japanese e-labnotebook with OSF
#' @importFrom rmarkdown render
#' @importFrom rmarkdown md_document
#' @importFrom osfr osf_retrieve_node
#' @importFrom osfr osf_upload
#' @importFrom stringr str_replace
#' @param Rmd_file file name of R Markdown file
#' @param osf URL of OSF
#' @export
render_elnjp_osf <- function(Rmd_file, osf) {
  render(Rmd_file, "md_document")
  labnote <- osf_retrieve_node(osf)
  md_file_name <- str_replace(Rmd_file, pattern = ".Rmd", replacement = ".md")
  files_name <- str_replace(Rmd_file, pattern = ".Rmd", replacement = "_files")
  osf_upload(labnote, path = md_file_name, conflicts = "overwrite")
  osf_upload(labnote, path = files_name, conflicts = "overwrite")
}

#' @title make new Japanese e-labnotebook with GitHub
#' @importFrom utils file.edit
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_day If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @export
elnjp_git <- function(add_name = FALSE, replace_day = FALSE) {
  # set file name
  if(replace_day == FALSE){
    day_name <- Sys.Date()
  }else{
    day_name <- replace_day
  }

  if(add_name == FALSE){
    file_name <- paste0(day_name, ".Rmd")
  }else{
    file_name <- paste0(day_name, add_name, ".Rmd")
  }

  # set Rmd template file
  path_skeleton <- system.file("rmarkdown/templates/eln_jp/skeleton/skeleton.Rmd",package = "eln4Rmd")
  text_skeleton <- readLines(path_skeleton, warn = F)

  # set render function
  tmp_rmd <- file(file_name, "w")
  for (i in 1:length(text_skeleton)) {
    st <- text_skeleton[i]
    st <- str_replace(st, pattern = "output: md_document",
                      replacement = paste0("output: eln4Rmd::render_elnjp_git(Rmd_file = '",file_name, "')"))
    writeLines(st, tmp_rmd)
  }
  close(tmp_rmd)
  file.edit(file_name)
}


#' @title render function for Japanese e-labnotebook with GitHub
#' @importFrom rmarkdown render
#' @importFrom rmarkdown md_document
#' @param Rmd_file file name of R Markdown file
#' @export
render_elnjp_git <- function(Rmd_file) {
  render(Rmd_file, "md_document")
  message("Git\u30bf\u30d6\u3067\uff0cCommit\u3092\u30af\u30ea\u30c3\u30af\u3057\u3066\uff0c\u4f5c\u6210\u3057\u305f\u30e9\u30dc\u30ce\u30fc\u30c8\u3092\u30b3\u30df\u30c3\u30c8\uff06\u30d7\u30c3\u30b7\u30e5\u3057\u307e\u3057\u3087\u3046\uff01")
}
