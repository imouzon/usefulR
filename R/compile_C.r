#--------------------------------------**--------------------------------------#
#  File Name:
#  Purpose:
#
#  Creation Date: 13-02-2015
#  Last Modified: Fri Feb 13 19:51:08 2015
#  Created By:
#
#--------------------------------------**--------------------------------------#
#
#  FORTRAN and C: 
#  source('~/R/shlib/C_FORTRAN.shlib.r')
#  .Fortran("subroutine name",as.integer(input1),as.double(input2), etc)

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

