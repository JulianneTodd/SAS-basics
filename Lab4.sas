*File>Import Data> Imported a dataset from same BIOS500>WEISS folder;
*Opened wtloss dataset and saved to "Work" directory;
*The log contains the following:;
	*NOTE: WORK.WTLOSS data set was successfully created;
	*NOTE: The data set WORK.WTLOSS has 30 observations and 4 variables;

PROC IMPORT OUT= WORK.wtloss 
            DATAFILE= "S:\course\BIOS500\WEISS\DATASETS\wtloss.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

*Just opening data to view;
PROC CONTENTS data= work.wtloss;
RUN;

*Since work is the default library, data=work.wtloss or data=wtloss will both call the code;
*This code tells us that there are 2 missing values;
PROC FREQ data=work.wtloss;
	tables gender trt/missing;
RUN;

*wtloss is continuous variable. Other variables are trt,id and gender; 
PROC UNIVARIATE data=work.wtloss;
	var wtloss; *This tells us the lowest/highest few values for the wtloss variable. If outlier, check and remove if needed (below);
RUN;
*work.wtloss is the same as wtloss, because work is the default;
DATA work.wtloss2;
	set work.wtloss;
		*The SET statement will make a new file so you're not altering the original data. This makes a 2nd dataset "wtloss2" that is identical to "wtloss";
	if ID=21 then wtloss=.; 
		*change implausible wtloss value to missing using an if/then statement;
		*when doing numerical values, "." represents missing, when doing character variables, " " space represents missing;
RUN;
*Rerun to make sure that the 215 weight loss value for ID21 has been removed;
PROC UNIVARIATE data=work.wtloss2;
	var wtloss;
RUN;

*Calculate weghtloss in kilos;
DATA work.wtloss2;
	set work.wtloss2;
	wtloss_kg=wtloss*0.4536;
	*This will calculate a new variable "wtloss_kg";
	*This step will overwrite a variable if you are calculating a variable that already exists;
RUN;

*	Arithmetic Operation		Symbol		Example
		Addition					+		age_adjusted=age+1
		Subtraction					-		previous_age=age-3
		Multiplication				*		rate_per_min=rate*60
		Division					/		intake_per_dau=intake_per_wk/7
		Exponentiation				**		corcle_area=pi*r**2
		Grouping					()		newtemp=(temp-32)*(5/9);

*can also create a "constant";
DATA work.wtloss2;
	set work.wtloss2;
	clinic="Atlanta";
		*creates a new variable called clinic where all observations are Atlanta;
RUN;

*This is a if/then/else statement to change the coded variable gender into a string variable "sex";
Data work.wtloss2;
	set work.wtloss2;
	if gender=. 				then sex='      '; 
			*the first time the sex variable is assigned, the variable length is established;
			*can also skip the missing variable step, since the missing variables will automatically be replaced;
	else if gender=0 			then sex='female';
	*could say else if gender=1;else sex='male';
Run;

PROC PRINT data=wtloss2;
Run;

*Symbol		mnemonic equivalent		definition					example
=					EQ				equal to					a=3
^= or ~=			NE				not equal to				a ne 3
>					GT				greater than				num>5
<					LT				less than					num<8
>=					GE				greater than or equal to	sales>=300
<=					LE				less than or equal to		sales<=100
					IN				equal to one of a list		num in (3,4,5)		

*Create a categorical variable for weight loss;
DATA work.wtloss2;
	set work.wtloss;
	if wtloss=.			then success='      ';
	else if wtloss <20	then success='low';
	else if wtloss<=30 	then success='medium';
						else success='high';
RUN;

PROC PRINT data=wtloss2;
Run;

*You need to do this all together or else you keep overwriting your data...;
DATA work.wtloss2;
	set work.wtloss;
	if ID=21 then wtloss=.; 
	wtloss_kg=wtloss*0.4536;	
	clinic="Atlanta";
	set work.wtloss;
	if gender=. 				then sex='      '; 
			*the first time the sex variable is assigned, the variable length is established;
			*can also skip the missing variable step, since the missing variables will automatically be replaced;
	else if gender=0 			then sex='female';
	*could say else if gender=1;else sex='male';
	if wtloss=.			then success='      ';
	else if wtloss <20	then success='low';
	else if wtloss<=30 	then success='medium';
						else success='high';
Run;
PROC FREQ data=work.wtloss2;
	tables gender*sex/ LIST MISSING; *LIST and Missing are separate requests;
RUN;
*calculate means for this varrible, separated by success level and include missing as separate field;
PROC MEANS data=work.wtloss2 n nmiss min max;
	var wtloss;
	class success/missing;
RUN;

*Set labels so tables are easier to view;
DATA work.wtloss3;
	set work.wtloss2;
	label trt = "Treatment Type"
		wtloss = "Weight Loss (lbs)"
		wtloss_kg = "Weight Loss (kgs)"; *No semicolon on the end because labe is a single statement;
RUN; 
*Now you can view the labels you added!;
PROC CONTENTS data=wtloss3;
RUN;

PROC MEANS data=work.wtloss3 n nmiss min max;
	var wtloss wtloss_kg;
RUN;

*This step sets the formatted variable categories;
PROC FORMAT;
	value genderf 0='female'
					1='male'; *genderf is new variable "gender formatted';
	value $trt_typef "A"="Diet Only" "B"="Exercise Only" "C"="Diet and Exercise"; *dollar sign for a character variable;
RUN;
*To apply temporarily, apply in a procedure step (PROC FREQ);
PROC FREQ data=work.wtloss3;
	format gender genderf.;*put period after genderf to tell SAS that you're calling a format;
	tables gender;
RUN;

*To apply permanently, apply in a data step;
DATA work.wtloss5;
	set work.wtloss3;
	format trt $trt_typef.;
RUN;
*To apply temporarily, apply in a procedure step (PROC FREQ);
PROC FREQ data=work.wtloss5;
	tables gender trt;
RUN;
********************************************************
*creating a new dataset;
DATA work.children;
	input age daycare $ sore_throat $; *daycare and sorethroat are character variables ($ designates this);
	datalines;
	3 yes no
	2 no no
	3 no no
	3 no no
	1 yes yes
	2 yes yes
	4 yes yes
	4 no yes
	; *if a value is missing, put a . in its place;
RUN;

PROC CONTENTS data=children;
RUN;

PROC PRINT; 
RUN;
