%% Compares mean pitches to target

% Questions
% (1) are people better at hitting the target in clear or noise trials?
% ttest between

% (2) Does performance affect stdev, are people who are further from the
% target displaying a greater stdevn?
% Get a measure of performance for each subject over all, in clear and
% noise trials for pre and post windows
% correlate this to stdev of pitch {where is this?}
% STATS =
%
%      clearVnoise_pre_patients: 0
%           clearVnoise_pre_HCs: 0
%     clearVnoise_post_patients: 1
%          clearVnoise_post_HCs: 0  

clear all
close all
set_params;
home=pwd

cd /Users/zagnew/Cereb_data/data/SUB01/expr2014.03.21.T10.46.03_mainrun/speak/block0

pitchdata_old=get_vec_hist6('pitch2',3);            % two arguments are file name and then file type (float vec)
orig_pertresp=get_vec_hist6('blockalt',3);          % pert response (needs to be shifted in time as only begins in response to voice onsett detect
voiceonset=get_vec_hist6('voice_onset_detect',2);   % voice detect
outbuff_wav=get_vec_hist6('outbuffer', 3);          % ZKA: playable waveform - do spectral analysis on this signal
outbuff_pitch=get_vec_hist6('output_pitch', 3);     % pitch of outbuffer is the target
amp=get_vec_hist6('weighted_mean_abs_inbuffer2', 3);
audio=get_vec_hist6('inbuffer2',3);
voicethresh=get_vec_hist6('thresh_inbuffer_state',2);

fs = 11025;
pitch_lims = [90 250]; % sets pitch finding limits
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

% create shifts
shift(1)=1;
shift(2)=2;
shift(3)=0;
shift(4)=-1;
shift(5)=-2;

%load /Users/zagnew/Cereb_data/data/GroupData/GroupData.mat
load /Users/zagnew/Cereb_data/data/DATA.mat
load /Users/zagnew/Cereb_data/data/DATA_TO_USE.mat
% load /Users/zagnew/Cereb_data/data/TrialData.mat      % trial by trial wtstdevs for each subject
% DATA(27).mean_cond1_pre
cd /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches
% load and rename all the subject target pitches
%patients
subj_MP_allsubs(1) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140321T103415.mat');
subj_MP_allsubs(2) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140321T121956.mat');
subj_MP_allsubs(3) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140321T142416.mat');
subj_MP_allsubs(4) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140321T170947.mat');
subj_MP_allsubs(5) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140321T183529.mat');
subj_MP_allsubs(6) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140322T104901.mat');
% manually changed it to 135 Hz^^
subj_MP_allsubs(7) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140322T115150.mat');
subj_MP_allsubs(8) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140322T134549.mat');
subj_MP_allsubs(9) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140322T154047.mat');
subj_MP_allsubs(10) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140322T162455.mat');
subj_MP_allsubs(11) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140322T183812.mat');
subj_MP_allsubs(12) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140323T104953.mat');
subj_MP_allsubs(13) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140323T132703.mat');
subj_MP_allsubs(14) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140323T150747.mat');
subj_MP_allsubs(15) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140323T162223.mat');
subj_MP_allsubs(16) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140323T180417.mat');

%HCs
subj_MP_allsubs(17) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140506T121323.mat');
subj_MP_allsubs(18) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140617T123801.mat');
subj_MP_allsubs(19) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140617T133413_real.mat');
subj_MP_allsubs(20) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140617T161417.mat');
subj_MP_allsubs(21) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140618T150410.mat');
subj_MP_allsubs(22) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140618T160728.mat');
subj_MP_allsubs(23) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140814T154458.mat');
subj_MP_allsubs(24) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140915T173347.mat');
subj_MP_allsubs(25) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140921T133544.mat');
subj_MP_allsubs(26) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140921T152451.mat');
subj_MP_allsubs(27) = load('/Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/meanpitch_20140923T151309.mat');

%good subs
subj_MP_goodsubjs=subj_MP_allsubs(allincluded);

%% (1) Calculates target shifts in Hz from each subjects' mean pitch
for isubj=1:27
    shiftinhertz_allsubs(isubj).smallstepup(1)  = (2^0.0833)^shift(1) * subj_MP_allsubs(isubj).meanpitch % change 1 to number of semitones
    shiftinhertz_allsubs(isubj).bigstepup(1)    = (2^0.0833)^shift(2) * subj_MP_allsubs(isubj).meanpitch % change 1 to number of semitones
    shiftinhertz_allsubs(isubj).nostep(1)       = (2^0.0833)^ shift(3)* subj_MP_allsubs(isubj).meanpitch % change 1 to number of semitones
    shiftinhertz_allsubs(isubj).smallstepdown(1) = (2^0.0833)^shift(4)* subj_MP_allsubs(isubj).meanpitch % change 1 to number of semitones
    shiftinhertz_allsubs(isubj).bigstepdown(1)  = (2^0.0833)^shift(5) * subj_MP_allsubs(isubj).meanpitch % change 1 to number of semitones
end

% manually change subject 6
subj_MP_allsubs(6).meanpitch=135;

save SubjectShiftsAllSubs.mat shiftinhertz_allsubs

set_params;
% Write out only good subjects:-

shiftinhertz_gdsubs=shiftinhertz_allsubs(allincluded)
save SubjectShiftsGdSubs.mat shiftinhertz_gdsubs

% shiftinhertz_allsubs(3).nostep   170.2775
% shiftinhertz_allsubs(3).smallstepdown     160.7242
% shiftinhertz_allsubs(5).nostep        124.2258
% shiftinhertz_allsubs(5).smallstepdown   117.2562






%% (2) Calulate distance between target and pitch for *each trial* for all subjects 

load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/SubjectShiftsAllSubs
for isubj = 1:27
    for itrial=1:8
        Diff_allsubs_eachtrial_allsubs(isubj).cond1_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch - DATA(isubj).WTtrialmeanpitch_cond1_pre(itrial);
        Diff_allsubs_eachtrial_allsubs(isubj).cond1_post(itrial) = shiftinhertz_allsubs(isubj).smallstepup -  DATA(isubj).WTtrialmeanpitch_cond1_post(itrial);
        Diff_allsubs_eachtrial_allsubs(isubj).cond2_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond2_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond2_post(itrial) = shiftinhertz_allsubs(isubj).bigstepup -  DATA(isubj).WTtrialmeanpitch_cond2_post(itrial);
        Diff_allsubs_eachtrial_allsubs(isubj).cond3_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond3_pre(itrial)    ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond3_post(itrial) = shiftinhertz_allsubs(isubj).nostep -  DATA(isubj).WTtrialmeanpitch_cond3_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond4_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond4_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond4_post(itrial) = shiftinhertz_allsubs(isubj).smallstepdown-  DATA(isubj).WTtrialmeanpitch_cond4_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond5_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond5_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond5_post(itrial) = shiftinhertz_allsubs(isubj).bigstepdown -  DATA(isubj).WTtrialmeanpitch_cond5_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond6_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond6_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond6_post(itrial) = shiftinhertz_allsubs(isubj).smallstepup -  DATA(isubj).WTtrialmeanpitch_cond6_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond7_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond7_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond7_post(itrial) = shiftinhertz_allsubs(isubj).bigstepup -  DATA(isubj).WTtrialmeanpitch_cond7_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond8_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond8_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond8_post(itrial) = shiftinhertz_allsubs(isubj).nostep -  DATA(isubj).WTtrialmeanpitch_cond8_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond9_pre(itrial) =  subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond8_post(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond9_post(itrial) = shiftinhertz_allsubs(isubj).smallstepdown -  DATA(isubj).WTtrialmeanpitch_cond9_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond10_pre(itrial) = subj_MP_allsubs(isubj).meanpitch -  DATA(isubj).WTtrialmeanpitch_cond10_pre(itrial)  ;
        Diff_allsubs_eachtrial_allsubs(isubj).cond10_post(itrial)= shiftinhertz_allsubs(isubj).bigstepdown -  DATA(isubj).WTtrialmeanpitch_cond10_post(itrial)  ;
    end
end

% good subjects
Diff_eachtrial_goodsubs=Diff_allsubs_eachtrial_allsubs(allincluded);

save Diff_allsubs_eachtrial_allsubs Diff_allsubs_eachtrial_allsubs
pwd


%% (3) Correlate meanwtstdev and distance from target on trial by trial basis for GOOD SUBS ONLY

for isubj=1:numsubs;
    temp1_clear_pre(isubj,:)=[Diff_eachtrial_goodsubs(isubj).cond1_pre Diff_eachtrial_goodsubs(isubj).cond2_pre Diff_eachtrial_goodsubs(isubj).cond3_pre Diff_eachtrial_goodsubs(isubj).cond4_pre Diff_eachtrial_goodsubs(isubj).cond5_pre];
    temp_meandistance_clear_pre(isubj,:)=temp1_clear_pre(isubj,:);
    temp2_clear_pre(isubj,:)=[DATA_TO_USE(isubj).StdWithinCond1_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond2_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond3_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond4_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond5_within_pre_stdev];
    temp_wtstdev_clear_pre(isubj,:)=temp2_clear_pre(isubj,:);
    
    temp1_noise_pre(isubj,:)=[Diff_eachtrial_goodsubs(isubj).cond6_pre Diff_eachtrial_goodsubs(isubj).cond7_pre Diff_eachtrial_goodsubs(isubj).cond8_pre Diff_eachtrial_goodsubs(isubj).cond9_pre Diff_eachtrial_goodsubs(isubj).cond10_pre];
    temp_meandistance_clear_pre(isubj,:)=temp1_noise_pre(isubj,:);
    temp2_noise_pre(isubj,:)=[DATA_TO_USE(isubj).StdWithinCond6_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond7_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond8_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond9_within_pre_stdev DATA_TO_USE(isubj).StdWithinCond10_within_pre_stdev];
    temp_wtstdev_clear_pre(isubj,:)=temp2_noise_pre(isubj,:);
    
    temp1_clear_post(isubj,:)=[Diff_eachtrial_goodsubs(isubj).cond1_post Diff_eachtrial_goodsubs(isubj).cond2_post Diff_eachtrial_goodsubs(isubj).cond3_post Diff_eachtrial_goodsubs(isubj).cond4_post Diff_eachtrial_goodsubs(isubj).cond5_post];
    temp_meandistance_clear_post(isubj,:)=temp1_clear_post(isubj,:);
    temp2_clear_post(isubj,:)=[DATA_TO_USE(isubj).StdWithinCond1_within_post_stdev DATA_TO_USE(isubj).StdWithinCond2_within_post_stdev DATA_TO_USE(isubj).StdWithinCond3_within_post_stdev DATA_TO_USE(isubj).StdWithinCond4_within_post_stdev DATA_TO_USE(isubj).StdWithinCond5_within_post_stdev];emp_wtstdev_clear_post(isubj,:)=temp2_clear_post(isubj,:);
    
    temp1_noise_post(isubj,:)=[Diff_eachtrial_goodsubs(isubj).cond6_post Diff_eachtrial_goodsubs(isubj).cond7_post Diff_eachtrial_goodsubs(isubj).cond8_post Diff_eachtrial_goodsubs(isubj).cond9_post Diff_eachtrial_goodsubs(isubj).cond10_post];
    temp_meandistance_clear_post(isubj,:)=temp1_noise_post(isubj,:);
    temp2_noise_post(isubj,:)=[DATA_TO_USE(isubj).StdWithinCond6_within_post_stdev DATA_TO_USE(isubj).StdWithinCond7_within_post_stdev DATA_TO_USE(isubj).StdWithinCond8_within_post_stdev DATA_TO_USE(isubj).StdWithinCond9_within_post_stdev DATA_TO_USE(isubj).StdWithinCond10_within_post_stdev];
    temp_wtstdev_clear_post(isubj,:)=temp2_noise_post(isubj,:);
    
    %remove nans
    validdata1(isubj, :) = ~isnan(temp_meandistance_clear_pre(isubj, :))
    validdata2(isubj, :) = ~isnan(temp_wtstdev_clear_pre(isubj, :))
    validdataBoth(isubj,:) = validdata1(isubj,:) & validdata2(isubj,:)
    tempdata_meandist=temp_meandistance_clear_pre(isubj, :);
    tempdata_stdevpitch=temp_wtstdev_clear_pre(isubj, :);
    keep1 = tempdata_meandist(validdataBoth(isubj,:))
    keep2 = tempdata_stdevpitch(validdataBoth(isubj,:))
    linear_rgrn(isubj,:)=polyfit(keep1, keep2, 2)
    [R,P]=corrcoef(keep1,keep2)
    Rval{isubj} = R
    Pval{isubj} = P
end
%
% figure
% subplot(2,1,1)
% for k=1:numpats
%     bar(k, Rval{k}(2))
%     hold all
% end
% axis([0 13 -2 2])
%
% subplot(2,1,2)
% for k=numpats+1:numsubs
%     bar(k, Rval{k}(2), 'm')
%     hold all
% end
% axis([13 26 -2 2])
%
% figure
% subplot(2,1,1)
% for k=1:numpats
%     bar(k, Pval{k}(2))
%     hold all
% end
% axis([0 13 -2 2])
%
% subplot(2,1,2)
% for k=numpats+1:numsubs
%     bar(k, Pval{k}(2), 'm')
%     hold all
% end
% axis([13 26 -2 2])

% % which of those are significant?
% for k=1:numsubs
%     if  Pval{k}(2)<=0.05
%         sig_corr(k)=1
%     end
% end


%% Group correlation anocova
% make variables
% for moo=1:numpats
% cleartrials_wtstdev_pats_pre=[temp1_clear_pre(1,:) temp1_clear_pre(2,:) temp1_clear_pre(1,:) temp1_clear_pre(2,:) temp1_clear_pre(1,:) temp1_clear_pre(2,:) temp1_clear_pre(1,:) temp1_clear_pre(2,:)]
% 
% 
% test= unique(reshape(temp1_clear_pre(1:numpats,:),1,[]))
% 
% A=123;456;789
% 
% 
% reshape(temp1_clear_pre(1:numpats,:),1,600)
% 
% B = temp1_clear_pre(:)';
% 
% A = unique(reshape(A,1,[]))
% 
% C = horzcat(temp1_clear_pre(1,:),temp1_clear_pre(2,:))
% 
% A=[1 2 3; 4 5 6]
% B=A(:)'

cleartrials_wtstdev_pats_pre=[temp1_clear_pre(1,:) temp1_clear_pre(2,:) temp1_clear_pre(3,:) ...
    temp1_clear_pre(4,:) temp1_clear_pre(5,:) temp1_clear_pre(6,:) ...
    temp1_clear_pre(7,:) temp1_clear_pre(8,:) temp1_clear_pre(9,:) ...
    temp1_clear_pre(10,:) temp1_clear_pre(11,:)];

cleartrials_wtstdev_HCs_pre=[temp1_clear_pre(12,:) temp1_clear_pre(13,:) ...
    temp1_clear_pre(14,:) temp1_clear_pre(15,:)];

noisetrials_wtstdev_pats_pre=[temp1_noise_pre(1,:) temp1_noise_pre(2,:) temp1_noise_pre(3,:) ...
    temp1_noise_pre(4,:) temp1_noise_pre(5,:) temp1_noise_pre(6,:) ...
    temp1_noise_pre(7,:) temp1_noise_pre(8,:) temp1_noise_pre(9,:) ...
    temp1_noise_pre(10,:) temp1_noise_pre(11,:)];

noisetrials_wtstdev_HCs_pre=[temp1_noise_pre(12,:) temp1_noise_pre(13,:) ...
    temp1_noise_pre(14,:) temp1_noise_pre(15,:)];


cleartrials_wtstdev_pats_post=[temp1_clear_post(1,:) temp1_clear_post(2,:) temp1_clear_post(3,:) ...
    temp1_clear_post(4,:) temp1_clear_post(5,:) temp1_clear_post(6,:) ...
    temp1_clear_post(7,:) temp1_clear_post(8,:) temp1_clear_post(9,:) ...
    temp1_clear_post(10,:) temp1_clear_post(11,:)];

cleartrials_wtstdev_HCs_post=[temp1_clear_post(12,:) temp1_clear_post(13,:) ...
    temp1_clear_post(14,:) temp1_clear_post(15,:)];

noisetrials_wtstdev_pats_post=[temp1_noise_post(1,:) temp1_noise_post(2,:) temp1_noise_post(3,:) ...
    temp1_noise_post(4,:) temp1_noise_post(5,:) temp1_noise_post(6,:) ...
    temp1_noise_post(7,:) temp1_noise_post(8,:) temp1_noise_post(9,:) ...
    temp1_noise_post(10,:) temp1_noise_post(11,:)];

noisetrials_wtstdev_HCs_post=[temp1_noise_post(12,:) temp1_noise_post(13,:) ...
    temp1_noise_post(14,:) temp1_noise_post(15,:)];





cleartrials_dist_fm_targ_pats_pre=[temp2_clear_pre(1,:) temp2_clear_pre(2,:) temp2_clear_pre(3,:) ...                                  
    temp2_clear_pre(4,:) temp2_clear_pre(5,:) temp2_clear_pre(6,:) ...
    temp2_clear_pre(7,:) temp2_clear_pre(8,:) temp2_clear_pre(9,:) ...
    temp2_clear_pre(10,:) temp2_clear_pre(11,:)];

cleartrials_dist_fm_targ_HCs_pre=[temp2_clear_pre(12,:) temp2_clear_pre(13,:) ...
    temp2_clear_pre(14,:) temp2_clear_pre(15,:)];


noisetrials_dist_fm_targ_pats_pre=[temp2_noise_pre(1,:) temp2_noise_pre(2,:) temp2_noise_pre(3,:) ...                                  
    temp2_noise_pre(4,:) temp2_noise_pre(5,:) temp2_noise_pre(6,:) ...
    temp2_noise_pre(7,:) temp2_noise_pre(8,:) temp2_noise_pre(9,:) ...
    temp2_noise_pre(10,:) temp2_noise_pre(11,:)];

noisetrials_dist_fm_targ_HCs_pre=[temp2_noise_pre(12,:) temp2_noise_pre(13,:) ...
    temp2_noise_pre(14,:) temp2_noise_pre(15,:)];



cleartrials_dist_fm_targ_pats_post=[temp2_clear_post(1,:) temp2_clear_post(2,:) temp2_clear_post(3,:) ...                                  
    temp2_clear_post(4,:) temp2_clear_post(5,:) temp2_clear_post(6,:) ...
    temp2_clear_post(7,:) temp2_clear_post(8,:) temp2_clear_post(9,:) ...
    temp2_clear_post(10,:) temp2_clear_post(11,:)];

cleartrials_dist_fm_targ_HCs_post=[temp2_clear_post(12,:) temp2_clear_post(13,:) ...
    temp2_clear_post(14,:) temp2_clear_post(15,:)];


noisetrials_dist_fm_targ_pats_post=[temp2_noise_post(1,:) temp2_noise_post(2,:) temp2_noise_post(3,:) ...                                  
    temp2_noise_post(4,:) temp2_noise_post(5,:) temp2_noise_post(6,:) ...
    temp2_noise_post(7,:) temp2_noise_post(8,:) temp2_noise_post(9,:) ...
    temp2_noise_post(10,:) temp2_noise_post(11,:)];

noisetrials_dist_fm_targ_HCs_post=[temp2_noise_post(12,:) temp2_noise_post(13,:) ...
    temp2_noise_post(14,:) temp2_noise_post(15,:)];



save /Users/zagnew/Cereb_data/data/ANCOVA_DATA.mat ...
    cleartrials_wtstdev_pats_pre cleartrials_wtstdev_HCs_pre ...
    noisetrials_wtstdev_pats_pre noisetrials_wtstdev_HCs_pre ...
    cleartrials_wtstdev_pats_post cleartrials_wtstdev_HCs_post ...
    noisetrials_wtstdev_pats_post noisetrials_wtstdev_HCs_post ...
    cleartrials_dist_fm_targ_pats_pre cleartrials_dist_fm_targ_HCs_pre ...
    noisetrials_dist_fm_targ_pats_pre noisetrials_dist_fm_targ_HCs_pre ...
    cleartrials_dist_fm_targ_pats_post cleartrials_dist_fm_targ_HCs_post ...
    noisetrials_dist_fm_targ_pats_post noisetrials_dist_fm_targ_HCs_post



%% calculate the difference between the target and their mean response for each subject for each condition:-
for isubj=1:27
    Diff_allsubs(isubj).cond1_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond1_pre)    %small up
    Diff_allsubs(isubj).cond1_post= shiftinhertz_allsubs(isubj).smallstepup - nanmean(DATA(isubj).mean_cond1_post)   %small up

    Diff_allsubs(isubj).cond2_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond2_pre)    %big up
    Diff_allsubs(isubj).cond2_post= shiftinhertz_allsubs(isubj).bigstepup - nanmean(DATA(isubj).mean_cond2_post)
    
    Diff_allsubs(isubj).cond3_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond3_pre)    % flat
    Diff_allsubs(isubj).cond3_post= shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond3_post)
    
    Diff_allsubs(isubj).cond4_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond4_pre)
    Diff_allsubs(isubj).cond4_post= shiftinhertz_allsubs(isubj).smallstepdown- nanmean(DATA(isubj).mean_cond4_post)
    
    Diff_allsubs(isubj).cond5_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond5_pre)
    Diff_allsubs(isubj).cond5_post= shiftinhertz_allsubs(isubj).bigstepdown - nanmean(DATA(isubj).mean_cond5_post)
    
    Diff_allsubs(isubj).cond6_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond6_pre)
    Diff_allsubs(isubj).cond6_post= shiftinhertz_allsubs(isubj).smallstepup - nanmean(DATA(isubj).mean_cond6_post)
    
    Diff_allsubs(isubj).cond7_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond7_pre)
    Diff_allsubs(isubj).cond7_post= shiftinhertz_allsubs(isubj).bigstepup - nanmean(DATA(isubj).mean_cond7_post)
    
    Diff_allsubs(isubj).cond8_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond8_pre)
    Diff_allsubs(isubj).cond8_post= shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond8_post)

    Diff_allsubs(isubj).cond9_pre=  shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond9_pre)
    Diff_allsubs(isubj).cond9_post= shiftinhertz_allsubs(isubj).smallstepdown - nanmean(DATA(isubj).mean_cond9_post)
    
    Diff_allsubs(isubj).cond10_pre= shiftinhertz_allsubs(isubj).nostep - nanmean(DATA(isubj).mean_cond10_pre)
    Diff_allsubs(isubj).cond10_post=shiftinhertz_allsubs(isubj).bigstepdown - nanmean(DATA(isubj).mean_cond10_post)
