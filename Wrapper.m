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

Calc_WT_STDEV;
% writes out patient_WTstdev_data.mat

Calc_WT_STDEV_2;
% writes out GroupData.mat

Groupanalysis;


Plot_groupdata;
% plots group data

Plotsinglesubgraphs;
% plots each subjects data

countgdtrials;
