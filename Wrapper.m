%% Wrapper script that runs the whole thing from start to finish
% ------
% ZKA 2016
% run this in this order!

clear all
close all
clc

set_params_pitchtracking;

disp('here we go.. ')

calctargets;

RunPeceptTest;

Pert_resp;

WriteDataout; % writes the data out into the format that Goodtrials wants as ALLDATA.mat

Goodtrials_HCs;

Goodtrials_PATs;

Calc_motor_errors;

Outlier_thresholding;

sort_conds;

% Calc_WT_STDEV;
% writes out patient_WTstdev_data.mat
% not really sure what this does..

% NOW: set which subjects to include in set_params_pitchtracking 
% e.g.
% subjects_included= [1 4 5 6 8 10 11 14];
% patients_included=[1 5 8 9 10 12 13 14 15 16];
  

Calc_WT_STDEV_2;
% writes out GroupData.mat, DATA.mat and DATA_TO_USE.mat
% also calculates mean high freq var and WT setdev #results
% group means are calculated from DATA(1). mean_cond1_wholetrial
% why are these 0 normed in a way that the distance values aren't?
% becuase sorted_data(condnn).wholetrial_norm_to_targ
% which comes from gooddata(1).goodpitchdata(each_block).data(trial,:);

Groupanalysis;
% does anovas for WTdev both using indivdual subject data, and on means. 
% runs anovas for high freq var in calc_group_means.m
% calculates mean distance from targ
% plotWTstdev_1;
% plot_mean_WTstd_final_1;
% anova_mean_WTstdev_final_1; % runs anova on individual subject means
% anova_mean_WTstdev_final_2; % runs anova on subject and patient group data
% calc group distance from target and plots that in calcmeandistfromtarg_1;
% Plot_groupdata which includes HFV anova
% anova_distancefrommean;

numtrials; 
% counts number of good trials, and gaps and saves it in GroupData: 
% gapsbysubject,WT_validtrials, WT_validtrials_pre, WT_validtrials_post. 
% #results all behav results!

Plot_groupdata;
% plots group data

Plotsinglesubgraphs;
% plots each subjects data

countgdtrials;

plot_beh_data;

calc_early_late_distfromtarg;

%% finding the results for the paper

% **Wtstdev results**
% *statistics
% Code = Groupanalysis/anova_mean_WTstdev_final_2
% Output = GroupData/stats/ mean_WTstdev_anova.mat

% *Results table
% Groupanalysis/calcmeandata_1
% e.g. GroupMeans.pat_ALLCONDS.pre_pitchWTstdev_clear



%------------------ 
%% **High Freq Var**
% *statistics
% Code = Plot_group_data/calc_group_means.m
% Output:  GroupData/stats/highfreqvar_anova 
 
%% *Results table
% Table output  = calc_group_means
% GroupData/stats/highfreqvar_results_table1
 
%% Distance from target
% Groupanalysis/calc_meandistancefromtarg_1.m
% plots the mean for each subject from 

% GroupData(1).cond(condnn).distfromtarg_WT < 1: 10 is patients, and 10:
% end is HCs

% ZED - look at good data and see how is calcing distance - had an error :/ 




