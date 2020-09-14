
ssc install regsave, replace 

*-- Basic use 
	sysuse auto.dta, clear
	regress price mpg trunk headroom length
	regsave 
 
	list
	
	save basicmodel.dta, replace  
	export excel using "basicmodel.xlsx", firstrow(varlabels) keepcellfmt replace 
 
*-- With multiple models & specifiying output
	* Model 1 
	sysuse auto.dta, clear
	regress price mpg  
	regsave, tstat pval 
	gen model = 1 
	tempfile  m1
	save `m1.dta'

	* Model 2
	sysuse auto.dta, clear
	regress price mpg trunk 
	regsave, tstat pval 
	gen model = 2 
	tempfile  m2
	save `m2.dta'

	* Model 3
	sysuse auto.dta, clear 
	regress price mpg trunk headroom 
	regsave, tstat pval 
	gen model = 3 
	tempfile  m3
	save `m3.dta'

	* Model 4 
	sysuse auto.dta, clear
	regress price mpg trunk headroom length
	regsave, tstat pval 
	gen model = 4
	tempfile  m4
	save `m4.dta'

	* Append & export 
	clear 
	forvalues i = 1/4 {
	append using `m`i'.dta'
	}

	label var model "Model"
	order model 

	save mymodels.dta, replace  
	export excel using "mymodels.xlsx", firstrow(varlabels) keepcellfmt replace 
