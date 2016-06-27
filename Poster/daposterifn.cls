%###############################################################################
%
% Description: This file is a class file for a diploma thesis poster.
%
% Anne Wolf <anne.wolf@tu-dresden.de>
%
%###############################################################################

\ProvidesClass{daposterifn}[2011/11/07 v0.6 daposterifn class (Anne Wolf)]

\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}

%###############################################################################
% REQUIRED PACKAGES
%###############################################################################
\RequirePackage[latin1]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english,ngerman]{babel}

\RequirePackage{geometry}
\RequirePackage{colortbl}
\RequirePackage{calc}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{paralist}
\RequirePackage{wrapfig}
\RequirePackage{blindtext}
\RequirePackage{multicol}
\RequirePackage{twoopt}
\RequirePackage{caption}
\RequirePackage{amsmath}
\RequirePackage{lmodern}


%###############################################################################
% CLASS OPTIONS
%###############################################################################
%-------------------------------------------------------------------------------
%- options for chairs ----------------------------------------------------------
%-------------------------------------------------------------------------------
\newcommand{\daposterContentChair}{}
\newcommand{\includeChairLogo}{}
%* chair TNT *******************************************************************
\DeclareOption{tnt}{
	\renewcommand{\daposterContentChair}{Lehrstuhl Theoretische Nachrichtentechnik}
	\renewcommand{\includeChairLogo}{%
		\includegraphics[height=\daposterLayoutScaleLogoFoot\daposterLayoutHoeheFussbalken]
		{./figures/logos/Logo-TNT_weiss-transp_dt}}
}
%* chair HF ********************************************************************
\DeclareOption{hf}{
	\renewcommand{\daposterContentChair}{Lehrstuhl Hochfrequenztechnik}
  %* no logo specified
%	\renewcommand{\includeChairLogo}{%
%		\includegraphics[height=\daposterLayoutScaleLogoFoot\daposterLayoutHoeheFussbalken]
%		{./figures/logos/Logo-HF}}
}
%* chair TK ********************************************************************
\DeclareOption{tk}{
	\renewcommand{\daposterContentChair}{Lehrstuhl Telekommunikation}
	\renewcommand{\includeChairLogo}{%
		\includegraphics[height=\daposterLayoutScaleLogoFoot\daposterLayoutHoeheFussbalken]
		{./figures/logos/Logo-TK}}
}
%* chair MNS *******************************************************************
\DeclareOption{mns}{
	\renewcommand{\daposterContentChair}{Lehrstuhl Mobile Nachrichtensysteme}
  %* no logo specified
%	\renewcommand{\includeChairLogo}{%
%		\includegraphics[height=\daposterLayoutScaleLogoFoot\daposterLayoutHoeheFussbalken]
%		{./figures/logos/Logo-MNS}}
}
%-------------------------------------------------------------------------------
%- options for thesis ----------------------------------------------------------
%-------------------------------------------------------------------------------
\newcommand{\daposterContentThesisType}{Diplomarbeit}
%* diploma thesis **************************************************************
\DeclareOption{diplom}{
	\renewcommand{\daposterContentThesisType}{Diplomarbeit}
}
%* master thesis ***************************************************************
\DeclareOption{master}{
	\renewcommand{\daposterContentThesisType}{Masterarbeit}
}
%* external thesis *************************************************************
\newif\ifextern
\externfalse
\DeclareOption{extern}{
	\externtrue
}
%-------------------------------------------------------------------------------
\ProcessOptions


%###############################################################################
% DEFINES
%###############################################################################
%* colors for the (dark and medium) blue areas according to corporate design ***
\definecolor{tuddunkel}{cmyk}{1.0, 0.7, 0.1, 0.5}
\definecolor{tudmittel}{cmyk}{0.5, 0.35, 0.05, 0.25}