end

% Write out only good subjects:-
Diff_gdsubs=Diff_allsubs(allincluded)


%% write out meannoise is an array where each lines is a patient for gd subs only:
for isubj=1:numpats
    temp1=[Diff_gdsubs(isubj).cond1_pre Diff_gdsubs(isubj).cond2_pre Diff_gdsubs(isubj).cond3_pre Diff_gdsubs(isubj).cond4_pre Diff_gdsubs(isubj).cond5_pre]
    temp2=[Diff_gdsubs(isubj).cond6_pre Diff_gdsubs(isubj).cond7_pre Diff_gdsubs(isubj).cond8_pre Diff_gdsubs(isubj).cond9_pre Diff_gdsubs(isubj).cond10_pre]
    mean_noise_pre_gdsubs(isubj)=nanmean(temp1);
    mean_clear_pre_gdsubs(isubj)=nanmean(temp2);
    stdevofpitch(isubj).cond1_pre= nanmean(DATA_TO_USE(isubj).StdWithinCond1_within_pre_stdev);
    stdevofpitch(isubj).cond1_post= nanmean(DATA_TO_USE(isubj).StdWithinCond1_within_post_stdev);
end

for isubj2=numpats+1:numpats+numHCs
    for temp_b=1:numHCs;
        tempa=[Diff_gdsubs(isubj2).cond1_pre Diff_gdsubs(isubj2).cond2_pre Diff_gdsubs(isubj2).cond3_pre Diff_gdsubs(isubj2).cond4_pre Diff_gdsubs(isubj2).cond5_pre]
        tempb=[Diff_gdsubs(isubj2).cond6_pre Diff_gdsubs(isubj2).cond7_pre Diff_gdsubs(isubj2).cond8_pre Diff_gdsubs(isubj2).cond9_pre Diff_gdsubs(isubj2).cond10_pre]
        mean_noise_pre_gdsubs(isubj2)=nanmean(tempa)
        mean_clear_pre_gdsubs(isubj2)=nanmean(tempb)
        stdevofpitch(isubj2).cond1_pre= nanmean(DATA_TO_USE(isubj2).StdWithinCond1_within_pre_stdev)
        stdevofpitch(isubj2).cond1_post= nanmean(DATA_TO_USE(isubj2).StdWithinCond1_within_post_stdev)
    end
