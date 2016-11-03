*Variation due to one factor is one-way ANOVA (analysis of variance);
*Assumptions:
1- subjects are independent
2-Measurements in each groups are from populations with relatively equal variances
3- measurements in each group are sampled from pops with normal distribution;

DATA work.ache;
	INPUT brand relief; * SAS the order in which you will input the variables (both variables in this case are 
						numeric, so we do not need a “$” after the variable name).;
		DATALINES;
			1 24.5
			1 23.5
 			1 26.4
			1 27.1
 			1 29.9
			2 28.4
			2 34.2
			2 29.5 
			2 32.2
			2 30.1
			3 26.1
			3 28.3
			3 24.3
			3 26.2
			3 27.8
			;
RUN;

PROC GLM DATA=work.ache;
	CLASS brand; *identifies the variable that classifies the data into groups. Must precede the model statment;
	MODEL relief=brand; *describes the relationship you want to investigate. 
						Takes the form Model Dependent variable=independent variable list;
	MEANS brand; *instructs PROC GLM to print the number of observations, the mean,and the standard deviation of the 
				dependent variable (relief) for each of the groups defined by the independent variable (brand);
				*Could run a means or proc univariate to do this too;
RUN;

QUIT; *Without this, it will keep saying that it is running PROC GLM;

*In results, Sum of Squares/Degrees of Freedom=mean square.
THEN (Mean square of the model)/(Mean square of the Error)=F value;
*AND (Sum of Squares of the Model)/(Sum of Squares of Corrected Total)=R Square
*Rsquare tells us how much variation is explained by the model;
*Brand being used explains 54% of the differences in relief times;
*P-value is 0.0091, which indicates we should reject the NULL. 
===At least one of the brands is different from the others;
*Running an F-test as part of PROC GLM as well;

*CONCLUSION= Conclusion:We conclude that there is evidence that the true mean minutes until relief from headache 
is different among the different brands (overall F test p-value=.009). At least one of the three brands
has a statistically significant different effect on headaches compared to at least one other brand; 

**********************************************************************
**************MULTIPLE COMPARISONS IN ONE-WAY ANOVA*******************
**********************************************************************

*Tukey:Only all pairwise comparisons are of interest, and all are pre-planned;
*Bonferroni: Pre-planned comparisons are of interest, some or all of which are non-pairwise (may include 
		all-pairwise along with other pre-planned contrasts)
*Scheffe: Some or all comparisons of interest are non-pairwise and at least one comparison is not planned before the
		analysis (may include all-pairwise, along with other contrasts)
		(also use when the sample sizes in the groups are very different);

*Liklihood of error increases with the number of tests you run:
	*1-(1-a)^(# tests);

*FOR HW: understand all, but only need Tukey;

			***************
			****TUKEY******
			***************
-if you plan to investigate Brand 1 v Brand 2, Brand 1 v Brand 3, then Brand 2 v Brand 3;

PROC GLM DATA=ache PLOTS=none; *supress the plots;
	CLASS brand;
	MODEL relief=brand;
	MEANS brand / TUKEY CLDIFF LINES; *Tukey indicates method, CLDIFF requests that confidence intervals be printed, 
										Lines is there for unknown reason;
RUN; *Runs 6 tests, both the 1 v 3 and 3v1 are run so you can display pos or neg based on what makes sense;
QUIT; *NOTE that confidence limits that don't contain 0 should be significant;

*Brand explained 54% of the variability in minutes to relief (p=.009), with both brands 1 and 3 having 
significantly shorter times to relief than brand 2 [26.3min, 26.5min, v 30.9min; *95% CI on difference:(-8.2, -1.0)
and(-8.0, -.7)]. Brand 1 and 3 did not significantly differ [95%CI on difference:-3.4, 3.9];

*The traditional way to display these results is to list the means in ascending order and connect all 
statistically equal means with an underline;


			********************
			****Bonferroni******
			********************
*Assume this was all planned ahead, required by Bonferroni;

*Four sets of hypotheses are tested
	1) mean of brand 1 does or does not equal mean of brand 2
	2) mean of brand 1 does or does not equal mean of brand 3
	3) mean of brand 2 does or does not equal mean of brand 3
	4) (mean of brand 2+mean of brand 3)/2 does or does not equal mean of brand 1;
