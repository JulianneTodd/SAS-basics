LIBNAME hw3 'S:\course\BIOS500\WEISS\DATASETS';

*Question 1-3;
*requesting that SAS do the rounding for me;
*median for Q1/ max for Q2/ 3rd quartile for Q3 (this would be the value that only 25% of the sample reported exercising more than...;
PROC MEANS data=hw3.Physical_activity2013 maxdec=0 median max q3;
    var modtot;
RUN;

*Question 4-5;
*max for Q4, nmiss (number of missing fields) for Q5;
PROC MEANS data=hw3.Physical_activity2013 maxdec=0 max nmiss;
    var allexer;
RUN;

*Question 6-7;
*Requesting the median (Q6) and min (Q7) number of minutes of exercise for the people who answered in each category of the "enough exercise" variable;
PROC MEANS data=hw3.Physical_activity2013 maxdec=0 median min;
    var modtot;
    class enough_exercise;
RUN;

*Question 8-9;
*Requesting the mean(Q8) and median (Q9) number of minutes of exercise for the people who meet CDC guidelines (using where statement for this);
PROC MEANS data=hw3.Physical_activity2013 maxdec=0 mean median;
    var modtot;
    where CDC_enough=1;
RUN;

*Q10;
*Run univariate and look at skewness;
PROC UNIVARIATE data=hw3.Physical_activity2013;
    var modtot;
RUN;

*Question 11;
*Requesting the frequency of each response for the "enough exercise" variable;
*not sure if anything is missing, so counting that separately;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise / missing;
RUN;

*Question 12;
*Requesting the frequency of each response for the "CDC enough" variable;
PROC FREQ data=hw3.Physical_activity2013;
    tables CDC_enough / missing;
RUN;

*Question 13-14;
*Requesting the frequency of each response for the "enough exercise" variable for people who did meet CDC guidelines;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise*CDC_enough / missing nocol;
RUN;

*Question 15;
*Requesting the frequency of each response for the "enough exercise" variable for people who did not follow CDC guidelines;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise*CDC_enough / missing;
    where CDC_enough=0;
RUN;

*Question 16;
*Requesting the frequency of each response for the "CDC enough" variable;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise*CDC_enough / missing nocol norow nofreq;
RUN;

*Question 17;
*Make a plot that shows the relationship between total number of minutes/week of moderate
exercise (modtot) and total number of minutes/week of strenuous exercise (strentot). Distinguish
between those following the CDC guidelines (“compliers”, CDC_enough=1) and those not following
the guidelines (non-compliers, (CDC_enough=0);


*Question 18;
*Make a plot that show the distribution of total minutes/week of moderate and strenuous exercise
(allexer) by “I get enough exercise” categories (enough_exercise);
