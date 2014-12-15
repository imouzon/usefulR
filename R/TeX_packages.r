#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' @param course character value, optional argument
#' @export
#' @examples
#' TeX_packages(runAgain = TRUE)

TeX_packages = function(runAgain = FALSE){
   package.list = 
   '
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %  File Name: TeXPackages.tex
   %  Purpose:
   %
   %  Creation Date: 09-10-2014
   %  Last Modified: Thu Oct  9 16:43:47 2014
   %  Created By:
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   \\usepackage[T1]{fontenc}
   \\usepackage{lmodern}
   \\usepackage{url}
   \\usepackage{pdfcolmk}
   \\usepackage{multirow}
   \\usepackage{graphicx}
   \\usepackage{tikz}
   \\usepackage{pifont}
   \\usepackage{amsmath,amsfonts,amsthm,amssymb}
   \\usepackage{setspace}
   \\usepackage{Tabbing}
   \\usepackage{etoolbox}
   \\usepackage{fancyhdr}
   \\usepackage{lastpage}
   \\usepackage{listings}
   \\usepackage{lstlinebgrd}
   \\usepackage{extramarks}
   \\usepackage{enumerate}
   \\usepackage{chngpage}
   \\usepackage{soul,color}
   \\usepackage{graphicx,float,wrapfig}
   \\usepackage{amsmath,amssymb, rotating}
   \\usepackage{epsfig}
   \\usepackage{color}
   \\usepackage{hyperref}
   \\usepackage{animate}
   \\usepackage{array}
   \\usepackage{graphics, color}
   \\usepackage{graphicx}
   \\usepackage{epsfig}
   %\\usepackage{minted}
   \\usepackage{setspace}
   \\usepackage{verbatim}
   \\usepackage[margin=1.0in]{geometry}
   \\usepackage{tikz}
   \\usepackage{mdframed}
   \\usepackage{clrscode3e}
   \\usetikzlibrary{backgrounds}
   '
   return(package.list)
}
