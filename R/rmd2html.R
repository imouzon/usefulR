#' function_name: rmd2html.R
#'
#' Purpose: 
#' Creation Date: 09-09-2015
#' Last Modified: Wed Sep  9 17:24:15 2015
#'
#' @param filename character value, the file to convert from Rmd to HTML
#' @export
#' @examples
#' rmd2html("lecture6.Rmd")
#'

rmd2html <- function(filename){

   filename <- gsub(".Rmd","",filename)

   knitr::knit2html(gsub("filename",filename,"filename.Rmd"))

   system(gsub("filename", filename, "mv filename.md filename.html"))

}
