Cerebellar pitch tracking analysis: ZKA 2014
------------------------------------------------------------

the A files only need to be run once. 

set_params.m is a file where the parameters are set for the entire analysis. each script calls this at the beginning. 


Need to set stdev thresholds to a high number in set_params.m first, and then run A file, B files (patients and HCs separately as they have different thresholds and time windows), C file, D file first. Then run E file which calculates the groups within trial stdevs and spits out values for trials to be excluded on the basis that they lie outside of 2SDs. Enter these values into set_params.m, and then repeat the B, C, D files with these new values. 





we used different time windows for the HCs and the patients as the patients showed a slower response time. these time windows are defined in set_params.m

the B scripts are for artifact removal

the C script sorts the data by condition

the D script calculates stdevs

- Recipe -
A_PerceptualTest_goodtrials 	<- creates /Users/zagnew/Cereb_data/data/SUB.mat
B_fast_diffwindows_Pats		<- creates /Users/zagnew/Cereb_data/data/SUB01/mainexp/speak/gooddata.mat



