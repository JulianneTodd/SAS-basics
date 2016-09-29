*Binomial RV:
	1)There are a fixed number of trials (n) in the study/experiment.
	2)There are two possible outcomes on each trial.
	3)The probabilities of the two outcomes remain the same, trial after trial.
	4)The results of one trial do not influence the results of any other trial.  i.e., the trials are 
	independent.
		If p=.5, the distribution will be symmetric. 

*22 M&Ms: 10Y, 2G, 4Bl, 1R, 2O,3Br;

LIBNAME coin "S:\course\bios500\weiss\datasets";
*run alone or after running the "Enhanced graphics template" to make the graph look nicer;

PROC SGPLOT data=coin.cointoss;
	vbar numheads; *make bar chart with vertical bars;
RUN;

*NOW TO RUN BINOMIAL RV PROBLEM WITH SAS;
**SYNTAX: variablename = PROBBNML (p,n, k);
	*where variablename is a name of your choice, PROBBNML is the SAS function name,
		*P=probability associated with each trial
		*N=number of trials
		*K=number of successes;

DATA work.prob; *This will now set a blank dataset because we don't have the set statement active below;
	*set ab;
	*Variable names can't be more than 32characters long and can't contain characters outside #s, letters and underscores;
	prob_le9=PROBBNML(0.5,30,9); *probability of getting less than or equal to 9 heads in 30 coin flips;
	prob_exactly15=PROBBNML(0.5,30,15)-PROBBNML(0.5,30,14);*probability of getting exactly 15 heads in 30 coin flips;
	prob_ge22=1-PROBBNML(0.5,30,21);*probability of getting 22 or more heads in 30 coin flips;
RUN;

PROC PRINT;
RUN;

**This is from the Application to public health part of the notes;
DATA work.prob; *This will now set a blank dataset;
	prob_le2of5=PROBBNML(0.09,5,2); *probability of getting less than or equal to 2 kids having asthma in sample size of 5;
	prob_exactly2=PROBBNML(0.09,5,2)-PROBBNML(0.09,5,1); *probability of exactly 2 kids having asthma in sample size of 5;
	prob_le2of100=PROBBNML(0.09,100,2); *probability of getting less than or equal to 2 kids having asthma in sample size of 100;
	prob_ge10=1-PROBBNML(0.09,100,9); *probability of 10 or more kids having asthma in sample size of 100;
RUN;

PROC PRINT;
RUN;

*NORMAL DISTRIBUTION!
*Stop for a moment and review some features of zscores
1) What percentage of observations should have a z-score between -1 and 1? =68.26
2) 5% of values fall below which z-score?
3)If a z-score = 0, then what is the probability of seeing a smaller value?
4)What are the two z-scores between which 95% of observations should occur?
5)If a z-score is negative, does that mean that the value of the random variable is also negative? NO! just means it falls below the avg;

DATA work.chloride;*make variables set to known values to make the equation coding clearer;
	mean=12.3;
	stddev=sqrt(24.01); *SQRT(x) is a SAS function that calculates the square root of x;
*Part 1;
	*Calculates the probability that an infant has >40 mmol/L chloride in his sweat;
		prob_gt40 = 1-PROBNORM((40-mean)/stddev);
*Part 2;
	*Calculates the z-score associated with probability of .90;
		min_z_p90=PROBIT(.90);
	*Calculates the corresponding value associated with the z-score;
		min_value = min_z_p90 * stddev + mean;
	LABEL 	prob_gt40= probability that sweat chloride gt 40
			min_z_p90 = std. random variable assoc.w/top 10%
			min_value= minimum chloride value for top 10%;
RUN;

PROC PRINT DATA=work.chloride 
	LABEL;*for column headers, use the label name instead of the variable name;
	TITLE chloride insweat example;
	TITLE2 Normal random variable;
RUN;

DATA work.BMI;*make variables set to known values to make the equation coding clearer;
	mean=25.5;
	stddev=3; 
*Part 1;
	*Calculates the probability that BMI over 30;
		prob_gt30 = 1-PROBNORM((30-mean)/stddev);
*Part 2;
	*Calculates the z-score associated with 25% percentile;
		min_z_p25=PROBIT(.25);
		min_value = min_z_p25 * stddev + mean;
RUN;
