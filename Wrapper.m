% wrapper script that runs the whole thing from start to finish

clear all
close all
set_params;

disp('here we go.. ')

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