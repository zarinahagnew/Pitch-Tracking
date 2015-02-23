%% Calc mean distance from low pass filtered for each trial from sorted_data.m
% Takes sorted data and calculates the distance from the low pass filtered version
% ZKA Feb 2015

close all
clear all
set_params;

cd(cerebellar_data_rootdir);

npatients = 0;
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB01/expr2014.03.21.T10.46.03_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB02/expr2014.03.21.T12.33.58_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB03/expr2014.03.21.T14.35.35_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB04/expr2014.03.21.T17.20.11_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB05/expr2014.03.21.T18.50.52_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB06/expr2014.03.22.T11.05.45_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB07/expr2014.03.22.T12.15.42_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB08/expr2014.03.22.T14.01.48_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB09/expr2014.03.22.T15.52.01_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB10/expr2014.03.22.T16.37.44_mainrun/speak/';
npatients = npatients+ 1;
patient_info{npatients}.exprdir = 'SUB11/expr2014.03.22.T18.46.44_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB12/expr2014.03.23.T11.03.52_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB13/expr2014.03.23.T13.47.01_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB14/expr2014.03.23.T15.21.00_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB15/expr2014.03.23.T16.32.53_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB16/expr2014.03.23.T18.16.58_mainrun/speak/';

% % HCS
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC01/expr2014.05.06.T12.36.43_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC02/expr2014.06.17.T12.53.53_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC03/expr2014.06.17.T13.50.36_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC04/expr2014.06.17.T16.22.20_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC05/expr2014.06.18.T15.14.02_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC06/expr2014.06.18.T16.18.27_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC07/expr2014.07.25.T10.29.55_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC08/expr2014.08.14.T15.57.52_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC09/expr2014.09.21.T14.17.36_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC10/expr2014.09.21.T15.35.54_JL_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC11/expr2014.09.23.t15.27.32_sn_mainrun/speak/';

