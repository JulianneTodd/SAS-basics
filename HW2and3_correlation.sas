*BIOS 501 Lab;     
*HOMEWORK WEEKS 2-3;
LIBNAME hw2 'S:\course\BIOS501\WEISS 2013\data sets';

PROC CONTENTS DATA=hw2.cancer; 
RUN;

** Exploratory data analysis, check normality assumption for both variables **;
PROC UNIVARIATE DATA=hw2.cancer;
	VAR exposure mortality;
	HISTOGRAM exposure mortality / NORMAL; *Don't need this, but helpful to view things;
	PROBPLOT exposure mortality / NORMAL (MU=EST SIGMA=EST);
RUN;

TITLE 'Cancer Mortality versus Exposure Index';
PROC SGPLOT DATA=hw2.cancer; *can use gplot too, but sg gives x and y;
	SCATTER X=mortality Y=exposure /markerattrs=(color=red size=5 symbol=star); 
*markerattrs changes the shape of the scatters!;
RUN;

PROC CORR DATA=hw2.cancer PEARSON SPEARMAN;
	VAR mortality; *independent (X) variable;
	WITH exposure; *dependent (Y) variable;
RUN;
