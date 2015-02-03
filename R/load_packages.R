#' Load my favorite packages
#'
#' This code sets some of the values for knitr that I like.
#' @param data.mining logical value, optional argument
#' @param graphics logical value, optional argument
#' @export
#' @examples
#' load_packages(data.mining = TRUE)

load_packages = function(data.mining = FALSE,graphics = FALSE){
   #useful for data mining
   if(data.mining){
      data.mining = 'rpart earth fields nnet neuralnet randomForest party R.matlab RWeka'
      eval(parse(text=paste0('require(',gsub(' ',',quietly=TRUE); require(',data.mining),');')))
   }else{
      data.mining = ''
   }

   #useful for graphics
   if(graphics){
      graphics = 'GGally ggmap'
      eval(parse(text=paste0('require(',gsub(' ',',quietly=TRUE); require(',graphics),');')))
   }else{
      graphics = ''
   }

   #packages I use all the time
   basic.packages = 'plyr reshape2 ggplot2'
   require('plyr',quietly=TRUE)
   require('reshape2',quietly=TRUE)
   require("ggplot2", quietly = TRUE)
   theme_set(theme_bw())

   #print a message indicating which packages were loaded
   message(paste('The following packages were loaded:',basic.packages,data.mining,graphics))
   
}

