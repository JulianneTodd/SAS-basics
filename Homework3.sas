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
*Run univariate and look at skewness to determine whether distribution is normal;
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
*Don't need row or total percentage values;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise*CDC_enough / missing norow nopercent;
RUN;

*Question 15;
*Requesting the frequency of each response for the "enough exercise" variable for people who did not follow CDC guidelines;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise*CDC_enough / nofreq nopercent nocol missing;
    where enough_exercise="As much as needed";
RUN;

*Question 16;
*Requesting the frequency of each response for the "CDC enough" variable;
PROC FREQ data=hw3.Physical_activity2013;
    tables enough_exercise*CDC_enough / missing nofreq;
RUN;

*Question 17;
*This graph shows the relationship between total number of minutes/week of moderate exercise (modtot) and total number of 
minutes/week of strenuous exercise (strentot). Data is grouped based on whether the individual follows CDC recommended guidelines
for exercise (CDC_enough=1) and those who do not meet guidelines (CDC_enough=0);

PROC SGPLOT DATA=hw3.Physical_activity2013;
    SCATTER Y=modtot X=strentot /GROUP=CDC_enough ;
    XAXIS LABEL="number of minutes/week of strenuous exercise"; *add an axis label;
    YAXIS LABEL="number of minutes/week of moderate exercise"; *add an axis label;
RUN;

*Question 18;
*Graph will show the distribution of total minutes/week of moderate and strenuous exercise(allexer) grouped based on response to
the “I get enough exercise” categories (enough_exercise);

PROC UNIVARIATE DATA=hw3.Physical_activity2013;
    VAR allexer;
    CLASS enough_exercise;
    HISTOGRAM allexer;
RUN;
