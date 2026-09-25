% for jSEDI, a community-driven, Diamond Open Access journal publishing peer-reviewed %research deep Earth And planets.
% Current version adapted from the equivalent Seismica template

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jsedi_sub}[2024 LaTeX2e document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% option for papers to be reviewed
\newif\if@forreview
\@forreviewfalse
\DeclareOption{forreview}{\@forreviewtrue}

% used for forreview
\newif\if@onecolumn
\@onecolumnfalse
\DeclareOption{onecolumn}{\@onecolumntrue}

\newif\if@letter
\@letterfalse
\DeclareOption{letter}{\@lettertrue}

\newif\if@comment
\@commentfalse
\DeclareOption{comment}{\@commenttrue}

\newif\if@reply
\@replyfalse
\DeclareOption{reply}{\@replytrue}

\newif\if@regular
\@regularfalse
\DeclareOption{regular}{\@regulartrue}

% option for review papers
\newif\if@review
\@reviewfalse
\DeclareOption{review}{\@reviewtrue}

\newif\if@anonymous
\@anonymousfalse
\DeclareOption{anonymous}{\@anonymoustrue}

\newif\if@breakmath
\@breakmathfalse
\DeclareOption{breakmath}{\@breakmathtrue}

\newif\if@languages
\@languagesfalse
\DeclareOption{languages}{\@languagestrue}

\newif\if@preprint
\@preprintfalse
\DeclareOption{preprint}{\@preprinttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Forreview option by default
\if@preprint
\else
\@forreviewtrue
\fi

\if@forreview
\@onecolumntrue
\fi

\if@onecolumn
\LoadClass[11pt,twoside,a4paper,onecolumn]{article}
\else
\LoadClass[11pt,twoside,a4paper,twocolumn]{article}
\fi

\RequirePackage[headsep=0.7cm,
top=2cm,
bottom=1.5cm,
left=1.5cm,
right=1.5cm,
footskip=0.7cm]{geometry}
\setlength{\columnsep}{0.8cm}
\RequirePackage[table]{xcolor}
\definecolor{linkblue}{RGB}{38,81,143}
\definecolor{linkblue}{RGB}{38,81,143} % 
\definecolor{jsediDarkBlue}{RGB}{18,52,103}     % dark blue
\definecolor{jsediGreen}{RGB}{77,185,123}       % green water
\definecolor{jsediDarkPink}{RGB}{222,60,75}     % dark pink  
\definecolor{jsediMediumBlue}{RGB}{38,81,143}   % medium blue
\definecolor{jsediOrangeRed}{RGB}{139,37,0}
\definecolor{codebackcolor}{RGB}{243,243,243}   % pale grey

\RequirePackage[unicode,
bookmarks=true,
linkcolor=linkblue,
citecolor=linkblue,
hidelinks,
hyperfootnotes=false]{hyperref}
\hypersetup{colorlinks,linkcolor=linkblue}
\hypersetup{colorlinks,citecolor=linkblue}
\hypersetup{colorlinks,urlcolor=linkblue}
\RequirePackage{url}
\def\UrlBreaks{\do\/\do-\do_}

\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{titling}
\RequirePackage{abstract}
\RequirePackage{fancyhdr}
\RequirePackage{lscape}
\RequirePackage{bookmark}
\RequirePackage{caption} 

%%%% biblatex
\RequirePackage[backend=biber,natbib,
indexing=cite,
uniquename=false,
%citestyle=authoryear-comp,
citestyle=authoryear,
bibstyle=authoryear,
dashed=false,
sorting=nyt,
maxbibnames=20,
maxcitenames=2,
uniquelist=minyear,
abbreviate=true,
date=year,
doi=true,
url=false,
isbn=false,
giveninits=true,
hyperref]{biblatex}

\DeclareFieldFormat{citethyperref}{\bibhyperref{#1}}

\DeclareCiteCommand{\citep}[\mkbibparens]
  {\usebibmacro{prenote}}
  {\bibhyperref{%
   \usebibmacro{citeindex}%
   \usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand{\parencite}[\mkbibparens]
  {\usebibmacro{prenote}}
  {\bibhyperref{%
   \usebibmacro{citeindex}%
   \usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand{\citet} % 
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \bibhyperref{%
     \printnames{labelname}%       
     \space
     \printtext[parens]{\usebibmacro{citeyear}} 
   }}  
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand{\textcite} 
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
   \bibhyperref{%
     \printnames{labelname}%       
     \space
     \printtext[parens]{\usebibmacro{citeyear}}% 
   }}  
  {\multicitedelim}
  {\usebibmacro{postnote}}


\RequirePackage{doi}


\RequirePackage[noblocks]{authblk}
\setcounter{Maxaffil}{0}
\RequirePackage{datatool}
\RequirePackage{etoolbox}
\RequirePackage{comment}
\RequirePackage{physics}
\RequirePackage{listings}
\RequirePackage{changepage}
\RequirePackage{setspace}

% fonts and math
\RequirePackage{mathptmx} 
\RequirePackage[scaled=.90]{helvet} 
\RequirePackage{newtxmath}
\if@breakmath
\RequirePackage{breqn}
\BeforeBeginEnvironment{dmath}{\begin{nolinenumbers}}
\AfterEndEnvironment{dmath}{\end{nolinenumbers}}
\BeforeBeginEnvironment{dmath*}{\begin{nolinenumbers}}
\AfterEndEnvironment{dmath*}{\end{nolinenumbers}}
%% patches \eq@setnumber to use \refstepcounter instead of \stepcounter, from https://tex.stackexchange.com/questions/241118/autoref-to-dmath-from-breqn-package-generates-wrong-link-text
\patchcmd\eq@setnumber{\stepcounter}{\refstepcounter}{}{%
	\errmessage{Patching \noexpand\eq@setnumber failed}%
}
% break equations
\renewenvironment{equation}{%
	\begin{dmath}}{%
\end{dmath}}
\fi
\newcommand{\mathbfup}[1]{\mathord{\textnormal{\textbf{#1}}}}

\RequirePackage[mathlines]{lineno} %% loaded here because incompatibility with breqn
\if@forreview
%\linenumbers
\doublespacing
\fi

\RequirePackage[T1]{fontenc}
\RequirePackage[autostyle=false, style=english]{csquotes}

\newcommand{\sff}{\sffamily}
\newcommand{\sflight}{\sffamily}


%-------------------------------------------------------------------------------
%                Configuration for authors
%-------------------------------------------------------------------------------

% package authblk
\renewcommand*{\Authsep}{, }
\renewcommand*{\Authand}{, }
\renewcommand*{\Authands}{, }
\renewcommand*{\Authfont}{\bfseries}    % make author names boldface    
\setlength{\affilsep}{0.2cm}   % set the space between author and affiliation
\renewcommand*{\Affilfont}{\normalfont\small}
\renewcommand\AB@affilsepx{, \protect\Affilfont}

% For orcid symbol without lualatex
% Copy of orcidlinks.sty / https://github.com/duetosymmetry/orcidlink-LaTeX-command
\RequirePackage{tikz}
\usetikzlibrary{svg.path}

\definecolor{orcidlogocol}{HTML}{A6CE39}
\tikzset{
	orcidlogo/.pic={
		\fill[orcidlogocol] svg{M256,128c0,70.7-57.3,128-128,128C57.3,256,0,198.7,0,128C0,57.3,57.3,0,128,0C198.7,0,256,57.3,256,128z};
		\fill[white] svg{M86.3,186.2H70.9V79.1h15.4v48.4V186.2z}
		svg{M108.9,79.1h41.6c39.6,0,57,28.3,57,53.6c0,27.5-21.5,53.6-56.8,53.6h-41.8V79.1z M124.3,172.4h24.5c34.9,0,42.9-26.5,42.9-39.7c0-21.5-13.7-39.7-43.7-39.7h-23.7V172.4z}
		svg{M88.7,56.8c0,5.5-4.5,10.1-10.1,10.1c-5.6,0-10.1-4.6-10.1-10.1c0-5.6,4.5-10.1,10.1-10.1C84.2,46.7,88.7,51.3,88.7,56.8z};
	}
}
%% Reciprocal of the height of the svg whose source is above.  The
%% original generates a 256pt high graphic; this macro holds 1/256.
\newcommand{\@OrigHeightRecip}{0.00390625}
%% We will compute the current X height to make the logo the right height
\newlength{\@curXheight}

\DeclareRobustCommand\orcidlink[1]{%
	\texorpdfstring{%
		\setlength{\@curXheight}{\fontcharht\font`X}%
		\href{https://orcid.org/#1}{\XeTeXLinkBox{\mbox{%
					\begin{tikzpicture}[yscale=-\@OrigHeightRecip*\@curXheight,
						xscale=\@OrigHeightRecip*\@curXheight,transform shape]
						\pic{orcidlogo};
					\end{tikzpicture}%
	}}}}{}}

\newcommand{\orcid}[1]{\orcidlink{#1}}

% Credit
\DTLgnewdb{credits}
\newcommand*{\credit}[2]{%
	\DTLnewrow{credits}%
	\DTLnewdbentry{credits}{credrole}{#1}%
	\DTLnewdbentry{credits}{credauthor}{#2}%
}

\if@anonymous
\renewcommand{\@author}{}
\fi

% Redefine thanks symbol for compatibility with fonts
\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or
		\mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger
		\or \ddagger\ddagger \else\@ctrerr\fi}}
%-------------------------------------------------------------------------------
%                Configuration for heading
%-------------------------------------------------------------------------------

% For credit
\newcommand{\printcreditifnotempty}{%
	\ifdim\DTLrowcount{credits}pt=0pt
	\else
	\vskip .5em
	\footnotesize\raggedright\textcolor{black}{Author contributions:} \DTLforeach*{credits}{\Credrole=credrole,
        \Credauthor=credauthor}{\textcolor{black}{ \textit{ \Credrole\/:} \Credauthor.} }
	\fi
}

\pretitle{%
	\begin{flushleft}
		\fontsize{21pt}{1em}\bfseries
}
\posttitle{%
	\end{flushleft}%
	\vskip .2cm
}
\preauthor{%
	\lineskip 0.2cm%
	\begin{flushleft}
	}
	
	\if@anonymous
	\postauthor{%
	\end{flushleft}%
	\vskip -.5em
	\par
}
\else
    \postauthor{%
    \end{flushleft}%
    \vskip -.5em
    \printcreditifnotempty
    \par
}
\fi
\predate{}
\postdate{}
\date{}

\newcommand{\banner}{jSEDI-banner}

\def\doi#1{\def\@doi{#1}}
\doi{}


\renewcommand\maketitlehooka{%
\vspace{-1.5cm}
\href{https://jsedi-preprod.episciences.org/}{\includegraphics[width=\textwidth]{\banner}}
\vspace{-.05cm}
\hrule depth 1pt width \textwidth\relax

\if@forreview
{\vspace*{-1.6cm} \hspace{0.1cm} 
	\href{https://jsedi-preprod.episciences.org/}{\color{black} \small \today{} -- Non-peer reviewed {\bfseries\manustype} submitted to} }
\else
{\vspace*{-1.3cm} \hspace{0.1cm} 
	\href{https://jsedi-preprod.episciences.org/}{\color{black} \small \today{} -- Non-peer reviewed {\bfseries\manustype} submitted to} }
\fi
\vspace*{1.7cm}
}

\renewcommand\maketitlehookd{%
\pagestyle{fancy}
\thispagestyle{plain}
}

%-------------------------------------------------------------------------------
%                Configuration for abstract
%-------------------------------------------------------------------------------

\newcommand*{\abstracttitlestyle}[1]{{\large \bfseries #1}}

\let\oldthanks\thanks
\renewcommand{\thanks}[1]{\oldthanks{\small   #1}}

\newenvironment{summary}[1]
{
\par
\noindent \abstracttitlestyle{#1} \hspace{0.0cm}
}{
\vspace{0.3cm}}%

\newenvironment{abswidth}{\begin{adjustwidth}{}{0.18\paperwidth}}{\end{adjustwidth}}

%% abstract.sty specs, needed for saythanks
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}
\renewcommand{\abstractname}{}   
\renewcommand{\absnamepos}{empty} 
\renewcommand{\abstractname}{}  % necessary to remove abstract title... don't know why

\if@onecolumn
\newcommand*{\makesedititle}[1]{%
\maketitle
\begin{abswidth}
	#1
\end{abswidth}
\vspace{0.7cm}
%\saythanks
}
\newcommand*{\addsummaries}[1]{%
\begin{abswidth}
	#1
\end{abswidth}
\vspace{0.7cm}
}
\else
\newcommand*{\makesedititle}[1]{%
\twocolumn[
\maketitle
\begin{abswidth}
	\begin{onecolabstract}
		%		\zsavepos{loc:beg_abstract}		
		#1
	\end{onecolabstract}
\end{abswidth}
\vspace*{0.7cm}
]
\saythanks
}
\newcommand*{\addsummaries}[1]{%
\twocolumn[
\begin{abswidth}
	#1
\end{abswidth}
]
\vspace{0.7cm}
}
\fi

%-------------------------------------------------------------------------------
%                Configuration for sections
%-------------------------------------------------------------------------------

\titleformat{\section}{\fontsize{14pt}{1em}\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}{\fontsize{12pt}{0.3em}\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\fontsize{11pt}{0.1em}\bfseries}{\thesubsubsection}{1em}{}

\setcounter{secnumdepth}{3}

\newenvironment{acknowledgements}
{\section*{Acknowledgements}
}%
{}

\if@anonymous
\excludecomment{acknowledgements}
\fi

%-------------------------------------------------------------------------------
%                Configuration for header and footer
%-------------------------------------------------------------------------------
%% Article type
\def\lettertype#1{\def\@lettertype{#1}}
%\lettertype{}

\newcommand{\letterreplace}[2]{%
	\ifdefined #1
	#1
	\else
	#2
	\fi
}

\newcommand{\articletype}{\color{jsediGreen}Letter}
\if@letter
\newcommand{\manustype}{\letterreplace{\@lettertype}{Express letter}}
\else
\if@comment
\newcommand{\manustype}{\letterreplace{\@lettertype}{Comment}}
\else
\if@reply
\newcommand{\manustype}{\letterreplace{\@lettertype}{Reply}}
\else
\if@review
\newcommand{\manustype}{\letterreplace{\@lettertype}{Review paper}}
\else
\newcommand{\manustype}{\letterreplace{\@lettertype}{Regular Article}}
\fi
\fi
\fi
\fi

\def\shorttitle@internal{}
\newcommand{\shorttitle}[1]{\gdef\shorttitle@internal{#1}}
\newcommand{\insertshorttitle}{\shorttitle@internal}

\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\fancyfoot[L]{\bfseries\footnotesize \thepage}
\fancyhead[L]{\footnotesize This is a non-peer reviewed {\bfseries\manustype} submitted to {\scshape \bfseries\href{https://jsedi-preprod.episciences.org/}{\color{jsediDarkBlue}jSEDI}} }
\fancyhead[R]{\footnotesize \color{jsediDarkBlue}\insertshorttitle}
\renewcommand{\headrule}{}

\fancypagestyle{plain}{%
\fancyhead{}
\renewcommand{\headrule}{}
}

%
%%-------------------------------------------------------------------------------
%%                Configuration for captions
%%-------------------------------------------------------------------------------

%\captionsetup{font=sf, 
\captionsetup{%
%font=sf, 
textfont=small,
labelfont=bf, 
labelsep=colon, 
justification=justified, 
singlelinecheck=false, oneside}


% equations
\if@breakmath
\else
\renewcommand{\eqref}[1]{\textup{\eqreftagform@{\ref{#1}}}}
\let\eqreftagform@\tagform@
\def\tagform@#1{%
\maketag@@@{(\ignorespaces#1\unskip\@@italiccorr)}%
}
\fi


%%-------------------------------------------------------------------------------
%%                Configuration for references
%%-------------------------------------------------------------------------------

\renewbibmacro{in:}{}
\DeclareFieldFormat[article]{pages}{#1}
\DeclareFieldFormat*{title}{#1}

%%-------------------------------------------------------------------------------
%%                Configuration for code
%%-------------------------------------------------------------------------------

% in-line code words
\def\code#1{\fontsize{9}{10}\colorbox{codebackcolor}{\texttt{#1}}}
\setlength{\fboxsep}{1pt}

\lstset{
tabsize=4,
captionpos=t,
breaklines=true,
showstringspaces=false,
basicstyle=\fontsize{9}{10}\ttfamily,
keywordstyle=\color{jsediGreen},
commentstyle=\color{gray},
stringstyle=\color{jsediDarkBlue},
emphstyle=\color{jsediDarkPink},
%	frameshape={RYR}{Y}{Y}{RYR},
backgroundcolor=\color{codebackcolor},   
rulecolor=\color{codebackcolor}
}


%%-------------------------------------------------------------------------------
%%                Configuration for math line numbers
%%-------------------------------------------------------------------------------
%% from  https://tex.stackexchange.com/questions/461186/how-to-use-lineno-with-amsmath-align

\if@forreview
%% Patch 'normal' math environments:
\newcommand*\linenomathpatch[1]{%
\cspreto{#1}{\linenomath}%
\cspreto{#1*}{\linenomath}%
\csappto{end#1}{\endlinenomath}%
\csappto{end#1*}{\endlinenomath}%
}
%% Patch AMS math environments:
\newcommand*\linenomathpatchAMS[1]{%
\cspreto{#1}{\linenomathAMS}%
\cspreto{#1*}{\linenomathAMS}%
\csappto{end#1}{\endlinenomath}%
\csappto{end#1*}{\endlinenomath}%
}

%% Definition of \linenomathAMS depends on whether the mathlines option is provided
\expandafter\ifx\linenomath\linenomathWithnumbers
\let\linenomathAMS\linenomathWithnumbers
%% The following line gets rid of an extra line numbers at the bottom:
\patchcmd\linenomathAMS{\advance\postdisplaypenalty\linenopenalty}{}{}{}
\else
\let\linenomathAMS\linenomathNonumbers
\fi

\linenomathpatch{equation}
\linenomathpatchAMS{gather}
\linenomathpatchAMS{multline}
\linenomathpatchAMS{align}
\linenomathpatchAMS{alignat}
\linenomathpatchAMS{flalign}
\fi

% Article info
\def\receiveddate#1{\def\@receiveddate{#1}}
\def\accepteddate#1{\def\@accepteddate{#1}}
\def\publisheddate#1{\def\@publisheddate{#1}}
\def\thevolume#1{\def\@thevolume{#1}}
\def\thenumber#1{\def\@thenumber{#1}}
\thenumber{}
\def\theyear#1{\def\@theyear{#1}}


%% style for landscape page header/footer
\fancypagestyle{lscapedplain}{%
%\newcommand{\insertshorttitle}{\shorttitle@internal}
\renewcommand{\sflight}{}
  \fancyhf{}
  \fancyfoot{%
    \begin{tikzpicture}[remember picture,overlay]
%      \node[text width=5cm,align=flush right,rotate=90] at ([xshift=-1cm,yshift=11cm]current page.east) {\sflight \footnotesize {\scshape \bfseries \color{jsediMediumBlue} jSEDI}~|~volume \@thevolume.\@thenumber~|~\@theyear};
      \node[text width=5cm,align=flush right,rotate=90] at ([xshift=-1cm,yshift=11cm]current page.east) {\sflight \footnotesize {\scshape \bfseries \color{jsediMediumBlue} jSEDI}};
      \node[text width=3cm,align=flush left,rotate=90] at ([xshift=-1cm,yshift=-11.8cm]current page.east) {\sff\bfseries\footnotesize \thepage};
    \end{tikzpicture}}
  \fancyhead{%
    \begin{tikzpicture}[remember picture,overlay]
      \node[text width=20cm, align=flush left,rotate=90] at ([xshift=1cm,yshift=-3.35cm]current page.west) {\sflight \footnotesize {\scshape \bfseries \color{jsediMediumBlue} jSEDI} | {\scshape \bfseries \articletype} | \insertshorttitle};
    \end{tikzpicture}}
}

\fancypagestyle{plainReset}{%
    \fancyhf{}
    \fancyfoot{}
    \fancyfoot[L]{\sff\bfseries\footnotesize \thepage}
%    \fancyfoot[R]{\sflight \footnotesize {\scshape \bfseries \color{jsediMediumBlue} jSEDI}~|~volume \@thevolume.\@thenumber~|~\@theyear}
    \fancyfoot[R]{\sflight \footnotesize {\scshape \bfseries \color{jsediMediumBlue} jSEDI}}
    \fancyhead[L]{\sflight \footnotesize {\scshape \bfseries \color{jsediMediumBlue} jSEDI} | {\scshape \bfseries \articletype} | \insertshorttitle}
    %\fancyhead[R]{\footnotesize \@author[1]}
    \renewcommand{\headrule}{}
}

\usepackage{bm}
\providecommand\bnabla{\boldsymbol{\nabla}}
\providecommand\bcdot{\boldsymbol{\cdot}}

% Overwrite vector and tensor definitions
\def\vec#1{\ensuremath{\mathbf{#1}}}
\def\tens#1{\ensuremath{\mathsf{#1}}}

\RequirePackage{cleveref}
\crefname{table}{tab.}{tabs} 
\Crefname{table}{Tab.}{Tabs} 
\crefname{figure}{fig.}{figs} 
\Crefname{figure}{Fig.}{Figs} 
\crefname{equation}{eq.}{eqs} 
\Crefname{equation}{Eq.}{Eqs} 



\newcommand{\publicationonly}[1]{}

\usepackage{verbatim}
\newenvironment{methods}{\comment}{\endcomment}

\if@letter
\renewenvironment{methods}
{\appendix
\section{Methods}
}
{}
\fi


% end of .cls 
