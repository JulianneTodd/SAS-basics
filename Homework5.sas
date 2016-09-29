Exercise 1: Estimating the Proportion of Blue Plain M&M’s®
[Please do not eat the lab materials until the exercise has concluded!] An article in The Austin American-Statesman 1(AAS) reported that 20% of the candies in bags of plain M&M’s® were blue. This 20% should be considered a characteristic of the M&M® population. Consider a blue M&M® a “success”, and a failure to be a non-blue M&M®.
  Carefully count the total number of M&M’s® in your bags. Re-check your count.
  Carefully count the number of BLUE M&M® in your bags. Re-check your counts.
  Instructions will be given in class about recording this information.
  After the last lab, we will send out the aggregate counts (over all lab sections) that you can use to complete the homework.

3. If it is true that the manufacturer aims for 20% of each bag to contain blue candies, how many blue M&M’s® would you expect, given the aggregate count (i.e. the total from the 4 labs)? (Round to the nearest whole number)

4. Use SAS to calculate the exact binomial probability of observing  the aggregate # of blue M&M’s® if the true probability of a blue candy = 0.2. (Round to 3 decimal places)

5. An alternate source from 2010 (purportedly a letter from the manufacturer2) stated that M&M'S have this distribution: 24% blue, 20% orange, 16% green, 14% yellow, 13% red, 13% brown. If 0.24 is the true population proportion of blues, what is the probability of observing  the aggregate # of blue M&M’s® we observed? (Enter your answer in scientific notation, if necessary).

6. Given your answers above, which population proportion of blue candies is more likely to be correct?
    A. 20%
    B. 24%
    C. Can’t tell.
    

*EXERCISE 2, QUESTION7;
*Bar chart showing the distribution of M&M® colors in 2004;
LIBNAME hw5 "S:\course\BIOS500\WEISS\DATASETS";

*Figure out the variable name I want to plot;
PROC CONTENTS data=hw5.m_and_m_colors2004; 
RUN; 

*RUN ENHANCED GRAPHICS TEMPLATE NOW;
PROC SGPLOT data=hw5.m_and_m_colors2004;
	vbar color; *make bar chart with vertical bars;
	title 'Distribution of M&M® colors in 2004';
RUN;
*Add 1-3 lines of text describing your results and submit your plot on question 7 of the online assessment;

*EXERCISE 3;
*Question 8- provide mean and stddev so that SAS can caluclate the probability based on normal distribution for BP at immigration;
DATA work.prob; *This will now set a blank dataset;
	mean=108;
	stddev=9.6;
		prob_gt125=1-PROBNORM((125-mean)/stddev);
RUN;

PROC PRINT;
RUN;
*Question 10- provide mean and stddev so that SAS can caluclate the probability based on normal distribution for BP after 5 yrs;
DATA work.prob; *This will now set a blank dataset;
	mean=116;
	stddev=10.4;
		prob_gt125=1-PROBNORM((125-mean)/stddev);
RUN;

PROC PRINT;
RUN;

*Question 13- determine what BP at immigration is considered to be the 95% percentile;
DATA work.prob; *This will now set a blank dataset;
	mean=108;
	stddev=9.6;
	*Calculates the z-score associated with the 95% percentile;
		min_z_p95=PROBIT(.95);
	*Calculates the corresponding value associated with the z-score;
		min_value = min_z_p95 * stddev+mean;
	LABEL 	min_z_p95 = std. random variable assoc.w/top 5%
			min_value= minimum blood pressure value for top 5%;
RUN;

PROC PRINT;
RUN;
