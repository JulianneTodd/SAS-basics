libname bios500 "S:\course\bios500\weiss\datasets";

proc contents data=bios500.exposure;
run;
/*This will call the dataset (exposure) in the directory bios500 and give a summary of the variables and data*/

proc print data=bios500.exposure;
  var id height;
run;
/*This will print all rows of the dataset but provide only the info re: variables called (id and height)*/

proc means data=bios500.exposure;
  var height;
run;
/*Proc means will runmean, std dev, min and max values for the entire dataset on the variable assigned*/
/*report mean and std to one more decimal from what was in the original dataset. So if data is to tenth, mean and std would go to the hundredths*/

proc means data=bios500.exposure maxdec=2 n nmiss mean std min q1 median q3 max;
  var height;
run;
/*if you start specifing what you want (ie: max dec, certain variables) the defaults will get overwritten and you'll no longer get the 5 number summary*/
/*max dec will specify the number of decimal places you want in the results viewer*/
/*n nmiss= number of missing observations*/
/*q1/median/q3= quartiles, descriptors*/

proc means data=bios500.exposure maxdec=2 n nmiss mean std min q1 median q3 max;
  var height;
  class sex;
run;
/*class can divide up the data by categorical variables*/
/*mean can work with variables that are continuous*/

proc univariate data=bios500.exposure;
var height;
run;

    /*kertosis -1 -> +1 is close to normal curve*/  
        /*0 is the normal bell curve*/  
        /*negative kertosis is flatter*/  
        /*postitive kertosis is pointed*/  
    /*skewness is a thing... negative will have a tail to the left; positive will have a tail to the right*/  
proc univariate data=bios500.exposure plot;
var height;
run;

proc univariate data=bios500.exposure plot;
  var height;
  histogram height / normal;
run;

/*if you have a var listed for histogram command, the same variable must be included in a var statement*/
/* "/ normal" will overlay a normal curve over the histogram we are asking for. The "/" adds a divide between the variables and the options*/

proc univariate data=bios500.exposure plot;
  var height;
  class sex;
  histogram height / normal;
run;

/*this will allow multiple histograms to be generated based on the class variable (gender in this case)*/  
proc univariate data=bios500.exposure;
  var weight;
  class sex;
  histogram weight;
  inset mean;
run;

/*This will do the same procedure with weight instead of height and "inset mean" line will add the mean of the data on the histogram*/  
/*Inset statement can include variables besides mean, such as range, skewness, etc. (descriptor variables)*/  
proc sgplot data=bios500.exposure;
  vbox height;
run;

/*vbox will give us vertical box plots.*/  
PROC SGPLOT data=bios500.exposure;
  vbox height / category=sex;
run;

/*class must be used for histograms, not category*/  
/*category must be used with boxplots, class will not work.*/  
PROC SGPLOT data=bios500.exposure;
  vbox height / group=sex;
run;

/*group will give you the same thing as category, but with boxplots*/ 
