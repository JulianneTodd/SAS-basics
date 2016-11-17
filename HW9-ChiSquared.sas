LIBNAME hw9 'S:\course\BIOS500\WEISS\DATASETS';

PROC FORMAT;
	VALUE yesnof 0="No" 1="Yes";
RUN;

PROC FREQ DATA=hw9.exposure;
	FORMAT smoke yesnof.;
	TABLES sex*smoke / EXPECTED CHISQ;
RUN;

PROC FREQ DATA=hw9.exposure;
	FORMAT smoke hx_smoke yesnof.;
	TABLES smoke*hx_smoke / EXPECTED CHISQ;
RUN;


PROC FORMAT;
	VALUE yesnof 0="No" 1="Yes";
	VALUE ismarriedf 0="unmarried" 1="married";
RUN;

PROC FREQ DATA=hw9.exposure;
	FORMAT smoke yesnof.;
	FORMAT marital_status ismarriedf.;
	TABLES marital_status*smoke / EXPECTED CHISQ RELRISK;
RUN;

*The risk of smoking in those who are unmarried is 0.6467x the risk of smoking in those who are married.

Since the confidence interval does not contain 1 (95% CI: 0.5282 - 0.7919), the risk of smoking is significantly different 
depending on an individual's marital status (at alpha=0.05).
We therefore concluded that in this population there is no association between respiratory illness and lung cancer.
Of course, this is the identical conclusion drawn from the chi-squared p-value, but by calculating the RR and its confidence 
interval we have an estimate of the size of any effect, not just the statistical significance
