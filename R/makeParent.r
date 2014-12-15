#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' @param parentDir character value, optional argument
#' @param docName character value, optional argument
#' @export
#' @examples
#' makeParent(parentDir = '~/courses/cs511/code_bank')

makeParent = function(parentDir = NULL, docName = 'main_document',overwrite = FALSE){
   #returns filename, filelocation, fullpath as a list
   parent.location = makeParent_location(parentDir = parentDir, docName = docName)

   #create empty parent file
   if(file.exists(parent.location$fullpath) & !overwrite) stop(paste('The file',parent.location$fullpath),'already exists')
   file.create(parent.location$fullpath)

   #get header information 
   header = makeParent_header(gsub('.rnw','',parent.location[[1]]),'imouzon')
   
   #add header to file
   write(header,file=parent.location$fullpath,append=TRUE)

   #add packages to file
   package.list = makeParent_addPackages()
   write(package.list,file=parent.location$fullpath,append=TRUE)
   
}
makeParent(overwrite=TRUE)
parent.location = makeParent_location()
parent.location[[3]]

library(knitr)

sys.calls()
