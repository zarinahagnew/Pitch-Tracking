%% pitch pert cerebellar re-analysis 2015

% Notes on pert.resp
% gp.precereb.patient_dat.pert_resp(isubj).cents4comp(1).pitch_in.dat{1}
% pitch_in.dat{1} - response to down pert
% pitch_in.dat{2} response to up pert
% pitch_in.dat{3} respone to all but *it's not flipped*
% to flip it use: 
% centsdev_dat.(group{igroup}).subj(isubj).absdat = {-the_dat{1} the_dat{2} [-the_dat{1}; the_dat{2}]};
% lab code is saved locally in 
% /home/zagnew/matlab/runpitchpertanalysis.m

% data is in 
% /data/bil-mb4/zarinah-data/cerebellar-data/pitch-pert-ataxia

% once data is analysed use plot_data

cd /data/bil-mb4/zarinah-data/cerebellar-data/pitch-pert-ataxia

load /data/bil-mb4/zarinah-data/cerebellar-data/pitch-pert-ataxia/controls/control.mat
load /data/bil-mb4/zarinah-data/cerebellar-data/pitch-pert-ataxia/controls/patient.mat

% /home/zagnew/data_analysis_code/pitch_pert_stats/plot_data_z.m

plot_data_z
