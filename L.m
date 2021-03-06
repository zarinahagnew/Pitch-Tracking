% this script takes low pass filters each trial and compares the distance between the raw pitch track and the filtered data.
% it then calculates the stdev of that difference


%% ZKA Jan 2015
clear all
close all

set_params;
cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
cd(cerebellar_data_rootdir)
%load DATA.mat % from
load GROUPDATA

%group_cond1_pats_to_use_mean
trialdata_pats(1,:)=group_cond1_pats_to_use_mean(250:1300);
trialdata_pats(2,:)=group_cond2_pats_to_use_mean(250:1300);
trialdata_pats(3,:)=group_cond3_pats_to_use_mean(250:1300);
trialdata_pats(4,:)=group_cond4_pats_to_use_mean(250:1300);
trialdata_pats(5,:)=group_cond5_pats_to_use_mean(250:1300);
trialdata_pats(6,:)=group_cond6_pats_to_use_mean(250:1300);
trialdata_pats(7,:)=group_cond7_pats_to_use_mean(250:1300);
trialdata_pats(8,:)=group_cond8_pats_to_use_mean(250:1300);
trialdata_pats(9,:)=group_cond9_pats_to_use_mean(250:1300);
trialdata_pats(10,:)=group_cond10_pats_to_use_mean(250:1300);
trialdata_pats(1,:)=group_cond1_HCs_to_use_mean(250:1300);
trialdata_HCs(2,:)=group_cond2_HCs_to_use_mean(250:1300);
trialdata_HCs(3,:)=group_cond3_HCs_to_use_mean(250:1300);
trialdata_HCs(4,:)=group_cond4_HCs_to_use_mean(250:1300);
trialdata_HCs(5,:)=group_cond5_HCs_to_use_mean(250:1300);
trialdata_HCs(6,:)=group_cond6_HCs_to_use_mean(250:1300);
trialdata_HCs(7,:)=group_cond7_HCs_to_use_mean(250:1300);
trialdata_HCs(8,:)=group_cond8_HCs_to_use_mean(250:1300);
trialdata_HCs(9,:)=group_cond9_HCs_to_use_mean(250:1300);
trialdata_HCs(10,:)=group_cond10_HCs_to_use_mean(250:1300);

% calculate smoothed and filtered versions
for icond=1:10
    PATs(icond,:).smoothedtrialdata=smooth_line(trialdata_pats(icond,:), 20);
    PATs(icond,:).lowpassdata=lowpass(trialdata_pats(icond,:), 0.01, 3);
    HCs(icond,:).smoothedtrialdata=smooth_line(trialdata_HCs(icond,:), 20);
    HCs(icond,:).lowpassdata=lowpass(trialdata_HCs(icond,:), 0.01, 3);
    
    PATs(icond).smoothed_diff=calc_distance(trialdata_pats(icond,:), PATs(icond,:).smoothedtrialdata);
    PATs(icond).filtered_diff=calc_distance(trialdata_pats(icond,:), PATs(icond,:).lowpassdata);    
    HCs(icond).smoothed_diff=calc_distance(trialdata_HCs(icond,:), HCs(icond,:).smoothedtrialdata);
    HCs(icond).filtered_diff=calc_distance(trialdata_HCs(icond,:), HCs(icond,:).lowpassdata);    
end














%% %% run anova on subject means

%DATA(isub).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt
for isub=1:27
sub(isub).clear_std=[...
nanstd(DATA(isub).distfromlowasspass.sorted_data(1).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(2).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(3).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(4).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(5).goodpitchdata_difflowpassfilt)];

sub(isub).noise_std=[...
nanstd(DATA(isub).distfromlowasspass.sorted_data(6).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(7).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(8).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(9).goodpitchdata_difflowpassfilt) ...
nanstd(DATA(isub).distfromlowasspass.sorted_data(10).goodpitchdata_difflowpassfilt)];
end

anovadata_stdev=[ ...
            sub(1).clear_std sub(2).clear_std sub(3).clear_std ...
            sub(4).clear_std sub(5).clear_std sub(6).clear_std ...
            sub(7).clear_std sub(8).clear_std sub(9).clear_std ...
            sub(10).clear_std sub(11).clear_std sub(12).clear_std ...
            sub(13).clear_std sub(14).clear_std sub(15).clear_std ...
            sub(16).clear_std sub(17).clear_std sub(18).clear_std ...
            sub(19).clear_std sub(20).clear_std sub(21).clear_std ...
            sub(22).clear_std sub(23).clear_std sub(24).clear_std ...
            sub(25).clear_std sub(26).clear_std sub(27).clear_std ...
            sub(1).noise_std sub(2).noise_std sub(3).noise_std ...
            sub(4).noise_std sub(5).noise_std sub(6).noise_std ...
            sub(7).noise_std sub(8).noise_std sub(9).noise_std ...
            sub(10).noise_std sub(11).noise_std sub(12).noise_std ...
            sub(13).noise_std sub(14).noise_std sub(15).noise_std ...
            sub(16).noise_std sub(17).noise_std sub(18).noise_std ...
            sub(19).noise_std sub(20).noise_std sub(21).noise_std ...
            sub(22).noise_std sub(23).noise_std sub(24).noise_std ...
            sub(25).noise_std sub(26).noise_std sub(27).noise_std];
        
        
% length(anovadata)  202770      

test=ones(1,60080);
test2=ones(1,41305);
test2=test2*2;
subjectgroup=[test test2 test test2];
%subjects = [1 2 3 4 5 6 7 8]; % Assuming that subjects 1-4 were in group 1 and 5-8 were in group 2

