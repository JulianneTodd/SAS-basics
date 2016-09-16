*create library;
LIBNAME hw 'S:\course\bios500\Weiss\Datasets';

*This will call the dataset (exposure) in the directory bios500 and give a summary of the variables and data;
PROC CONTENTS DATA=hw.heart2;
Run;
*height is the only continuous (numerical) variable per the results file;

*PROC MEANS will runmean, std dev, min and max values for the entire dataset on the variable assigned;
*max dec will specify the number of decimal places you want in the results viewer;
proc means DATA=hw.heart2 maxdec=1;
var ageatstart;
run;

*Running again for diastolic blood pressure. Can specify that MAX is only output desired, but its part of the standard 5 results given and I don't want to have to change the defaults back...;
PROC MEANS data=hw.heart2;
var diastolic;
RUN;


*using the CLASS statement to divide up data by categorical value (sex);
*using specifier after calling the data (maxdec and q3) to request specific info;
PROC MEANS DATA=hw.heart2 maxdec=0 q3;
var weight;
class sex;
RUN;

*have to request mean specifically because the last procedure reset defaults to only give q3;
PROC MEANS DATA=hw.heart2 maxdec=1 mean;
var diastolic;
RUN;

*same variable, now with more reported stats!;
PROC UNIVARIATE DATA=hw.heart2;
var diastolic;
RUN;

*Forgot to specify max # of decimal places... luckily I can round on my own. Also, this confirmed the answer to questions 3 and 5;

*Below are the commands run to generate the plots for Question 7;

*COMBINED horizontal box plots for systolic split by sex;
PROC SGPLOT DATA=hw.heart2;
hbox systolic / category=sex;
run;

*Side by side histograms for systolic split by sex;
PROC UNIVARIATE DATA=hw.heart2 plot;
var systolic;
class sex;
histogram systolic;
run;


*So, I think the output for these last two is what you meant by "side-by-side", its weird because they are vertical, so I don't think you want the boxplots/histograms split up and placed in 2 separate graphs side-by-side to eachother...;
