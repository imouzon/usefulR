#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' Creation Date: 
#' Last Modified: Fri Feb 13 20:09:46 2015
#' @param paramname character value, optional argument
#' @param paramname integer value, optional argument
#' @param docName character value, optional argument
#' @export
#' @examples
#' 

verbatim.paste = function(txt) paste0('\n\\begin{verbatim}\n',txt,'\n\\end{verbatim}\n',collapse='')
compile_C = function(filename,flags=''){
   gcc.Call = 'gcc -Wall -ansi -pedantic filename.c -o filename.out flags'
   gcc.Call = gsub('flags',flags,gcc.Call)
   gcc.Call = gsub('filename',filename,gcc.Call)
   system(gcc.Call)

   exec.Call = './filename.out'
   exec.Call = gsub('filename',filename,exec.Call)
   res = system(exec.Call,intern=TRUE)

   #print results
   cat(paste('\\begin{framed}\n'))
   cat(verbatim.paste(paste('>',gcc.Call,'\n')))
   cat(verbatim.paste(paste('>',exec.Call,'\n')))
   cat(verbatim.paste(paste(res,collapse='\n')))
   cat(paste('\\end{framed}\n\n'))
}


