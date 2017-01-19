*BIOS 501 Lab;     *Lab 2 - Correlation and SLR;
LIBNAME bios501 'S:\course\BIOS501\WEISS 2013\data sets';

PROC CONTENTS DATA=bios501.senic2; 
RUN;

** Create a temporary data set and add labels to variables **;
DATA work.infection;
	SET bios501.senic2;
	LABEL prob_inf = 'Probability of infection (%)'  facility = 'Percent of 35 possible facilities and services provided';
RUN;

** Check new data set **;
PROC CONTENTS DATA=work.infection;
RUN;

** Exploratory data analysis, check normality assumption for both variables **;
PROC UNIVARIATE DATA=work.infection;
	VAR prob_inf facility;
	HISTOGRAM prob_inf facility / NORMAL; *Don't need this, but helpful to view things;
	PROBPLOT prob_inf facility / NORMAL (MU=EST SIGMA=EST);
RUN;

*************************** Visual examination of relationship *******************************
**Scatterplots are used to first visually examine the relationship between two continuous variables. 
The independent variable is typically plotted along the horizontal (X) axis, and the dependent variable 
is plotted along the vertical (Y) axis. There are many ways to create scatterplots in SAS. Here are some
examples;

TITLE 'Probability of infection vs. percent of facilities and services offered';
PROC SGPLOT DATA=work.infection; *can use gplot too, but sg gives x and y;
	SCATTER X=facility Y=prob_inf /markerattrs=(color=green size=5 symbol=triangle); 
*markerattrs changes the shape of the scatters! makes green triangles instead of blue circles;
RUN;

SYMBOL INTERPOL=rl value=circle COLOR=red; ** Interpol=rl adds regression equation to log;
PROC GPLOT DATA=work.infection; *Gplot won't quit, so make sure it has a quit post-run;
	PLOT prob_inf*facility;
RUN;
QUIT;

PROC SGSCATTER DATA=work.infection;
	MATRIX prob_inf facility;
RUN;

** Correlation analysis **;
PROC CORR DATA=work.infection;
	VAR facility; *independent (X) variable;
	WITH prob_inf; *dependent (Y) variable;
RUN;

PROC CORR DATA=work.infection PEARSON SPEARMAN;
	VAR facility;
	WITH prob_inf;
RUN;

*RESULTS: In the results viewer, Box for Pearson Correlation Coefficients gives r and p-value.
first row gives r, 2nd row gives p-value;

********NOTES ABOUT THE PEARSON CORRELATION COEFFICIENT (r)*******************
H0:no linear relationship exists between the two variables (and the slope is equal to zero)
H1: A linear relationship exists between the two variables

Assumptions: Both variables are continuous, normally distributed, and have a linear relationship;

*The correlation coefficient (r) ranges from -1 to 1, with the sign indicating the direction of the 
relationship (a positive value means that as X increases, Y tends to increase; *a negative value means that 
as X increases, Y tends to decrease). If r is close to 0, the linear relationship is very weak; *as r gets
closer to ±1, the linear relationship strengthens:

*Even though the p-value indicates a significant correlation, it is not necessarily a strong correlation, 
and the relationship is not necessarily best modeled as linear. Particularly with a large sample, it is 
easy to find significance with this test; *real-world data very rarely have zero linear association. 
Be sure to do a graphical assessment and consider the value of r in addition to the correlation test!;

*•	A non-parametric alternative to r is the Spearman Rank Correlation Coefficient, which can be used 
for non-normal or non-continuous data. It is still only appropriate for linear associations. If the data 
are normal, the Pearson and Spearman coefficients should be similar;
