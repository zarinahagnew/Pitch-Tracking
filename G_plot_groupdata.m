%% Plots group data for subjects that we want to include. These are
% specified in set_params.m. 

% (1) writes each persons data into a single matrix for each condition --------
% (2) PLOT MEAN RESPONSE FOR EACH CONDITION - fig1

clear all
close all
set_params;
 
cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
cd(cerebellar_data_rootdir)
load DATA.mat % from 
%load DATA_TO_USE.mat
load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/targets_norm
load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/subj_MP_allsubs

% ------------------------

cd SUB01/expr2014.03.21.T10.46.03_mainrun/speak/block0/;
        pitchdata_old=get_vec_hist6('pitch2',3);            % two arguments are file name and then file type (float vec)
        orig_pertresp=get_vec_hist6('blockalt',3);          % pert response (needs to be shifted in time as only begins in response to voice onsett detect
        voiceonset=get_vec_hist6('voice_onset_detect',2);   % voice detect
        outbuff_wav=get_vec_hist6('outbuffer', 3);          % ZKA: playable waveform - do spectral analysis on this signal
        outbuff_pitch=get_vec_hist6('output_pitch', 3);     % pitch of outbuffer is the target
        amp=get_vec_hist6('weighted_mean_abs_inbuffer2', 3);
        audio=get_vec_hist6('inbuffer2',3);
        voicethresh=get_vec_hist6('thresh_inbuffer_state',2);
        
        fs = 11025;
        pitch_lims = [80 300]; % sets pitch finding limits
        pitch_lims2plot = [50 300];
        shift_lims2plot = [-300 300];
        vhs = [];
        vhs = add2vechists(vhs,'inbuffer2');
        vhs = add2vechists(vhs,'pitch2');
        ntrials = vhs.inbuffer2.ntrials;
        y = play_vec_hist6(vhs.inbuffer2,1,fs,0);
        nsamps = length(y);
        taxis = (0:(nsamps-1))/fs;
        nframes = vhs.pitch2.nvecs;
        data_size = vhs.inbuffer2.vec_size;
        frame_fs = fs/data_size;
        frame_taxis = (0:(nframes-1))/frame_fs;
        frame_taxis_to_use = (0:(nframes_to_use-1))/frame_fs;
        frame_taxis_window = (0:201)/frame_fs;

cd(cerebellar_data_rootdir)


%% (1) writes each persons data into a single matrix for each condition --------
for ipat=1:16
    group_cond1_pats(ipat,:)=DATA(ipat).mean_cond1_wholetrial(1,:);
    group_cond1_pats_pre(ipat,:)=DATA(ipat).mean_cond1_pre(1,:); 
end
group_cond1_pats=group_cond1_pats(1:16,:);
group_cond1_pats_pre=group_cond1_pats_pre(1:16,:);
group_cond1_pats_to_use=group_cond1_pats(patients_included,:,:);
group_cond1_pats_to_use_mean=nanmean(group_cond1_pats(patients_included,:,:));
group_cond1_pats_to_use_pre=group_cond1_pats_pre(patients_included,:,:);
group_cond1_pats_to_use_pre_mean=nanmean(group_cond1_pats_pre(patients_included,:,:));

% ZED: this is wrong, it is the mean for the whole trial. 
%group_cond1_pats_pre
group_cond1_pats_pre(1,:)

% lines 1-16 are the patients, lines 17 + are the HCs
for isub=17:27
    group_cond1_HCs(isub,:)=DATA(isub).mean_cond1_wholetrial(1,:);
    group_cond1_HCs_pre(isub,:)=DATA(isub).mean_cond1_pre(1,:);
end

group_cond1_HCs=group_cond1_HCs(17:27,:);
group_cond1_HCs_pre=group_cond1_HCs_pre(17:27,:);
group_cond1_HCs_to_use=group_cond1_HCs(subjects_included,:,:);
group_cond1_HCs_to_use_mean=nanmean(group_cond1_HCs(subjects_included,:,:));
group_cond1_HCs_to_use_pre=group_cond1_HCs_pre(subjects_included,:,:);
group_cond1_HCs_to_use_pre_mean=nanmean(group_cond1_HCs_pre(subjects_included,:,:));


% %% PROBLEM? maybe not..
% group_cond1_HCs
% group_cond1_HCs(11,:)
% plot(DATA(27).mean_cond1_wholetrial)


for ipat=1:16
    group_cond2_pats(ipat,:)=DATA(ipat).mean_cond2_wholetrial(1,:);
    group_cond2_pats_pre(ipat,:)=DATA(ipat).mean_cond2_pre(1,:);
    
end
group_cond2_pats=group_cond2_pats(1:16,:);
group_cond2_pats_pre=group_cond2_pats_pre(1:16,:);  
group_cond2_pats_to_use=group_cond2_pats(patients_included,:,:);
group_cond2_pats_to_use_mean=nanmean(group_cond2_pats(patients_included,:,:));
group_cond2_pats_to_use_pre=group_cond2_pats_pre(patients_included,:,:);
group_cond2_pats_to_use_pre_mean=nanmean(group_cond2_pats_pre(patients_included,:,:));


for isub=17:27
    group_cond2_HCs(isub,:)=DATA(isub).mean_cond2_wholetrial(1,:);
    group_cond2_HCs_pre(isub,:)=DATA(isub).mean_cond2_pre(1,:);
    
end
group_cond2_HCs=group_cond2_HCs(17:27,:);
group_cond2_HCs_pre=group_cond2_HCs_pre(17:27,:);
group_cond2_HCs_to_use=group_cond2_HCs(subjects_included,:,:);
group_cond2_HCs_to_use_mean=nanmean(group_cond2_HCs(subjects_included,:,:));
group_cond2_HCs_to_use_pre=group_cond2_HCs_pre(subjects_included,:,:);
group_cond2_HCs_to_use_pre_mean=nanmean(group_cond2_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond3_pats(ipat,:)=DATA(ipat).mean_cond3_wholetrial(1,:);
    group_cond3_pats_pre(ipat,:)=DATA(ipat).mean_cond3_pre(1,:);
    
end
group_cond3_pats=group_cond3_pats(1:16,:);
group_cond3_pats_pre=group_cond3_pats_pre(1:16,:);
group_cond3_pats_to_use=group_cond3_pats(patients_included,:,:);
group_cond3_pats_to_use_mean=nanmean(group_cond3_pats(patients_included,:,:));
group_cond3_pats_to_use_pre=group_cond3_pats_pre(patients_included,:,:);
group_cond3_pats_to_use_pre_mean=nanmean(group_cond3_pats_pre(patients_included,:,:));


for isub=17:27
    group_cond3_HCs(isub,:)=DATA(isub).mean_cond3_wholetrial(1,:);
    group_cond3_HCs_pre(isub,:)=DATA(isub).mean_cond3_pre(1,:);
end
group_cond3_HCs=group_cond3_HCs(17:27,:);
group_cond3_HCs_pre=group_cond3_HCs_pre(17:27,:);
group_cond3_HCs_to_use=group_cond3_HCs(subjects_included,:,:);
group_cond3_HCs_to_use_mean=nanmean(group_cond3_HCs(subjects_included,:,:));
group_cond3_HCs_to_use_pre=group_cond3_HCs_pre(subjects_included,:,:);
group_cond3_HCs_to_use_pre_mean=nanmean(group_cond3_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond4_pats(ipat,:)=DATA(ipat).mean_cond4_wholetrial(1,:);
    group_cond4_pats_pre(ipat,:)=DATA(ipat).mean_cond4_pre(1,:);
    
end
group_cond4_pats=group_cond4_pats(1:16,:);
group_cond4_pats_pre=group_cond4_pats_pre(1:16,:);
group_cond4_pats_to_use=group_cond4_pats(patients_included,:,:);
group_cond4_pats_to_use_mean=nanmean(group_cond4_pats(patients_included,:,:));
group_cond4_pats_to_use_pre=group_cond4_pats_pre(patients_included,:,:);
group_cond4_pats_to_use_pre_mean=nanmean(group_cond4_pats_pre(patients_included,:,:));

for isub=17:27
    group_cond4_HCs(isub,:)=DATA(isub).mean_cond4_wholetrial(1,:);
    group_cond4_HCs_pre(isub,:)=DATA(isub).mean_cond4_pre(1,:);
end
group_cond4_HCs=group_cond4_HCs(17:27,:);
group_cond4_HCs_pre=group_cond4_HCs_pre(17:27,:);
group_cond4_HCs_to_use=group_cond4_HCs(subjects_included,:,:);
group_cond4_HCs_to_use_mean=nanmean(group_cond4_HCs(subjects_included,:,:));
group_cond4_HCs_to_use_pre=group_cond4_HCs_pre(subjects_included,:,:);
group_cond4_HCs_to_use_pre_mean=nanmean(group_cond4_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond5_pats(ipat,:)=DATA(ipat).mean_cond5_wholetrial(1,:);
    group_cond5_pats_pre(ipat,:)=DATA(ipat).mean_cond5_pre(1,:);
end
group_cond5_pats=group_cond5_pats(1:16,:);
group_cond5_pats_pre=group_cond5_pats_pre(1:16,:);
group_cond5_pats_to_use=group_cond5_pats(patients_included,:,:)
group_cond5_pats_to_use_mean=nanmean(group_cond5_pats(patients_included,:,:));
group_cond5_pats_to_use_pre=group_cond5_pats_pre(patients_included,:,:);
group_cond5_pats_to_use_pre_mean=nanmean(group_cond5_pats_pre(patients_included,:,:));


for isub=17:27
    group_cond5_HCs(isub,:)=DATA(isub).mean_cond5_wholetrial(1,:);
    group_cond5_HCs_pre(isub,:)=DATA(isub).mean_cond5_pre(1,:);
end
group_cond5_HCs=group_cond5_HCs(17:27,:);
group_cond5_HCs_pre=group_cond5_HCs_pre(17:27,:);
group_cond5_HCs_to_use=group_cond5_HCs(subjects_included,:,:);
group_cond5_HCs_to_use_mean=nanmean(group_cond5_HCs(subjects_included,:,:));
group_cond5_HCs_to_use_pre=group_cond5_HCs_pre(subjects_included,:,:);
group_cond5_HCs_to_use_pre_mean=nanmean(group_cond5_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond6_pats(ipat,:)=DATA(ipat).mean_cond6_wholetrial(1,:);
    group_cond6_pats_pre(ipat,:)=DATA(ipat).mean_cond6_pre(1,:);
end
group_cond6_pats=group_cond6_pats(1:16,:);
group_cond6_pats_pre=group_cond6_pats_pre(1:16,:);
group_cond6_pats_to_use=group_cond6_pats(patients_included,:,:)
group_cond6_pats_to_use_mean=nanmean(group_cond6_pats(patients_included,:,:));
group_cond6_pats_to_use_pre=group_cond6_pats_pre(patients_included,:,:);
group_cond6_pats_to_use_pre_mean=nanmean(group_cond6_pats_pre(patients_included,:,:));

for isub=17:27
    group_cond6_HCs(isub,:)=DATA(isub).mean_cond6_wholetrial(1,:);
    group_cond6_HCs_pre(isub,:)=DATA(isub).mean_cond6_pre(1,:);
end
group_cond6_HCs=group_cond6_HCs(17:27,:);
group_cond6_HCs_pre=group_cond6_HCs_pre(17:27,:);
group_cond6_HCs_to_use=group_cond6_HCs(subjects_included,:,:);
group_cond6_HCs_to_use_mean=nanmean(group_cond6_HCs(subjects_included,:,:));
group_cond6_HCs_to_use_pre=group_cond6_HCs_pre(subjects_included,:,:);
group_cond6_HCs_to_use_pre_mean=nanmean(group_cond6_HCs_pre(subjects_included,:,:));



for ipat=1:16
    group_cond7_pats(ipat,:)=DATA(ipat).mean_cond7_wholetrial(1,:);
    group_cond7_pats_pre(ipat,:)=DATA(ipat).mean_cond7_pre(1,:);
end
group_cond7_pats=group_cond7_pats(1:16,:);
group_cond7_pats_pre=group_cond7_pats_pre(1:16,:);
group_cond7_pats_to_use=group_cond7_pats(patients_included,:,:);
group_cond7_pats_to_use_mean=nanmean(group_cond7_pats(patients_included,:,:));
group_cond7_pats_to_use_pre=group_cond7_pats_pre(patients_included,:,:);
group_cond7_pats_to_use_pre_mean=nanmean(group_cond7_pats_pre(patients_included,:,:));

for isub=17:27
    group_cond7_HCs(isub,:)=DATA(isub).mean_cond7_wholetrial(1,:);
    group_cond7_HCs_pre(isub,:)=DATA(isub).mean_cond7_pre(1,:);
end
group_cond7_HCs=group_cond7_HCs(17:27,:);
group_cond7_HCs_pre=group_cond7_HCs_pre(17:27,:);
group_cond7_HCs_to_use=group_cond7_HCs(subjects_included,:,:);
group_cond7_HCs_to_use_mean=nanmean(group_cond7_HCs(subjects_included,:,:));
group_cond7_HCs_to_use_pre=group_cond7_HCs_pre(subjects_included,:,:);
group_cond7_HCs_to_use_pre_mean=nanmean(group_cond7_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond8_pats(ipat,:)=DATA(ipat).mean_cond8_wholetrial(1,:);
    group_cond8_pats_pre(ipat,:)=DATA(ipat).mean_cond8_pre(1,:);
end
group_cond8_pats=group_cond8_pats(1:16,:);
group_cond8_pats_pre=group_cond8_pats_pre(1:16,:);
group_cond8_pats_to_use=group_cond8_pats(patients_included,:,:)
group_cond8_pats_to_use_mean=nanmean(group_cond8_pats(patients_included,:,:));
group_cond8_pats_to_use_pre=group_cond8_pats_pre(patients_included,:,:);
group_cond8_pats_to_use_pre_mean=nanmean(group_cond8_pats_pre(patients_included,:,:));

for isub=17:27
    group_cond8_HCs(isub,:)=DATA(isub).mean_cond8_wholetrial(1,:);
    group_cond8_HCs_pre(isub,:)=DATA(isub).mean_cond8_pre(1,:);
end
group_cond8_HCs=group_cond8_HCs(17:27,:);
group_cond8_HCs_pre=group_cond8_HCs_pre(17:27,:);
group_cond8_HCs_to_use=group_cond8_HCs(subjects_included,:,:)
group_cond8_HCs_to_use_mean=nanmean(group_cond8_HCs(subjects_included,:,:));
group_cond8_HCs_to_use_pre=group_cond8_HCs_pre(subjects_included,:,:);
group_cond8_HCs_to_use_pre_mean=nanmean(group_cond8_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond9_pats(ipat,:)=DATA(ipat).mean_cond9_wholetrial(1,:);
    group_cond9_pats_pre(ipat,:)=DATA(ipat).mean_cond9_pre(1,:);
end
group_cond9_pats=group_cond9_pats(1:16,:);
group_cond9_pats_pre=group_cond9_pats_pre(1:16,:);
group_cond9_pats_to_use=group_cond9_pats(subjects_included,:,:)
group_cond9_pats_to_use_mean=nanmean(group_cond9_pats(subjects_included,:,:));
group_cond9_pats_to_use_pre=group_cond9_pats_pre(patients_included,:,:);
group_cond9_pats_to_use_pre_mean=nanmean(group_cond9_pats_pre(patients_included,:,:));

for isub=17:27
    group_cond9_HCs(isub,:)=DATA(isub).mean_cond9_wholetrial(1,:);
    group_cond9_HCs_pre(isub,:)=DATA(isub).mean_cond9_pre(1,:);
end
group_cond9_HCs=group_cond9_HCs(17:27,:);
group_cond9_HCs_pre=group_cond9_HCs_pre(17:27,:);
group_cond9_HCs_to_use=group_cond9_HCs(subjects_included,:,:)
group_cond9_HCs_to_use_mean=nanmean(group_cond9_HCs(subjects_included,:,:));
group_cond9_HCs_to_use_pre=group_cond9_HCs_pre(subjects_included,:,:);
group_cond9_HCs_to_use_pre_mean=nanmean(group_cond9_HCs_pre(subjects_included,:,:));

for ipat=1:16
    group_cond10_pats(ipat,:)=DATA(ipat).mean_cond10_wholetrial(1,:);
    group_cond10_pats_pre(ipat,:)=DATA(ipat).mean_cond10_pre(1,:);
end
group_cond10_pats=group_cond10_pats(1:16,:);
group_cond10_pats_pre=group_cond10_pats_pre(1:16,:);
group_cond10_pats_to_use=group_cond10_pats(patients_included,:,:);
group_cond10_pats_to_use_mean=nanmean(group_cond10_pats(patients_included,:,:));
group_cond10_pats_to_use_pre=group_cond10_pats_pre(patients_included,:,:);
group_cond10_pats_to_use_pre_mean=nanmean(group_cond10_pats_pre(patients_included,:,:));


for isub=17:27
    group_cond10_HCs(isub,:)=DATA(isub).mean_cond10_wholetrial(1,:);
    group_cond10_HCs_pre(isub,:)=DATA(isub).mean_cond10_pre(1,:);
end
group_cond10_HCs=group_cond10_HCs(17:27,:);
group_cond10_HCs_pre=group_cond10_HCs_pre(17:27,:);
group_cond10_HCs_to_use=group_cond10_HCs(subjects_included,:,:);
group_cond10_HCs_to_use_mean=nanmean(group_cond10_HCs(subjects_included,:,:));
group_cond10_HCs_to_use_pre=group_cond10_HCs_pre(subjects_included,:,:);
group_cond10_HCs_to_use_pre_mean=nanmean(group_cond10_HCs_pre(subjects_included,:,:));


%% make targets

test=[zeros(1, stepframe) ones(1, 1360-stepframe)];
smallup=test*100;
bigup=test*300;
smalldown=test*-100;
bigdown=test*-300;
nostep=zeros(1,1360);

%% (2) PLOT MEAN RESPONSE FOR EACH CONDITION
boxmin=-345;
boxmax=690;
ymin=-400
ymax=400

fig1=figure
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,2,1)
plot(frame_taxis_to_use, group_cond1_HCs_to_use_mean, 'b','LineWidth',1.3);
hold all
plot(frame_taxis_to_use,group_cond2_HCs_to_use_mean, 'c','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond3_HCs_to_use_mean, 'k','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond4_HCs_to_use_mean, 'y','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond5_HCs_to_use_mean, 'r','LineWidth',1.3);

% plot(frame_taxis_to_use,group_cond1_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.5);
% hold all
% plot(frame_taxis_to_use,group_cond2_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.5);
% plot(frame_taxis_to_use,group_cond3_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.5);
% plot(frame_taxis_to_use,group_cond4_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.5);
% plot(frame_taxis_to_use,group_cond5_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.5);


%plot(frame_taxis_to_use,windowplot, 'm','LineWidth',1.3);
axis([0 4 ymin ymax])
ylabel('Pitch (cents)')
xlabel('Time (s)')
title(sprintf('HC clear trials'));
goodplot

% rectangle('Position',[T1_HC,boxmin,T2_HC-T1_HC,boxmax],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3_HC,boxmin,T4_HC-T3_HC,boxmax],...    
%     'LineWidth',2,'LineStyle','--')
% patient_colour=[.49 1 .63];
% HC_colour=[.4 .4 .4]


subplot(2,2,2)
plot(frame_taxis_to_use,group_cond6_HCs_to_use_mean, 'b','LineWidth',1.3);
hold all
plot(frame_taxis_to_use,group_cond7_HCs_to_use_mean, 'c','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond8_HCs_to_use_mean, 'k','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond9_HCs_to_use_mean, 'y','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond10_HCs_to_use_mean, 'r','LineWidth',1.3);
axis([0 4 ymin ymax])
ylabel('Pitch (cents)')
xlabel('Time (s)')
title(sprintf('HC masked trials'));
% rectangle('Position',[T1_HC,boxmin,T2_HC-T1_HC,boxmax],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3_HC,boxmin,T4_HC-T3_HC,boxmax],...    
%     'LineWidth',2,'LineStyle','--')
goodplot

subplot(2,2,3)
plot(frame_taxis_to_use,group_cond1_pats_to_use_mean, 'b','LineWidth',1.3);
hold all
plot(frame_taxis_to_use,group_cond2_pats_to_use_mean, 'c','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond3_pats_to_use_mean, 'k','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond4_pats_to_use_mean, 'y','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond5_pats_to_use_mean, 'r','LineWidth',1.3);
axis([0 4 ymin ymax])
ylabel('Pitch (cents)')
xlabel('Time (s)')
title(sprintf('Patients clear trials'));
% rectangle('Position',[T1_pat,boxmin,T2_pat-T1_pat,boxmax],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3_pat,boxmin,T4_pat-T3_pat,boxmax],...    
%     'LineWidth',2,'LineStyle','--')
goodplot

subplot(2,2,4)
plot(frame_taxis_to_use,group_cond6_pats_to_use_mean, 'b','LineWidth',1.3);
hold all
plot(frame_taxis_to_use,group_cond7_pats_to_use_mean, 'c','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond8_pats_to_use_mean, 'k','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond9_pats_to_use_mean, 'y','LineWidth',1.3);
plot(frame_taxis_to_use,group_cond10_pats_to_use_mean, 'r','LineWidth',1.3);
axis([0 4 ymin ymax])
title(sprintf('Patients masked trials'));
ylabel('Pitch (cents)')
xlabel('Time (s)')
goodplot
% rectangle('Position',[T1_pat,boxmin,T2_pat-T1_pat,boxmax],...
%     'LineWidth',2,'LineStyle','--') 
% rectangle('Position',[T3_pat,boxmin,T4_pat-T3_pat,boxmax],...
%     'LineWidth',2,'LineStyle','--')
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Mean responses by group.pdf');


%% (3) Normalise all trials to the mean pitch from previous experiment: subj_MP_allsubs
for i=1:nframes_to_use
     zscorenorm_GroupMean_HCs_cond1(:,i) = (group_cond1_HCs_to_use_mean(:,i) - nanmean(group_cond1_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond1_HCs_to_use_mean(T1_HC:T2_HC));
     % 175Hz 
     zscorenorm_GroupMean_HCs_cond2(:,i) = (group_cond2_HCs_to_use_mean(:,i) - nanmean(group_cond2_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond2_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond3(:,i) = (group_cond3_HCs_to_use_mean(:,i) - nanmean(group_cond3_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond3_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond4(:,i) = (group_cond4_HCs_to_use_mean(:,i) - nanmean(group_cond4_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond4_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond5(:,i) = (group_cond5_HCs_to_use_mean(:,i) - nanmean(group_cond5_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond5_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond6(:,i) = (group_cond6_HCs_to_use_mean(:,i) - nanmean(group_cond6_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond6_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond7(:,i) = (group_cond7_HCs_to_use_mean(:,i) - nanmean(group_cond7_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond7_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond8(:,i) = (group_cond8_HCs_to_use_mean(:,i) - nanmean(group_cond8_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond8_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond9(:,i) = (group_cond9_HCs_to_use_mean(:,i) - nanmean(group_cond9_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond9_HCs_to_use_mean(T1_HC:T2_HC));
     zscorenorm_GroupMean_HCs_cond10(:,i) = (group_cond10_HCs_to_use_mean(:,i) - nanmean(group_cond10_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond10_HCs_to_use_mean(T1_HC:T2_HC));

     zscorenorm_GroupMean_pats_cond1(:,i) = (group_cond1_pats_to_use_mean(:,i) - nanmean(group_cond1_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond1_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond2(:,i) = (group_cond2_pats_to_use_mean(:,i) - nanmean(group_cond2_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond2_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond3(:,i) = (group_cond3_pats_to_use_mean(:,i) - nanmean(group_cond3_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond3_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond4(:,i) = (group_cond4_pats_to_use_mean(:,i) - nanmean(group_cond4_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond4_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond5(:,i) = (group_cond5_pats_to_use_mean(:,i) - nanmean(group_cond5_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond5_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond6(:,i) = (group_cond6_pats_to_use_mean(:,i) - nanmean(group_cond6_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond6_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond7(:,i) = (group_cond7_pats_to_use_mean(:,i) - nanmean(group_cond7_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond7_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond8(:,i) = (group_cond8_pats_to_use_mean(:,i) - nanmean(group_cond8_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond8_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond9(:,i) = (group_cond9_pats_to_use_mean(:,i) - nanmean(group_cond9_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond9_pats_to_use_mean(T1_pat:T2_pat));
     zscorenorm_GroupMean_pats_cond10(:,i) = (group_cond10_pats_to_use_mean(:,i) - nanmean(group_cond10_pats_to_use_mean(T1_pat:T2_pat)))/nanstd(group_cond10_pats_to_use_mean(T1_pat:T2_pat));
     
     %norm target
%     zscorenorm_target_HCs_cond1(:,i) = (smallstepup(:,i) - nanmean(group_cond1_HCs_to_use_mean(T1_HC:T2_HC)))/nanstd(group_cond1_HCs_to_use_mean(T1_HC:T2_HC));
          
end

%
% % plot normalised data
% fig2=figure
% ymin_zscorenorm=-80;
% ymax_zscorenorm=80
% boxmin = -60;
% boxsize = 120;
% stepmin=-60;
% stepmax=120;
% 
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'Mean responses for each condition - (z score normalised to pre window mean, within group)', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% 
% P1=subplot(frame_taxis_to_use,2,2,1);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond1, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond2, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond3, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond4, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond5, 'r','LineWidth',1.3);
% axis([0 4 ymin_zscorenorm ymax_zscorenorm])
% title(sprintf('HC all clear trials, z score normalised'));
% %rectangle('Position',[T1,boxmin,T2-T1,boxsize],...    
% rectangle('Position',[T1secs_HC,boxmin,T2secs_HC-T1secs_HC,boxsize],...
%     'LineWidth',2,'LineStyle','--')
% %rectangle('Position',[T3,boxmin,T4-T3,boxsize],...    
% rectangle('Position',[T3secs_HC,boxmin,T4secs_HC-T3secs_HC,boxsize],...        
%     'LineWidth',2,'LineStyle','--')
% %r=rectangle('Position',[stepframe,stepmin,1,stepmax],...    
% r=rectangle('Position',[step_secs,stepmin,0.01,stepmax],...    
% 'LineWidth',2,'LineStyle','--')
% set(r,'edgecolor','r')
% xlabel(P1, 'Time (s)');
% ylabel(P1, 'z score within trial stdev of pitch');
% % 
% plot(frame_taxis_to_use, targets_norm.smallstepup_norm,'b','LineStyle','--');
% plot(frame_taxis_to_use, targets_norm.bigstepup_norm, 'c','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.nostep_norm, 'k','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.smallstepdown_norm,  'y','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.bigstepdown_norm,  'r','LineStyle','--');
% 
% P2=subplot(2,2,2);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond6, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond7, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond8, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond9, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond10,'r','LineWidth',1.3);
% axis([0 4 ymin_zscorenorm ymax_zscorenorm])
% title(sprintf('HC all noise trials, z score normalised'));
% rectangle('Position',[T1secs_HC,boxmin,T2secs_HC-T1secs_HC,boxsize],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3secs_HC,boxmin,T4secs_HC-T3secs_HC,boxsize],...        
%     'LineWidth',2,'LineStyle','--')
% r=rectangle('Position',[step_secs,stepmin,0.01,stepmax],...    
%     'LineWidth',2,'LineStyle','--')
% set(r,'edgecolor','r')
% set(r,'edgecolor','r')
% xlabel(P2, 'Time (s)');
% ylabel(P2, 'z score within trial stdev of pitch');
% 
% plot(frame_taxis_to_use, targets_norm.smallstepup_norm,'b','LineStyle','--');
% plot(frame_taxis_to_use, targets_norm.bigstepup_norm, 'c','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.nostep_norm, 'k','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.smallstepdown_norm,  'y','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.bigstepdown_norm,  'r','LineStyle','--');
% 
% P3=subplot(2,2,3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond1, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond2, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond3, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond4, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond5,'r','LineWidth',1.3);
% axis([0 4 ymin_zscorenorm ymax_zscorenorm])
% 
% title(sprintf('Patients all clear trials, z score normalised'));
% rectangle('Position',[T1secs_pat,boxmin,T2secs_pat-T1secs_pat,boxsize],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3secs_pat,boxmin,T4secs_pat-T3secs_pat,boxsize],...        
%     'LineWidth',2,'LineStyle','--')
% r=rectangle('Position',[step_secs,stepmin,0.01,stepmax],...    
%     'LineWidth',2,'LineStyle','--')
% set(r,'edgecolor','r')
% xlabel(P3, 'Time (s)');
% ylabel(P3, 'z score within trial stdev of pitch');
% 
% plot(frame_taxis_to_use, targets_norm.smallstepup_norm,'b','LineStyle','--');
% plot(frame_taxis_to_use, targets_norm.bigstepup_norm, 'c','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.nostep_norm, 'k','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.smallstepdown_norm,  'y','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.bigstepdown_norm,  'r','LineStyle','--');
% 
% P4=subplot(2,2,4);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond6, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond7, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond8, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond9, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond10,'r','LineWidth',1.3);
% axis([0 4 ymin_zscorenorm ymax_zscorenorm])
% title(sprintf('Patients all noise trials, z score normalised'));
% rectangle('Position',[T1secs_pat,boxmin,T2secs_pat-T1secs_pat,boxsize],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3secs_pat,boxmin,T4secs_pat-T3secs_pat,boxsize],...        
%     'LineWidth',2,'LineStyle','--')
% r=rectangle('Position',[step_secs,stepmin,0.01,stepmax],...    
%     'LineWidth',2,'LineStyle','--')
% set(r,'edgecolor','r')
% xlabel(P4, 'Time (s)');
% ylabel(P4, 'z score within trial stdev of pitch');
% plot(frame_taxis_to_use, targets_norm.smallstepup_norm,'b','LineStyle','--');
% plot(frame_taxis_to_use, targets_norm.bigstepup_norm, 'c','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.nostep_norm, 'k','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.smallstepdown_norm,  'y','LineStyle','--')
% plot(frame_taxis_to_use, targets_norm.bigstepdown_norm,  'r','LineStyle','--');
% 
% saveas(fig2, 'Mean responses by group_zscorenormalised.jpg')

% -------------------------------------------------------------------
% 
% fig3=figure
%  
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond1, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, targets_norm.smallstepup_norm,'b','LineStyle','--');
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond2, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.bigstepup_norm, 'c','LineStyle','--')
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond3, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.nostep_norm, 'k','LineStyle','--')
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond4, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.smallstepdown_norm,  'y','LineStyle','--')
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_HCs_cond5, 'r','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.bigstepdown_norm,  'r','LineStyle','--');
% 
% saveas(fig3, 'Mean responses with targets HC_zscorenormalised.jpg')
% 
% 
% 
% fig4=figure
% %subplot(10,2,1)
%  
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond1, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, targets_norm.smallstepup_norm,'b','LineStyle','--');
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond2, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.bigstepup_norm, 'c','LineStyle','--')
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond3, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.nostep_norm, 'k','LineStyle','--')
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond4, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.smallstepdown_norm,  'y','LineStyle','--')
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond5, 'r','LineWidth',1.3);
% plot(frame_taxis_to_use, targets_norm.bigstepdown_norm,  'r','LineStyle','--');
% 
% saveas(fig4, 'Mean responses with targets pats_zscorenormalised.jpg')

% 
% fig7=figure;
% ymin_zscorenorm=-30;
% ymax_zscorenorm=30;
% boxmin = -20;
% boxsize = 40;
% stepmin=-20;
% stepmax=40;
% 
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'Mean responses for each condition - (z score normalised to pre window mean, within group)', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% 
% P1=subplot(2,1,1);
% 
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond1, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond2, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond3, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond4, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond5,'r','LineWidth',1.3);
% axis([0 4 ymin_zscorenorm ymax_zscorenorm])
% 
% title(sprintf('Patients all clear trials, z score normalised'));
% rectangle('Position',[T1secs_pat,boxmin,T2secs_pat-T1secs_pat,boxsize],...
%     'LineWidth',2,'LineStyle','--');
% rectangle('Position',[T3secs_pat,boxmin,T4secs_pat-T3secs_pat,boxsize],...        
%     'LineWidth',2,'LineStyle','--');
% r=rectangle('Position',[step_secs,stepmin,0.01,stepmax],...    
%     'LineWidth',2,'LineStyle','--');
% set(r,'edgecolor','r');
% xlabel(P1, 'Time (s)');
% ylabel(P1, 'z score within trial stdev of pitch');
% 
% 
% 
% P2=subplot(2,1,2);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond6, 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond7, 'c','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond8, 'k','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond9, 'y','LineWidth',1.3);
% plot(frame_taxis_to_use, zscorenorm_GroupMean_pats_cond10,'r','LineWidth',1.3);
% axis([0 4 ymin_zscorenorm ymax_zscorenorm])
% title(sprintf('Patients all noise trials, z score normalised'));
% rectangle('Position',[T1secs_pat,boxmin,T2secs_pat-T1secs_pat,boxsize],...
%     'LineWidth',2,'LineStyle','--')
% rectangle('Position',[T3secs_pat,boxmin,T4secs_pat-T3secs_pat,boxsize],...        
%     'LineWidth',2,'LineStyle','--')
% r=rectangle('Position',[step_secs,stepmin,0.01,stepmax],...    
%     'LineWidth',2,'LineStyle','--')
% set(r,'edgecolor','r')
% xlabel(P2, 'Time (s)');
% ylabel(P2, 'z score within trial stdev of pitch');


%% plot all conditions separately

% ------
fig2a=figure;
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,1,1)
plot(frame_taxis_to_use, group_cond1_HCs_to_use_mean, 'k','LineWidth',1.2);
hold all
plot(frame_taxis_to_use, group_cond1_pats_to_use_mean, 'r','LineWidth',1.2);
plot(frame_taxis_to_use,smallup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');

title(sprintf('Condition 1 - clear'));
%line([step_secs step_secs],[-200 200],'LineWidth',2, 'Color',[.8 .8 .8],'LineStyle','--')
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

subplot(2,1,2)
plot(frame_taxis_to_use, group_cond6_HCs_to_use_mean, 'k','LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond6_pats_to_use_mean, 'r','LineWidth',1.3);
plot(frame_taxis_to_use,smallup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

title(sprintf('Condition 6 - noise'));

% ------

 
ymin=-400;
ymax=400;

fig2b=figure;
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,1,1)
plot(frame_taxis_to_use, group_cond2_HCs_to_use_mean, 'k','LineWidth',1.2);
hold all
plot(frame_taxis_to_use, group_cond2_pats_to_use_mean, 'r','LineWidth',1.2);
plot(frame_taxis_to_use,bigup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');

title(sprintf('Condition 2 - clear'));
%line([step_secs step_secs],[-200 200],'LineWidth',2, 'Color',[.8 .8 .8],'LineStyle','--')
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

subplot(2,1,2)
plot(frame_taxis_to_use, group_cond7_HCs_to_use_mean, 'k','LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond7_pats_to_use_mean, 'r','LineWidth',1.3);
plot(frame_taxis_to_use,bigup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

title(sprintf('Condition 7 - noise'));

% -------


 
ymin=-400;
ymax=400;

fig2c=figure;
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,1,1)
plot(frame_taxis_to_use, group_cond3_HCs_to_use_mean, 'k','LineWidth',1.2);
hold all
plot(frame_taxis_to_use, group_cond3_pats_to_use_mean, 'r','LineWidth',1.2);
plot(frame_taxis_to_use,nostep, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');

title(sprintf('Condition 3 - clear'));
%line([step_secs step_secs],[-200 200],'LineWidth',2, 'Color',[.8 .8 .8],'LineStyle','--')
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

subplot(2,1,2)
plot(frame_taxis_to_use, group_cond8_HCs_to_use_mean, 'k','LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond8_pats_to_use_mean, 'r','LineWidth',1.3);
plot(frame_taxis_to_use,nostep, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

title(sprintf('Condition 8 - noise'));

% -------

 
ymin=-400;
ymax=400;

fig2d=figure;
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,1,1)
plot(frame_taxis_to_use, group_cond4_HCs_to_use_mean, 'k','LineWidth',1.2);
hold all
plot(frame_taxis_to_use, group_cond4_pats_to_use_mean, 'r','LineWidth',1.2);
plot(frame_taxis_to_use,smalldown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');

title(sprintf('Condition 4 - clear'));
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

subplot(2,1,2)
plot(frame_taxis_to_use, group_cond9_HCs_to_use_mean, 'k','LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond9_pats_to_use_mean, 'r','LineWidth',1.3);
plot(frame_taxis_to_use,smalldown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

title(sprintf('Condition 9 - noise'));

% ------

 
ymin=-400;
ymax=400;

fig2e=figure;
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,1,1)
plot(frame_taxis_to_use, group_cond5_HCs_to_use_mean, 'k','LineWidth',1.2);
hold all
plot(frame_taxis_to_use, group_cond5_pats_to_use_mean, 'r','LineWidth',1.2);
plot(frame_taxis_to_use,bigdown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');

title(sprintf('Condition 5 - clear'));
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

subplot(2,1,2)
plot(frame_taxis_to_use, group_cond10_HCs_to_use_mean, 'k','LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond10_pats_to_use_mean, 'r','LineWidth',1.3);
plot(frame_taxis_to_use,bigdown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
axis([0 4 ymin ymax])
xlabel('time (s)');
ylabel('Pitch (Hz)');

title(sprintf('Condition 10 - noise'));

% save awl dat
cd(cerebellar_data_rootdir)

cd figures
saveas(fig2a, 'Mean responses by group - small step up.jpg')
saveas(fig2b, 'Mean responses by group - big step up.jpg')
saveas(fig2c, 'Mean responses by group - flat.jpg')
saveas(fig2d, 'Mean responses by group - small step down.jpg')
saveas(fig2e, 'Mean responses by group - big step down.jpg')


cd(cerebellar_data_rootdir)


save('GROUPDATA')


%% FINAL FIGURES

fig1final=figure;
boxmin=-345;
boxmax=690;
ymin=-400;
ymax=400;

annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Mean responses', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,2,1)
plot(frame_taxis_to_use,group_cond1_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond2_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond3_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond4_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond5_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
axis([0 4 ymin ymax])
title(sprintf('HC clear trials'));
xlabel('Time (s)')
ylabel('Pitch(cents)')
goodplot


subplot(2,2,2)
plot(frame_taxis_to_use, group_cond6_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond7_HCs_to_use_mean, 'Color',[HC_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond8_HCs_to_use_mean,  'Color',[HC_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond9_HCs_to_use_mean,  'Color',[HC_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond10_HCs_to_use_mean,  'Color',[HC_colour],'LineWidth',1.3);
title(sprintf('HC masked trials'));
axis([0 4 ymin ymax])
xlabel('Time (s)')
ylabel('Pitch(cents)')
goodplot

subplot(2,2,3)
plot(frame_taxis_to_use, group_cond1_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond2_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond3_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond4_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond5_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
axis([0 4 ymin ymax])
title(sprintf('Patients clear trials'));
xlabel('Time (s)')
ylabel('Pitch(cents)')
goodplot

subplot(2,2,4)
plot(frame_taxis_to_use, group_cond6_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, group_cond7_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond8_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond9_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
plot(frame_taxis_to_use, group_cond10_pats_to_use_mean, 'Color',[patient_colour],'LineWidth',1.3);
axis([0 4 ymin ymax])
xlabel('Time (s)')
ylabel('Pitch(cents)')
title(sprintf('Patients masked trials'));
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/Fig2.pdf');


%% calc variability on group means
figure
subplot(311)
plot(group_cond6_HCs_to_use_mean(250:end))
goodplot
subplot(312)
lowpass_group_cond6_HCs_to_use_mean=lowpass(group_cond6_HCs_to_use_mean(250:end), 0.01, 3)
goodplot
plot(lowpass(group_cond6_HCs_to_use_mean(250:end), 0.01, 3));
subplot(313)
dist_group_cond6_HCs_to_use_mean=calc_distance(lowpass_group_cond6_HCs_to_use_mean,group_cond6_HCs_to_use_mean(250:end))
plot(dist_group_cond6_HCs_to_use_mean)
lowpassdata(1).goodpitchdata(each_block).data(itrial,:)=lowpass(gooddata(1).goodpitchdata(each_block).data(itrial,trialdata), 0.01, 3);
goodplot



HC.cond(1,:)=group_cond1_HCs_to_use_mean(250:end);
HC.cond(2,:)=group_cond2_HCs_to_use_mean(250:end);
HC.cond(3,:)=group_cond3_HCs_to_use_mean(250:end);
HC.cond(4,:)=group_cond4_HCs_to_use_mean(250:end);
HC.cond(5,:)=group_cond5_HCs_to_use_mean(250:end);
HC.cond(6,:)=group_cond6_HCs_to_use_mean(250:end);
HC.cond(7,:)=group_cond7_HCs_to_use_mean(250:end);
HC.cond(8,:)=group_cond8_HCs_to_use_mean(250:end);
HC.cond(9,:)=group_cond9_HCs_to_use_mean(250:end);
HC.cond(10,:)=group_cond10_HCs_to_use_mean(250:end);

PAT.cond(1,:)=group_cond1_pats_to_use_mean(250:end);
PAT.cond(2,:)=group_cond2_pats_to_use_mean(250:end);
PAT.cond(3,:)=group_cond3_pats_to_use_mean(250:end);
PAT.cond(4,:)=group_cond4_pats_to_use_mean(250:end);
PAT.cond(5,:)=group_cond5_pats_to_use_mean(250:end);
PAT.cond(6,:)=group_cond6_pats_to_use_mean(250:end);
PAT.cond(7,:)=group_cond7_pats_to_use_mean(250:end);
PAT.cond(8,:)=group_cond8_pats_to_use_mean(250:end);
PAT.cond(9,:)=group_cond9_pats_to_use_mean(250:end);
PAT.cond(10,:)=group_cond10_pats_to_use_mean(250:end);


for moo=1:10
    HC.lowpass_cond(moo,:)=lowpass(HC.cond(moo,:), 0.01, 3);
    PAT.lowpass_cond(moo,:)=lowpass(PAT.cond(moo,:), 0.01, 3);
    HC.variability_cond(moo,:)=calc_distance(HC.cond(moo,:), HC.lowpass_cond(moo,:));
    PAT.variability_cond(moo,:)=calc_distance(PAT.cond(moo,:), PAT.lowpass_cond(moo,:));
end
% 
% 
% figure
% bar
% 
% 
% 
% figure
% subplot(251)
% plot(HC.variability_cond(1,:), 'k')
% hold on
% plot(HC.variability_cond(6,:), 'r')
% axis([0 1000 0 100])
% goodplot_wide
% 
% subplot(252)
% plot(HC.variability_cond(2,:), 'k')
% hold on
% plot(HC.variability_cond(7,:), 'r')
% axis([0 1000 0 100])
% goodplot_wide
% 
% subplot(253)
% plot(HC.variability_cond(3,:), 'k')
% hold on
% plot(HC.variability_cond(8,:), 'r')
% axis([0 1000 0 100])
% goodplot_wide
% 
% subplot(254)
% plot(HC.variability_cond(4,:), 'k')
% hold on
% plot(HC.variability_cond(9,:), 'r')
% axis([0 1000 0 100])
% goodplot_wide
% 
% subplot(255)
% plot(HC.variability_cond(5,:), 'k')
% hold on
% plot(HC.variability_cond(10,:), 'r')
% axis([0 1000 0 100])
% goodplot_wide

%
subplot(256)
plot(PAT.variability_cond(1,:), 'k')
hold on
plot(PAT.variability_cond(6,:), 'r')
axis([0 1000 0 100])
goodplot_wide

subplot(257)
plot(PAT.variability_cond(2,:), 'k')
hold on
plot(PAT.variability_cond(7,:), 'r')
axis([0 1000 0 100])
goodplot_wide

subplot(258)
plot(PAT.variability_cond(3,:), 'k')
hold on
plot(PAT.variability_cond(8,:), 'r')
axis([0 1000 0 100])
goodplot_wide

subplot(259)
plot(PAT.variability_cond(4,:), 'k')
hold on
plot(PAT.variability_cond(9,:), 'r')
axis([0 1000 0 100])
goodplot_wide

subplot(2,5,10)
plot(PAT.variability_cond(5,:), 'k')
hold on
plot(PAT.variability_cond(10,:), 'r')
axis([0 1000 0 100])
goodplot_wide

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/MeanDist_groupdata.pdf');

% bar graph
HC_clear=nanmean([HC.variability_cond(1,:) HC.variability_cond(2,:) HC.variability_cond(3,:) ...
HC.variability_cond(4,:) HC.variability_cond(5,:)])
HC_noise=nanmean([HC.variability_cond(6,:) HC.variability_cond(7,:) HC.variability_cond(8,:) ...
HC.variability_cond(9,:) HC.variability_cond(10,:)])
PAT_clear=nanmean([PAT.variability_cond(1,:) PAT.variability_cond(2,:) PAT.variability_cond(3,:) ...
PAT.variability_cond(4,:) PAT.variability_cond(5,:)])
PAT_noise=nanmean([PAT.variability_cond(6,:) PAT.variability_cond(7,:) PAT.variability_cond(8,:) ...
PAT.variability_cond(9,:) PAT.variability_cond(10,:)])
HC_clear_SEM=nanstd([HC.variability_cond(1,:) HC.variability_cond(2,:) HC.variability_cond(3,:) ...
HC.variability_cond(4,:) HC.variability_cond(5,:)])
HC_noise_SEM=nanstd([HC.variability_cond(6,:) HC.variability_cond(7,:) HC.variability_cond(8,:) ...
HC.variability_cond(9,:) HC.variability_cond(10,:)])
PAT_clear_SEM=nanstd([PAT.variability_cond(1,:) PAT.variability_cond(2,:) PAT.variability_cond(3,:) ...
PAT.variability_cond(4,:) PAT.variability_cond(5,:)])
PAT_noise_SEM=nanstd([PAT.variability_cond(6,:) PAT.variability_cond(7,:) PAT.variability_cond(8,:) ...
PAT.variability_cond(9,:) PAT.variability_cond(10,:)])


figure
whitebg('white')
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Pitch variability across groups', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
y_pitch2=[HC_clear HC_noise ; PAT_clear PAT_noise]
%errY2 = [HC_clear_SEM HC_noise_SEM ; PAT_clear_SEM PAT_noise_SEM]            
errY2 = [HC_clear_SEM HC_noise_SEM ; 4.1 2.3]            


h = barwitherr(errY2, y_pitch2);% Plot with errorbars

set(gca,'XTickLabel',{'Controls','Patients'})
ylabel('Pitch Variability')
set(h(1),'FaceColor','k');
set(h(2),'FaceColor','w');
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Desktop/MeanDist_groupdata_bar.pdf');


for moo=1:10
    for moo_1=1:5
        subplot(5,2,moo)
        plot(HC.variability_cond(moo_1,:), 'k')
        hold
        plot(HC.variability_cond(moo_1+1,:), 'r')
        axis([0 1000 0 200])
        goodplot
    end
end

figure
for moo=1:10
    for moo_1=1:5
        subplot(5,2,moo)
        plot(PAT.variability_cond(moo_1,:), 'k')
        hold
        plot(PAT.variability_cond(moo_1+1,:), 'r')
        axis([0 1000 0 400])
        goodplot
    end
end

% anova
anovadata_groupvar= [...
    HC.cond(1,:) HC.cond(2,:) HC.cond(3,:) HC.cond(4,:) HC.cond(5,:) ...
    HC.cond(6,:) HC.cond(7,:) HC.cond(8,:) HC.cond(9,:) HC.cond(10,:) ...
    PAT.cond(1,:) PAT.cond(2,:) PAT.cond(3,:) PAT.cond(4,:) PAT.cond(5,:) ...
    PAT.cond(6,:) PAT.cond(7,:) PAT.cond(8,:) PAT.cond(9,:) PAT.cond(10,:)];

trial=22220;

test=ones(1,11110);
test2=test*2;
subjectgroup=[test test2];

%create conditions
condition= cell(1,22220);
for i=1:11110/2
    condition{i} = 'clear';
end
for i=5556:22220/2
    condition{i} = 'noise';
end
condition=[condition condition]
condition=condition';

group1=[subjectgroup];
group2=[condition];
p = anovan(anovadata_groupvar,{group1 group2 },'model','interaction')




% RESULT: 









% %%  Plot each subjects' mean response and the group mean
% %good subs only
% fig1b=figure
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'PAT GROUP DATA: All patients and mean patient response', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% subplot(5,2,1)
% for moo=1:numpats
% plot(DATA_TO_USE(moo).mean_cond1_wholetrial(1,:), 'm');
% hold all
% plot(group_cond1_pats_to_use_mean,'g','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (patients)'));
% end
% subplot(5,2,3)
% for moo=1:numpats
% plot(DATA_TO_USE(moo).mean_cond2_wholetrial(1,:), 'm');
% hold all
% plot(group_cond2_pats_to_use_mean,'g','LineWidth',1.3)
% title(sprintf('Cond2 - average across subjects (patients)'));
% end
% 
% 
% subplot(5,2,5)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond3_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond3_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond3 - average across subjects (patients)'));
% end
% 
% subplot(5,2,7)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond4_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond4_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond4 - average across subjects (patients)'));
% end
% subplot(5,2,9)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond5_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond5_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond5 - average across subjects (patients)'));
% end
% 
% subplot(5,2,2)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond6_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond6_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond6 - average across subjects (patients)'));
% end
% 
% subplot(5,2,4)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond7_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond7_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond7 - average across subjects (patients)'));
% end
% 
% subplot(5,2,6)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond8_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond8_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond8 - average across subjects (patients)'));
% end
% 
% subplot(5,2,8)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond9_wholetrial(1,:), 'm');
%     hold on
%     plot(group_cond9_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond9 - average across subjects (patients)'));
% end
% 
% subplot(5,2,10)
% for moo=1:numpats
%     plot(DATA_TO_USE(moo).mean_cond10_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond10_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond10 - average across subjects (patients)'));
% end
% 
% saveas(fig1b, 'Single and group mean patient responses GD SUBS ONLY.jpg')
% 
% 
% 
% fig1c=figure
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'HC GROUP DATA: All HCients and mean HCient response', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% subplot(5,2,1)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond1_wholetrial(1,:), 'm');
% hold all
% plot(group_cond1_HCs_to_use_mean,'g','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (HCients)'));
% end
% subplot(5,2,3)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond2_wholetrial(1,:), 'm');
% hold all
% plot(group_cond2_HCs_to_use_mean,'g','LineWidth',1.3)
% title(sprintf('Cond2 - average across subjects (HCients)'));
% end
% 
% 
% subplot(5,2,5)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond3_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond3_HCs_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond3 - average across subjects (HCients)'));
% end
% 
% subplot(5,2,7)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond4_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond4_HCs_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond4 - average across subjects (HCients)'));
% end
% subplot(5,2,9)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond5_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond5_HCs_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond5 - average across subjects (HCients)'));
% end
% 
% subplot(5,2,2)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond6_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond6_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond6 - average across subjects (HCients)'));
% end
% 
% subplot(5,2,4)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond7_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond7_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond7 - average across subjects (HCients)'));
% end
% 
% subplot(5,2,6)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond8_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond8_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond8 - average across subjects (HCients)'));
% end
% 
% subplot(5,2,8)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond9_wholetrial(1,:), 'm');
%     hold on
%     plot(group_cond9_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond9 - average across subjects (HCients)'));
% end
% 
% subplot(5,2,10)
% for moo=1:numHCs
%     plot(DATA_TO_USE(moo).mean_cond10_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond10_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond10 - average across subjects (HCients)'));
% end
% 
% saveas(fig1c, 'Single and group mean HC responses GD SUBS ONLY.jpg')


%% all subs for viewing purposes

% 
% fig1=figure
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'PAT GROUP DATA: All patients and mean patient response', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% subplot(5,2,1)
% for moo=1:16
%     plot(DATA(moo).mean_cond1_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond1_pats_to_use_mean, 'g','LineWidth',1.3)
%     title(sprintf('Cond1 - average across subjects (patients)'));
% end
% 
% subplot(5,2,3)
% for moo=1:16
%     plot(DATA(moo).mean_cond2_wholetrial(1,:), 'm');
%     hold on
%     plot(group_cond2_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond2 - average across subjects (patients)'));
% end
% 
% subplot(5,2,5)
% for moo=1:16
%     plot(DATA(moo).mean_cond3_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond3_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond3 - average across subjects (patients)'));
% end
% 
% subplot(5,2,7)
% for moo=1:16
%     plot(DATA(moo).mean_cond4_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond4_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond4 - average across subjects (patients)'));
% end
% subplot(5,2,9)
% for moo=1:16
%     plot(DATA(moo).mean_cond5_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond5_pats_to_use_mean,'g','LineWidth',1.3)
%     title(sprintf('Cond5 - average across subjects (patients)'));
% end
% 
% subplot(5,2,2)
% for moo=1:16
%     plot(DATA(moo).mean_cond6_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond6_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond6 - average across subjects (patients)'));
% end
% 
% subplot(5,2,4)
% for moo=1:16
%     plot(DATA(moo).mean_cond7_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond7_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond7 - average across subjects (patients)'));
% end
% 
% subplot(5,2,6)
% for moo=1:16
%     plot(DATA(moo).mean_cond8_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond8_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond8 - average across subjects (patients)'));
% end
% 
% subplot(5,2,8)
% for moo=1:16
%     plot(DATA(moo).mean_cond9_wholetrial(1,:), 'm');
%     hold on
%     plot(group_cond9_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond9 - average across subjects (patients)'));
% end
% 
% subplot(5,2,10)
% for moo=1:16
%     plot(DATA(moo).mean_cond10_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond10_pats_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond10 - average across subjects (patients)'));
% end
% 
% saveas(fig1, 'Single and group mean patient responses.jpg')
% 
% fig2=figure;
% c=subplot(2,5,1);
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'HCs GROUP DATA: All HCs and mean patient response', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% subplot(5,2,1)
% for moo=17:27
%     plot(DATA(moo).mean_cond1_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond1_HCs_to_use_mean,'c','LineWidth',1.3)
%     title(sprintf('Cond1 - average across subjects (HCs)'));
% end
% 
% %GroupMean_HCs_cond10
% subplot(5,2,3)
% for moo=17:27
%     plot(DATA(moo).mean_cond2_wholetrial(1,:), 'm');
%     %pause
%     hold all
%     plot(group_cond2_HCs_to_use_mean,'c','LineWidth',1.3)
%     title(sprintf('Cond2 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,5)
% for moo=17:27
%     plot(DATA(moo).mean_cond3_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond3_HCs_to_use_mean,'c','LineWidth',1.3)
%     title(sprintf('Cond3 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,7)
% for moo=17:27
%     plot(DATA(moo).mean_cond4_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond4_HCs_to_use_mean,'c','LineWidth',1.3)
%     title(sprintf('Cond4 - average across subjects (HCs)'));
% end
% subplot(5,2,9)
% for moo=17:27
%     plot(DATA(moo).mean_cond5_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond5_HCs_to_use_mean,'c','LineWidth',1.3)
%     title(sprintf('Cond5 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,2)
% for moo=17:27
%     plot(DATA(moo).mean_cond6_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond6_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond6 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,4)
% for moo=17:27
%     plot(DATA(moo).mean_cond7_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond7_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond7 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,6)
% for moo=17:27
%     plot(DATA(moo).mean_cond8_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond8_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond8 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,8)
% for moo=17:27
%     plot(DATA(moo).mean_cond9_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond9_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond9 - average across subjects (HCs)'));
% end
% 
% subplot(5,2,10)
% for moo=17:27
%     plot(DATA(moo).mean_cond10_wholetrial(1,:), 'm');
%     hold all
%     plot(group_cond10_HCs_to_use_mean,'b','LineWidth',1.3)
%     title(sprintf('Cond10 - average across subjects (HCs)'));
% end
% 
% saveas(fig2, 'Single and group mean HC responses.jpg')
% 
% % prewindow
% 
% fig3=figure;
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'PAT GROUP DATA: All patients and mean patient response', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% 
% for moo=1:16
% plot(DATA(moo).mean_cond1_pre(1,:), 'm');
% hold all
% plot(group_cond1_pats_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (patients)'));
% end
% 
% subplot(5,2,3)
% for moo=1:16
% plot(DATA(moo).mean_cond2_pre(1,:), 'm');
% hold all
% plot(group_cond2_pats_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond2 - average across subjects (patients)'));
% end
% 
% subplot(5,2,5)
% for moo=1:16
% plot(DATA(moo).mean_cond3_pre(1,:), 'm');
% hold all
% plot(group_cond3_pats_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond3 - average across subjects (patients)'));
% end
% 
% subplot(5,2,7)
% for moo=1:16
% plot(DATA(moo).mean_cond4_pre(1,:), 'm');
% hold all
% plot(group_cond4_pats_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond4 - average across subjects (patients)'));
% end
% 
% subplot(5,2,9)
% for moo=1:16
% plot(DATA(moo).mean_cond5_pre(1,:), 'm');
% hold all
% plot(group_cond5_pats_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond5 - average across subjects (patients)'));
% end
% 
% subplot(5,2,2)
% for moo=1:16
% plot(DATA(moo).mean_cond6_pre(1,:), 'm');
% hold all
% plot(group_cond6_pats_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond6 - average across subjects (patients)'));
% end
% 
% subplot(5,2,4)
% for moo=1:16
% plot(DATA(moo).mean_cond7_pre(1,:), 'm');
% hold all
% plot(group_cond7_pats_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond7 - average across subjects (patients)'));
% end
% 
% subplot(5,2,6)
% for moo=1:16
% plot(DATA(moo).mean_cond8_pre(1,:), 'm');
% hold all
% plot(group_cond8_pats_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond8 - average across subjects (patients)'));
% end
% 
% subplot(5,2,8)
% for moo=1:16
% plot(DATA(moo).mean_cond9_pre(1,:), 'm');
% hold all
% plot(group_cond9_pats_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond9 - average across subjects (patients)'));
% end
% 
% subplot(5,2,10)
% for moo=1:16
% plot(DATA(moo).mean_cond10_pre(1,:), 'm');
% hold all
% plot(group_cond10_pats_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond10 - average across subjects (patients)'));
% end
% 
% saveas(fig3, 'Single and group mean patient responses_pre window only.jpg')
% 
% 
% %% compare good and bad sub means
% 
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond1_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond1_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond1_wholetrial(1,:), 'k');
% hold all
% plot(group_cond1_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (HCients)'));
% end
% 
% % cond2
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond2_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond2_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond2 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond2_wholetrial(1,:), 'k');
% hold all
% plot(group_cond2_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond2 - average across subjects (HCients)'));
% end
% 
% % cond3
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond3_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond3_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond3 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond3_wholetrial(1,:), 'k');
% hold all
% plot(group_cond3_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond3 - average across subjects (HCients)'));
% end
% 
% % cond4
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond4_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond4_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond4 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond4_wholetrial(1,:), 'k');
% hold all
% plot(group_cond4_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond4 - average across subjects (HCients)'));
% end
%  
% % cond5
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond5_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond5_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond5 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond5_wholetrial(1,:), 'k');
% hold all
% plot(group_cond5_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond5 - average across subjects (HCients)'));
% end
% 
% % cond6
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond6_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond6_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond5 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond6_wholetrial(1,:), 'k');
% hold all
% plot(group_cond6_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond6 - average across subjects (HCients)'));
% end
% 
% % cond7
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond7_wholetrial(1,:), 'k');
% hold all
% plot(group_cond7_HCs_to_use_mean,'m','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond7_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond7_HCs),'b','LineWidth',1.3)
% title(sprintf('Cond7 - average across subjects (HCients)'));
% end
% 
% 
% % cond8
% figure
% subplot(2,1,1)
% for moo=1:totalHCs
% plot(DATA(moo).mean_cond8_wholetrial(1,:), 'k');
% hold all
% plot(nanmean(group_cond8_HCs),'m','LineWidth',1.3)
% title(sprintf('Cond8 - average across subjects (HCients)'));
% end
% 
% subplot(2,1,2)
% for moo=1:numHCs
% plot(DATA_TO_USE(moo).mean_cond8_wholetrial(1,:), 'k');
% hold all
% plot(group_cond8_HCs_to_use_mean,'b','LineWidth',1.3)
% title(sprintf('Cond8 - average across subjects (HCients)'));
% end
% 
% 
% 





% 
% % prewindow
% fig4=figure;
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'HC GROUP DATA: All patients and mean patient response', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% subplot(5,2,1)
% for moo=1:16
% plot(DATA(moo).mean_cond1_pre(1,:), 'm');
% hold all
% plot(group_cond1_HCs_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond1 - average across subjects (patients)'));
% end
% 
% subplot(5,2,3)
% for moo=1:16
% plot(DATA(moo).mean_cond2_pre(1,:), 'm');
% hold all
% plot(group_cond2_HCs_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond2 - average across subjects (patients)'));
% end
% 
% subplot(5,2,5)
% for moo=1:16
% plot(DATA(moo).mean_cond3_pre(1,:), 'm');
% hold all
% plot(group_cond3_HCs_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond3 - average across subjects (patients)'));
% end
% 
% subplot(5,2,7)
% for moo=1:16
% plot(DATA(moo).mean_cond4_pre(1,:), 'm');
% hold all
% plot(group_cond4_HCs_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond4 - average across subjects (patients)'));
% end
% subplot(5,2,9)
% for moo=1:16
% plot(DATA(moo).mean_cond5_pre(1,:), 'm');
% hold all
% plot(group_cond5_HCs_to_use_pre_mean,'c','LineWidth',1.3)
% title(sprintf('Cond5 - average across subjects (patients)'));
% end
% 
% subplot(5,2,2)
% for moo=1:16
% plot(DATA(moo).mean_cond6_pre(1,:), 'm');
% hold all
% plot(group_cond6_HCs_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond6 - average across subjects (patients)'));
% end
% 
% subplot(5,2,4)
% for moo=1:16
% plot(DATA(moo).mean_cond7_pre(1,:), 'm');
% hold all
% plot(group_cond7_HCs_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond7 - average across subjects (patients)'));
% end
% 
% subplot(5,2,6)
% for moo=1:16
% plot(DATA(moo).mean_cond8_pre(1,:), 'm');
% hold all
% plot(group_cond8_HCs_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond8 - average across subjects (patients)'));
% end
% 
% subplot(5,2,8)
% for moo=1:16
% plot(DATA(moo).mean_cond9_pre(1,:), 'm');
% hold all
% plot(group_cond9_HCs_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond9 - average across subjects (patients)'));
% end
% 
% subplot(5,2,10)
% for moo=1:16
% plot(DATA(moo).mean_cond10_pre(1,:), 'm');
% hold all
% plot(group_cond10_HCs_to_use_pre_mean,'b','LineWidth',1.3)
% title(sprintf('Cond10 - average across subjects (patients)'));
% end
% saveas(fig4, 'Single and group mean patient responses_pre window only.jpg')
% 

