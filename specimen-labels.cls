\NeedsTeXFormat{LaTeX2e}[1995/12/01] 
\ProvidesClass{specimen-labels}[2017/11/1 v1 Natural History Collections specialist document class]

% Load article class as a foundaiton
\LoadClass[12pt,letter,twocolumn]{article}

% Various package requirements to produce fancy labels
\RequirePackage{geometry,graphicx,datatool,fontenc,inputenc,times}

% Lat-Long: DMS to DD
% #1- negative suffix, #2 - positive suffix, #3 - lat/lon
\newcommand{\latlontodeg}[3]{\DTLifnumlt{#3}{0}{#1}{#2}~%
	\DTLabs{\TMPlatlon}{#3}%
	\DTLtrunc{\TMPdeg}{\TMPlatlon}{0}%
	\DTLsub{\TMPlatlon}{\TMPlatlon}{\TMPdeg}%
	\DTLmul{\TMPlatlon}{\TMPlatlon}{60}%
	\DTLtrunc{\TMPmin}{\TMPlatlon}{0}%  
	\DTLsub{\TMPlatlon}{\TMPlatlon}{\TMPmin}%
	\DTLmul{\TMPlatlon}{\TMPlatlon}{60}%
	\DTLtrunc{\TMPsec}{\TMPlatlon}{0}%  
	$\TMPdeg^\circ\TMPmin'\TMPsec''$}