end

%post
for isubj=1:numpats
    temp1a=[Diff_gdsubs(isubj).cond1_post Diff_gdsubs(isubj).cond2_post Diff_gdsubs(isubj).cond3_post Diff_gdsubs(isubj).cond4_post Diff_gdsubs(isubj).cond5_post]
    temp2a=[Diff_gdsubs(isubj).cond6_post Diff_gdsubs(isubj).cond7_post Diff_gdsubs(isubj).cond8_post Diff_gdsubs(isubj).cond9_post Diff_gdsubs(isubj).cond10_post]
    mean_noise_post_gdsubs(isubj)=nanmean(temp1a)
    mean_clear_post_gdsubs(isubj)=nanmean(temp2a)
    stdevofpitch(isubj).cond1_post= nanmean(DATA_TO_USE(isubj).StdWithinCond1_within_post_stdev)
    stdevofpitch(isubj).cond1_post= nanmean(DATA_TO_USE(isubj).StdWithinCond1_within_post_stdev)
end

for isubj2=numpats+1:numpats+numHCs
    for temp_b=1:numHCs;
        tempa2=[Diff_gdsubs(isubj2).cond1_post Diff_gdsubs(isubj2).cond2_post Diff_gdsubs(isubj2).cond3_post Diff_gdsubs(isubj2).cond4_post Diff_gdsubs(isubj2).cond5_post]
        tempb2=[Diff_gdsubs(isubj2).cond6_post Diff_gdsubs(isubj2).cond7_post Diff_gdsubs(isubj2).cond8_post Diff_gdsubs(isubj2).cond9_post Diff_gdsubs(isubj2).cond10_post]
        mean_noise_post_gdsubs(isubj2)=nanmean(tempa2)
        mean_clear_post_gdsubs(isubj2)=nanmean(tempb2)
        stdevofpitch(isubj2).cond1_post= nanmean(DATA_TO_USE(isubj2).StdWithinCond1_within_post_stdev)
        stdevofpitch(isubj2).cond1_post= nanmean(DATA_TO_USE(isubj2).StdWithinCond1_within_post_stdev)
    end
