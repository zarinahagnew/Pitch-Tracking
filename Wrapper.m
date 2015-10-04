%% Wrapper script that runs the whole thing from start to finish

% ------
% ZKA 2015
% run this in this order!

clear all
close all
clc

set_params_pitchtracking;

disp('here we go.. ')

calctargets;

RunPeceptTest;

Pert_resp;

WriteDataout;

Outlier_thresholding;

Calc_motor_errors

Goodtrials_HCs;

Goodtrials_PATs;

Groupanalysis;

Plot_groupdata;

Plotsinglesubgraphs;



B_fast;
disp('good trials done!')

C_sort_conds;
disp('conditions sorted!')

D_calc_WT_stdev;
disp('WT variability calculated')

G_plot_groupdata;
disp('plotting group data, wait for the pause')
pause
F_groupanalysis;
disp('and the anova..')