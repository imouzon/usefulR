#' function_name: tex.mat
#'
#' Purpose: Write better LaTeX matrices
#' Creation Date: 06-03-2015
#' Last Modified: Fri Mar  6 10:37:23 2015
#'
#' @param paramname character value, optional argument
#' @param paramname integer value, optional argument
#' @export
#' @examples
#' tex.mat(matrix(1:4,nrow=2),'X')
tex.mat = function(X.mat,matrix_name=NULL,round.val=6,endofline=TRUE,color.pos.neg=TRUE){
   addmathenv = TRUE
   check.underscore = TRUE
   align.decimal = TRUE

   template = 'matrix_name = matrixopen \n matrix stuff \nmatrixclose'
   if(align.decimal){
      to.left = as.numeric(strsplit(as.character(format(max(X.mat),scientific=TRUE)),'e\\+0+')[[1]][2])
      to.right = min(c(round.val, c(1:round.val)[sapply(1:round.val,function(i) (sum(round(as.vector(X.mat),i) == as.vector(X.mat)) == nrow(X.mat)*ncol(X.mat)))]))
      #matrixopen = paste0('\\left[ \\begin{tabular}{',paste0(rep(paste0('S[table-format=',to.left,'.',to.right,']'),ncol(X.mat)),collapse=''),'}')
      matrixopen = paste0('\\\\left[ \\\\begin{tabular}{',paste0(rep('S',ncol(X.mat)),collapse=''),'}')
      matrixclose = '\\\\end{tabular} \\\\right]'
      template = gsub('matrixopen',matrixopen,template)
      template = gsub('matrixclose',matrixclose,template)
   }else{
      template = gsub('matrixopen','\\\\begin{bmatrix}\n',template)
      template = gsub('matrixclose','\\\\\\\\\n\\\\end{bmatrix}',template)
   }

   if(addmathenv) template = paste('$$',template,'$$',sep='\n')
   if(endofline) template = paste0(template,'')

   if(check.underscore){
      matrix_name = paste0('\\\\mathbf{',gsub('_','}_{',matrix_name),'}')
   }else{
      matrix_name = paste0('\\\\mathbf{',matrix_name,'}')
   }

   if(is.null(matrix_name)){
      template = gsub('\\mathbf\\{matrix_name\\} = ','',template)
   }else{
      template = gsub('matrix_name',matrix_name,template)
   }

   X.pst = as.vector(t(X.mat))
   X.pst.round = as.character(round(X.pst,round.val))
   if(sum(X.pst < 0) == 0) color.pos.neg = FALSE
   if(color.pos.neg) X.pst.round[X.pst<0] = paste0('{\\\\color[rgb]{1,0,0} ', X.pst.round, '}')[X.pst<0]
   X.pst = paste(sapply(1:nrow(X.mat), function(i) paste(X.pst.round[(1+ncol(X.mat)*(i-1)):(ncol(X.mat)*i)], collapse=' & ')),collapse='\\\\\\\\\n')
   template = gsub('matrix stuff', X.pst, template)
   if(endofline) template = paste0(template,'\n\n')
   cat(template)
}
