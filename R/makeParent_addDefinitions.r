#' Keep the parent document simple
#'
#' This code sets some of the values for knitr that I like.
#' @param addDefs character value, optional argument
#' @param addTheorems character value, optional argument
#' @param addStructure character value, optional argument
#' @export
#' @examples
#' makeParent_addDefinitions()

makeParent = function(addDefs = TRUE, addTheorems = TRUE, addStructure = TRUE){
defs = 
'
%%%%%%%% Define New Commands  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \\blue{} creates blue text
\\newcommand{\\blue}[1]{{\\color{blue} #1}}

% \\red{} create red text
\\newcommand{\\red}[1]{{\\color{red} #1}}

% \\distras gives a distribution tilde
\\newcommand{\\distras}[1]{%
\\savebox{\\mybox}{\\hbox{\\kern3pt$\\scriptstyle#1$\\kern3pt}}%
\\savebox{\\mysim}{\\hbox{$\\sim$}}%
\\mathbin{\\overset{#1}{\\kern\\z@\\resizebox{\\wd\\mybox}{\\ht\\mysim}{$\\sim$}}}%
}
\\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Create New Theorems  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New theorems: 
%     \\newtheorem{name}{What gets printed in the box}[counter]
% used by
%     \\begin{name}
%     CONTENT GOES HERE
%     \\end{name}

\\newtheorem{theorem}{Theorem}[section]
\\newtheorem{lemma}{Lemma}[section]
\\newtheorem{cor}{Corollary}[section]
\\newtheorem{remark}{Remark}[section] 
\\newtheorem{defi}{Definition}[section]
\\newtheorem{example}{Example}[section]
\\newtheorem{model}{Model}[section]
\\newtheorem{condi}{Condition}[section]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%% Mathematical Macros  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\\newcommand{\\psp}{\\ensuremath{\\left(\\Omega,\\mathcal{F},\\mu\\right)}}

\\newcommand{\\degree}[1]{\\ensuremath{\\text{degree}(#1)}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%% Homework Envioronment Tools  %%%%%%%%%%%%%%%%%%%%%%
% Problem header helps us know when we go to next page
\\newcommand{\\enterProblemHeader}[1]{\\nobreak\\extramarks{#1}{#1 continued on next page\\ldots}\\nobreak%
                                    \\nobreak\\extramarks{#1 (continued)}{#1 continued on next page\\ldots}\\nobreak}%
\\newcommand{\\exitProblemHeader}[1]{\\nobreak\\extramarks{#1 (continued)}{#1 continued on next page\\ldots}\\nobreak%
                                   \\nobreak\\extramarks{#1}{}\\nobreak}%

% label problems
\\newlength{\\labelLength}
\\newcommand{\\labelAnswer}[2]
  {\\settowidth{\\labelLength}{#1}%
   \\addtolength{\\labelLength}{0.25in}%
   \\changetext{}{-\\labelLength}{}{}{}%
   \\noindent\\fbox{\\begin{minipage}[c]{\\columnwidth}#2\\end{minipage}}%
   \\marginpar{\\fbox{#1}}%

   % We put the blank space above in order to make sure this
   % \\marginpar gets correctly placed.
   \\changetext{}{+\\labelLength}{}{}{}}%

% Start a problem with \\homeworkProblemName
\\setcounter{secnumdepth}{0}
\\newcommand{\\homeworkProblemName}{}%
\\newcounter{homeworkProblemCounter}%
\\newenvironment{homeworkProblem}[1][Problem \\arabic{homeworkProblemCounter}]%
  {\\stepcounter{homeworkProblemCounter}%
   \\renewcommand{\\homeworkProblemName}{#1}%
   \\section{\\homeworkProblemName}%
   \\enterProblemHeader{\\homeworkProblemName}}%
  {\\exitProblemHeader{\\homeworkProblemName}}%

% start an answer with \\problemAnswer
\\newcommand{\\problemAnswer}[1]
  {\\noindent\\fbox{\\begin{minipage}[c]{\\columnwidth}#1\\end{minipage}}}%

\\newcommand{\\problemLAnswer}[1]
  {\\labelAnswer{\\homeworkProblemName}{#1}}

% start a section of the homework
\\newcommand{\\homeworkSectionName}{}%
\\newlength{\\homeworkSectionLabelLength}{}%
\\newenvironment{homeworkSection}[1]%
  {% We put this space here to make sure we're not connected to the above.
   % Otherwise the changetext can do funny things to the other margin

   \\renewcommand{\\homeworkSectionName}{#1}%
   \\settowidth{\\homeworkSectionLabelLength}{\\homeworkSectionName}%
   \\addtolength{\\homeworkSectionLabelLength}{0.25in}%
   \\changetext{}{-\\homeworkSectionLabelLength}{}{}{}%
   \\subsection{\\homeworkSectionName}%
   \\enterProblemHeader{\\homeworkProblemName\\ [\\homeworkSectionName]}}%
  {\\enterProblemHeader{\\homeworkProblemName}%

   % We put the blank space above in order to make sure this margin
   % change doesn't happen too soon (otherwise \\sectionAnswer's can
   % get ugly about their \\marginpar placement.
   \\changetext{}{+\\homeworkSectionLabelLength}{}{}{}}%

\\newcommand{\\sectionAnswer}[1]
  {% We put this space here to make sure we're disconnected from the previous
   % passage

   \\noindent\\fbox{\\begin{minipage}[c]{\\columnwidth}#1\\end{minipage}}%
   \\enterProblemHeader{\\homeworkProblemName}\\exitProblemHeader{\\homeworkProblemName}%
   \\marginpar{\\fbox{\\homeworkSectionName}}%

   % We put the blank space above in order to make sure this
   % \\marginpar gets correctly placed.
   }%
\\makeatletter
\\newcommand{\\distas}[1]{\\mathbin{\\overset{#1}{\\kern\\z@\\sim}}}%
\\newsavebox{\\mybox}\\newsavebox{\\mysim}
\\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%% Fancy Quotes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\\makeatletter
\\tikzset{%
  fancy quotes/.style={
    text width=\\fq@width pt,
    align=justify,
    inner sep=1em,
    anchor=north west,
    minimum width=\\textwidth,
  },
  fancy quotes width/.initial={.8\\textwidth},
  fancy quotes marks/.style={
    scale=8,
    text=white,
    inner sep=0pt,
  },
  fancy quotes opening/.style={
    fancy quotes marks,
  },
  fancy quotes closing/.style={
    fancy quotes marks,
  },
  fancy quotes background/.style={
    show background rectangle,
    inner frame xsep=0pt,
    background rectangle/.style={
      fill=gray!25,
      rounded corners,
    },
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% less fancy
%   \\begin{fquote}[Author][Book][date]
%       Here is a good quote
%   \\end{fquote}
%
%           Whats up dogs!         ____________________________________
%                                   -Lawler, Introduction to Stochastic 

\\definecolor{lessfancyquotemark}{gray}{.7}
\\makeatletter
\\def\\fquote{%
    \\@ifnextchar[{\\fquote@i}{\\fquote@i[]}%]
           }%
\\def\\fquote@i[#1]{%
    \\def\\tempa{#1}%
    \\@ifnextchar[{\\fquote@ii}{\\fquote@ii[]}%]
                 }%
\\def\\fquote@ii[#1]{%
    \\def\\tempb{#1}%
    \\@ifnextchar[{\\fquote@iii}{\\fquote@iii[]}%]
                      }%
\\def\\fquote@iii[#1]{%
    \\def\\tempc{#1}%
    \\vspace{1em}%
    \\noindent%
    \\begin{list}{}{%
         \\setlength{\\leftmargin}{0.1\\textwidth}%
         \\setlength{\\rightmargin}{0.1\\textwidth}%
                  }%
         \\item[]%
         \\begin{picture}(0,0)%
         %\\put(-15,-5){\\makebox(0,0){\\scalebox{3}{\\textcolor{lessfancyquotemark}{``}}}}%
         \\end{picture}%
         \\begingroup\\itshape}%

 \\def\\endfquote{%
 \\endgroup\\par%
 \\makebox[0pt][l]{%
 \\hspace{0.8\\textwidth}%
 \\begin{picture}(0,0)(0,0)%
 %\\put(15,15){\\makebox(0,0){%
 %\\scalebox{2}{\\color{lessfancyquotemark}''}}}%
 \\end{picture}}%
 \\ifx\\tempa\\empty%
 \\else%
    \\ifx\\tempc\\empty%
       \\hfill\\rule{100pt}{0.5pt}\\\\\\mbox{}\\hfill- \\tempa,\\ \\emph{\\tempb}%
   \\else%
       \\hfill\\rule{100pt}{0.5pt}\\\\\\mbox{}\\hfill- \\tempa,\\ \\emph{\\tempb},\\ \\tempc%
   \\fi\\fi\\par%
   \\vspace{0.5em}%
 \\end{list}%
 }%
 \\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   \\begin{simplequote}[Author][Book][date]
%       Here is a good quote
%   \\end{simplequote}
%
%       italicized text that wraps eventually
%                                        -Author, Book (date)

\\makeatletter
\\def\\simpquote{%
    \\@ifnextchar[{\\simpquote@i}{\\simpquote@i[]}%]
           }%
\\def\\simpquote@i[#1]{%
    \\def\\tempa{#1}%
    \\@ifnextchar[{\\simpquote@ii}{\\simpquote@ii[]}%]
                 }%
\\def\\simpquote@ii[#1]{%
    \\def\\tempb{#1}%
    \\@ifnextchar[{\\simpquote@iii}{\\simpquote@iii[]}%]
                      }%
\\def\\simpquote@iii[#1]{%
    \\def\\tempc{#1}%
    \\vspace{0.5em}%
    \\noindent%
    \\begin{list}{}{%
         \\setlength{\\leftmargin}{0.1\\textwidth}%
         \\setlength{\\rightmargin}{0.1\\textwidth}%
                  }%
         \\item[]%
         \\begingroup\\itshape}%

 \\def\\endsimpquote{%
 \\endgroup\\par%
 \\makebox[0pt][l]{%
 \\hspace{0.8\\textwidth}%
 }%
 \\ifx\\tempa\\empty%
 \\else%
    \\ifx\\tempc\\empty%
       \\mbox{}\\hfill- \\tempa,\\ \\emph{\\tempb}%
   \\else%
       \\mbox{}\\hfill- \\tempa,\\ \\emph{\\tempb}\\ (\\tempc)%
   \\fi\\fi\\par%
   \\vspace{0.5em}%
 \\end{list}%
 }%
 \\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   \\begin{stackquote}[Author][Book][date]
%       Here is a good quote
%   \\end{stackquote}
%
%       italicized text that wraps eventually
%                                        -Author, 
%                                     Book (date)

\\makeatletter
\\def\\stackquote{%
    \\@ifnextchar[{\\stackquote@i}{\\stackquote@i[]}%]
           }%
\\def\\stackquote@i[#1]{%
    \\def\\tempa{#1}%
    \\@ifnextchar[{\\stackquote@ii}{\\stackquote@ii[]}%]
                 }%
\\def\\stackquote@ii[#1]{%
    \\def\\tempb{#1}%
    \\@ifnextchar[{\\stackquote@iii}{\\stackquote@iii[]}%]
                      }%
\\def\\stackquote@iii[#1]{%
    \\def\\tempc{#1}%
    \\vspace{0.5em}%
    \\noindent%
    \\begin{list}{}{%
         \\setlength{\\leftmargin}{0.1\\textwidth}%
         \\setlength{\\rightmargin}{0.1\\textwidth}%
                  }%
         \\item[]%
         \\begingroup\\itshape}%

 \\def\\endstackquote{%
 \\endgroup\\par%
 \\makebox[0pt][l]{%
 \\hspace{0.8\\textwidth}%
 }%
 \\ifx\\tempa\\empty%
 \\else%
    \\ifx\\tempc\\empty%
       \\mbox{}\\hfill- \\tempa, \\\\
       \\mbox{}\\hfill \\emph{\\tempb}%
   \\else%
       \\mbox{}\\hfill- \\tempa, \\\\ 
       \\mbox{}\\hfill \\emph{\\tempb}\\ (\\tempc)%
   \\fi\\fi\\par%
   \\vspace{0.5em}%
 \\end{list}%
 }%
 \\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%% Framed Theorems %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\\newtheorem{theo}{Theorem}
\\newenvironment{ftheo}
  {\\begin{mdframed}\\begin{theo}}
  {\\end{theo}\\end{mdframed}}

\\newtheorem{deffy}{Definition}
\\newenvironment{fdef}
  {\\begin{mdframed}\\begin{deffy}}
  {\\end{deffy}\\end{mdframed}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%% Project Specific Information %%%%%%%%%%%%%%%%%%%%%

%The semester of the current project
\\def\\Semester{Fall 2014} %i.e., Spring 2014

% ClassShort is the abbreviation of the project or course
% Group or course name (short) %i.e., MATH 544
\\def\\GroupShort{COM S 511}   
\\def\\thistitle{Homework Assignment 1}%
\\def\\thistitleShort{HW 1}%

% ClassLong is the full name of the project or course
% Group or course name (long) %i.e. Intro. to Stochastic Processes
\\def\\GroupLong{DSN and Analysis of Algorithms}

% MeetingTime is a meeting time associated with the course
% Group or class meeting time % i.e., MWF 1:10 - 2:00
\\def\\MeetingTime{TR 12:40 - 2:00} 

% The full name of the person leading the group
% Group leader or course instructor (long) %Dr. Alex Roitershtein
\\def\\GroupLeaderLong{Dr. Oliver Eulenstein}

% The last name of the person leading the group
% Group Leader or course instructor (short) % i.e., Roitershtein
\\def\\GroupLeaderShort{Eulenstein} 


% Author Name
\\def\\AuthorName{Ian Mouzon}
\\def\\AuthorNameShort{Mouzon}
\\def\\AuthorContact{imouzon [@iastate]}

% Instructions (due date, etc.)
% i.e., Due Friday, September 19th at 1:00
\\def\\HWDueDate{Tuesday September 9th at 12:40}


% Instructions 
% i.e., Guidelines
%\\def\\theseInstructions{When proofs are required, try to make them both clear and rigorous. Even when proofs are not required, you should justify your answers and explain your work.}

% Assignment
% List of problems to be assigned
\\def\\Assignment{Assigned problems on blackboard}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%% Page set up %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note we need the following for the page header and foot:
% \\thistitle
% \\Semester
% \\GroupLong
% \\GroupShort
% \\MeetingTime
% \\GroupLeaderLong
% \\GroupLeaderShort
% \\AuthorName
% \\AuthorContact

\\topmargin=-0.45in      %
\\evensidemargin=0in     %
\\oddsidemargin=0in      %
\\textwidth=6.5in        %
\\textheight=9.0in       %
\\headsep=0.25in         %

% Setup the header and footer
\\pagestyle{fancy}                                                       %
\\lhead{\\AuthorContact}                                              %
\\lhead{\\AuthorNameShort}                                                 %
\\chead{\\GroupShort\\ (\\GroupLeaderShort\\ \\Semester): \\thistitleShort}  %
\\rhead{\\firstxmark}                                                     %
\\lfoot{\\lastxmark}                                                      %
\\cfoot{}                                                                %
\\rfoot{Page\\ \\thepage\\ of\\ \\pageref{LastPage}}                          %
\\renewcommand\\headrulewidth{0.4pt}                                      %
\\renewcommand\\footrulewidth{0.4pt}                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\\ifdefempty{\\definition}{
%      Do this if definition is NOT empty
%   }{
%      Do this if definition is empty
%   }

\\makeatletter
\\def\\titleheader{
   \\thispagestyle{empty}%
   \\begin{center}%
   \\renewcommand{\\arraystretch}{1.5}%
   \\begin{tabular}{c}%
      \\Large{\\GroupShort: \\GroupLong} \\\\
      \\thistitle \\\\
      \\Semester, \\GroupLeaderLong\\\\
   \\end{tabular}
   \\end{center}

   \\begin{center}
   \\renewcommand{\\arraystretch}{1.5}
      \\begin{tabular*}{0.65\\textwidth}{r@{:\\hspace{.3cm}}l}
   \\hline
   Name& \\AuthorName\\\\
   email& \\AuthorContact  \\\\
   %\\ifdefempty{\\theseInstructions}{}{Instructions&  \\theseInstructions \\\\}
   \\ifdefempty{\\Assignment}{}{Assignment& \\Assignment \\\\}
   \\ifdefempty{\\HWDueDate}{}{Due Date&  \\HWDueDate \\\\}
   \\hline
   \\end{tabular*}
   \\end{center}
}
\\makeatother
'
}

