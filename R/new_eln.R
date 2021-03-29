#' @title make new Japanese e-labnotebook
#' @importFrom rmarkdown draft
#' @param add_name If you want to add the name after the date as the file name,
#' add this argument.
#' @param replace_day If you want to use the specified date as the file name
#' instead of today's date, add this argument.
#' @export
new_elnjp <- function(add_name = FALSE, replace_day = FALSE) {
  if(replace_day == FALSE){
    day_name <- Sys.Date()
  }else{
    day_name <- replace_day
  }

  if(add_name == FALSE){
    file <- paste0(day_name, ".Rmd")
  }else{
    file <- paste0(day_name, add_name, ".Rmd")
  }

  draft(file, template="eln_jp", package="eln4Rmd")
}