end


%% Q1. are people better at hitting the target in clear trials?

STATS.clearVnoise_pre_patients=ttest(mean_noise_pre_gdsubs(1:numpats), mean_clear_pre_gdsubs(1:numpats));
STATS.clearVnoise_pre_HCs=ttest(mean_noise_pre_gdsubs(numpats+1:numsubs), mean_clear_pre_gdsubs(numpats+1:numsubs));
STATS.clearVnoise_post_patients=ttest(mean_noise_post_gdsubs(1:numpats), mean_clear_post_gdsubs(1:numpats));
STATS.clearVnoise_post_HCs=ttest(mean_noise_post_gdsubs(numpats+1:numsubs), mean_clear_post_gdsubs(numpats+1:numsubs));


% nope
fig1=figure;
xmin= -4
xmax= 4

meansforplots_pre=[nanmean(mean_noise_pre_gdsubs(1:numpats)) nanmean(mean_clear_pre_gdsubs(1:numpats));nanmean(mean_noise_pre_gdsubs(numpats+1:numsubs)) nanmean(mean_clear_pre_gdsubs(numpats+1:numsubs))];
meansforplots_post=[nanmean(mean_noise_post_gdsubs(1:numpats)) nanmean(mean_clear_post_gdsubs(1:numpats));nanmean(mean_noise_post_gdsubs(numpats+1:numsubs)) nanmean(mean_clear_post_gdsubs(numpats+1:numsubs))];
stdevsforplots_pre=[nanstd(mean_noise_pre_gdsubs(1:numpats)) nanstd(mean_clear_pre_gdsubs(1:numpats));nanstd(mean_noise_pre_gdsubs(numpats+1:numsubs)) nanstd(mean_clear_pre_gdsubs(numpats+1:numsubs))];
stdevsforplots_post=[nanstd(mean_noise_post_gdsubs(1:numpats)) nanstd(mean_clear_post_gdsubs(1:numpats));nanstd(mean_noise_post_gdsubs(numpats+1:numsubs)) nanstd(mean_clear_post_gdsubs(numpats+1:numsubs))];
semforplot_pre=stdevsforplots_pre/(sqrt(13))
semforplot_post=stdevsforplots_post/(sqrt(13))% dividing the SD by the square root of N

