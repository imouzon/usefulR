#' packages for LaTeX
#'
#' This code sets some of the values for knitr that I like.
#' @param all_packges logical value, optional argument
#' @export
#' @examples
#' makeParent_addPackages(package.opts = list('formatHW' = c('TA','STAT602')))

makeParent_addPackages = function(package.list=NULL,pass.package=NULL,use.defaults=TRUE){
   package.list=NULL
   pass.package=NULL
   use.defaults=TRUE

   package.template = function(i){
      pkg.tmp = paste0('{',names(package.list)[i],'}\n')
      if(is.null(package.list[[i]])){
         opt.tmp = ''
      }else{
          opt.tmp = paste0('[',paste(package.list[[i]],collapse=','),']')
      }
      return(paste0('\\usepackage',opt.tmp,pkg.tmp))
   }

   #DOC.Tempate = paste(c('POTP','DOCTYPE','PCKGS','DOCBEG','DOCEND'),collapse='\\n')
   #names of the list elements are are packages, values are options
   if(use.defaults){
      pass.package.defaults = list('xcolor'=c('usenames','dvipsnames','svgnames','table'))
      package.defaults = c('fontenc',
                           'lmodern', 
                           #'url', 
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
                           'extramarks',
                           'enumerate',
                           'soul,color',
                           'graphicx,float,wrapfig',
                           'amsmath,amssymb,rotating',
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
                           'fancyenvironments',
                           'mymathmacros',
                           'algorithm',
                           'algpseudocode',
                           'pgfplots')
      default.opts = list('geometry' = 'margin=1.0in', 
                          'algpseudocode'='noend',
                          'formatHW'=c('STAT580','imouzon'), 
                          'fontenc'='T1')
      package.defaults = merge_lists(list(sapply(package.defaults,function(x) NULL), default.opts))
   }else{
      package.defaults=ls()
   }

   #combine the default packages with the given packages
   package.list = merge_lists(list(package.defaults,package.list),append.lists=FALSE)

   #combine the default past to package options with the provided pass to package options
   pass.package = merge_lists(list(pass.package.defaults,pass.package),append.lists=FALSE)

   package.list = paste(sapply(1:length(package.list), package.template),collapse='')

   pass.package = sapply(names(pass.package),function(i) paste(pass.package[[i]],collapse=','))
   pass.package = paste0('\\PassOptionsToPackage{',names(pass.package),'}{',pass.package,'}\n')

   return(list('packages'=package.list,'PTPO'=pass.package))
}
