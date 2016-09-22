LIBNAME hw4 'S:\course\BIOS500\WEISS\DATASETS';

*Question 11;
*Created a new variable (contact_total) which sums contact home and work;
DATA hw4.exposure2;
	set hw4.exposure;
	contact_total=contact_home+contact_work
RUN; 
*Determine the mean of contact_total to the tenth?;
PROC MEANS data=hw4.exposure2;
   var contact_total;
RUN;

*Question 12;
*Created a categorical variable (BMI_designation) from BMI in the exposure dataset, using the following categories;
    *Underweight: less than 18.5;
    *Normal: >=18.5, less than 25;
    *Overweight: >=25, but less than 30;
    *Obese: 30 or higher;
DATA hw4.exposure3;
	set hw4.exposure2;
	   if BMI=.			then BMI_designation='           ';
   	else if BMI <18.5	then BMI_designation='underweight';
	   else if BMI>=18.5 <25 	then BMI_designation='normal';
	   else if BMI>=25  <30 	then BMI_designation='overweight';
		else if BMI>30				then BMI_designation='obese'; *unnecessary, but worth just coding in for the homework;
RUN;
*PROC FREQ to determine number of subjects in the dataset are classified as “normal weight" and % of subs classified as "obese";
PROC FREQ data=hw4.exposure3 maxdec=1;
	tables BMI_designation/ LIST missing;
RUN;

*Question 14;
*Create a format for the binary coding scheme 1=YES, 0=NO. Apply the format to two of the;
*variables in your exposure dataset that use this coding scheme (e.g. respiratory and smoke); 
*and run a PROC FREQ with these two variables. Print the output table (it should show the;
*formats) with your name as the title.  Copy the outputted table into a Word document;

*Question 15;
*In the same Word document from #14 above, copy your SAS code used to answer question 11-14;
*Make sure there is a comment heading containing you name.  Your SAS code is expected to be well;
*-commented and formatted for easy reading.  Your attached file should include both the output table and your code;
*Submit your document as “LASTNAME_FIRST_NAME_BIOS500L_LAB4HW.doc”;
