*******************************************************
*******Generate Table 1********************************
*******************************************************

*create library;
LIBNAME mid 'S:\course\bios500\Weiss\Datasets';

*This will call the dataset (nilton) in the directory bios500 and give a summary of the variables and data;
PROC CONTENTS DATA=mid.nilton;
Run;
*From this step, I learned that that Race is coded as: 1=W 2=AA 9=Other;

PROC PRINT DATA=bios500.exposure (obs=10);
RUN;
*From this step, I learned that the following variables have >1 decimal place;
*LOGGLUCOSE LOGLOGGLUCOSE LOG2GLUCOSE LOG10GLUCOSE SQRTGLUCOSE INVGLUCOSE;

*Create local libname where I have permission to save/edit file;
LIBNAME midterm 'H:\SAS 9.4 Temporary Files';
*Recode Race into 2 groups: African American and Other (Other and white combined);
*Round all non-integers to one decimal point
*Categorize number of days from admit to discharge (admdisci) into 4 groups;
DATA midterm.nilton2;
	set mid.nilton;
	*this step will round all the above mentioned variables with >1 decimal;
			LOGGLUCOSErnd= ROUND(LOGGLUCOSE);
			LOGLOGGLUCOSErnd= ROUND(LOGLOGGLUCOSE);
			LOG2GLUCOSErnd= ROUND(LOG2GLUCOSE);
			LOG10GLUCOSErnd= ROUND(LOG10GLUCOSE);
			SQRTGLUCOSErnd= ROUND(SQRTGLUCOSE);
			INVGLUCOSErnd= ROUND(INVGLUCOSE);
	*this step will recode race into 2 groups;
		if race=9				then race_recode='9'; 
			if race=1		then race_recode='9';*setting the "white" category to be switched to "other" as a new variable;
			else if race=2 		then race_recode='2'; 
	*this will recode # of days from admit to discharge into the categories required for table 1;
		if admdisci=.			then admdisci_grouped='           ';
			if admdisci <=7		then admdisci_grouped='</=7days';
			if admdisci >=8 <=21 	then admdisci_grouped='8-21days';
			if admdisci >=22  <=45 	then admdisci_grouped='22-45days';
		 	if admdisci >=46	then admdisci_grouped='46+ days';
Run;

*Calculate Mean and Std Dev using PROC MEANS for the first 3 variables needed for the table;
*Age in years, WBC count at admission and Platelet count at admission;
PROC MEANS data=midterm.nilton2 mean std maxdec=0;
    var age WBC Platelet;
RUN; *This will calculate the values for the OVERALL column;

PROC MEANS data=midterm.nilton2 mean std maxdec=0;
    var age WBC Platelet;
	class HIV;
RUN; *This will calculate the values for the HIV Status specific columns;

*Frequency (percentages) must be calculated for the following variables:
*ABX use in 3 months before admit;
*Days from Admit to discharge;
*Race;
*Gender;
PROC FREQ data=midterm.nilton2;
    tables prev_antibiotics*HIV /norow;
RUN;

PROC FREQ data=midterm.nilton2;
    tables admdisci_grouped*HIV /norow;
RUN;

PROC FREQ data=midterm.nilton2;
    tables race_recode*HIV /norow;
RUN;

PROC FREQ data=midterm.nilton2;
    tables gender*HIV /norow;
RUN;
 
*******************************************************
*******Generate Figure 1*******************************
*******************************************************
**Figure 1. Age in years and white blood cell count at admission by HIV status;
PROC SGPLOT DATA=midterm.nilton2;
    SCATTER Y=age X=WBC /GROUP=HIV;
    XAXIS LABEL="WBC count at admission"; *add an axis label;
    YAXIS LABEL="Age of patient"; *add an axis label;
	Title "Figure 1. Age in years and white blood cell count at admission by HIV status";
RUN;

*******************************************************
*******Generate Figure 2*******************************
*******************************************************
**Figure 2. Age by HIV status and recoded race;

*Age and WBC count at admission by HIV status;
PROC SGPLOT data=midterm.nilton2;
  vbox age / category=HIV;
  title 'Figure 2a:Patient Age by HIV status';
  XAXIS LABEL="HIV Status (1=positive, 2=negative, 9=unknown)"; *add an axis label;
  YAXIS LABEL="Age distribution of patients"; *add an axis label;
run;
PROC SGPLOT data=midterm.nilton2;
  vbox age / category=race_recode;
  title 'Figure 2b: Patient Age by Race';
  XAXIS LABEL="Race (2=African American, 9=Other)"; *add an axis label;
  YAXIS LABEL="Age distribution of patients"; *add an axis label;
run;