%###############################################################################
% POSTER CONFIGURATION (INPUT OF LAYOUT PARAMETERS)
%###############################################################################
%* height of (dark and medium) blue areas in the headline and footline *********
\newlength{\daposterLayoutHoeheKopfbalkenDunkel}
\setlength{\daposterLayoutHoeheKopfbalkenDunkel}{7cm}
\newlength{\daposterLayoutHoeheKopfbalkenHell}
\setlength{\daposterLayoutHoeheKopfbalkenHell}{1.5cm}
\newlength{\daposterLayoutHoeheFussbalken}
\setlength{\daposterLayoutHoeheFussbalken}{3.5cm}
%* width of the left (and right) margins ***************************************
\newlength{\daposterLayoutRandLinks}
\setlength{\daposterLayoutRandLinks}{3.5cm}
\newlength{\daposterLayoutRandRechts}
\setlength{\daposterLayoutRandRechts}{\daposterLayoutRandLinks}
%* width of the top and bottom (inner!) margins ********************************
\newlength{\daposterLayoutRandInnenOben}
\setlength{\daposterLayoutRandInnenOben}{1.5cm}
\newlength{\daposterLayoutRandInnenUnten}
\setlength{\daposterLayoutRandInnenUnten}{2cm}
%* scaling factors for height of logos in head line and footline ***************
\newcommand{\daposterLayoutScaleLogoHead}{0.55}
\newcommand{\daposterLayoutScaleLogoFoot}{0.65}
%* height of poster area for thesis and personal details ***********************
\newlength{\daposterLayoutHoeheDetails}
\setlength{\daposterLayoutHoeheDetails}{10cm}
%* width of space between columns in text area *********************************
\newlength{\daposterLayoutSpaltenabstand}
\setlength{\daposterLayoutSpaltenabstand}{1.25cm}
%* skip between poster area for thesis and personal details and text area ******
\newlength{\daposterLayoutRandDetailsUnten}
\setlength{\daposterLayoutRandDetailsUnten}{0.5cm} %früher 1cm
%* height of rule separating both poster areas *********************************
\newlength{\daposterLayoutRuleHeightDetailsUnten}
\setlength{\daposterLayoutRuleHeightDetailsUnten}{0.5mm}
%* width and inner margin of the student's foto for personal details ***********
\newlength{\daposterLayoutPassbildBreite}
\setlength{\daposterLayoutPassbildBreite}{4cm}
\newlength{\daposterLayoutPassbildRandInnen}
\setlength{\daposterLayoutPassbildRandInnen}{1cm}
%* font size and parskip of the student's biography for personal details *******
\newcommand{\daposterLayoutFontSizeWerdegang}{\small}
\newlength{\daposterLayoutParSkipWerdegang}
\setlength{\daposterLayoutParSkipWerdegang}{2ex}
%* skip above and below poster title (DA-Thema) ********************************
\newlength{\daposterLayoutSkipObenTitle}
\setlength{\daposterLayoutSkipObenTitle}{1cm}
\newlength{\daposterLayoutSkipUntenTitle}
\setlength{\daposterLayoutSkipUntenTitle}{1cm}
%* font size for various parts of the poster ***********************************
\newcommand{\daposterLayoutFontSizeHeadline}{\normalsize}
\newcommand{\daposterLayoutFontSizeDAThema}{\LARGE}
\newcommand{\daposterLayoutFontSizeDAStudent}{\large}
\newcommand{\daposterLayoutFontSizeDADetails}{\large}


