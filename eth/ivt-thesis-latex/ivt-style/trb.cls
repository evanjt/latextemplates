% Transportation Research Board conference paper template
% version 2.1.3

% 
% David R. Pritchard, http://davidpritchard.org
% Joseph Molloy, joseph.moloy@ivt.baug.ethz.ch
%   1.0   - Mar. 2009
%   1.1   - Sep. 2011, fixes for captions
%   2.0   - Mar. 2012, Reorganized title page incl. automatic counters
%   2.1   - Jul. 2015, Automatic total word counter and more formattings
%   2.1.1 - Jan. 2016, Minor modifications and first uploaded to Github
%   2.1.1 - May. 2016, created a lite version for people to use directly on TeX without Sweave options
%   2.1.2 - July. 2019, compatibility with ETHZ IVT
%   2.1.3 - Dec. 2019, TRB now allows Harvard style, i.e. Authoryear in natbib.

% Official trb manual for authors:
% http://onlinepubs.trb.org/onlinepubs/AM/InfoForAuthors.pdf
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{trbunofficial}[2017/06/10 TRB latex template]

\LoadClass[titlepage, oneside, 12pt]{article}

\RequirePackage[tiny, rm, pagestyles]{titlesec}
\RequirePackage{enumitem}
\RequirePackage{ccaption}
\RequirePackage[fleqn]{amsmath}
\RequirePackage{mathptmx} % Times text series for text and math
% Some pdf conversion tricks? Unsure.
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{textcomp}
\RequirePackage[pagewise, mathlines]{lineno}
\RequirePackage{geometry}
\RequirePackage{graphics}
\RequirePackage{graphicx}

% Use hyper-refs for URLs and citations, allow line breaks for URLs include after all other packages, especially after titlesec
\RequirePackage{hyperref}
\RequirePackage{url}
% convenient referencing (after hyperref)
\RequirePackage[capitalize]{cleveref}

\RequirePackage[sort&compress, numbers]{natbib}
\RequirePackage{xparse}
\RequirePackage{totcount}
\DeclareOption{numbered}{%
  \linenumbers%
}
\ProcessOptions\relax

% Vars
%------------------------------------------------------------------------------
%%% for TRB header
\def\@AuthorHeaders{Set Author Surnames with \textbackslash AuthorHeaders\{name1, name2\}}

