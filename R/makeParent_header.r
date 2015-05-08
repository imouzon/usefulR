#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' @param parentDir character value, optional argument
#' @param docName character value, optional argument
#' @examples
#' makeParent_header(filename,creator)

makeParent_header = function(makeParent_filename,creator=NULL){
raw.header = 
"% For LaTeX-Box: root = makeParent_filename.tex 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  File Name: makeParent_filename
%  Purpose: 
%
%  Creation Date: makeParentCreationDate
%  Last Modified: 
%  Created By: makeParentCreatorName
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HOW TO USE THIS FILE:
%
% 1. Create a new .rnw file (this new file is referred to as a 'child document')
% 2. Reference this file using one of the following in the child document:
%
%   a. by using \\sexpr{}:
%
%        \\sexpr{set_parent('main-document.rnw')}
%
%   b. by using a chunk:
%
%        <<set-parent,echo=FALSE,cache=FALSE>>=
%        set_parent('main-document.rnw')
%        @
%
% 3. knit the document in the usual way - the preamble here is included
%

"
    
   #correct filenames
   raw.header = gsub('makeParent_filename',makeParent_filename,raw.header)

   #correct creationDate
   raw.header = gsub('makeParentCreationDate', Sys.Date() ,raw.header)

   #add creator
   if(is.null(creator)) creator = Sys.info()[[6]]
   raw.header = gsub('makeParentCreatorName', creator,raw.header)

   return(raw.header)
}


