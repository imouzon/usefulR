#' packages for LaTeX
#'
#' This code sets some of the values for knitr that I like.
#' @param useAllpackges logical value, optional argument
#' @export
#' @examples
#' makeParent_addPackages(all_packages = TRUE)

makeParent_addPackages = function(all_packages=TRUE){
package.list = 
'
\\PassOptionsToPackage{usenames,dvipsnames,svgnames,table}{xcolor}
\\documentclass[10pt]{report}

%\\tracingall % used to pin point problems in latexing a doc

%%%%%%%% Packages  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\\PassOption
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
\\usetikzlibrary{backgrounds}'

return(package.list)
}
