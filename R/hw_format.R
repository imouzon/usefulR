#' function_name:
#'
#' Purpose: 
#' Creation Date: 01-05-2015
#' Last Modified: Mon May  4 18:40:43 2015
#'
#' @param fig_width numeric value, optional argument (default 5)
#' @param fig_height numeric value optional argument (default 5)
#' @param fig_crop logical value, optional argument (default TRUE)
#' @param dev character argument (default pdf)
#' @param highlight character value, optional argument (default = "default")
#' @param keep_tex logical value, optional argument
#' @param includes = NULL, optional argument
#' @param pandoc_args = NULL, optional argument
#' @param paramname integer value, optional argument
#' @param docName character value, optional argument
#' @export

hw_format = function(rootDir = getwd(), fig_width = 5, fig_height = 5, use_tikz=FALSE, fig_crop=TRUE, dev = "pdf", highlight="default", keep_tex=FALSE, includes=NULL, pandoc_args=NULL, knitrSetup=TRUE){
   if (identical(highlight, "default")) highlight = "pygments"
   #template = system.file("/templates/hw_template/resources/hw_template.tex",package="usefulR")
   template = "/Users/user/R/packages/usefulR/templates/hw_template/resources/hw_template.tex"
   format = rmarkdown::pdf_document(number_sections = TRUE, fig_caption = TRUE, dev = dev, highlight = highlight, template = template, keep_tex = TRUE, latex_engine = "pdflatex", includes = includes, pandoc_args = NULL)
   print(format)
   if(knitrSetup){
      knitrSetup.opts = usefulR::knitrSetup(rootDir=rootDir, use.tikz=use_tikz, fig.height=fig_height, fig.width=fig_width, crop=fig_crop, return_opts=TRUE)
      #opts_knit
      format$knitr$opts_knit = usefulR::merge_lists(lists= list(format$knitr$opts_knit, knitrSetup.opts$knitr$opts_knit),FALSE)

      #opts_chunk
      format$knitr$opts_chunk = usefulR::merge_lists(list(format$knitr$opts_chunk, knitrSetup.opts$knitr$opts_chunk),FALSE)

      #opts_hooks
      format$knitr$knit_hooks = usefulR::merge_lists(list(format$knitr$knit_hooks, knitrSetup.opts$knitr$knit_hooks), FALSE)
   }
   format
}
