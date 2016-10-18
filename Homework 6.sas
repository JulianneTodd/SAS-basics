**************************************************
** Lab 6 homework assignment
** Code copied from the program referenced on homework handout
** "S:\course\BIOS500\WEISS\PROGRAMS\Normal distribution program for hw 6.sas"
** Cleaned slightly to just perform functions required for homework;
**************************************************;

******NORMALLY DISTRIBUTED POPULATION;
**create a variable called normal that follows the standard normal distribution;
data normaldata; 
do obs=1 to 2000;
normal=rannorm(5551212); *generates random values from the standard normal distribution;
output;
end;
run;

***********************************************************
*select 100 samples of size 20 from the normal population;
PROC SURVEYSELECT DATA=normaldata METHOD=SRS sampsize=20 rep=100 OUT=sample;
RUN;

*observe distribution shapes of the small samples;
*remember that these are all samples from a normal population;
proc univariate noprint data=sample;
by replicate;
histogram normal;
title samplesize20Normal, Ammirati; 
inset mean;
run;

***********************************************************
*select 100 samples of size 100 from the normal population;
PROC SURVEYSELECT DATA=normaldata METHOD=SRS sampsize=100 rep=100 OUT=sample;
RUN;

*observe distribution shapes of the larger samples;
*remember that these are all samples from a normal population;
proc univariate noprint data=sample;
by replicate;
histogram normal;
title samplesize100NORMAL, Ammirati;
inset mean skewness kurtosis;
run;

***********************************************************
***********************************************************
*NON-NORMALLY DISTRIBUTED POPULATION;
**create a  skewed variable called skewvar;
data skewdata; 
do obs=1 to 2000;
skewvar=log(rannorm(5551212)+1);
output;
end;
run;

*select 100 samples of size 20 from the skewed population;
PROC SURVEYSELECT DATA=skewdata METHOD=SRS sampsize=20 rep=100 OUT=sample;
RUN;

*observe distribution shapes of the small samples;
*remember that these are all samples from a skewed population;
proc univariate noprint data=sample;
by replicate;
histogram skewvar;
title samplesize20Skewed, Ammirati; 
inset mean;
run;

***********************************************************
*select 100 samples of size 100 from the skewed population;
PROC SURVEYSELECT DATA=skewdata METHOD=SRS sampsize=100 rep=100 OUT=sample;
RUN;

*observe distribution shapes of the larger samples;
*remember that these are all samples from a skewed population;
proc univariate noprint data=sample;
by replicate;
histogram skewvar;
title samplesize100Skewed, Ammirati;
inset mean skewness kurtosis;
run;
