#' function_name: lsPackages
#'
#' Purpose: lists the packages loaded since the start of the R session
#' Creation Date: 06-03-2015
#' Last Modified: Fri Mar  6 15:05:17 2015
#'
#' @param ret logical value, optional argument
#' @param pr logical value, optional argument
#' @param lib logical value, optional argument
#' @export
#' @examples
#' lsPackages(FALSE,TRUE,TRUE)
lsPackages = function(ret=FALSE,pr=TRUE,lib=FALSE){
   added.pkgs = (.packages())[which(!(.packages()) %in% getOption("defaultPackages"))]
   if(lib){
      cat.packs = paste0('library(', added.pkgs, ')', collapse='\n')
   }else{
      cat.packs = paste0(added.pkgs, collapse='\n')
   }
   if(pr) cat(cat.packs)
   if(ret) return(added.pkgs)
}