for isubj = 1:npatients
    the_expr_dir = [cerebellar_data_rootdir (patient_info{isubj}.exprdir)];
    cd (the_expr_dir);
    cd block0
    pitchdata=get_vec_hist6('pitch2',3);                                    %two arguments are file name and then file type (float vec)
    block=get_vec_hist6('blockalt',3);                                      %pert response (needs to be shifted in time as only begins in response to voice onsett detect
    voiceonset=get_vec_hist6('voice_onset_detect',2);                       %voice detect
    outbuff_wav=get_vec_hist6('outbuffer', 3);                              % playable waveform
    outbuff_pitch=get_vec_hist6('output_pitch', 3);                         % pich of outbuffer is the target
    amp=get_vec_hist6('weighted_mean_abs_inbuffer2', 3);
    audio=get_vec_hist6('inbuffer2',3);
    
    % sort out x axis
    samples2get = length(pitchdata.data(2,:));
    fs = 11025;
    framef = fs/32;
    nframes_per_trial = pitchdata.nvecs;
    taxis = (0:(samples2get-1))/fs;
    frame_taxis = (0:(nframes_per_trial-1))/framef;
    cd (the_expr_dir);

    % writes all data into one structure called 'DATA'
    DATA(isubj).distfromlowasspass= load (sprintf('%ssorted_data.mat',patient_info{isubj}.exprdir));  
end

%% put all data into one matrix
for cond=1:10
Pat_data_distlowpass(cond).data=vertcat( ...
    DATA(1).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(2).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(3).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(4).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(5).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(6).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(7).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(8).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(9).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(10).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(11).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(12).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(13).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(14).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(15).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(16).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);

HC_data_distlowpass(cond).data=vertcat( ...
    DATA(17).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(18).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(19).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(20).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(21).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(22).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(23).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(24).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(25).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(26).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt, ...
    DATA(27).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);

end

%% caluclate how many are all nan trials
HC_alltrials_clear=vertcat(...
    HC_data_distlowpass(1).data, HC_data_distlowpass(2).data, HC_data_distlowpass(3).data, HC_data_distlowpass(4).data, ...
    HC_data_distlowpass(5).data);

HC_alltrials_noise=vertcat(...
    HC_data_distlowpass(6).data, HC_data_distlowpass(7).data, HC_data_distlowpass(8).data, ...
    HC_data_distlowpass(9).data, HC_data_distlowpass(9).data, HC_data_distlowpass(10).data);

PAT_alltrials_clear=vertcat(...
    Pat_data_distlowpass(1).data, Pat_data_distlowpass(2).data, Pat_data_distlowpass(3).data, Pat_data_distlowpass(4).data, ...
    Pat_data_distlowpass(5).data);

PAT_alltrials_noise=vertcat(...
    Pat_data_distlowpass(6).data, Pat_data_distlowpass(7).data, Pat_data_distlowpass(8).data, ...
    Pat_data_distlowpass(9).data, Pat_data_distlowpass(9).data, Pat_data_distlowpass(10).data);

%%
pat_clear_goodtrial_counter=0;
for itrial=1:640
    if sum(isnan(PAT_alltrials_clear(itrial,:)))<750
        pat_clear_goodtrial_counter=pat_clear_goodtrial_counter+1;
    end
end
fraction_gd_pats_clear=(pat_clear_goodtrial_counter/640)*100
goodtrials_pat_clear=pat_clear_goodtrial_counter % use this as N for SEM


pat_noise_goodtrial_counter=0;
for itrial=1:768
    if sum(isnan(PAT_alltrials_noise(itrial,:)))<750
        pat_noise_goodtrial_counter=pat_noise_goodtrial_counter+1;
    end
end
fraction_gd_pats_noise=(pat_noise_goodtrial_counter/768)*100
goodtrials_pat_noise=pat_noise_goodtrial_counter % use this as N for SEM

HC_clear_goodtrial_counter=0;
for itrial=1:440
    if sum(isnan(HC_alltrials_clear(itrial,:)))<750
        HC_clear_goodtrial_counter=HC_clear_goodtrial_counter+1;
    end
end
fraction_gd_HCs_clear=(HC_clear_goodtrial_counter/440)*100
goodtrials_HC_clear=HC_clear_goodtrial_counter % use this as N for SEM


HC_noise_goodtrial_counter=0;
for itrial=1:528
    if sum(isnan(HC_alltrials_noise(itrial,:)))<750
        HC_noise_goodtrial_counter=HC_noise_goodtrial_counter+1;
    end
end
fraction_gd_HCs_noise=(HC_noise_goodtrial_counter/528)*100
goodtrials_HC_noise=HC_noise_goodtrial_counter % use this as N for SEM


















%% ACROSS trial mean and stdev
for isubj=1:16
    for cond=1:10
        PAT_subjmean(isubj).data(cond,:)=nanmean(DATA(isubj).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);
        PAT_subjstdev(isubj).data(cond,:)=nanstd(DATA(isubj).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);
    end
end
for isub=1:11
    for cond=1:10
        HC_subjmean(isubj).data(cond,:)=nanmean(DATA(isub+16).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);
        HC_subjstdev(isubj).data(cond,:)=nanstd(DATA(isub+16).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);
    end
end

%% *WT* trial mean and stdev
% ZED - need to add subject number in here
for ipat=1:16
    for icond=1:10
        for itrial=1:8
            PAT_WT_STD_var(ipat).data(icond).data(itrial)=nanstd(DATA(ipat).distfromlowasspass(1).sorted_data(icond).goodpitchdata_difflowpassfilt(itrial,:))
        end
    end
end

for isub=1:11
    for icond=1:10
        for itrial=1:8
            HC_WT_STD_var(isub).data(icond).data(itrial)=nanstd(DATA(isub+16).distfromlowasspass(1).sorted_data(icond).goodpitchdata_difflowpassfilt(itrial,:))
        end
    end
end

for icond=1:5
PatGp_WTstddev_clear(icond,:)=horzcat(...
    PAT_WT_STD_var(1).data(icond).data, PAT_WT_STD_var(2).data(icond).data, ...
    PAT_WT_STD_var(3).data(icond).data, PAT_WT_STD_var(4).data(icond).data, ...
    PAT_WT_STD_var(5).data(icond).data, PAT_WT_STD_var(6).data(icond).data, ...
    PAT_WT_STD_var(7).data(icond).data, PAT_WT_STD_var(8).data(icond).data, ...
    PAT_WT_STD_var(9).data(icond).data, PAT_WT_STD_var(10).data(icond).data, ...
    PAT_WT_STD_var(11).data(icond).data, PAT_WT_STD_var(12).data(icond).data, ...
    PAT_WT_STD_var(13).data(icond).data, PAT_WT_STD_var(14).data(icond).data, ...
    PAT_WT_STD_var(15).data(icond).data, PAT_WT_STD_var(16).data(icond).data);
end

PatGp_WTstddev_clear_horz=horzcat(...
    PatGp_WTstddev_clear(1,:), PatGp_WTstddev_clear (2,:), ...
    PatGp_WTstddev_clear(3,:), PatGp_WTstddev_clear (4,:), ...
    PatGp_WTstddev_clear(5,:));

for icond=1:5
PatGp_WTstddev_noise(icond,:)=horzcat(...
    PAT_WT_STD_var(1).data(icond+5).data, PAT_WT_STD_var(2).data(icond+5).data, ...
    PAT_WT_STD_var(3).data(icond+5).data, PAT_WT_STD_var(4).data(icond+5).data, ...
    PAT_WT_STD_var(5).data(icond+5).data, PAT_WT_STD_var(6).data(icond+5).data, ...
    PAT_WT_STD_var(7).data(icond+5).data, PAT_WT_STD_var(8).data(icond+5).data, ...
    PAT_WT_STD_var(9).data(icond+5).data, PAT_WT_STD_var(10).data(icond+5).data, ...
    PAT_WT_STD_var(11).data(icond+5).data, PAT_WT_STD_var(12).data(icond+5).data, ...
    PAT_WT_STD_var(13).data(icond+5).data, PAT_WT_STD_var(14).data(icond+5).data, ...
    PAT_WT_STD_var(15).data(icond+5).data, PAT_WT_STD_var(16).data(icond+5).data);
end
PatGp_WTstddev_noise_horz=horzcat(...
    PatGp_WTstddev_noise(1,:), PatGp_WTstddev_noise (2,:), ...
    PatGp_WTstddev_noise(3,:), PatGp_WTstddev_noise (4,:), ...
    PatGp_WTstddev_noise(5,:));

for icond=1:5
HCGp_WTstddev_clear(icond,:)=horzcat(...
    HC_WT_STD_var(1).data(icond).data, HC_WT_STD_var(2).data(icond).data, ...
    HC_WT_STD_var(3).data(icond).data, HC_WT_STD_var(4).data(icond).data, ...
    HC_WT_STD_var(5).data(icond).data, HC_WT_STD_var(6).data(icond).data, ...
    HC_WT_STD_var(7).data(icond).data, HC_WT_STD_var(8).data(icond).data, ...
    HC_WT_STD_var(9).data(icond).data, HC_WT_STD_var(10).data(icond).data, ...
    HC_WT_STD_var(11).data(icond).data);
end

HCGp_WTstddev_clear_horz=horzcat(...
    HCGp_WTstddev_clear(1,:), HCGp_WTstddev_clear (2,:), ...
    HCGp_WTstddev_clear(3,:), HCGp_WTstddev_clear (4,:), ...
    HCGp_WTstddev_clear(5,:));

for icond=1:5
HCGp_WTstddev_noise(icond,:)=horzcat(...
    HC_WT_STD_var(1).data(icond+5).data, HC_WT_STD_var(2).data(icond+5).data, ...
    HC_WT_STD_var(3).data(icond+5).data, HC_WT_STD_var(4).data(icond+5).data, ...
    HC_WT_STD_var(5).data(icond+5).data, HC_WT_STD_var(6).data(icond+5).data, ...
    HC_WT_STD_var(7).data(icond+5).data, HC_WT_STD_var(8).data(icond+5).data, ...
    HC_WT_STD_var(9).data(icond+5).data, HC_WT_STD_var(10).data(icond+5).data, ...
    HC_WT_STD_var(11).data(icond+5).data);
end

HCGp_WTstddev_noise_horz=horzcat(...
    HCGp_WTstddev_noise(1,:), HCGp_WTstddev_noise (2,:), ...
    HCGp_WTstddev_noise(3,:), HCGp_WTstddev_noise (4,:), ...
    HCGp_WTstddev_noise(5,:));


%% anova
anova_data_WTstdev=[HCGp_WTstddev_clear_horz, HCGp_WTstddev_noise_horz, PatGp_WTstddev_clear_horz, PatGp_WTstddev_noise_horz]

%create subject group
test=ones(1,880);
test2=ones(1,1280);
test2=test2*2;
subjectgroup=[test test2];

%create condition group
condition = cell(1,2160);
for i=1:440
    condition{i}='clear';
end
for i=441:880
    condition{i}='noise';
end
for i=881:1520
    condition{i}='clear';
end
for i=1521:2160
    condition{i}='noise';
end
condition=condition';

group1=[subjectgroup];
group2=[condition];
% sub_fact=horzcat(...
%     sub(1, :),sub(2, :),sub(3, :),sub(4, :),sub(5, :),sub(6, :),sub(7, :), ...
%     sub(8, :),sub(9, :),sub(10, :),sub(11, :),sub(12, :),sub(13, :),sub(14, :), ...
%     sub(15, :),sub(16, :),sub(17, :),sub(18, :),sub(19, :),sub(20, :),sub(21, :), ...    
%     sub(22, :),sub(23, :),sub(24, :),sub(25, :),sub(26, :),sub(27, :));

% p= anovan(anova_data_WTstdev,{group1 group2},'model','interaction')
[pvals,tbl,stats] = anovan(anova_data_WTstdev,{group1 group2},'random',1, 'model','interaction','varnames',{'subjectgroup' 'condition'});
[pvals,tbl,stats] = anovan(anova_data_WTstdev,{group1 group2}, 'model','interaction','varnames',{'subjectgroup' 'condition'});

%% ttests
ttest(HCGp_WTstddev_clear_horz, HCGp_WTstddev_noise_horz)
ttest(PatGp_WTstddev_clear_horz, PatGp_WTstddev_noise_horz)
ttest2(HCGp_WTstddev_clear_horz, PatGp_WTstddev_clear_horz)
ttest2(HCGp_WTstddev_noise_horz, PatGp_WTstddev_noise_horz)

%plot this:
figure
y_pitch2=[nanmean(HCGp_WTstddev_clear_horz) nanmean(HCGp_WTstddev_noise_horz); ...
          nanmean(PatGp_WTstddev_clear_horz) nanmean(PatGp_WTstddev_noise_horz)]
errY2 = [nanstd(HCGp_WTstddev_clear_horz)/sqrt(goodtrials_HC_clear) nanstd(HCGp_WTstddev_noise_horz)/sqrt(goodtrials_HC_noise); ...
          nanstd(PatGp_WTstddev_clear_horz)/sqrt(goodtrials_pat_clear) nanstd(PatGp_WTstddev_noise_horz)/sqrt(goodtrials_pat_noise)]            
h = barwitherr(errY2, y_pitch2);% Plot with errorbars
set(gca,'XTickLabel',{'HCs','Patients'})
ylabel('mean stdev of distance from low pass filt')
set(h(1),'FaceColor','k');
set(h(2),'FaceColor','w');
title(sprintf('Group mean variability in pitch tracking'));
axis([0 3 0 35])
legend('clear', 'noise')
goodplot
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/meanstdvaribility.pdf');


HC_WT_STD_var(1).data(1).data
HCGp_WTstddev_clear_horz(1:8)





%% all conditions separately
% calulate and plot means - all conditions separately
for cond=1:10
    Pats_groupmean(cond).data=nanmean(Pat_data_distlowpass(cond).data);
    Pats_groupstd(cond).data=nanstd(Pat_data_distlowpass(cond).data);
    Pats_groupSEM(cond).data=Pats_groupstd(cond).data/sqrt(goodtrials_pat)
    Pats_groupSEM_forplot_pos(cond).data=Pats_groupmean(cond).data+Pats_groupSEM(cond).data
    Pats_groupSEM_forplot_neg(cond).data=Pats_groupmean(cond).data-Pats_groupSEM(cond).data
    
    HCs_groupmean(cond).data=nanmean(HC_data_distlowpass(cond).data);
    HCs_groupstd(cond).data=nanstd(HC_data_distlowpass(cond).data);
    HCs_groupSEM(cond).data=HCs_groupstd(cond).data/sqrt(goodtrials_HC);
    HCs_groupSEM_forplot_pos(cond).data=HCs_groupmean(cond).data+HCs_groupSEM(cond).data
    HCs_groupSEM_forplot_neg(cond).data=HCs_groupmean(cond).data-HCs_groupSEM(cond).data
end

% plot with SEM also
figure
for cond=1:10
    subplot(2,5, cond)
    plot(frame_taxis_to_use(1:751), Pats_groupSEM_forplot_pos(cond).data,'k', 'LineWidth',0.5)
    hold on
    plot(frame_taxis_to_use(1:751), Pats_groupSEM_forplot_pos(cond).data,'k', 'LineWidth',0.5)
    plot(frame_taxis_to_use(1:751), Pats_groupmean(cond).data, ...
        'b','LineWidth',1,'Color',[patient_colour]);
    axis([0 3 -20 20])
    goodplot_wide
end

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Fig4e.pdf');


figure
for cond=1:10
    subplot(2,5, cond)
    plot(frame_taxis_to_use(1:751), HCs_groupSEM_forplot_pos(cond).data,'k', 'LineWidth',0.5)
    hold on
    plot(frame_taxis_to_use(1:751), HCs_groupSEM_forplot_pos(cond).data,'k', 'LineWidth',0.5)
    plot(frame_taxis_to_use(1:751), HCs_groupmean(cond).data, ...
        'b','LineWidth',1,'Color',[HC_colour]);
    axis([0 3 -20 20])
    goodplot_wide
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Fig4f.pdf');

% plot patients and HCs on same graph
figure
for cond=1:10
subplot(2,5, cond)
plot(frame_taxis_to_use(1:751), HCs_groupmean(cond).data, ...
    'b','LineWidth',1,'Color',[HC_colour]);
%    'b','LineWidth',1,'Color',[HC_colour],'LineStyle','--');
hold
plot(frame_taxis_to_use(1:751), HCs_groupmean(cond).data, ...
    'b','LineWidth',1,'Color',[HC_colour]);

