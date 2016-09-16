LIBNAME hw 'S:\course\bios500\Weiss\Datasets';

PROC CONTENTS DATA=hw.healthy_doc;
Run;

PROC PRINT Data=hw.healthy_doc;
Run;

PROC PRINT Data=hw.healthy_doc (Obs=97);
  Var age;
Run;

Data work.one;
  set hw.healthy_doc;
Run;