% make positive
meansforplots_pre(:,2)=-meansforplots_pre(:,2)
meansforplots_post(:,2)=-meansforplots_post(:,2)
meansforplots_post(2,1)=-meansforplots_post(2,1)
subplot(2,1,1)
%bar(meansforplots_pre, 'm')
h = barwitherr(semforplot_pre, meansforplots_pre, 'r');
title('PRE step: - patients on the left, HCs on the right')
xlabel('     < patients   (noise, clear)                                        HCs (noise, clear)>')
ylabel('distance from target (Hz)')
axis([0.5 2.5 xmin xmax])

subplot(2,1,2)
% bar(meansforplots_post, 'c')
h = barwitherr(semforplot_post, meansforplots_post, 'b');
title('POST step: -patients on the left, HCs on the right')
xlabel('     < patients   (noise, clear)                                        HCs (noise, clear)>')
ylabel('distance from target (Hz)')
axis([0.5 2.5 xmin xmax])

%% anova

anovandata=[mean_clear_pre_gdsubs mean_clear_post_gdsubs ...
    mean_clear_pre_gdsubs mean_clear_post_gdsubs ...
    mean_noise_pre_gdsubs mean_noise_post_gdsubs ...
    mean_noise_pre_gdsubs mean_noise_post_gdsubs];

