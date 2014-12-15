#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' @param parentDir character value, optional argument
#' @param docName character value, optional argument
#' @export
#' @examples
#' makeParent(parentDir = '~/courses/cs511/code_bank')

makeParent = function(parentDir = NULL, docName = 'main_document'){
   parent.location = makeParent_location(parentDir = parentDir, docName = docName)

   if(is.null(parentDir)) parentDir = getwd()

   if(grepl('.rnw',tolower(docName))){
      docName = paste(strsplit(docName,'\\.')[[1]][1:(length(strsplit(docName,'\\.')[[1]]) - 1)],collapse='.')
   }
   docName = paste0(docName,'.rnw')
   return(paste(parentDir,docName,sep='/'))
}


