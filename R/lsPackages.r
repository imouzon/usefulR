#' function_name: lsPackages
#'
#' Purpose: lists the packages loaded since the start of the R session
#' Creation Date: 06-03-2015
#' Last Modified: Fri Mar  6 15:37:22 2015
#'
#' @param ret logical value, optional argument
#' @param pr logical value, optional argument
#' @param lib logical value, optional argument
#' @export
#' @examples
#' lsPackages(FALSE,TRUE,TRUE)
lsPackages = function(ret=FALSE,pr=TRUE,lib=FALSE,ignore.packages='base'){
   added.pkgs = (.packages())[which(!(.packages()) %in% c(getOption("defaultPackages"),ignore.packages))]

   if(lib){
      cat.packs = paste0('library(', added.pkgs, ')', collapse='\n')
   }else{
      cat.packs = paste0(added.pkgs, collapse='\n')
   }
   if(pr) cat(cat.packs)
   if(ret) return(added.pkgs)

   #sapply(1:length(added.pkgs), function(i) getDepList(added.pkgs[i]))
   #getDepList()
   #search()
   #(.packages())[which(!(.packages()) %in% c(getOption("defaultPackages"),'base'))]
   #available.packages()
   #tools:::package.dependencies(added.pkgs)
   #tools:::pkgDepends(c('ggplot2'))
}