% anova_pats=mean_noise_pre_gdsubs(1:numpats)
% anova_HCsmean_noise_pre(numpats+1:numsubs)

%create subject group
pattest=ones(1,numpats);
HCtest=ones(1,numHCs);
test2=HCtest*2;
temp=[pattest test2]
subjectgroup=[temp temp temp temp temp temp temp temp];

%create window group
pre_post = cell(1,19);
for i=1:numsubs
    %names{i} = ['Sample Text ' num2str(i)];
    pre_post{i} = 'pre';
end
for i=numsubs+1:numsubs*2
    pre_post{i} = 'post';
end

pre_post2=[pre_post pre_post pre_post pre_post]
pre_post=pre_post2';

%create condition group
condition = cell(1,40);
for i=1:numsubs*4
    condition{i}='clear';
end
for i=numsubs*4+1:numsubs*8
    condition{i}='noise';
end
condition=condition';

group1=[subjectgroup];
group2=[pre_post];
group3=[condition];
p = anovan(anovandata,{group1 group2 group3},'model','interaction');


% independant t test to see if patients are worse than HCs in clear or
% noise conditions.
STATS.HCsVpatients_noise=ttest2(mean_noise_pre_gdsubs(1:numpats), mean_noise_pre_gdsubs(numpats+1:numsubs))
STATS.HCsVpatients_clear=ttest2(mean_clear_pre_gdsubs(1:numpats), mean_clear_pre_gdsubs(numpats+1:numsubs))

% hope to see both are as good at hitting the target, but that noise makes
% them worse. Seems that in patients, noise makes them worse

% plot these out in a bar graph to see the effect of noise on how well hit
% a target.
fig2=figure;
xmin=-120
xmax= 120
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'distance from the target for clear trials (blue) and noise trial (pink) ', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(1,2,1)
toplot_pats=[mean_clear_pre_gdsubs(1:numpats); mean_noise_pre_gdsubs(1:numpats)];
toplot_pats=toplot_pats';
% clear in blue, noise in pink,
% pink should always be futher from 0 than
% blue
bar(toplot_pats,'grouped'), colormap(cool)
xlabel('subjects')
ylabel('distance from target (Hz)')
axis([0 15  xmin xmax])

subplot(1,2,2)
toplot_HCs=[mean_clear_pre_gdsubs(numpats+1:numsubs); mean_noise_pre_gdsubs(numpats+1:numsubs)];
toplot_HCs=toplot_HCs';
% clear in blue, noise in pink,
% pink should always be futher from 0 than
% blue
bar(toplot_HCs,'grouped'), colormap(cool)
xlabel('subjects')
ylabel('distance from target (Hz)')
axis([0 15 xmin xmax])


%% (2) Does performance affect stdev, are people who are further from the
% target displaying a greater stdevn?
% % correlations
% test=[1 2 3 4 5;]
% test1=[2 4 6 8 10]
% [r,p] = corrcoef(test,test1)

noisetrials_pats=mean_noise_pre_gdsubs(1:numpats);
cleartrials_pats=mean_clear_pre_gdsubs(1:numpats);
noisetrials_HCs=mean_noise_pre_gdsubs(numpats+1:numsubs);
cleartrials_HCs=mean_clear_pre_gdsubs(numpats+1:numsubs);

