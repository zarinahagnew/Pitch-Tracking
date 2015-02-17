%% Calc mean distance from low pass filtered for each trial from sorted_data.m
% Takes sorted data and calculates the distance from the low pass filtered version
% ZKA Feb 2015


close all
clear all
set_params;

%for plotting only :)
minpitch=100;
maxpitch=300;

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

for isubj=1:npatients
    for cond=1:10
        subjmean(isubj).data(cond,:)=nanmean(DATA(1).distfromlowasspass(1).sorted_data(cond).goodpitchdata_difflowpassfilt);
    end
end

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

% how many are all nan trials
% pat_badtrial_counter=0;
% for itrial=1:128
%     if sum(isnan(Pat_data_distlowpass(condition).data(itrial,:)))>174
%         pat_badtrial_counter=pat_badtrial_counter+1;
%     end
% end
% fraction_bad_pats=(pat_badtrial_counter/128)*100
% 
% HC_badtrial_counter=0;
% for itrial=1:88
%     if sum(isnan(HC_data_distlowpass(condition).data(itrial,:)))>174
%         HC_badtrial_counter=HC_badtrial_counter+1;
%     end
% end
% fraction_bad_HCs=(HC_badtrial_counter/88)*100

%% all conditions separately
% calulate and plot means - all conditions separately
for cond=1:10
Pats_groupmean(cond).data=nanmean(Pat_data_distlowpass(cond).data);
Pats_groupstd(cond).data=nanstd(Pat_data_distlowpass(cond).data);
HCs_groupmean(cond).data=nanmean(HC_data_distlowpass(cond).data);
HCs_groupstd(cond).data=nanstd(HC_data_distlowpass(cond).data);
end

figure
for cond=1:10
subplot(2,5, cond)
plot(frame_taxis_to_use(1:751), Pats_groupmean(cond).data, ...
    'b','LineWidth',1,'Color',[patient_colour]);
%    'b','LineWidth',1,'Color',[patient_colour],'LineStyle','--');

hold
plot(frame_taxis_to_use(1:751), HCs_groupmean(cond).data, ...
    'b','LineWidth',1,'Color',[HC_colour]);

xlabel('Variability (cents)');
ylabel('Time (seconds)');
axis([0 2.5 -100 50])
goodplot
end



figure
for cond=1:10
subplot(2,5, cond)
plot(frame_taxis_to_use(1:751), Pats_groupstd(cond).data,'b','LineWidth',1,'Color',[patient_colour]);

hold on
plot(frame_taxis_to_use(1:751), HCs_groupstd(cond).data, 'b','LineWidth',1,'Color',[HC_colour]);

xlabel('Variability (cents)');
ylabel('Time (seconds)');
axis([0 2.5 -50 200])
goodplot
end


figure
for cond=1:10
subplot(2,5, cond)
goodplot
plot(frame_taxis_to_use(1:751), HCs_groupmean(cond).data)
xlabel('Variability (cents)');
ylabel('Time (seconds)');
axis([0 2.5 -100 50])
end

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

% anova  - all clear and noise conds together
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
Pats_groupmean_noise=nanmean(Pats_groupmean_noise1);
HCs_groupmean_clear=nanmean(HCs_groupmean_clear1);
HCs_groupmean_noise=nanmean(HCs_groupmean_noise1);

figure
subplot(221)
plot(frame_taxis_to_use(1:751), Pats_groupmean_clear)
axis([0 2.5 -50 50])
goodplot

subplot(222)
plot(frame_taxis_to_use(1:751),Pats_groupmean_noise)
axis([0 2.5 -50 50])
goodplot

subplot(223)
plot(frame_taxis_to_use(1:751),HCs_groupmean_clear)
axis([0 2.5 -50 50])
goodplot

subplot(224)
plot(frame_taxis_to_use(1:751),HCs_groupmean_noise)
axis([0 2.5 -50 50])
goodplot



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
