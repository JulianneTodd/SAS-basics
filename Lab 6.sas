*Target Population: Entire pop you want to study;
*Sampling Frame: What you have access to, and what you can pull sample from. ideally entire population;
*Sampling Element: Unit you actually sample. The n # of responses taken.
*Measure: variable being measured

*five friendly words from Gettysburg Address:
1 living  
2 dedicated 
3 brave 
4 birth 
5 people 
average: 6.2;

*five words that appear to be average length:
1 field
2 final
3 place
4 their
5 great
average: 5 ;

*five random words:
1 birth
2 highly
3 shall
4 vain
5 earth
average: 5 ;

data work.num; do i=1 to 268; output; end; run;
proc surveyselect method=srs data=work.num out=work.five sampsize=5; run;
proc print data=work.five; run;

*five words based on results of code from above:
74 field
98 that
119 the
185 nobly
258 the
average: 4 ;

LIBNAME bios500 'S:\course\BIOS500\WEISS\DATASETS';
*graph the class results for each method of sampling from gettysburg address;
proc univariate data=bios500.sample2013 plot;
  var F_mean A_mean R_mean;
  histogram F_mean A_mean R_mean / normal; *friendly, average, random;
run;

			*Mean  		Std Dev		Min 		Max
friendly 	6.15		1.11		2.8			9.4
average		5.00		0.937		2.2			8.0
random		4.28		1.09		2.2			11.0

*Graph the data for the whole population (Entire gettysburg address);
proc univariate data=bios500.gettysburg plot;
  var length;
  histogram length / normal; *word length;
run;
*Mean of words= 4.29;
*Std Dev= 2.12;

*clearly random sampling was best;

*Use proc surveyselect to take the 10% random sample from the dataset Sample_lab
*Population=sample_lab dataset;
PROC SURVEYSELECT data=bios500.sample_lab
	method=srs samprate=0.1 out=sample; 
		*Method=SRS will give simple random sample; 
		*Sampling rate=.1 (10% sampling) 
		*out=sample dataset we are creating;
run;

PROC MEANS data=sample n mean; 
	var W; 
	where wave=1; 
run;
PROC MEANS data=sample n mean; 
	var W; 
	by agecat;
	where wave=1; 
run;
PROC MEANS data=sample n mean; 
	var w; 
	where wave=2; 
run;
PROC MEANS data=sample n mean; 
	var W; 
	by agecat;
	where wave=2; 
run;
PROC MEANS data=sample n mean;  
	var w; 
	where wave=3; 
run;
PROC MEANS data=sample n mean; 
	var W; 
	by agecat;
	where wave=3; 
run;

PROC MEANS data=sample n mean;  
	var w; 
	where wave=1 OR wave=2; * 1|2;
run;
PROC MEANS data=sample n mean; 
	var W; 
	by agecat;
	where wave=1 OR wave=2; 
run;

PROC MEANS data=sample n mean;  
	var w; 
	where wave=1 | wave=2 | wave=3; 
run;
PROC MEANS data=sample n mean; 
	var W; 
	by agecat;
	where wave=1 OR wave=2 OR wave=3; 
run;
PROC MEANS data=sample n mean;  
	var w; 
	where ~(wave=1 | wave=2 | wave=3); 
run;
PROC MEANS data=sample n mean; 
	var W; 
	by agecat;
	where wave not in(1,2,3); 
run;


******			Overall				Age Group 1				Age Group 2
			n		W				n		W				n		W
Wave 1		101		7.69			14		6.91			87		7.82
Wave 2		46		-0.26			35		-1.27			11		2.95
Wave 3		36		-10.6			36		-10.6			***		***
Nonrespond	27		-55.6			27		-55.6			***		***

Wave 1+2	147		5.20			49		1.07			98		7.27
Wave 1-3	183		2.09			85		-3.88			98		7.27
TOTAL		210		-5.29			112		-16.29			98		7.27;

*Get population totals, not sample totals;
PROC MEANS data=sample n mean; 
	var W;
RUN;
PROC MEANS data=sample n mean; 
	var W;
	by agecat;
RUN;
************************************;
*good form is to sort data first;
PROC SORT data=sample_lab out=work.test2;
	by agecat;
RUN;

PROC MEANS data=test2;
	var W;
RUN;

PROC MEANS data=test2;
	var w;
	by agecat;
RUN;



