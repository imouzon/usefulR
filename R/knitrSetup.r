#' Set knitr up the way I like it
#'
#' This code sets some of the values for knitr that I like.
#' @param rootDir character value, optional argument
#' @param use.tikz logical value, optional argument
#' @export
#' @examples
#' knitrSetup(use.tikz = FALSE)
knitrSetup = function(rootDir = FALSE, use.tikz = FALSE){
   require('knitr')
   if(rootDir == FALSE) rootDir <- getwd()

   #use date in figure names or cache files?
   fig.use.time = FALSE
   cache.use.time = FALSE

   #store figures in the fig folder, prefix with 'graphics-'
   fig.folder = paste(rootDir,'/out/figures/',sep='')
   if(fig.use.time){
      fig.prefix = paste('figure_',format(Sys.time(),'%m-%d'),sep='')
   }else{
      fig.prefix = 'figure_'
   }
   fig.path = paste(fig.folder,fig.prefix,'_',sep='')

   #cahced output stored in cache.path
   cache.folder = paste(rootDir,'/out/cache/',sep='')
   if(cache.use.time){
      cache.prefix = paste('out_',format(Sys.time(),'%m-%d'),sep='')
   }else{
      cache.prefix = 'out_'
   }
   cache.path = paste(cache.folder,cache.prefix,'_',sep='')

   options(replace.assign=TRUE,width=50)

   #figure options
   fig.w = 5
   fig.h = 5
   opts_chunk$set(
      fig.path=fig.path,
      cache.path=cache.path,
      fig.align='center', 
      fig.width=fig.w, 
      fig.height=fig.h, 
      #fig.show='hold', 
      #crop=TRUE,
      fig.pos = 'h',
      par=TRUE
   )

   #other options
   opts_chunk$set(
      tidy=TRUE
   )

   if(use.tikz != FALSE){
      #library(tikzDevice)
      #options(tikzLatex = '/opt/local/bin/pdflatex')
      opts_chunk$set(dev='tikz', sanitize=TRUE,crop=TRUE)
      knit_hooks$set(par=function(before, options, envir){if(before && options$fig.show!='none') par(mar=c(4,4,.1,.1), cex.lab=.95, cex.axis=.9, mgp=c(2,.7,0), tcl=-.3)}, crop=hook_pdfcrop)
      knit_hooks$set(true.font=function(before,options,envir) if(before && !is.null(options$out.width)) dev.args = list(pointsize=10*as.numeric(strsplit(options$out.width,'\\\\')[[1]][1])))
   }

   fig.msg = paste('By defualt figures will be stored in ',fig.path,'and have dimension',fig.w,'by',fig.h)
   cache.msg = paste('By default cache will be stored in',cache.path)
   message('knitr has the following options:\n',fig.msg,'\n',cache.msg,sep='   ')
}
