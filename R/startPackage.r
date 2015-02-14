#' Simple description
#' 
#' More detailed description (several lines, potentially paragraphs)
#' This section does NOT describe the code
pkg_defaults = function(value = list()) {
  defaults = value

  get = function(name, drop = TRUE){
    if (missing(name)){
       defaults 
    }else{
      if (drop && length(name) == 1){
         defaults[[name]] 
      }else{
        setNames(defaults[name], name)
      }
    }
  }

  set = function(...){
    dots = list(...)
    if (length(dots) == 0) return()
    if (is.null(names(dots)) && length(dots) == 1 && is.list(dots[[1]]))
      if (length(dots <- dots[[1]]) == 0) return()
    defaults <<- merge(dots)
    invisible(NULL)
  }

  list(options = defaults, get = get, set = set)
}

opts_pkg = pkg_defaults(list(
   Package = '',
   Path = '',
   home = '~/R/packages/',
   Type = 'Package',
   files = c('description','namespace','readme','news','faq','gitignore'),
   folders = c('R','demo','inst','tests','vignettes','dev','data','src'),
   Authors = 'Ian Mouzon <imouzon@iastate.edu>',
   Maintainer  = 'Ian Mouzon <imouzon@iastate.edu>',
   github = 'imouzon',
   Version = '0.0',
   Description = '',
   Date = paste(as.Date(Sys.time())),
   URL = '',
   BugReports = '',
   VignetteBuilder = 'knitr',
   License = 'MIT',
   Depends = 'R (>= 2.14.1)',
   Imports = '',
   Suggests = '',
   description = list(filename = 'DESCRIPTION',
                      header = '',
                      elementFormat = 'element: elemval',
                      tailer = '',
                      elements = c('Package',
                                   'Type',
                                   'Version',
                                   'Date',
                                   'Authors',
                                   'Maintainer',
                                   'Description',
                                   'Depends',
                                   'Suggests',
                                   'License',
                                   'URL',
                                   'BugReports',
                                   'VignetteBuilder')
                      ),
   namespace = list(filename = 'NAMESPACE',
                    header = '',
                    elementFormat = '',
                    tailer = '',
                    elements = ''),

   readme = list(filename = 'README.md',
                 header = '',
                 elementFormat = '',
                 tailer = '',
                 elements = ''),

   gitignore = list(filename = '.gitignore',
                    header = '',
                    elementFormat = '',
                    tailer = '',
                    elements = ''),

   news = list(filename = 'NEWS.md',
               header = '',
               elementFormat = '',
               tailer = '',
               elements = ''),

   faq = list(filename = 'FAQ.md',
              header = '',
              elementFormat = '',
              tailer = '',
              elements = '')
   )
)

gdubsub = function(pttrns, subs, string){
   for(i in 1:length(pttrns)){
      string = gsub(pttrns[i],subs[i],string)
   }
   return(string)
}

pkg_create = function(pkg_name,use_github=TRUE){
   opts_pkg$options$Package = pkg_name
   if(use_github && opts_pkg$get('URL') == '') opts_pkg$options$URL = gdubsub(c('user','pkg_name'), c(opts_pkg$get('github'),pkg_name), 'http://github.com/user/pkg_name/')
   if(use_github && opts_pkg$get('BugReports') == '') opts_pkg$options$BugReports = gdubsub(c('user','pkg_name'), c(opts_pkg$get('github'),pkg_name), 'http://github.com/user/pkg_name/')
   opts_pkg$options$Path = paste0(opts_pkg$get('home'),pkg_name,'/')
   opts_pkg = pkg_defaults(opts_pkg$options)

   #do not overwrite a package
   if(!dir.create(opts_pkg$get('Path'))){
      pkg_exists = 'The package pkg_name already exists in the directory pkg_home'
      stop(gsub('pkg_home', opts_pkg$get('home'), gsub('pkg_name',opts_pkg$get('Package'), pkg_exists)))
   }
                
   #create the subfolders
   crfldr = function(x) dir.create(paste0(opts_pkg$get('Path'),x))
   sapply(opts_pkg$get('folders'), crfldr)

   #create the files, overwrite nothing
   create.pkg.files= function(file.opt){
      elemsub = function(x) gdubsub(c('elemval','element'),c(opts_pkg$get(x),x), opts_pkg$get(file.opt)$elementFormat)
      if(!(file.exists(paste(opts_pkg$get('Path'),opts_pkg$get(file.opt)$filename,sep='/')))){
         write(paste(opts_pkg$get(file.opt)$header, sapply(opts_pkg$get(file.opt)$elements, elemsub), opts_pkg$get(file.opt)$tailer,collapse='\n'), 
               file = paste(opts_pkg$get('Path'),opts_pkg$get(file.opt)$filename,sep='/'))
      }
   }
   sapply(opts_pkg$get('files'), create.pkg.files)
   message(gdubsub(c('pkg_name', 'pky_path'),c(opts_pkg$get('Package'), opts_pkg$get('Path')), 'The package pkg_name has been created and is in the folder pkg_path'))

   #Initialize git 
   if(use_github){
      git_package_start = 'cd package_home; git init; git add .; git commit -m \'Package initialized using imouzon\\usefulR\'; curl -u \'USER\' https://api.github.com/user/repos -d \'{\"name\":\"REPO\"}\'; git remote add origin git@github.com:USER/REPO.git; git push origin master;' 
      system(gdubsub(c('package_home','USER','REPO'),
                     c(opts_pkg$get('Path'),opts_pkg$get('github'),opts_pkg$get('Package')), 
                     git_package_start))
      message(gsub('githubURL', opts_pkg$get('URL') ,'The package hase been added to github for you: githubURL'))
   }
}

source('~/R/packages/usefulR/R/startPackage.r')
