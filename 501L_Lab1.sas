**************
*  BIOS 501  *
*  Lab 1     *
**************;

** Set up permanent library to tell SAS where to locate the data set **;
LIBNAME bios501 'S:\course\BIOS501\WEISS 2013\data sets';

** What's in the data set? **;
PROC CONTENTS DATA=bios501.wdocs POSITION;
RUN;

** Location of formats catalog  **;
LIBNAME formats ' S:\course\BIOS501\WEISS 2013\format library';
OPTIONS FMTSEARCH=(formats); *Ignore... not a big deal;

** What do the formats mean? **;
PROC FORMAT LIBRARY = formats FMTLIB;*allows you to change the format of variables;
RUN;
***************************************************************
?	For categorical variables, use PROC FREQ.
	- Are there any typos?
	- Do all values abide by coding schemes?
	- Are there any duplicate values that indicate the same category? (e.g., Male and male)
	- Are there any missing values?
** Remember that not all categorical variables will show up as character in the                           PROC CONTENTS output – you will often have categorical data that are coded numerically. **
       
?	For continuous variables, use PROCs UNIVARIATE, MEANS, SGPLOT, etc.
	- What are the key summary statistics (mean, SD, median, etc.)?
	- Are there any outliers?
	- Are there any implausible values? (Remember that outliers are not necessarily implausible.)
	- Based on the histogram and/or boxplot, what is the shape of the distribution? 
	  (Skewed, symmetric, Normal, uniform, etc.)
	- Are there any missing values?

** Categorical variables **;
PROC FREQ DATA=bios501.wdocs;
	TABLES exerreco primary / NOCUM;
RUN;

PROC FREQ DATA=bios501.wdocs;
	TABLES exerreco / NOCUM;
RUN;

** Continuous variables **;
PROC UNIVARIATE DATA=bios501.wdocs;
	VAR dbp;
	CLASS exerreco;
	HISTOGRAM dbp;
RUN; 

PROC SGPLOT DATA=bios501.wdocs;
	HBOX dbp;    /* VBOX for vertical boxplot, HISTOGRAM for histogram */
	TITLE 'Boxplot of DBP';
RUN;

** Two-sample t-test **;

*PROC FORMAT;
*VALUE YESNO 1="Yes" 2="No";
*RUN;

PROC TTEST DATA=bios501.wdocs;
	CLASS exerreco;
	VAR dbp;
	TITLE 'Does average DBP differ among female doctors who meet 
		      CDC exercise guidelines and those who do not?';
RUN;

** Chi-square test **;
PROC FREQ DATA=bios501.wdocs;
	TABLE primary * exerreco / CHISQ EXPECTED NOPERCENT NOCOL;
	TITLE 'Is there an association between primary care status and exercise compliance?';
RUN;


******************************************************
************Homework 1********************************
******************************************************

*create library;
LIBNAME hw1 'S:\course\bios501\Weiss 2013\data sets';

*This will call the dataset (nutrition) in the directory bios501 and give a summary of the variables and data;
PROC CONTENTS DATA=hw1.nutrition;
Run;

*********RUN PROC UNIVARIATE and TTEST ON CONTINUOUS VARIABLE**********************;
*Generate mean, SD and p-value across groups for retinol intake;
PROC UNIVARIATE DATA=hw1.nutrition;
	VAR RETDIET;
	*class sex;
	HISTOGRAM RETDIET;
RUN; 

PROC PRINT DATA=hw1.nutrition;
	VAR RETDIET;
Run;

DATA work;
	IQR=513;
	Q3=966;
	Outlier=Q3+1.5*(IQR);
Run;

PROC Print data=work;
	var Outlier;
Run;

PROC SGPLOT DATA=hw1.nutrition;
	HBOX RETDIET;
	group=sex;/* VBOX for vertical boxplot, HISTOGRAM for histogram */
	TITLE 'Boxplot of Dietary Retinol Consumption';
RUN;

PROC TTest data=hw1.nutrition ALPHA=0.05; *we did not specify H0;
	var RETDIET;
	class sex;
Run; *USE POOLED VALUE***

*******RUN CHI SQUARED ON CATEGORICAL VARIABLE*************;
PROC FORMAT;
VALUE VITUSEF 1="Yes, fairly often" 2="Yes, not often" 3="No";
RUN;

PROC FREQ DATA=hw1.nutrition;
TABLES VITUSE VITUSE*sex / NOCUM;
RUN;

PROC FREQ DATA=hw1.nutrition;
FORMAT VITUSE VITUSEF.;
TABLES VITUSE*sex / EXPECTED CHISQ NOROW;
RUN;