PROC GLM DATA=ache PLOTS=none;
	CLASS brand;
	MODEL relief=brand; *MODEL statement must appear before ESTIMATES statement;
		ODS OUTPUT Estimates=bonfstats; *makes a new dataset with the estimates;
			ESTIMATE 'Brand 1 vs. Brand 2' brand 1 -1 0; *write a new estimate/label for each hypothesis to be tested;
			ESTIMATE 'Brand 1 vs. Brand 3' brand 1 0 -1; *Coefficients refer to the weighting of each mean;
			ESTIMATE 'Brand 2 vs. Brand 3' brand 0 1 -1;
			ESTIMATE 'Brand 1 vs. Brands 2&3' brand 1 -0.5 -0.5;
		TITLE Calculations for Multiple Comparisons Using Bonferroni;
RUN; 
QUIT;

*The order in which you list the coefficient values must correspond to how SAS orders the levels of 
your effect variable: ascending order for both numeric and character variables.  In our dataset, the 
order will be Brand 1, Brand 2, Brand 3;

*IN THE RESULTS VIEWER, the P VALUES we get are not correct, since they account for 1 test, not 4.
*multiply these p-values by 4, since we have 4 tests—shown on the right. 
Note that the p-value cannot be higher than 1 since it is a probability;

PROC PRINT DATA=bonfstats; *We already told SAS to output the results from the estimates statement into a new temp
							dataset called bonfstats. This step is just reprinting the bonfstats dataset, which is 
							thep values for each null hypothesis;
RUN;


*Can run a proc contents to verify the order of the variables, did not do it here;

DATA bonfint; 
SET bonfstats;*set up the constants needed in finding the critical value of t; 
		n=15; 
		k=3; 
		G=4; 
		alpha=.05; 
		percentile=1-(alpha/(2*G) ); 
		critical_value =TINV(percentile,n-k); *critical t-value for 4 Bonferroni tests;

*calculate Bonferroni Lower and Upper Confidence Limits; 
bonf_LCL=Estimate - StdErr*critical_value; 
bonf_UCL=Estimate + StdErr*critical_value;

p_value= Probt*4; *adjusts p-value to correct value for 4 Bonferroni tests; 
if p_value>=1 then p_value=.999; *set to maximum possible (p cannot be >1) because it is a probability;

	LABEL Parameter=Comparison 
		Estimate=L-hat 
		StdErr=Standard Error of L-hat 
		tValue=Test Statistic 
		critical_value=Critical 
		Value bonf_LCL= Lower Confidence Limit 
		bonf_UCL= Upper Confidence 
		Limit p_value=Adjusted p-value;

	TITLE Bonferroni CIs, Critical Values, and p-values, Adjusted for 4 Tests; 
	TITLE2 Dependent Variable: Minutes until Headache Relief; 
RUN;

PROC PRINT DATA=bonfint LABEL; 
	VAR Parameter--StdErr Critical_value--bonf_UCL tvalue p_value; **double dash is calling all variables from 
																	Parameter to standard error;
	FORMAT Estimate StdErr Critical_value--bonf_UCL tvalue p_value 7.4; 
RUN;

			*******************
			****SCHEFFE'S******
			*******************
*This is used in cases when you did not consider multiple comparisons before hand;
PROC GLM DATA=ache PLOTS=none;
	CLASS brand;
	MODEL relief=brand; 
	MEANS brand / SCHEFFE CLDIFF LINES;
	ESTIMATE 'Brand 2 vs. Brand 1&3' brand -0.5 1 -0.5; *This is optional to compare brand 2 versus the others for sure;
				*Note: This P-value will be wrong, but the test statistic is correct. You can calculate the p-value yourself;
	TITLE "Scheffe’s Approach"; /*Note that the double quotes are necessary here since we have an 
									apostrophe in the title */
RUN; 
QUIT;

*This model only has 3 hypotheses... Brand 1 v. Brand 2, Brand 1 v. Brand 3, Brand 2 v. Brand 3; 
*We can construct the 95%confidence interval using the Estimate(L= 4.47), Standard Error (SE(L)=1.1846), 
and critical value of 2.7876.  
		4.47 ± 2.7876*1.1846 = (1.17, 7.77)= indicates significance because 0 is not within the CI;