%create condition group
condition = cell(1,202770);
for i=1:101385
    condition{i}='clear';
end
for i=101386:101385*2
    condition{i}='noise';
end
condition=condition';

group1=[subjectgroup];
group2=[condition];
p = anovan(anovadata_stdev,{group1 group2},'model','interaction')

        
        
        
        


%% old





%create matrix for plotting mean disntance from smooth line and plot that
%as bar graph
fig2=figure;
ymin=-25;
ymax=25;
for icond=1:10
    cond(icond,:)=[mean(PATs(icond).filtered_diff); mean(HCs(icond).filtered_diff)];
    errY2(icond,:) = [std(PATs(icond).filtered_diff)/sqrt(numpats); std(HCs(icond).filtered_diff)/sqrt(numHCs)];
    subplot(2,5, icond)
    h(icond) = barwitherr(errY2(icond,:), cond(icond,:));% Plot with errorbars
    set(gca,'XTickLabel',{'Patients','HCs'})
    ylabel('distance from lowpass filtered')
    if icond==1|3|5|7|9
    set(h(icond),'FaceColor','k');
    else
    set(h(icond),'FaceColor','w');
    end
    title(sprintf('Condition'));
    axis([0 3 ymin ymax])
end

saveas(fig2, 'GroupData/MeanDistancefromFiltered_bar.jpg')



% stdev
fig2=figure;
ymin=0;
ymax=50;
for icond=1:10
    cond(icond,:)=[std(PATs(icond).filtered_diff); std(HCs(icond).filtered_diff)];
    
    
    
    errY2(icond,:) = [std(PATs(icond).filtered_diff)/sqrt(numpats); std(HCs(icond).filtered_diff)/sqrt(numHCs)];
    subplot(2,5, icond)
    h(icond) = barwitherr(errY2(icond,:), cond(icond,:));% Plot with errorbars
    set(gca,'XTickLabel',{'Patients','HCs'})
    ylabel('distance from lowpass filtered')
    if icond==1|3|5|7|9
    set(h(icond),'FaceColor','k');
    else
    set(h(icond),'FaceColor','w');
    end
    title(sprintf('Condition'));
    axis([0 3 ymin ymax])
end

saveas(fig2, 'GroupData/stdDistancefromFiltered_bar.jpg')









% stats
anovandata=[PATs(1).filtered_diff PATs(2).filtered_diff PATs(3).filtered_diff ...
    PATs(4).filtered_diff PATs(5).filtered_diff PATs(6).filtered_diff ...
    PATs(7).filtered_diff PATs(8).filtered_diff PATs(9).filtered_diff ...
    PATs(10).filtered_diff HCs(1).filtered_diff HCs(2).filtered_diff ...
    HCs(3).filtered_diff HCs(4).filtered_diff HCs(5).filtered_diff ...
    HCs(6).filtered_diff HCs(7).filtered_diff HCs(8).filtered_diff ...
    HCs(9).filtered_diff HCs(10).filtered_diff];

%create subject group
test=ones(1,10510);
test2=test*2;
subjectgroup=[test test2];

subjects = [1 :27 cooper]; % Assuming that subjects 1-4 were in group 1 and 5-8 were in group 2


%create condition group
cond_length=length(PATs(1).filtered_diff)*5;
condition = cell(1,length(PATs(1).filtered_diff)*20);
for i=1:cond_length
    condition{i}='clear';
end
for i=cond_length+1:cond_length*2
    condition{i}='noise';
end
for i=cond_length*2+1:cond_length*3
    condition{i}='clear';
end
for i=cond_length*3+1:cond_length*4
    condition{i}='noise';
end
condition=condition';

group1=[subjectgroup];
group2=[condition];
p = anovan(anovandata,{group1 group2},'model','interaction')
% p = anovan(test,{group1 group2 group3},'model','interaction')
% p = anovan(anovandata,{group1 group2 group3}, 1)
% p = anovan(anovandata,{group1 group2 group3}, 'full')

% ttests
pat_clear=[PATs(1).filtered_diff PATs(2).filtered_diff PATs(3).filtered_diff ...
    PATs(4).filtered_diff PATs(5).filtered_diff];
pat_noise=[PATs(6).filtered_diff ...
    PATs(7).filtered_diff PATs(8).filtered_diff PATs(9).filtered_diff ...
    PATs(10).filtered_diff];
HC_clear=[HCs(1).filtered_diff HCs(2).filtered_diff HCs(3).filtered_diff ...
    HCs(4).filtered_diff HCs(5).filtered_diff];
HC_noise=[HCs(6).filtered_diff ...
    HCs(7).filtered_diff HCs(8).filtered_diff HCs(9).filtered_diff ...
    HCs(10).filtered_diff];

ttest(HC_clear, HC_noise)
ttest(pat_clear, pat_noise)

ttest2(HC_clear, pat_clear)
ttest2(HC_noise, pat_noise)

fig3=figure;
ymin=0;
ymax=50;

cond=[std(HC_clear),std(pat_clear);std(HC_noise), std(pat_noise)];
errY2=[std(HC_clear)/numsubs,std(pat_clear)/numpats;std(HC_noise)/numsubs, std(pat_noise)/numpats]

h = barwitherr(errY2, cond);% Plot with errorbars
set(gca,'XTickLabel',{'Clear','Noise'})
ylabel('distance from lowpass filtered (cents)')
set(h(1),'FaceColor','k');
set(h(2),'FaceColor','w');
title(sprintf('Wobble in clear and noise trials for all groups'));
axis([0 3 ymin ymax])

saveas(fig3, 'GroupData/stdDistancefromFiltered_bar_allconds.jpg')






