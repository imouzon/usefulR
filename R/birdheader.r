#' function_name: birdheader
#'
#' Purpose: add a state bird picture to markdown or latex 
#' Creation Date: 10-03-2015
#' Last Modified: Fri Mar 20 00:41:18 2015
#'
#' @param paramname character value, optional argument
#' @param paramname integer value, optional argument
#' @param docName character value, optional argument
#' @export
#' @examples
#' birdheader('katemoss_CK.jpg',flag=TRUE)

birdheader = function(birdimg,flag=TRUE){
   if(flag) cat(birdimg) 
}