%###############################################################################
% MAIN LAYOUT SETTINGS
%###############################################################################
%-------------------------------------------------------------------------------
%- paper size and text area ----------------------------------------------------
%-------------------------------------------------------------------------------
%* set paper size and margins **************************************************
\geometry{a1paper, left=\daposterLayoutRandLinks, right=\daposterLayoutRandRechts, top=0cm, bottom=0cm}
%* calculation of text height and width ****************************************
\setlength{\textheight}{\paperheight-\daposterLayoutHoeheKopfbalkenDunkel-\daposterLayoutHoeheKopfbalkenHell-\daposterLayoutHoeheFussbalken-\daposterLayoutRandInnenOben-\daposterLayoutRandInnenUnten}
\setlength{\textwidth}{\paperwidth-\daposterLayoutRandLinks-\daposterLayoutRandRechts}
%-------------------------------------------------------------------------------
%- width of poster area for thesis and personal details ------------------------
%-------------------------------------------------------------------------------
\newlength{\daposterLayoutBreiteDetailsArbeit}
\setlength{\daposterLayoutBreiteDetailsArbeit}{0.667\textwidth-0.333\daposterLayoutSpaltenabstand}
\newlength{\daposterLayoutBreiteDetailsStudent}
\setlength{\daposterLayoutBreiteDetailsStudent}{0.333\textwidth-0.667\daposterLayoutSpaltenabstand}
%-------------------------------------------------------------------------------
%- width and height specifications for headline and footline -------------------
%-------------------------------------------------------------------------------
%* set page style with headline and footline ***********************************
\pagestyle{fancy}
\setlength{\headwidth}{\paperwidth}
\setlength{\headheight}{\daposterLayoutHoeheKopfbalkenDunkel+\daposterLayoutHoeheKopfbalkenHell+1.3cm}
\setlength{\footskip}{\daposterLayoutHoeheFussbalken+\daposterLayoutRandInnenUnten}
\setlength{\headsep}{\daposterLayoutRandInnenOben}


%###############################################################################
% POSTER LAYOUT FOR HEADLINE AND FOOTLINE
%###############################################################################
%* deletes all predefined entries for headline and footline ********************
\fancyhf{}
%* sets width for headline rule (no rule!) *************************************
\renewcommand{\headrulewidth}{0pt}
%-------------------------------------------------------------------------------
%- definition of headline ------------------------------------------------------
%-------------------------------------------------------------------------------
\lhead{%
\setlength{\tabcolsep}{0pt}\renewcommand{\arraystretch}{0}%
\hspace{-\daposterLayoutRandLinks}%
\begin{tabularx}{\paperwidth}{X}
	\rowcolor{tuddunkel}
	\begin{minipage}[b][\daposterLayoutHoeheKopfbalkenDunkel][c]{\paperwidth}
		\hspace{\daposterLayoutRandLinks}%
		\includegraphics[height=\daposterLayoutScaleLogoHead\daposterLayoutHoeheKopfbalkenDunkel]{./figures/logos/Logo-TU_weiss}
	\end{minipage} \\
	\rowcolor{tudmittel}
	\begin{minipage}[b][\daposterLayoutHoeheKopfbalkenHell][c]{\paperwidth}
	  \sffamily\bfseries\daposterLayoutFontSizeHeadline
		\hspace{\daposterLayoutRandLinks}%
		\textcolor{white}{%
		Fakultät Elektrotechnik und Informationstechnik,
		Institut für Nachrichtentechnik,
		\daposterContentChair}%
		\hspace{\daposterLayoutRandRechts}
	\end{minipage}%
\end{tabularx}}
%-------------------------------------------------------------------------------
%- definition of footline ------------------------------------------------------
%-------------------------------------------------------------------------------
\lfoot{%
\setlength{\fboxsep}{0pt}%
\hspace{-\daposterLayoutRandLinks}%
\colorbox{tuddunkel}{%
\begin{minipage}[b][\daposterLayoutHoeheFussbalken][c]{\paperwidth}
	\hspace{\daposterLayoutRandLinks}%
	\includegraphics[height=\daposterLayoutScaleLogoFoot\daposterLayoutHoeheFussbalken]{./figures/logos/Logo-ET_weiss}%
	\hfill
	\includeChairLogo%
	\hspace{\daposterLayoutRandRechts}
\end{minipage}
}}


