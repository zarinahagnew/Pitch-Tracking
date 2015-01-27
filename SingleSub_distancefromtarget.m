clear all
close all
set_params;

cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
cd(cerebellar_data_rootdir)
load DATA.mat
load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/SubjectShiftsAllSubs

%subject 27
figure
subplot(5,2,1)
plot(DATA(27).mean_cond1_wholetrial, 'k')
hold on
temp=ones(1, stepframe);
temp=temp*shiftinhertz_allsubs(27).nostep;
temp2=[NaN(1, stepframe) ones(1,1400-stepframe)];
temp2=temp2*shiftinhertz_allsubs(27).smallstepup;
targ=[temp temp2]
plot(temp, 'r')
plot(temp2, 'r')
axis([1 1400 110 160])

subplot(5,2,3)
plot(DATA(27).mean_cond2_wholetrial, 'k')
hold on
temp=ones(1, stepframe);
temp=temp*shiftinhertz_allsubs(27).nostep;
temp2=[NaN(1, stepframe) ones(1,1400-stepframe)];
temp2=temp2*shiftinhertz_allsubs(27).bigstepup;
targ=[temp temp2]
plot(temp, 'r')
plot(temp2, 'r')
axis([1 1400 110 160])
