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

WriteDataout; % writes the data out into the format that Goodtrials wants as ALLDATA.mat

Outlier_thresholding;

Calc_motor_errors

Goodtrials_HCs;

Goodtrials_PATs;

sort_conds;

% Calc_WT_STDEV;
% writes out patient_WTstdev_data.mat
% not really sure what this does..

Calc_WT_STDEV_2;
% writes out GroupData.mat, DATA.mat and DATA_TO_USE.mat

%note to self - work out what these two do differently??

Groupanalysis;


Plot_groupdata;
% plots group data

Plotsinglesubgraphs;
% plots each subjects data

countgdtrials;
