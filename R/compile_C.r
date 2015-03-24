#' Compile C code 
#'
#' Compiles C code and run it, formatting results from system 
#' @param filename character value, optional argument
#' @param flags character value, optional argument
#' @export

verbatim.paste = function(txt) paste0('\n\\begin{verbatim}\n',txt,'\n\\end{verbatim}\n',collapse='')
compile_C = function(filename,arg='',flags=''){
   gcc.Call = 'gcc -Wall -ansi -pedantic filename.c -o filename.out flags'
   gcc.Call = gsub('flags',flags,gcc.Call)
   gcc.Call = gsub('filename',filename,gcc.Call)
   system(gcc.Call)

   exec.Call = './filename.out arg'
   exec.Call = gsub('filename',filename,exec.Call)
   exec.Call = gsub('arg',arg,exec.Call)
   res = system(exec.Call,intern=TRUE)

   #print results
   cat(paste('\\begin{framed}\n'))
   cat(verbatim.paste(paste('>',gcc.Call,'\n')))
   cat(verbatim.paste(paste('>',exec.Call,'\n')))
   cat(verbatim.paste(paste(res,collapse='\n')))
   cat(paste('\\end{framed}\n\n'))
}

