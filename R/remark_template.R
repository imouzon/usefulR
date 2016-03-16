#' function_name: remark_template.R
#'
#' Purpose: Provides a framework for a basic remark presentation
#' Creation Date: 20-01-2016
#' Last Modified: Tue Feb  9 12:14:09 2016
#'
#' @param fig_width numeric value, optional argument (default 5)
#' @param fig_height numeric value optional argument (default 5)
#' @param dev character argument (default pdf)
#' @param highlight character value, optional argument (default = "default")
#' @param keep_tex logical value, optional argument
#' @param includes = NULL, optional argument
#' @param pandoc_args = NULL, optional argument
#' @param paramname integer value, optional argument
#' @export

remark_template = function(
   toc_depth = 3,
   template = "default", 
   css = NULL,
   fig_width = 5, 
   fig_height = 5, 
   fig_retina = if (!fig_caption) 2,
   fig_caption = FALSE,
   dev = "png", 
   smart = TRUE,
   self_contained = TRUE,
   theme="default", 
   highlight="default", 
   mathjax = "default",
   includes=NULL, 
   keep_md=FALSE, 
   lib_dir = NULL,
   md_extensions = NULL,
   pandoc_args=NULL, 
   ...){

   # requires rmarkdown

   # arguments for pandoc: 
   args <- c()

   # document should be standalone using this template
   # args <- c("--standalone")

   # wrap sections in <div> tags
   args <- c(args, "--section-divs")

   # No table of contents at this point in time
   toc <- FALSE
   args <- c(args, rmarkdown:::pandoc_toc_args(toc, toc_depth))

   # template args
   if (identical(template, "default")){

      template <- system.file("rmarkdown/templates/remark_template/resources/remark_template.html",package="usefulR")

   }

   args <- c(args, "--template", rmarkdown:::pandoc_path_arg(template))

   pre_processor <- function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {

      if(is.null(lib_dir)) lib_dir <- files_dir

      args <- c()
      
      args <- c(args, rmarkdown:::pandoc_html_highlight_args(highlight, template, self_contained, lib_dir, output_dir))

      args <- c(args, rmarkdown:::includes_to_pandoc_args(includes, filter = if(identical(runtime,"shiny")) normalize_path else identity))

      args

   }


   rmarkdown:::output_format(
      knitr = rmarkdown:::knitr_options_html(
         fig_width, 
         fig_height, 
         fig_retina, 
         keep_md, 
         dev
      ),
      pandoc = rmarkdown:::pandoc_options(
         to = "markdown", 
         from = rmarkdown:::from_rmarkdown(fig_caption), 
         args = args
      ),
      keep_md = keep_md,
      clean_supporting = self_contained,
      pre_processor = pre_processor,
      base_format = rmarkdown:::html_document_base(
         smart = smart, 
         theme = theme, 
         self_contained = self_contained, 
         lib_dir = lib_dir, 
         mathjax = mathjax, 
         template = template, 
         pandoc_args = pandoc_args, ...)
   )
}
