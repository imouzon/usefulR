#' function_name: merge_lists
#'
#' Purpose: merge two or more lists together
#' Creation Date: 19-03-2015
#' Last Modified: Mon May  4 17:48:23 2015
#'
#' @param lists a list of list, optional argument
#' @param append.lists logical argument, optional argument
#' @param descending.priority logical argument, optional argument
#' @export
#' @examples
#' list1 = list('dogs'=c('chows','beagles'), cows='milk', food = 'hot dogs')
#' list2 = list('dogs'='doberman', cows=c('milk','beef'), friends = 'nick')
#' list3 = list('dogs'='puppy', cows=c('barnyard','beef'), girls='peach', friends = 'ian')
#' usefulR::merge_lists(list(list1,list2,list3))
#' 

merge_lists = function(lists,append.lists=TRUE,descending.priority=FALSE){
   #remove lists that are null
   lists.in = lists
   for(i in length(lists):1){
      if(is.null(names(lists[[i]]))){
         lists[[i]] = NULL
      }else{
         dropmem = which(names(lists[[i]]) == "")
         if(length(dropmem) > 0){
            lists[[i]][dropmem] = NULL
         }
      }
   }
   if(length(lists) <= 1){
      return(lists.in[[1]])
   }
   sapply(1:length(lists), function(i) is.null(lists[[i]]))
   if(descending.priority) lists = lists[length(lists):1]
   l1 = lists[[1]]
   for(i in 2:length(lists)){
      l2 = lists[[i]]
      common.names = names(l1)[which(names(l1) %in% names(l2))]
      if(append.lists){ 
         for(j in common.names) l1[[j]] = unique(c(l1[[j]], l2[[j]]))
      }else{
         for(j in common.names) l1[[j]] = l2[[j]]
      }
      uncommon.names = names(l2)[which(!(names(l2) %in% names(l1)))]
      for(j in uncommon.names) l1[[j]] = l2[[j]]
   }
   return(l1)
}
