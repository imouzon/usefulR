#' function_name: merge_lists
#'
#' Purpose: merge two or more lists together
#' Creation Date: 19-03-2015
#' Last Modified: Fri Mar 20 00:02:17 2015
#'
#' @param lists a list of list, optional argument
#' @param append.lists logical argument, optional argument
#' @param descending.priority logical argument, optional argument
#' @export
#' @examples
#' list1 = list('dogs'=c('chows','beagles'), cows='milk', food = 'hot dogs')
#' list2 = list('dogs'='doberman', cows=c('milk','beef'), friends = 'nick')
#' list3 = list('dogs'='puppy', cows=c('barnyard','beef'), girls='peach', friends = 'ian')
#' merge_lists(list(list1,list2,list3))
#' 

merge_lists = function(lists,append.lists=TRUE,descending.priority=FALSE){
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
