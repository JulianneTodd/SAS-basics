LIBNAME lab 'S:\course\BIOS500\WEISS\DATASETS';

PROC FORMAT;
	VALUE yesnof 0="No" 1="Yes";
RUN;

*Assumptions= sample is random;
*2 factors:
*1=seasonal allergies or no seasonal allergies;
*2=rural versus urban dwellers;

*Chi-squared test of proportions;
PROC FREQ DATA=lab.allergy;
	FORMAT aller_seas yesnof. ;
	TABLES aller_seas*home_location / EXPECTED CHISQ NOROW;
RUN; *The larger the chi2 is, the more likely you are to reject the null (bigger chi, smaller p-value);
*Typically a rule: If one expected value is <5, you cannot use Chi squared (we will in this class). You would use Fisher's exact;
*must put P-value and percentages in the results.
*The occurrence of seasonal allergy did not differ significantly between rural and city dwellers (rural=23% v city=19%. p=0.06).;

*Chi-squared test of association;
PROC FREQ DATA=lab.exposure; 
	FORMAT respiratory cancer yesnof.; 
	TABLES respiratory*cancer / EXPECTED CHISQ; 
RUN;

*Measures of association (RELRISK option);
PROC FREQ DATA=lab.exposure; 
FORMAT respiratory cancer yesnof.; 
TABLES respiratory*cancer / EXPECTED CHISQ RELRISK; 
RUN;

*Manually input frequencies in a new dataset; 
DATA work.allergy_counts; 
	INPUT allergy $ location $ cellcount; 
	DATALINES; 
		No Rural 462 
		No City 1076 
		Yes Rural 135 
		Yes City 251 
; 
RUN;
*Run Chi-Square test; 
PROC FREQ DATA=work.allergy_counts; 
	WEIGHT cellcount; 
	TABLES allergy*location / nopercent norow chisq expected; 
RUN;

*Manually input observed M&M frequncies; 
DATA work.mm; 
	INPUT color$ count; 
	DATALINES; 
		green 1023 
		red 640 
		blue 1085 
		brown 718 
		yellow 615 
		orange 1124 
; 
RUN;
*Chi-square goodness of fit test; 
PROC FREQ DATA=work.mm; 
	WEIGHT count; 
	TABLES color / NOCUM TESTP=(24 14 16 20 13 13); 
RUN;

*Using alternative ordering; 
PROC FREQ DATA=work.mm order=data; 
	WEIGHT count; 
	TABLES color / NOCUM TESTP=(16 13 24 14 13 20); 	
RUN;