%###############################################################################
% MULTICOL SETTINGS (FOR TEXT AREA)
%###############################################################################
\setlength{\premulticols}{0cm}
\setlength{\postmulticols}{0cm}
\setlength{\multicolsep}{0cm}
\setlength{\columnsep}{\daposterLayoutSpaltenabstand}
\setlength{\columnseprule}{0cm}


%###############################################################################
% SETTINGS FOR TEXT LAYOUT (HEADINGS, ITEMIZE ENVIRONMENTS, CAPTIONS, ...)
%###############################################################################
%-------------------------------------------------------------------------------
%- set layout of headings (font and skip) --------------------------------------
%- nach: http://help-csli.stanford.edu/tex/latex-sections.shtml ----------------
%-------------------------------------------------------------------------------
\def\section{\@startsection{section}{1}{\z@}
		{-2ex plus -0.5ex minus -.2ex}{1ex plus .2ex}{\sffamily\bfseries\Large}}
\def\subsection{\@startsection{subsection}{2}{\z@}
		{-1.75ex plus -0.5ex minus -.2ex}{0.5ex plus .2ex}{\sffamily\bfseries\large}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
		{-1.0ex plus -0.5ex minus -.2ex}{0.25ex plus .2ex}{\sffamily\bfseries\normalsize}}
\def\paragraph{\@startsection{paragraph}{4}{\z@}
		{3.25ex plus 1ex minus .2ex}{-1em}{\sffamily\bfseries\normalsize}}
\def\subparagraph{\@startsection{subparagraph}{4}{\parindent}
		{3.25ex plus 1ex minus .2ex}{-1em}{\sffamily\bfseries\normalsize}}
%-------------------------------------------------------------------------------
%- set indent and skip for paragraphs ------------------------------------------
%-------------------------------------------------------------------------------
\setlength{\parindent}{0em} %Einzug gefährlich für Minipage-Umgebungen!
\setlength{\parskip}{0ex}
%-------------------------------------------------------------------------------
%- set symbols and margins for itemize environment -----------------------------
%-------------------------------------------------------------------------------
\setdefaultitem{\normalfont\textbullet}%
{\normalfont\bfseries \textendash}%
{\textasteriskcentered}{\textperiodcentered}
\setlength{\labelsep}{1em}
\setdefaultleftmargin{3.5em}{2.2em}{1.87em}{1.7em}{1em}{1em}
%-------------------------------------------------------------------------------
%- set layout for captions -----------------------------------------------------
%-------------------------------------------------------------------------------
\renewcommand{\captionfont}{\sffamily\small}
\renewcommand{\captionlabelfont}{\sffamily\small}
%-------------------------------------------------------------------------------
%- set layout for description environment --------------------------------------
%-------------------------------------------------------------------------------
\renewcommand{\descriptionlabel}[1]{\hspace\labelsep\sffamily\bfseries #1}


%###############################################################################
% DEFINITION OF FONTSIZES
%###############################################################################
\renewcommand{\tiny}{\fontsize{10}{12}\selectfont}
\renewcommand{\scriptsize}{\fontsize{12}{14}\selectfont}
\renewcommand{\footnotesize}{\fontsize{14.4}{18}\selectfont}   
\renewcommand{\small}{\fontsize{17.28}{22}\selectfont}
\renewcommand{\normalsize}{\fontsize{20.74}{25}\selectfont}
\renewcommand{\large}{\fontsize{24.88}{30}\selectfont}
\renewcommand{\Large}{\fontsize{29.86}{37}\selectfont}
\renewcommand{\LARGE}{\fontsize{35.83}{45}\selectfont}
\renewcommand{\huge}{\fontsize{43}{54}\selectfont}
\renewcommand{\Huge}{\fontsize{51.6}{64}\selectfont}


%###############################################################################
% NEW COLUMN TYPES
%###############################################################################
%* define left / centered / right columns for tabularx environment *************
\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}


