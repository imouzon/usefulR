#' Set knitr up the way I like it
#'
#' This code sets some of the values for knitr that I like.
#' @param course character value, optional argument
#' @export
#' @examples
#' knitrSetup(use.tikz = FALSE)
TeX_hw_title = function(semester = '', course = '', instructor = '', writers = '', contact = '', title = '', due = '', assignment = '', location = ''){
   #semester course instructor writers contact title due assignment location
   if(semester == ''){
      TeX.Semester = ''
   }else{
      TeX.Semester = gsub('R.Semester',semester,'\\newcommand{\\Semester}{R.Semester}')
   }

   #get the course names
   if(course == ''){
      TeX.course.short = ''
      TeX.course.long = ''
      TeX.course.title = ''
   }else{
      course = unlist(strsplit(course,':\\s+'))
      if(length(course) > 1){
         course.short = course[1]
         course.long = course[2]
      }else{
         course.short = course[1]
         course.long = ''
      }
   
      #course.short
      TeX.course.short = gsub('R.course.short',course.short,'\\newcommand{\\CourseShort}{R.course.short}')

      #course.long
      TeX.course.long = gsub('R.course.long',course.long,'\\newcommand{\\CourseLong}{R.course.long}')

      #course.title
      TeX.course.title = gsub('R.CourseLong',course.long,'\\newcommand{\\CourseLong}{R.CourseShort: R.CourseLong}')
      TeX.course.title = gsub('R.CourseShort',course.short,TeX.course.title)
   }


   TeX_hw_course_info = paste("%Course Information",'\n',
                              TeX.Semester,'\n',
                              TeX.course.short,'\n',
                              TeX.course.long,'\n',
                              TeX.course.title,
                              sep='')

   #get the instructor names
   if(instructor == ''){
      TeX.instructor.long == ''
      TeX.instructor.short == ''
   }else{
      instructor = unlist(strsplit(instructor,'\\s+'))
      instructor.short = instructor[length(instructor)]
      instructor.long = paste(instructor,collapse=' ')

      TeX.instructor.long = gsub('R.InstructorLong',instructor.long,'\\newcommand{\\InstructorLong}{R.InstructorLong}')
      TeX.instructor.short = gsub('R.InstructorShort',instructor.short,'\\newcommand{\\InstructorShort}{R.InstructorShort}')
   }

   #Instructor Information
   TeX_hw_instructor_info = paste("%Instructor Information",'\n',
                              TeX.instructor.short,'\n',
                              TeX.instructor.long,'\n',
                              sep='')

   #Writter infor
   if(writers == ''){
      TeX.writers.long = ''
      TeX.Writers.short = ''
   }else{
      writers.long = gsub('\\s+',' ',writers)
      writers = unlist(strsplit(writers,',\\s+'))
      for(i in 2:length(writers)){
         if(grepl('\\.',writers[i])){
            writers[i-1] = paste(writers[i-1],writers[i],sep=', ')
         }
      }
      writers = writers[!grepl('\\.',writers) | grepl(',',writers)]
      writers.short = paste(sapply(1:length(writers),function(x) paste(unlist(strsplit(writers[x],'\\s+'))[2:length(unlist(strsplit(writers[x],'\\s+')))],collapse = ' ')),collapse = ', ')

      TeX.writers.long = gsub("R.WritersLong",writers.long,"\\newcommand{\\WritersLong}{R.WritersLong}")
      TeX.writers.short = gsub("R.WritersShort",writers.short,"\\newcommand{\\WritersShort}{R.WritersShort}")
   }

   if(contact == ''){
      TeX.writers.contact = ''
   }else{
      contact = gsub(',\\s+','}, \\\\\\\\textcolor{blue}{',contact)
      contact = paste('\\\\textcolor{blue}{',contact,'}',sep='',collapse = ',')
      TeX.writers.contact = gsub('R.WritersContact',contact,'\\newcommand{\\WritersContact}{R.WritersContact}')
   }

   TeX_hw_writer_info = paste("%Writer Information",'\n',
                              TeX.writers.short,'\n',
                              TeX.writers.long,'\n',
                              TeX.writers.contact,'\n',
                              sep='')

   #Homework info
   if(title == ''){
      TeX.title = ''
   }else{
      TeX.title = gsub('R.homeworkTitle',title,'\\newcommand{\\homeworkTitle}{R.homeworkTitle}')
   }

   if(due == ''){
      TeX.DueDate = ''
   }else{
      TeX.DueDate = gsub('R.DueDate',due,'\\newcommand{\\homeworkDueDate}{R.DueDate}')
   }

   if(assignment == ''){
      TeX.assignment = ''
   }else{
      TeX.assignment= gsub('R.assignment',assignment,'\\newcommand{\\homeworkAssignment}{R.assignment}')
   }

   #data location
   if(location == ''){
      TeX.DataLoc = ''
   }else{
      TeX.DataLoc = gsub('R.DataLoc',location,'\\newcommand{\\homeworkDataLocation}{\\blue{R.DataLoc}}')
   }

   TeX_hw_homework_info = paste("%Homework Information",'\n',
                              TeX.title,'\n',
                              TeX.DueDate,'\n',
                              TeX.assignment,'\n',
                              TeX.DataLoc,'\n',
                              sep='')

   #%HomeworkInfo
   TeX_HW_info_doc = paste(TeX_hw_course_info,'\n',
                           TeX_hw_instructor_info,'\n', 
                           TeX_hw_writer_info,'\n', 
                           TeX_hw_homework_info)

   fileConn = file('information_format_document.tex')
   writeLines(TeX_HW_info_doc, fileConn)
   close(fileConn)

   TeX_title = '
   \\begin{center}
   \\renewcommand{\\arraystretch}{1.5}
      \\begin{tabular}{c}
         \\LARGE{\\CourseLong} \\\\
         \\Large{\\InstructorLong} \\\\
         
         \\homeworkTitle \\\\

         \\Semester, \\homeworkDueDate\\\\
      \\end{tabular}
   \\end{center}
   \\begin{center}
   \\renewcommand{\\arraystretch}{1.5}
      \\begin{tabular*}{0.65\\textwidth}{r@{:\\hspace{.3cm}}l}
      \\hline
      Student Name& \\WritersLong \\\\
      email& \\WritersContact \\\\
      Due Date& \\homeworkDueDate\\\\
      Data Location& \\homeworkDataLocation \\\\
      \\hline
   \\end{tabular*}
   \\end{center}"
   return(title.text)'

   fileConn = file('title_format_document.tex')
   writeLines(TeX_HW_info_doc, fileConn)
   close(fileConn)

}


TeX_hw_title(semester = 'SPRING 2014',
   course = 'M165: Calc',
   instructor = 'Dr. Dan Nordman',
   writers = 'Ian Mozun',
   contact = 'imouzon@iastate.edu',
   title = 'Hommero 3',
   due = 'Feb 1 2014',
   assignment = '1.4, 1.5',
   location = '')



}
