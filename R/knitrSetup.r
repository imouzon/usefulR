#' Set knitr up the way I like it
#'
#' This code sets some of the values for knitr that I like.
#' @param rootDir character value, optional argument (defaults to working directory)
#' @param use.tikz logical value, optional argument (default FALSE)
#' @param cache.use.time logical value, optional argument (default FALSE)
#' @param fig.folder character value, optional argument (default 'graphics')
#' @param fig.prefix character value, optional argument (default 'fig_')
#' @export
#' @examples
#' knitrSetup(use.tikz = FALSE)
knitrSetup = function(rootDir=getwd(), use.tikz=FALSE, cache.use.time=FALSE, fig.folder='graphics', fig.prefix='fig_', cache.folder='cache', cache.prefix='out_', formatR.arrow=TRUE, code.width=50, fig.height=5, fig.width=5, fig.align='center', fig.show='hold', crop=TRUE, tidy=TRUE, fig.pos='H', par=TRUE, tikzLatex='/usr/texbin/pdflatex', tikz.sanitize=TRUE, tikz.crop=TRUE, return_opts=NULL){
   require('knitr')

   #store figures in the fig folder, prefix with 'graphics_'
   fig.folder = file.path(rootDir,fig.folder)
   fig.path = paste0(fig.folder,'/',fig.prefix)

   #cached output stored in cache.path
   cache.folder = file.path(rootDir,'cache')
   cache.path = paste0(cache.folder,'/',cache.prefix)

   #These are arguments for formatR which tidys up the code
   Roptions = list("formatR.arrow"=formatR.arrow,"width"=code.width)

   #knit options
   knitrSetup_knit_opts = list(NULL)

   #chunk options
   knitrSetup_chunk_opts = list(
      "fig.path"=fig.path,
      "cache.path"=cache.path,
      "fig.align"=fig.align, 
      "fig.width"=fig.width, 
      "fig.height"=fig.height, 
      "fig.show"=fig.show, 
      "crop"=crop,
      "par"=par,
      "fig.pos"=fig.pos,
      "tidy"=tidy
   )

   #fix the color errors
   knitrSetup_hooks_opts = list("document" = function(x){sub('\\usepackage[]{color}', '\\usepackage[]{xcolor}', x, fixed = TRUE)})

   #if we are supposed to use tikz then what?
   if(use.tikz != FALSE){
      require(tikzDevice)
      Roptions = usefulR::merge_lists(list(Roptions,list("tikzLatex" = tikzLatex)),FALSE)
      knitrSetup_chunk_opts = usefulR::merge_lists(list(knitrSetup_chunk_opts,list("dev"='tikz',"sanitize"=TRUE,"crop"=TRUE)),FALSE)
      knitrSetup_hooks_opts = usefulR::merge_lists(list(knitrSetup_hooks_opts,
         list("par"=function(before, options, envir){
            if(before && options$fig.show!='none') par(mar=c(4,4,.1,.1), cex.lab=.95, cex.axis=.9, mgp=c(2,.7,0), tcl=-.3)
         },
         "crop"=hook_pdfcrop
         )),
         FALSE
      )
      #knit_hooks$set(true.font=function(before,options,envir){
      #   if(before && !is.null(options$out.width)) 
      #      dev.args = list(pointsize=10*as.numeric(strsplit(options$out.width,'\\\\')[[1]][1]))
      #})
   }

   fig.msg = paste('By defualt figures will be stored in',fig.path,'and have dimension',fig.width,'by',fig.height)
   cache.msg = paste('By default cache will be stored in',cache.path)
   message(paste('knitr has the following options:',fig.msg,cache.msg,sep='\n'))

   if(is.null(return_opts)){
      opts_knit$set(knitrSetup_knit_opts)
      opts_chunk$set(knitrSetup_chunk_opts)
      knitr_hooks$set(knitrSetup_hooks_opts)
      options(Roptions)
   }else{
      return_opts = list("knitr" = list("opts_knit"=knitrSetup_knit_opts, "opts_chunk" = knitrSetup_chunk_opts, "knit_hooks" = knitrSetup_hooks_opts),"R" = Roptions)
      return(return_opts)
   }
}