\newcommand{\AuthorHeaders}[1]{
  \def\@AuthorHeaders{#1}
}

%% IVT commands
%------------------------------------------------------------------------------
\providecommand{\germanabstract}[1]{\gdef\@thegermanabstract{#1}}
\newcommand{\reportdategerman}[1]{\gdef\@reportdategerman{#1}}%
\newcommand{\ivtsource}[1]{ }
\newcommand{\suggestedCitation}[1]{\gdef\@suggestedCitation{#1}}%

% Page layout
%------------------------------------------------------------------------------ 
\geometry{textwidth=6.5in, textheight=9.0in}
\geometry{top=1in, left=1in}
\geometry{headheight=0.3in, headsep=0.2in}

% Text formatting
%------------------------------------------------------------------------------ 
\setlength{\parindent}{0.5in}


% Header
%------------------------------------------------------------------------------
\newpagestyle{main}{
\sethead{\@AuthorHeaders}{}{\thepage}
}
\pagestyle{main}

% HEADINGS
%------------------------------------------------------------------------------
% Line spacing: 12pt before section titles
\renewcommand*{\refname}{\uppercase{References}}
\titleformat{\section}{\bfseries}{}{0pt}{\uppercase}
\titlespacing*{\section}{0pt}{12pt}{*0}
\titleformat{\subsection}{\bfseries}{}{0pt}{}
\titlespacing*{\subsection}{0pt}{12pt}{*0}
\titleformat{\subsubsection}{\itshape}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{12pt}{*0}

% EQUATIONS
%------------------------------------------------------------------------------
\setlength{\mathindent}{0in}
% Set spacing before and after equation to be 0
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{0pt}
  \setlength\belowdisplayskip{0pt}
  \setlength\abovedisplayshortskip{0pt}
  \setlength\belowdisplayshortskip{0pt}
}

% LISTS
%------------------------------------------------------------------------------ 
% Adjust lists a little. Not quite perfectly fitting TRB style, but vaguely
% close at least.
\setlist[1]{labelindent=0.5in,leftmargin=*}
\setlist[2]{labelindent=0in,leftmargin=*}
\setlist{nosep} % eliminate extra verticle spacings between items

% CAPTIONS
%------------------------------------------------------------------------------ 
% Get the captions right. Authors must still be careful to use "Title Case"
% for table captions, and "Sentence case." for figure captions.
\renewcommand{\fnum@figure}{\bfseries FIGURE~\thefigure}
\renewcommand{\fnum@table}{\bfseries TABLE~\thetable}
\captiontitlefont{\bfseries \boldmath}
\captiondelim{\;}
%\precaption{\boldmath}




% Compatibility with eth-ivt
%------------------------------------------------------------------------------ 
\RequirePackage{url}
\newcommand{\subtitle}[1]{}
\newcommand{\reportdate}[1]{}
\newcommand{\reportnumber}[1]{}
\newcommand{\titlefigure}[1]{}
\newcommand{\papertype}[1]{}
\newcommand{\mytitle}[1]{}%

\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}
\newcommand{\printabstract}{
    \section{Abstract}
    \@abstract
}

\providecommand\keywords{}
\renewcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\printkeywords}{
    \noindent\textit{Keywords}: \@keywords
    \newpage    
}



% CITATIONS
%------------------------------------------
% TRB uses an Author (num) citation style. I haven't found a way to make
% LaTeX/Bibtex do this automatically using the standard \cite macro, but
% this modified \trbcite macro does the trick.
%\renewcommand{\cite}[1]{(\textit{\citenum{#1}})}
%\renewcommand{\citep}[1]{\citeauthor{#1} (\textit{\citenum{#1}})}
\setcitestyle{round,authoryear}

% Reduce spacing between bibliographic items
\setlength{\bibsep}{0pt plus 0.3ex}


% LINE NUMBERING
%------------------------------------------------------------------------------ 
% Adjust the fond of the line numbering
\renewcommand\linenumberfont{\normalfont\small}


% REFERENCES
% Remove square brackets from the numbering and add indentation to bibliography 
% in the REFERENCES section
\renewcommand\@biblabel[1]{#1.\hspace{0.25in}} 

% COUNTERS
%------------------------------------------------------------------------------ 
% TRB requires the total number of words, figures, and tables to be displayed
% on the title page. This is possible under the totcount and the xparse
% packages on CTAN.
%
% Note that a total word count is added in V 2.1 to print a single value that
% is calculated as: numberofwords + numberoffigures*250 + numberoftable*250

% Total world count solution from Tex.SX:
% https://tex.stackexchange.com/q/255940
% https://tex.stackexchange.com/q/448605

\makeatletter
\newread\somefile
\newcounter{totalwordcounter}
\newcounter{wordcounter}

% default: 250 number of words per table
\def\@WordsPerTable{250}
\newcommand{\WordsPerTable}[1]{%
	\def\@WordsPerTable{#1}
}

% TODO: there must be a better way to define this to avoid using 0
% Variable to control manual word counting
\def\@TotalWords{0}
\newcommand{\TotalWords}[1]{%
	\def\@TotalWords{#1}
}

% From totcount package
\regtotcounter{table} 	%count tables
\regtotcounter{figure} 	%count figures

\newcommand{\quickwordcount}[1]{%
	\immediate\write18{texcount -1 -sum -merge #1.tex > #1-words}%
	\immediate\openin\somefile=#1-words%
	\read\somefile to \@@localdummy%
	\immediate\closein\somefile%
	\setcounter{wordcounter}{\@@localdummy}%
	\@@localdummy%
}

\newcommand{\totalwordcount}{%
	\setcounter{totalwordcounter}{\value{wordcounter}}%
	\addtocounter{totalwordcounter}{\numexpr\@WordsPerTable*\totvalue{table}}%
	\number\value{totalwordcounter}% Output the number
	\renewcommand{\totalwordcount}{\number\value{totalwordcounter}}
}

\newcommand{\figurecountwarning}{
  \ifnum\totvalue{figure}>6
      \ClassError{trb}{A maximum of 6 figures are allowed for trb}{}
  \fi
}

% Turn and command in author into a line break.
\renewcommand{\author}[1]{
    \def\and{\newline\newline}
    \gdef\@author{#1}
}%

% TODO: find better way than multiple hfill and break to get numbered empty
% lines. Is it really necessary to have empty lines numbered? Its just the way
% users of word deal with that.
\renewcommand{\maketitle}{%
	\thispagestyle{empty}
	\begin{flushleft}
		{\MakeUppercase{\bfseries\@title}}\\
		\hfill\break%
		\@author\\
		\hfill\break%
		\if\@TotalWords 0
		Word Count: \quickwordcount{Template}~words $+$ \total{table} table(s) $\times$ \@WordsPerTable\ $=$ \totalwordcount~words\\
		\else
		Word Count: \@TotalWords\ words $+$ \total{table} table(s) $\times$ \@WordsPerTable\ $=$ \the\numexpr\@TotalWords + \totvalue{table}*\@WordsPerTable~words\\
		\fi
		
		\figurecountwarning

		\hfill\break%
		Submission Date: \today
	\end{flushleft}
	\newpage
	
    \printabstract
    \newline
    \newline
    \printkeywords

}
\makeatother



\bibliographystyle{ivt-style/trb}
