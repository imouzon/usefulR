#' packages for LaTeX
#'
#' This code sets some of the values for knitr that I like.
#' @param all_packges logical value, optional argument
#' @export
#' @examples
#' makeParent_addPackages(all_packages = TRUE)

makeParent_addPackages = function(all_packages=TRUE){
   PassOptionsToPackage=c('usenames,dvipsnames,svgnames,table','xcolor')
   package.list = matrix(
                  c('fontenc',
                    'lmodern', 
                    'url', 
                    'pdfcolmk', 
                    'multirow', 
                    'graphicx', 
                    'pifont', 
                    'amsmath,amsfonts,amsthm,amssymb', 
                    'setspace',
                    'Tabbing',
                    'etoolbox',
                    'fancyhdr',
                    'lastpage',
                    'listings',
                    'lstlinebgrd',
                    'extramarks',
                    'enumerate',
                    'chngpage',
                    'soul,color',
                    'graphicx,float,wrapfig',
                    'amsmath,amssymb, rotating',
                    'epsfig',
                    'color',
                    'hyperref',
                    'animate',
                    'array',
                    'graphics, color',
                    'graphicx',
                    'epsfig',
                    'setspace',
                    'verbatim',
                    'geometry',
                    'tikz',
                    'mdframed',
                    'clrscode3e',
                    'formalHW',
                    'formatHW',
                    'fancyquote',
                    'mymathmacros'),byrow=TRUE,ncol=1)

   package.opts =  matrix(c('margin=1.0in','geometry',
                            'T1',          'fontenc'),
                          nrow=2,byrow=TRUE)

   package.call = paste0('\\usepackage{',package.list,'}')


   for(i in 1:nrow(package.opts)){
      package.call[grepl(package.opts[i,2], package.list)] = gsub('usepackage',paste0('usepackage[',package.opts[i,1],']'),package.call[grepl(package.opts[i,2], package.list)])
   }
      
   POTP = paste0('\\PassOptionsToPackage{',PassOptionsToPackage[1],'}{',PassOptionsToPackage[2],'}')

   ret = paste(POTP,'\\documentclass[10pt]{report}',paste(package.call,collapse='\n'),collapse='\n')
   ret = paste(ret,'\n\\begin{document}','\n\n','\n\\end{document}',sep='\n')

   return(ret)
}
