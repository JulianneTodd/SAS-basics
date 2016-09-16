/*Lab 3*/ ***Working on categorical variables this week;
/*Look at frequencies and percentages. No means, because the value itself is unimportant*/
    /*Ordinal variables= ordered. Like "mostly, sometimes, never"*/
    *Nominal variables= No order. "Dogs cats and fish";

LIBNAME lab3 'S:\course\BIOS500\WEISS\DATASETS';

*provide variable names under comand "Tables" to generate a frequency table for that variable;
PROC FREQ data=lab3.exposure;
    tables type_work activity_level;
RUN;

*add an asterisk between variables to combine both variables into a single table for cross tabulations;
*First variable named goes down left side, 2nd variable goes across top;
*table on the upper left hand side will indicate what the 4 #s in each box correspond to. Frequency, Percentage of TOTAL # of responses, Row percent gives % within that row, and column percent;
PROC FREQ data=lab3.exposure;
    tables type_work*activity_level;
RUN;

/*OPTIONS for tables*/
**nopercent= without percentages
**norow=doesn't show row percentages
**nocol=doesn't show column percentages
**nofreq=doesn't show frequencies
**nocum=doesn't show cumulative percentages
**list= don't get row or column percentages, presents info as a list rather than standard table output
**missing=counts missing values as separate category, rather than just exclude them;
PROC FREQ data=lab3.exposure;
    tables type_work*activity_level / list;
RUN;

*this command line will produce an normal cross tab table but without the percentage values;
PROC FREQ data=lab3.exposure;
    tables type_work*activity_level / nopercent;
 RUN;

 *On a crosstabulation table, disease on the left and exposure on the top;

 *this command line will produce an normal cross tab table but without the percentage values;
 PROC FREQ data=lab3.exposure;
    tables sex*type_work*activity_level / nocol nopercent;
 RUN;

 *these next two procedures will do the same thing. sex*var1*var2 = sex*(var1 var2);
 PROC FREQ data=lab3.exposure;
    tables sex*hx_smoke*marital_status;
 RUN;

 PROC FREQ data=lab3.exposure;
    tables sex*(hx_smoke marital_status);
 RUN;

 *This variable (diabetes) has a few values missing. This procedure indicates this value at the bottom of the table;
 *SAS does not include the 3 missing values in the calculation (as indicated by the fact that the percentages still add to 100);
 PROC FREQ data=lab3.exposure;
    tables diabetes;
 RUN;

 *This procedure now has the missing people in the calculations, rather than ignoring these people;
 PROC FREQ data=lab3.exposure;
    tables diabetes / missing;
 RUN;

 *This is review from last week;
 PROC UNIVARIATE data=lab3.exposure;
    var age;
    class sex;
 RUN;

 *Use a where statement to pull only certain data; 
    *Quotes required for characters, and these are case sensitive;
    *DO NOT USE QUOTES for numbers;
 PROC UNIVARIATE data=lab3.exposure;
    var age;
    where sex='M';
 RUN;

 PROC FREQ data=lab3.exposure;
    table smoke;
    where chol>190 and sex='M';
 RUN;

 *This will save your working data as a temporary file to mess around with the data;
 *exposure2 is the work library that copies the exposure library;
 DATA work.exposure2;
    set bios500.exposure;
 RUN;
