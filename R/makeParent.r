#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' @param parentDir character value, optional argument
#' @param docName character value, optional argument
#' @export
#' @examples
#' makeParent(parentDir = '~/courses/cs511/code_bank')

makeParent = function(parentDir = NULL, package.list = NULL, special.opts = NULL, type="tex", pass.package=NULL, use.defaults=TRUE, docName = 'main_document', documentClass='report', fontsize='10pt', overwrite = FALSE){
parentDir = "/Users/user/dmc2015/ian/"
package.list = NULL
special.opts = NULL
type="markdown"
pass.package=NULL
use.defaults=TRUE
docName = 'main_document'
documentClass='report'
fontsize='10pt'
overwrite = FALSE
   #returns filename, filelocation, fullpath as a list

   parent.location = makeParent_location(parentDir = parentDir, docName = docName)

   #create empty parent file
   if(file.exists(parent.location$fullpath) & !overwrite){
      message(paste('The file',parent.location$fullpath),'already exists')
   }else{
      file.create(parent.location$fullpath)

      #get header information 
      comment.header = makeParent_header(gsub('.rnw','',parent.location[[1]]),'imouzon')
      
      #get the packages to use packages to file
      package.list = makeParent_addPackages(package.list=package.list,pass.package=pass.package,use.defaults=use.defaults)

      #template for document class line
      doc.temp = paste0('\\documentclass[',fontsize,']{',documentClass,'}\n')

      #create document header
      doc.header = paste0(package.list$PTPO,doc.temp,package.list$packages,collapse='\n')

      #create document values
      document = paste(comment.header,doc.header,special.opts,'\n\\begin{document}','\n\n','\n\\end{document}',sep='\n')

      if(type == "markdown"){
         document = gsub('usepackage\\[[[:alnum:]]+,[[:alnum:]]+\\]\\{formatHW','usepackage[$author$,$course$]{formatHW',document)
         document = gsub("\\\\end\\{document\\}","\\\\HWinfo{$date$}{}{}\n\\\\titleheaderA{$title$}\n\n$body$\n\\\\end{document}",document)
         parent.location$fullpath = gsub("rnw","latex",parent.location$fullpath)
      }

      write(document,file=parent.location$fullpath,append=FALSE)

      msg = paste('The parent document has been created:',parent.location$fullpath)
      message(msg)
   }

   return(parent.location$fullpath)
}
