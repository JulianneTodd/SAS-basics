LIBNAME lab7 'S:\course\BIOS500\WEISS\datasets';

PROC CONTENTS data=lab7.exposure;
Run;

*Cholesterol is a variable called chol;
PROC MEANS data=hw7.exposure mean;
	var chol;
RUN;

***Q1-Q6***Is the mean cholesterol in this population significantly different from 180? 
Test at the 0.05 significance level. (Use the variable chol);

*Check Assumptions*;
PROC UNIVARIATE data=lab7.exposure;
	var chol;
	histogram chol / normal; *Will overlay normal curve;
	probplot chol;
Run; 

*Run 1sample T-test*;
PROC TTest data=lab7.exposure H0=180 ALPHA=0.05;
	var chol;
Run; 

***Q7-Q12***Is there a statistically significant difference in BMI between men and women in this population? Use a significance level of 0.05.;
*Run 2sample T-test*;
PROC TTest data=lab7.exposure ALPHA=0.05; *Don't specify H0;
	var BMI;
	class sex;
Run;

***Q13-Q18***USE OUTPUT FROM HW PDF;