ylabel('Variability (cents)');
xlabel('Time (seconds)');
axis([0 2.5 -100 50])
goodplot_wide
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Fig4a.pdf');









figure
for cond=1:10
subplot(2,5, cond)
plot(frame_taxis_to_use(1:751), Pats_groupstd(cond).data,'b','LineWidth',1,'Color',[patient_colour]);
hold on
plot(frame_taxis_to_use(1:751), HCs_groupstd(cond).data, 'b','LineWidth',1,'Color',[HC_colour]);
ylabel('Variability (cents)');
xlabel('Time (seconds)');
axis([0 2.5 -50 200])
goodplot_wide
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Fig4b.pdf');

% reshape data for anova
%horzcat(Pat_data_distlowpass(cond).data(1,:)

anovadata_pats_cond1=Pat_data_distlowpass(1).data(1,:);
anovadata_pats_cond2=Pat_data_distlowpass(2).data(1,:);
anovadata_pats_cond3=Pat_data_distlowpass(3).data(1,:);
anovadata_pats_cond4=Pat_data_distlowpass(4).data(1,:);
anovadata_pats_cond5=Pat_data_distlowpass(5).data(1,:);
anovadata_pats_cond6=Pat_data_distlowpass(6).data(1,:);
anovadata_pats_cond7=Pat_data_distlowpass(7).data(1,:);
anovadata_pats_cond8=Pat_data_distlowpass(8).data(1,:);
anovadata_pats_cond9=Pat_data_distlowpass(9).data(1,:);
anovadata_pats_cond10=Pat_data_distlowpass(10).data(1,:);

for i = 2:16 %length(patients_included)
        dataToAppend_cond1 = Pat_data_distlowpass(1).data(i,:);
        dataToAppend_cond2 = Pat_data_distlowpass(2).data(i,:);
        dataToAppend_cond3 = Pat_data_distlowpass(3).data(i,:);
        dataToAppend_cond4 = Pat_data_distlowpass(4).data(i,:);
        dataToAppend_cond5 = Pat_data_distlowpass(5).data(i,:);
        dataToAppend_cond6 = Pat_data_distlowpass(6).data(i,:);
        dataToAppend_cond7 = Pat_data_distlowpass(7).data(i,:);
        dataToAppend_cond8 = Pat_data_distlowpass(8).data(i,:);
        dataToAppend_cond9 = Pat_data_distlowpass(9).data(i,:);
        dataToAppend_cond10 = Pat_data_distlowpass(10).data(i,:);
        anovadata_pats_cond1 = [anovadata_pats_cond1 dataToAppend_cond1];
        anovadata_pats_cond2 = [anovadata_pats_cond2 dataToAppend_cond2];
        anovadata_pats_cond3 = [anovadata_pats_cond3 dataToAppend_cond3];
        anovadata_pats_cond4 = [anovadata_pats_cond4 dataToAppend_cond4];
        anovadata_pats_cond5 = [anovadata_pats_cond5 dataToAppend_cond5];
        anovadata_pats_cond6 = [anovadata_pats_cond6 dataToAppend_cond6];
        anovadata_pats_cond7 = [anovadata_pats_cond7 dataToAppend_cond7];
        anovadata_pats_cond8 = [anovadata_pats_cond8 dataToAppend_cond8];
        anovadata_pats_cond9 = [anovadata_pats_cond9 dataToAppend_cond9];
        anovadata_pats_cond10 = [anovadata_pats_cond10 dataToAppend_cond10];
        
end

anovadata_HCs_cond1=HC_data_distlowpass(1).data(1,:);
anovadata_HCs_cond2=HC_data_distlowpass(2).data(1,:);
anovadata_HCs_cond3=HC_data_distlowpass(3).data(1,:);
anovadata_HCs_cond4=HC_data_distlowpass(4).data(1,:);
anovadata_HCs_cond5=HC_data_distlowpass(5).data(1,:);
anovadata_HCs_cond6=HC_data_distlowpass(6).data(1,:);
anovadata_HCs_cond7=HC_data_distlowpass(7).data(1,:);
anovadata_HCs_cond8=HC_data_distlowpass(8).data(1,:);
anovadata_HCs_cond9=HC_data_distlowpass(9).data(1,:);
anovadata_HCs_cond10=HC_data_distlowpass(10).data(1,:);

for i = 2:11 %length(HCients_included)
        dataToAppend_cond1 = HC_data_distlowpass(1).data(i,:);
        dataToAppend_cond2 = HC_data_distlowpass(2).data(i,:);
        dataToAppend_cond3 = HC_data_distlowpass(3).data(i,:);
        dataToAppend_cond4 = HC_data_distlowpass(4).data(i,:);
        dataToAppend_cond5 = HC_data_distlowpass(5).data(i,:);
        dataToAppend_cond6 = HC_data_distlowpass(6).data(i,:);
        dataToAppend_cond7 = HC_data_distlowpass(7).data(i,:);
        dataToAppend_cond8 = HC_data_distlowpass(8).data(i,:);
        dataToAppend_cond9 = HC_data_distlowpass(9).data(i,:);
        dataToAppend_cond10 = HC_data_distlowpass(10).data(i,:);
        anovadata_HCs_cond1 = [anovadata_HCs_cond1 dataToAppend_cond1];
        anovadata_HCs_cond2 = [anovadata_HCs_cond2 dataToAppend_cond2];
        anovadata_HCs_cond3 = [anovadata_HCs_cond3 dataToAppend_cond3];
        anovadata_HCs_cond4 = [anovadata_HCs_cond4 dataToAppend_cond4];
        anovadata_HCs_cond5 = [anovadata_HCs_cond5 dataToAppend_cond5];
        anovadata_HCs_cond6 = [anovadata_HCs_cond6 dataToAppend_cond6];
        anovadata_HCs_cond7 = [anovadata_HCs_cond7 dataToAppend_cond7];
        anovadata_HCs_cond8 = [anovadata_HCs_cond8 dataToAppend_cond8];
        anovadata_HCs_cond9 = [anovadata_HCs_cond9 dataToAppend_cond9];
        anovadata_HCs_cond10 = [anovadata_HCs_cond10 dataToAppend_cond10];
        
end

% anova conditions modeled separately
anovadata=[anovadata_HCs_cond1 anovadata_HCs_cond2 anovadata_HCs_cond3 ...
           anovadata_HCs_cond4 anovadata_HCs_cond5 anovadata_HCs_cond6 ...
           anovadata_HCs_cond7 anovadata_HCs_cond8 anovadata_HCs_cond9 ...
           anovadata_HCs_cond10 anovadata_pats_cond1 anovadata_pats_cond2 ...
           anovadata_pats_cond3 anovadata_pats_cond4 anovadata_pats_cond5 ...
           anovadata_pats_cond6 anovadata_pats_cond7 anovadata_pats_cond8 ... 
           anovadata_pats_cond9 anovadata_pats_cond10];
% 
% %create subject group
% test=ones(1,82610);
% test2=ones(1,120160);
% test2=test2*2;
% subjectgroup=[test test2];
% 
% %create condition group
% cond_length_HC=41305;
% cond_length_pat=60080;
% condition = cell(1,202770);
% for i=1:8261
%     condition{i}='cond1';
% end
% for i=8262:165220
%     condition{i}='cond2';
% end
% for i=165221:8261*3
%     condition{i}='cond3';
% end
% for i=24784:8261*4
%     condition{i}='cond4';
% end
% for i=33044:8261*5
%     condition{i}='cond5';
% end
% for i=41306:8261*6
%     condition{i}='cond6';
% end
% for i=49567:8261*7
%     condition{i}='cond7';
% end
% for i=57828:8261*8
%     condition{i}='cond8';
% end
% for i=66089:8261*9
%     condition{i}='cond7';
% end
% for i=74350:8261*10
%     condition{i}='cond8';
% end
% 
% 
% 
% 
% for i=82611:94626
%     condition{i}='cond1';
% end
% for i=94627:94626+12016
%     condition{i}='cond2';
% end
% for i=106643:106642+12016
%     condition{i}='cond3';
% end
% for i=24784:12016
%     condition{i}='cond4';
% end
% for i=33044:12016
%     condition{i}='cond5';
% end
% for i=41306:12016
%     condition{i}='cond6';
% end
% for i=49567:12016
%     condition{i}='cond7';
% end
% for i=57828:12016
%     condition{i}='cond8';
% end
% for i=66089:8261*9
%     condition{i}='cond7';
% end
% for i=74350:8261*10
%     condition{i}='cond8';
% end
% 
% 
% 
% condition=condition';
% 
% group1=[subjectgroup];
% group2=[condition];
% p = anovan(anovadata,{group1 group2},'model','interaction')



%% clear v noise trials
% calulate and plot means - lumped into clear and noise conds
Pats_groupmean_clear1=vertcat(Pat_data_distlowpass(1).data, Pat_data_distlowpass(2).data, Pat_data_distlowpass(3).data, Pat_data_distlowpass(4).data, Pat_data_distlowpass(5).data);
Pats_groupmean_noise1=vertcat(Pat_data_distlowpass(6).data, Pat_data_distlowpass(7).data, Pat_data_distlowpass(8).data, Pat_data_distlowpass(9).data, Pat_data_distlowpass(10).data);
HCs_groupmean_clear1=vertcat(HC_data_distlowpass(1).data, HC_data_distlowpass(2).data, HC_data_distlowpass(3).data, HC_data_distlowpass(4).data, HC_data_distlowpass(5).data);
HCs_groupmean_noise1=vertcat(HC_data_distlowpass(6).data, HC_data_distlowpass(7).data, HC_data_distlowpass(8).data, HC_data_distlowpass(9).data, HC_data_distlowpass(10).data);

Pats_groupmean_clear=nanmean(Pats_groupmean_clear1);
Pats_groupstdev_clear=nanstd(Pats_groupmean_clear1);
Pats_groupSEM_clear=Pats_groupstdev_clear/sqrt(goodtrials_pat);

Pats_groupmean_noise=nanmean(Pats_groupmean_noise1);
Pats_groupstdev_noise=nanstd(Pats_groupmean_noise1);
Pats_groupSEM_noise=Pats_groupstdev_noise/sqrt(goodtrials_pat);

HCs_groupmean_clear=nanmean(HCs_groupmean_clear1);
HCs_groupstdev_clear=nanstd(HCs_groupmean_clear1);
HCs_groupSEM_clear=HCs_groupstdev_clear/sqrt(goodtrials_HC);

HCs_groupmean_noise=nanmean(HCs_groupmean_noise1);
HCs_groupstdev_noise=nanstd(HCs_groupmean_noise1);
HCs_groupSEM_noise=HCs_groupstdev_noise/sqrt(goodtrials_HC);

figure
subplot(221)
plot(frame_taxis_to_use(1:751), Pats_groupmean_clear, 'b','LineWidth',1.2,'Color',[patient_colour]);
axis([0 2.5 -50 50])
title('Patients (clear)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

subplot(222)
plot(frame_taxis_to_use(1:751),Pats_groupmean_noise, 'b','LineWidth',1.2,'Color',[patient_colour]);
axis([0 2.5 -50 50])
title('Patients (noise)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

subplot(223)
plot(frame_taxis_to_use(1:751),HCs_groupmean_clear, 'b','LineWidth',1.2,'Color',[HC_colour]);
axis([0 2.5 -50 50])
title('HCs (clear)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

subplot(224)
plot(frame_taxis_to_use(1:751),HCs_groupmean_noise, 'b','LineWidth',1.2,'Color',[HC_colour]);
axis([0 2.5 -50 50])
title('HCs (noise)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Fig4c.pdf');


figure
subplot(211)
bar(1, mean(HCs_groupmean_clear), 'm')
hold
bar(2, mean(HCs_groupmean_noise))
axis([0 3 -1 0])

subplot(212)
bar(1, mean(Pats_groupmean_clear))
hold
bar(2, mean(Pats_groupmean_noise))
axis([0 3 -1 0])



%% clear vs noise conditions - stdev of distance from low pass data

% Pats_groupstdev_clear
% Pats_groupstdev_noise
% 
% HCs_groupstdev_clear
% HCs_groupstdev_noise
% 

anovadata_stdev=[HCs_groupstdev_clear HCs_groupstdev_noise Pats_groupstdev_clear Pats_groupstdev_noise];

%create subject group
test=ones(1,751);
test2=ones(1,751);
test2=test2*2;
subjectgroup=[test test test2 test2];

%create condition group
condition = cell(1,3004);
for i=1:715
    condition{i}='clear';
end
for i=716:1502
    condition{i}='noise';
end
for i=1503:2253
    condition{i}='clear';
end
for i=2254:3004
    condition{i}='noise';
end
condition=condition';

group1=[subjectgroup];
group2=[condition];
p = anovan(anovadata_stdev,{group1 group2},'model','interaction')

ttest(HCs_groupstdev_clear, HCs_groupstdev_noise)
ttest(Pats_groupstdev_clear, Pats_groupstdev_noise)
ttest2(HCs_groupstdev_clear, Pats_groupstdev_clear)
ttest2(HCs_groupstdev_noise, Pats_groupstdev_noise)


figure
subplot(221)
plot(frame_taxis_to_use(1:751), Pats_groupstdev_clear, 'b','LineWidth',1.2,'Color',[patient_colour]);
axis([0 2.5 0 100])
title('Patients (clear)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

subplot(222)
plot(frame_taxis_to_use(1:751),Pats_groupstdev_noise, 'b','LineWidth',1.2,'Color',[patient_colour]);
axis([0 2.5 0 100])
title('Patients (noise)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

subplot(223)
plot(frame_taxis_to_use(1:751),HCs_groupstdev_clear, 'b','LineWidth',1.2,'Color',[HC_colour]);
axis([0 2.5 0 100])
title('HCs (clear)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

subplot(224)
plot(frame_taxis_to_use(1:751),HCs_groupstdev_noise, 'b','LineWidth',1.2,'Color',[HC_colour]);
axis([0 2.5 0 100])
title('HCs (noise)')
xlabel('Time (s)')
ylabel('Var (cents)')
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Stdev_distancefromlowpass.pdf');





figure
subplot(211)
title('Healthy controls')
bar(1, nanmean(HCs_groupstdev_clear), 'k')
hold on
bar(2, nanmean(HCs_groupstdev_noise), 'k')
axis([0 3 0 35])
goodplot

sem=HCs_groupstdev_clear/sqrt(goodtrials_HC)

ttest(HCs_groupstdev_clear, HCs_groupstdev_noise)

subplot(212)
title('Patients')
bar(1, mean(Pats_groupstdev_clear), 'w')
hold on
bar(2, mean(Pats_groupstdev_noise), 'w')
axis([0 3 0 35])
goodplot
ttest(Pats_groupstdev_clear, Pats_groupstdev_noise)

figure
y_pitch2=[nanmean(HCs_groupstdev_clear) nanmean(HCs_groupstdev_noise); ...
          nanmean(Pats_groupstdev_clear) nanmean(Pats_groupstdev_noise)]
errY2 = [nanstd(HCs_groupstdev_clear)/sqrt(goodtrials_HC) nanstd(HCs_groupstdev_noise)/sqrt(goodtrials_HC); ...
          nanstd(Pats_groupstdev_clear)/sqrt(goodtrials_pat) nanstd(Pats_groupstdev_noise)/sqrt(goodtrials_pat) ]            
h = barwitherr(errY2, y_pitch2);% Plot with errorbars
set(gca,'XTickLabel',{'HCs','Patients'})
ylabel('mean stdev of distance from low pass filt')
set(h(1),'FaceColor','k');
set(h(2),'FaceColor','w');
title(sprintf('Group mean variability in pitch tracking'));
axis([0 3 ymin ymax])
goodplot
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/meanstdvaribility.pdf');


% 
% 
% y_pitch2=[GroupMeans.HC_ALLCONDS.pre_pitchWTstdev_clear GroupMeans.pat_ALLCONDS.pre_pitchWTstdev_clear; ...
%           GroupMeans.HC_ALLCONDS.pre_pitchWTstdev_noise GroupMeans.pat_ALLCONDS.pre_pitchWTstdev_noise]
% errY2 = [ GroupSEM.HC_ALLCONDS.pre_pitchWTstdev_clear GroupSEM.pat_ALLCONDS.pre_pitchWTstdev_clear; ...
%           GroupSEM.HC_ALLCONDS.pre_pitchWTstdev_noise GroupSEM.pat_ALLCONDS.pre_pitchWTstdev_noise]            
% h = barwitherr(errY2, y_pitch2);% Plot with errorbars
% set(gca,'XTickLabel',{'clear','noise'})
% ylabel('mean stdev of pitch')
% set(h(1),'FaceColor','k');
% set(h(2),'FaceColor','w');
% title(sprintf('Pre Step'));
% axis([0 3 ymin ymax])






HC_clear=[anovadata_HCs_cond1 anovadata_HCs_cond2 anovadata_HCs_cond3 ...
           anovadata_HCs_cond4 anovadata_HCs_cond5];
HC_noise=[anovadata_HCs_cond6 anovadata_HCs_cond7 anovadata_HCs_cond8 ...
            anovadata_HCs_cond9 anovadata_HCs_cond10];
       
PAT_clear=[anovadata_pats_cond1 anovadata_pats_cond2 anovadata_pats_cond3 ...
            anovadata_pats_cond4 anovadata_pats_cond5];
PAT_noise=[anovadata_pats_cond6 anovadata_pats_cond7 anovadata_pats_cond8 ... 
           anovadata_pats_cond9 anovadata_pats_cond10];

             
% anova  - all clear and noise conds together
anovadata=[anovadata_HCs_cond1 anovadata_HCs_cond2 anovadata_HCs_cond3 ...
           anovadata_HCs_cond4 anovadata_HCs_cond5 anovadata_HCs_cond6 ...
           anovadata_HCs_cond7 anovadata_HCs_cond8 anovadata_HCs_cond9 ...
           anovadata_HCs_cond10 anovadata_pats_cond1 anovadata_pats_cond2 ...
           anovadata_pats_cond3 anovadata_pats_cond4 anovadata_pats_cond5 ...
           anovadata_pats_cond6 anovadata_pats_cond7 anovadata_pats_cond8 ... 
           anovadata_pats_cond9 anovadata_pats_cond10];

%create subject group
test=ones(1,82610);
test2=ones(1,120160);
test2=test2*2;
subjectgroup=[test test2];

%create condition group
cond_length_HC=41305;
cond_length_pat=60080;
condition = cell(1,202770);
for i=1:41305
    condition{i}='clear';
end
for i=41306:82610
    condition{i}='noise';
end
for i=82611:142690
    condition{i}='clear';
end
for i=142691:202770
    condition{i}='noise';
end
condition=condition';

group1=[subjectgroup];
group2=[condition];
p = anovan(anovadata,{group1 group2},'model','interaction')

%ttests
ttest(HC_clear, HC_noise)
ttest(PAT_clear, PAT_noise)
ttest2(HC_clear, PAT_clear)
ttest2(HC_noise, PAT_noise)