[r,p] = corrcoef(noisetrials_pats,cleartrials_pats);
[r,p] = corrcoef(noisetrials_HCs,cleartrials_HCs);

pat_correln = polyfit(noisetrials_pats,cleartrials_pats,1);
pat_correln(1)
display (' .. is the slope')
pat_correln(2)
display (' .. is the intercept of the linear predictor ')


HC_correln = polyfit(noisetrials_HCs,cleartrials_HCs,1);
HC_correln(1)
display (' .. is the slope')
HC_correln(2)
display (' .. is the intercept of the linear predictor ')


% [R,P]=corrcoef(...) also returns P, a matrix of p-values for testing the
% hypothesis of no correlation.

% Each p-value is the probability of getting a correlation as large as the
% observed value by random chance, when the true correlation is zero.
% If P(i,j) is small, say less than 0.05, then the
% correlation R(i,j) is significant.



% plot:- are those that are better in noise better on clear trials also?
fig3=figure
% ymin = -70
% ymax = 100
% xmin = -70
% xmax = 100

ymin = -200
ymax = 200
xmin = -200
xmax = 200

annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Relationship between distance from the target for clear adn noise trials for HCs (blue) and patients (pink) ', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')

subplot(2,1,1)
scatter(noisetrials_HCs, cleartrials_HCs,'filled', 'c')
axis([ xmin xmax  ymin ymax])
xlabel('distance from target (noise trials)')
ylabel('distance from target (clear trials)(Hz)')

subplot(2,1,2)
scatter(noisetrials_pats, cleartrials_pats,'filled', 'm')
axis([ xmin xmax  ymin ymax])
xlabel('distance from target (noise trials)')
ylabel('distance from target (clear trials)(Hz)')

save GroupMeanPitch


%% (3) plot distance from the mean by frame
cd (cerebellar_data_rootdir)
%load DATA_TO_USE.mat

for isubj=1:27
    for iframe=1:length(DATA(isubj).mean_cond1_pre)
        distfromtarg_allsubs(isubj).cond1_prestep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepup - DATA(isubj).mean_cond1_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond1_poststep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepup - DATA(isubj).mean_cond1_post(:,iframe);
        distfromtarg_allsubs(isubj).cond2_prestep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepup - DATA(isubj).mean_cond2_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond2_poststep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepup - DATA(isubj).mean_cond2_post(:,iframe);
        distfromtarg_allsubs(isubj).cond3_prestep(:,iframe)=shiftinhertz_allsubs(isubj).nostep - DATA(isubj).mean_cond3_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond3_poststep(:,iframe)=shiftinhertz_allsubs(isubj).nostep - DATA(isubj).mean_cond3_post(:,iframe);
        distfromtarg_allsubs(isubj).cond4_prestep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepdown - DATA(isubj).mean_cond4_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond4_poststep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepdown - DATA(isubj).mean_cond4_post(:,iframe);
        distfromtarg_allsubs(isubj).cond5_prestep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepdown - DATA(isubj).mean_cond5_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond5_poststep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepdown - DATA(isubj).mean_cond5_post(:,iframe);
        distfromtarg_allsubs(isubj).cond6_prestep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepup - DATA(isubj).mean_cond6_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond6_poststep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepup - DATA(isubj).mean_cond6_post(:,iframe);
        distfromtarg_allsubs(isubj).cond7_prestep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepup - DATA(isubj).mean_cond7_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond7_poststep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepup - DATA(isubj).mean_cond7_post(:,iframe);
        distfromtarg_allsubs(isubj).cond8_prestep(:,iframe)=shiftinhertz_allsubs(isubj).nostep - DATA(isubj).mean_cond8_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond8_poststep(:,iframe)=shiftinhertz_allsubs(isubj).nostep - DATA(isubj).mean_cond8_post(:,iframe);
        distfromtarg_allsubs(isubj).cond9_prestep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepdown - DATA(isubj).mean_cond9_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond9_poststep(:,iframe)=shiftinhertz_allsubs(isubj).smallstepdown - DATA(isubj).mean_cond9_post(:,iframe);
        distfromtarg_allsubs(isubj).cond10_prestep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepdown - DATA(isubj).mean_cond10_pre(:,iframe);
        distfromtarg_allsubs(isubj).cond10_poststep(:,iframe)=shiftinhertz_allsubs(isubj).bigstepdown - DATA(isubj).mean_cond10_post(:,iframe);
    end
end

distfromtarg_gdsubs=distfromtarg_allsubs(subjects_included);

%sanity check - plot these
% figure
% for isubj=1:numsubs
% subplot(numsubs/3, numsubs/2, isubj)
% bar(1, shiftinhertz_gdsubs(isubj).bigstepup)
% hold all
% bar(2, shiftinhertz_gdsubs(isubj).smallstepup)
% bar(3, shiftinhertz_gdsubs(isubj).nostep)
% bar(4, shiftinhertz_gdsubs(isubj).smallstepdown)
% bar(5, shiftinhertz_gdsubs(isubj).bigstepdown)
% end

% 
% % plot that to check
% for isubj=1:numsubs
%         clf
%         subplot(2,1,1)
%         plot(DATA_TO_USE(isubj).mean_cond1_pre(1,:))
%         hold on
%         target=ones(1,201);
%         target=target *(shiftinhertz_gdsubs(isubj).smallstepup);
%         axis([0 250 110 140])
%         plot(target, 'm')
%         subplot(2,1,2)
%         plot(distfromtarg_gdsubs(isubj).cond1_prestep(1,:))
%         axis([0 250 -80 80])
%         pause
%         target(1)
% end



%% plot mean distance from targ for each condition across subjects for all subjects

