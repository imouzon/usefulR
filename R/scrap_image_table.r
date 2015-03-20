#' function_name: scrape_image_table
#'
#' Purpose: get urls for images from table, potentially save images
#' Creation Date: 10-03-2015
#' Last Modified: Fri Mar 20 00:42:11 2015
#'
#' @param url character value, optional argument
#' @param table integer value, optional argument
#' @export
#' @examples
#' scrape_image_data('url',2)

scrape_image_data = function(url,table){
   paste(rep(url,table))
#    url = 'http://en.wikipedia.org/wiki/List_of_U.S._state_birds'
#    raw.html = html(url)
#    raw.html %>%
#       html_node("
#    rd = fromJSON(raw.data) 
#    ?readLines
}


