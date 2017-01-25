*BIOS 501 Lecture Homework 1;

LIBNAME HW1 ' s:\course\bios501\cotsonis\2017';

PROC CONTENTS DATA=HW1.senic; 
RUN;

** Create a temporary data set and add labels to variables **;
DATA work.senic;
	SET HW1.senic;
	LABEL y = 'average estimated probability of infection(%)'  
		x4 = 'routine chest-xray'
		x5 = 'number of beds'
		x6 = 'medical school affiliation (1=yes, 2=no)'
		x10 = 'available facilities and services';
RUN;

** Check new data set **;
PROC CONTENTS DATA=work.senic;
RUN;

PROC CORR DATA=work.senic;
	VAR x4; *independent (X) variable;
	WITH y; *dependent (Y) variable;
RUN;

** Generate data for table: Regression analysis of y versus x4**;
PROC REG DATA=work.senic PLOTS(ONLY)=FIT; *puts regression line into the plot;
	MODEL y = x4 / CLB;* / CLM CLI; *DEPENDENT=INDEPENDENT=does the exposure impact the mortality;
			*CLM requests confidence interval. CLI requests prediction interval @ 95%;
	TITLE 'Simple linear regression analysis';
	ID x4; *this should be the independent variable;
RUN;
QUIT;

PROC CORR DATA=work.senic;
	VAR x5; *independent (X) variable;
	WITH y; *dependent (Y) variable;
RUN;

** Generate data for table: Regression analysis of y versus x5**;
PROC REG DATA=work.senic PLOTS(ONLY)=FIT; *puts regression line into the plot;
	MODEL y = x5 / CLB;* / CLM CLI; *DEPENDENT=INDEPENDENT=does the exposure impact the mortality;
			*CLM requests confidence interval. CLI requests prediction interval @ 95%;
	TITLE 'Simple linear regression analysis';
	ID x5; *this should be the independent variable;
RUN;
QUIT;

PROC CORR DATA=work.senic;
	VAR x6; *independent (X) variable;
	WITH y; *dependent (Y) variable;
RUN;

** Generate data for table: Regression analysis of y versus x6**;
PROC REG DATA=work.senic PLOTS(ONLY)=FIT; *puts regression line into the plot;
	MODEL y = x6 / CLB;* / CLM CLI; *DEPENDENT=INDEPENDENT=does the exposure impact the mortality;
			*CLM requests confidence interval. CLI requests prediction interval @ 95%;
	TITLE 'Simple linear regression analysis';
	ID x6; *this should be the independent variable;
RUN;
QUIT;

PROC CORR DATA=work.senic;
	VAR x10; *independent (X) variable;
	WITH y; *dependent (Y) variable;
RUN;

** Generate data for table: Regression analysis of y versus x10**;
PROC REG DATA=work.senic PLOTS(ONLY)=FIT; *puts regression line into the plot;
	MODEL y = x10 / CLB;* / CLM CLI; *DEPENDENT=INDEPENDENT=does the exposure impact the mortality;
			*CLM requests confidence interval. CLI requests prediction interval @ 95%;
	TITLE 'Simple linear regression analysis';
	ID x10; *this should be the independent variable;
RUN;
QUIT;