for isubj=1:27
    for iframe=1:201
        
        meandistfromtarg_allsubs(isubj).cond1_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond1_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond1_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond1_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond2_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond2_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond2_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond2_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond3_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond3_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond3_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond3_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond4_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond4_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond4_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond4_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond5_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond5_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond5_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond5_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond6_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond6_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond6_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond6_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond7_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond7_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond7_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond7_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond8_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond8_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond8_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond8_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond9_prestep(:,iframe)= nanmean(distfromtarg_allsubs(isubj).cond9_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond9_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond9_poststep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond10_prestep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond10_prestep(:,iframe));
        meandistfromtarg_allsubs(isubj).cond10_poststep(:,iframe)=nanmean(distfromtarg_allsubs(isubj).cond10_poststep(:,iframe));
    end
end
% good subjects
meandistfromtarg_gdsubs=(meandistfromtarg_allsubs(allincluded));

%mean clear trials
for ipat=1:numpats
    Group_meandistfromtarg_pats_clear= ...
        [meandistfromtarg_gdsubs(ipat).cond1_prestep ; ...
        meandistfromtarg_gdsubs(ipat).cond3_prestep ; ...
        meandistfromtarg_gdsubs(ipat).cond3_prestep ; ...
        meandistfromtarg_gdsubs(ipat).cond4_prestep ; ...
        meandistfromtarg_gdsubs(ipat).cond5_prestep]
end




% %% sanity check
% % clear sorted_data
% load SUB01/expr2014.03.21.T10.46.03_mainrun/speak/sorted_data.mat
% % load SUB02/expr2014.03.21.T12.33.58_mainrun/speak/sorted_data.mat
% %load HC11/expr2014.09.23.t15.27.32_sn_mainrun/speak/sorted_data.mat
% 
% % for plotting targets
% temp1_pre=[nan(1, T1) ones(1, T1:T2)];
% temp2_pre = padarray(temp1_pre, [0 1360-length(temp1_pre)],nan,'post');
% 
% temp1_post=[nan(1, T3) ones(1, T4-T3)];
% temp2_post = padarray(temp1_post, [0 1360-length(temp1_post)],nan,'post');
% 
% 
% %for each subject
% 
% isubj=1
% 
% targetpre_toplot=temp2_pre*subj_MP_goodsubjs(isubj).meanpitch;
% 
% 
% conditionn=1
% for itrial=1:8
% measuredpitch_pre=temp2_pre*DATA_TO_USE(isubj).WTtrialmeanpitch_cond1_pre(itrial)
% measuredpitch_post=temp2_post*DATA_TO_USE(isubj).WTtrialmeanpitch_cond1_post(itrial)
% 
%     subplot(2,1,1)
%     plot(sorted_data(conditionn).wholetrial(itrial,:))
%     hold all
%     %plot targets in red
%     plot(targetpre_toplot, 'r','LineWidth',1.3);
%     plot(temp2_post*shiftinhertz_gdsubs(isubj).smallstepup, 'r','LineWidth',1.3);
%     % plot mean measured pitch
%     plot(measuredpitch_pre, 'b' ,'LineWidth',1.3);
%     plot(measuredpitch_post, 'b' ,'LineWidth',1.3);
%     axis([0 1360 100 250])
%     
%     subplot(2,1,2)
%     %diff_pre=subj_MP(isubj).meanpitch-
%     bar(1, Diff_eachtrial_goodsubs(isubj).cond1_pre(itrial))
%     hold on
%     bar(2, Diff_eachtrial_goodsubs(isubj).cond1_post(itrial))
%     axis([0 3 -40 40])
% % 
% %     subplot(3,1,3)
% %     bar(1, subj_MP_goodsubjs(isubj).meanpitch - nanmean(sorted_data(conditionn).prestep(itrial,:)))
% %     hold on
% %     bar(2, shiftinhertz_gdsubs(isubj).smallstepup - nanmean(sorted_data(conditionn).poststep(itrial,:)))
% %     axis([0 3 -40 40])
% %     
%     pause
%     clf
% end
% 
% 
% conditionn=2
% for itrial=1:8
% measuredpitch_pre=temp2_pre*DATA_TO_USE(isubj).WTtrialmeanpitch_cond2_pre(itrial)
% measuredpitch_post=temp2_post*DATA_TO_USE(isubj).WTtrialmeanpitch_cond2_post(itrial)
% 
%     subplot(2,1,1)
%     plot(sorted_data(conditionn).wholetrial(itrial,:))
%     hold all
%     %plot targets in red
%     plot(targetpre_toplot, 'r','LineWidth',1.3);
%     plot(temp2_post*shiftinhertz_gdsubs(isubj).bigstepup, 'r','LineWidth',1.3);
%     % plot mean measured pitch
%     plot(measuredpitch_pre, 'b' ,'LineWidth',1.3);
%     plot(measuredpitch_post, 'b' ,'LineWidth',1.3);
%     axis([0 1360 100 150])
%     
%     subplot(2,1,2)
%     %diff_pre=subj_MP(isubj).meanpitch-
%     bar(1, Diff_eachtrial_goodsubs(isubj).cond2_pre(itrial))
%     hold on
%     bar(2, Diff_eachtrial_goodsubs(isubj).cond2_post(itrial))
%     axis([0 3 -40 40])
% % 
% %     subplot(3,1,3)
% %     bar(1, subj_MP_goodsubjs(isubj).meanpitch - nanmean(sorted_data(conditionn).prestep(itrial,:)))
% %     hold on
% %     bar(2, shiftinhertz_gdsubs(isubj).smallstepup - nanmean(sorted_data(conditionn).poststep(itrial,:)))
% %     axis([0 3 -40 40])
% %     
%     pause
%     clf
% end