%###############################################################################
% SETTINGS AND COMMANDS FOR POSTER CONTENT (THESIS AND STUDENT DETAILS)
%###############################################################################
%-------------------------------------------------------------------------------
%- definition / initialization of content parameters ---------------------------
%-------------------------------------------------------------------------------
%* sets initialization values for thesis details and biography *****************
\newcommand{\daposterContentDAThema}{Thema der Diplomarbeit}
\newcommand{\daposterContentDAStudent}{Name des Studenten}
\newcommand{\daposterContentDABetreuerTUD}{Name des TUD-Betreuers}
\newcommand{\daposterContentDABetreuerExternName}{Name des externen Betreuers}
\newcommand{\daposterContentDABetreuerExternFirma}{Firma}
\newcommand{\daposterContentDAHochschullehrer}{Name des Hochschullehrers}
\newcommand{\daposterContentDAVerteidigungDatum}{Datum der Verteidigung}
\newcommand{\daposterContentStudentPassbildPfad}{./figures/passbild}
\newcommand{\daposterContentStudentWerdegang}{%
	mm/jjjj - mm/jjjj\newline
	erklärender Text zu diesem Zeitraum
	
	mm/jjjj - mm/jjjj\newline
	Text zu einem anderen Zeitraum
	
	mm/jjjj - mm/jjjj\newline
	eine riesige Menge Text, damit man auch mal sieht, dass das Passbild wirklich vom Text umflossen wird
}
%-------------------------------------------------------------------------------
%- process student and thesis parameters ---------------------------------------
%-------------------------------------------------------------------------------
\newcommand{\setDAParameter}[3][]{%
  %* set thesis title (optional: font size) ************************************
	\ifthenelse{\equal{#2}{Thema}}{%
		\renewcommand*{\daposterContentDAThema}{#3}%
		\ifthenelse{\equal{#1}{\empty}}{}{%
			\ifthenelse{\isundefined{#1}}{}{%
				\ifthenelse{%
					\equal{#1}{\LARGE} \or
					\equal{#1}{\Large} \or
					\equal{#1}{\large}}{%
					\renewcommand{\daposterLayoutFontSizeDAThema}{#1}%
				}{}%
			}%
		}%
	}{}%
  %* set name of student *******************************************************
	\ifthenelse{\equal{#2}{Student}}{\renewcommand*{\daposterContentDAStudent}{#3}}{}%
  %* set name of TUD supervisor ************************************************
	\ifthenelse{\equal{#2}{BetreuerTUD}}{\renewcommand*{\daposterContentDABetreuerTUD}{#3}}{}%
  %* set name of external supervisor *******************************************
	\ifthenelse{\equal{#2}{BetreuerExternName}}{\renewcommand*{\daposterContentDABetreuerExternName}{#3}}{}%
  %* set company of external supervisor ****************************************
	\ifthenelse{\equal{#2}{BetreuerExternFirma}}{\renewcommand*{\daposterContentDABetreuerExternFirma}{#3}}{}%
  %* set name of professor *****************************************************
	\ifthenelse{\equal{#2}{Hochschullehrer}}{\renewcommand*{\daposterContentDAHochschullehrer}{#3}}{}%
  %* set date of thesis defense ************************************************
	\ifthenelse{\equal{#2}{VerteidigungDatum}}{\renewcommand*{\daposterContentDAVerteidigungDatum}{#3}}{}%
}
%-------------------------------------------------------------------------------
%- set path of student's photo (optional: picture width) -----------------------
%-------------------------------------------------------------------------------
\newcommand{\setStudentPassbild}[2][\daposterLayoutPassbildBreite]{%
	\ifthenelse{\equal{#1}{\empty}}{}{\setlength{\daposterLayoutPassbildBreite}{#1}}%
	\renewcommand{\daposterContentStudentPassbildPfad}{#2}%
}
%-------------------------------------------------------------------------------
%- set text for student's biography (optional: font size and paragraph skip) ---
%-------------------------------------------------------------------------------
\newcommandtwoopt{\setStudentWerdegang}[3][][]{%
	\ifthenelse{\equal{#1}{\empty}}{}{%
		\ifthenelse{\isundefined{#1}}{}{%
			\ifthenelse{%
				\equal{#1}{\normalsize} \or
				\equal{#1}{\small} \or
				\equal{#1}{\footnotesize} \or
				\equal{#1}{\scriptsize}}{%
				\renewcommand{\daposterLayoutFontSizeWerdegang}{#1}%
			}{}%
		}%
	}%
	\ifthenelse{\equal{#2}{\empty}}{}{%
		\ifthenelse{\isundefined{#2}}{}{%
				\renewcommand{\daposterLayoutParSkipWerdegang}{#2}%
		}%
	}%
	\renewcommand{\daposterContentStudentWerdegang}{#3}%
}
%-------------------------------------------------------------------------------
%- define layout of poster area for thesis and student details -----------------
%-------------------------------------------------------------------------------
\newcommand{\includeDADetails}{%
\setlength{\fboxsep}{0pt}%
%\fbox{%
\begin{minipage}[b][\daposterLayoutHoeheDetails][b]{\daposterLayoutBreiteDetailsArbeit}
	\centering\daposterLayoutFontSizeDADetails
	\daposterContentThesisType\ zum Thema
	
	\vspace{\daposterLayoutSkipObenTitle}
	
	{\bfseries\daposterLayoutFontSizeDAThema%
	\daposterContentDAThema}
	
	\vspace{\daposterLayoutSkipUntenTitle}
	
	{\bfseries\daposterLayoutFontSizeDAStudent%
	\daposterContentDAStudent}
	
	\vfill
		
%	\fbox{%
	\begin{minipage}[t][\baselineskip]{\daposterLayoutBreiteDetailsStudent}
		\centering
		Betreuer:
	\end{minipage}%}%
	\hfill
%	\fbox{%
	\begin{minipage}[t][\baselineskip]{\daposterLayoutBreiteDetailsStudent}
		\centering
		Hochschullehrer:
	\end{minipage}%}
	
%	\fbox{%
	\begin{minipage}[b]{\daposterLayoutBreiteDetailsStudent}
		\centering
		\daposterContentDABetreuerTUD
		\ifextern%
			\newline\daposterContentDABetreuerExternName\ (\daposterContentDABetreuerExternFirma)
		\fi
	\end{minipage}%}%
	\hfill
%	\fbox{%
	\begin{minipage}[b]{\daposterLayoutBreiteDetailsStudent}
		\centering
		\daposterContentDAHochschullehrer
	\end{minipage}%}
\end{minipage}%}%
\hfill
%\fbox{%
\begin{minipage}[b][\daposterLayoutHoeheDetails][b]{\daposterLayoutBreiteDetailsStudent}
	{\centering\daposterLayoutFontSizeDADetails
	Werdegang
	
	\vfill}
	
	\daposterLayoutFontSizeWerdegang
%\fbox{%
	\begin{minipage}[b]{\linewidth}
	%-------------------------------------------------
		\setlength{\intextsep}{0pt} %oben
		\setlength{\columnsep}{\daposterLayoutPassbildRandInnen} %links
		\begin{wrapfigure}{r}{\daposterLayoutPassbildBreite}
			\includegraphics[width=\linewidth]{\daposterContentStudentPassbildPfad}
		\end{wrapfigure}
	%-------------------------------------------------
		\setlength{\parskip}{\daposterLayoutParSkipWerdegang}
		
		\daposterContentStudentWerdegang
		
		\daposterContentDAVerteidigungDatum\newline
		Verteidigung der \daposterContentThesisType
	\end{minipage}%}%
\end{minipage}%}%
\\% 
\rule{\linewidth}{\daposterLayoutRuleHeightDetailsUnten}%
\vspace{\daposterLayoutRandDetailsUnten}
}


%###############################################################################
% START!
%###############################################################################
\normalsize

\AtBeginDocument{
\special{papersize=\the\paperwidth,\the\paperheight}
\sffamily
}
