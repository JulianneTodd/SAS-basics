LIBNAME lab7 'S:\course\BIOS500\WEISS\datasets';

PROC CONTENTS data=lab7.fev_data;
Run;

PROC MEANS data=lab7.fev_data mean;
	var age height fev_6months fev;
RUN;

PROC FREQ data=lab7.fev_data;
	tables sex;
Run;

**H0- FEV for children with asthma will be no different from FEV of healthy children;
**HA- FEV for children with asthma will not equal FEV of healthy children;

**Assumptions: 3! Population has normal distribution, sample is simple/random, variance is unknown;

*Check assumptions when possible;
PROC UNIVARIATE data=lab7.fev_data;
	var fev;
	histogram fev / normal; *Will overlay normal curve;
	probplot fev;
Run; *From this we learn that its not really normal (Goodness of fit tests for normal distribution), but its a large enough sample that we don't care;

PROC TTest data=lab7.fev_data H0=3.25 ALPHA=0.05;
	var fev;
Run; *Observe DF, mean, std dev, 95% CU means; 

*We are looking to see whether the mean for asthma kids is different from 3.25. Therefore, if the 95% CL mean does not contain 3.25,
we would expect this t-test to be significant, since the 95% CL range for asthma group should have 3.25 IN RANGE if it is nonsignificant;

*******Important to identify sample mean and the comparison value, measure of spread, confidence intervaland/or p-value;
**speculate on direction of effect (FEV mean is 2.6 versus 3.25 is normal, so we are expecting the asthma kids to have lower FEV;

*******We observed an average FEV of 2.64 L (sd 0.87)among the sample of children with asthma, as compared to the known healthy child
population mean of 3.25 L.  At the 5% significance level, the sample data provide sufficient statistical evidence to conclude that 
the children with asthma have a lowerpopulation meanFEV value (p-value <0.0001);***********

*******************************************************************************
*******************************2-sample T-test*******************************

*Assume variances are the same in each sample;

PROC TTest data=lab7.fev_data ALPHA=0.05; *we did not specify H0;
	var fev;
	class sex;
Run; *Pooled and Unpooled (Satterthwaite) will dictate whether variances are equal. Typically we use the pooled all the time, but if 
Equality of variances indicate that PR>F is <.05, you should use the Satterthwaite;

*****CONCLUSION: In our sample, male FEV averaged 2.81 (sd 1.00) and female FEV averaged 2.45 L (sd 0.65).  Based 
on these estimates, we are 95% confident that the true difference in FEV for male and female children 
with asthma is between 0.23 and 0.49 L. **********;



*******************************************************************************
*******************************PAIRED T-test*******************************

*H0-there is no difference between pre/post treatment FEV scores;
*HA-there is a difference between pre/post treatment FEV scores;

*ASSUMPTIONS: 2! Simple random sample, normal distribution or sufficiently large sample; 

DATA work.new_fev;
	set lab7.fev_data;
	diff=fev_6months-fev;
RUN;

PROC UNIVARIATE data=new_fev;
	var diff;
	histogram diff / normal; *Will overlay normal curve;
	probplot diff;
Run; *654 observations, we see its not normal, so we don't care that it isn't normal;

PROC TTest data=lab7.fev_data ALPHA=0.05;
	PAIRED fev_6months*fev; *use PAIRED instead of VAR;
Run;

*We are looking at the average difference and trying to determine if it is 0. Therefore, if 0 does not fall within the 95% CL mean,
we would expect this to be significant, since 0 SHOULD BE IN RANGE if it is nonsignificant;


*****Conclusion: After taking an asthma medication for 6 months, children’s FEV increased on average 
0.420 L (sd 0.423). If the population of children with asthma were given this medication, we would be 
95% confident that the average change in FEV would be between 0.387 and 0.452 L.; *Get the average change from the 95% CL Mean;

PROC TTest data=lab7.fev_incorrectly_unpaired  ALPHA=0.05;
	var fev;
	class time;
Run;

*Bad dataset because you don't know that everything is pre-post or post-pre-- not matching correctly;
*This is still statistically significant but the CI is really large (but the mean is the same);

*Only specify the H0 in a 1 sample t-test!;
PROC TTEST data=libref.dataset H0=value ALPHA=value SIDE=side; 
*This statement indicates which data set will be used for this procedure, in this order:
libref,period (.) and then provide the dataset;
*The H0 option specifies the population value to compare with the sample 
data.  In place of the word value, provide the population mean. Use this 
option only when doing a one-sample t-test;
*ALPHA AND SIDE ARE OPTIONAL;
*The ALPHA option specifies the alpha level that you will use to conduct 
the test.  If you do not specify the alpha value, the default is 0.05
*The SIDE option specifies the side of the test.  U is for upper one-sided tests and L is for lower one-sided tests.  
If you do not specify this option, the default is a two-sided test.;
	var variable;
*The VAR statement specifies which variable holds the sample data that 
you will be testing. Provide the variable name in place of the word 
variable.;
		class variable;
*The CLASS statement specifies which categorical variable will group the 
continuous variable. Beside the CLASS statement, the categorical 
variable of interest should be provided.  This variable can only have two 
levels.  By specifying this option, you specify a two sample t-test.;
			paired var1*var2;
*The PAIRED statementis used for paired t-test. This statement is followed by the two variables that you are 
comparing.  The star (*) acts as a subtraction symbol, indicating that you are looking at the difference 
between the two time points. [fev_6months*fevmeans fev_6months minus fev];
RUN;
