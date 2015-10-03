%% Sets parameters for all 

% dock all figures
set(0,'DefaultFigureWindowStyle','docked');
cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data_final_run/';

% smallup=100
% bigup=300
% noshift=0
% smalldown=-100
% bigdown=-300
% 

% subject info

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
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC12/expr2015.05.11.T11.18.14_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC13/expr2015.05.11.T11.53.19_mainrun/speak/';
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC14/expr2015.05.11.T12.28.56_mainrun/speak/';


%% EXP INFO
fs = 11025;     
data_size = 32; 
frame_rate = fs/data_size;
framef = fs/32;
frame_fs = fs/data_size;
stepframe=413; 
amp_thresh=5*(10 ^ 7);                                  %amplitude threshold for cut off

% num trials and blocks
num_blocks= 8;
trialsperblock=10;

% cents to shift
sup=100; % small up
bup=300; % big up
nos=0;   % no shift
sdw=-100; % small down
bdw=-300; % big down
cents2shift_types = [sup bup nos sdw bdw];

% frame to seconds
% frame_num=413;
% frame_num=50;
% framestosecs=(frame_num)/frame_fs;

framestoremove=50; % frames to remove after a break in voicing (used in B file) 

seconds_per_trial_req = 4.0;
nframes_per_trial = round(seconds_per_trial_req*frame_rate);
seconds_per_trial = nframes_per_trial/frame_rate;
step_time=stepframe/frame_fs;

%% TIMINGS e.g. step occurs at 413 frames.
% 
% %patients
% T1= 400; %210;                          %frames
% T2= 600; %410; % 200 frames
% % HCs
% T1= 250;                          %frames
% T2= 450; %410; % 200 frames
% T3=1000;    %3789.5ms
% T4=1200;    %4478.5ms
% 
% T1secs=(T1)/frame_fs;
% T2secs=(T2)/frame_fs;
% T3secs=(T3)/frame_fs;
% T4secs=(T4)/frame_fs;
% step_secs=(stepframe)/frame_fs;
% T_gap=T3-T2;


%% patients and HCs with separate time windows
T1_HC= 220;     %210;             
T2_HC= 420;     %410;   % 200 frames
T3_HC=1000;     %3789.5
T4_HC=1200;     %4478.5

T1_pat= 350;    %210;             
T2_pat= 550;    %410;   % 200 frames
T3_pat=1000;    %3789.5
T4_pat=1200;    %4478.5


T1secs_HC=(T1_HC)/frame_fs;
T2secs_HC=(T2_HC)/frame_fs;
T3secs_HC=(T3_HC)/frame_fs;
T4secs_HC=(T4_HC)/frame_fs;

T1secs_pat=(T1_pat)/frame_fs;
T2secs_pat=(T2_pat)/frame_fs;
T3secs_pat=(T3_pat)/frame_fs;
T4secs_pat=(T4_pat)/frame_fs;

T_gap_HC=T3_HC-T2_HC;
T_gap_pat=T3_pat-T2_pat;

T1secs_HC=(T1_HC)/frame_fs;
T2secs_HC=(T2_HC)/frame_fs;
T3secs_HC=(T3_HC)/frame_fs;
T4secs_HC=(T4_HC)/frame_fs;

T1secs_pat=(T1_pat)/frame_fs;
T2secs_pat=(T2_pat)/frame_fs;
T3secs_pat=(T3_pat)/frame_fs;
T4secs_pat=(T4_pat)/frame_fs;

T_gap=T3_HC-T2_HC;

step_secs=(stepframe)/frame_fs;

T=[400 1270];
start=T(1)/frame_fs;
stop=T(2)/frame_fs;
 
%% SUBJECTS TO INCLUDE

%%  for all subs
%  subjects_included= [1:14];
%  patients_included=[1:16];

%   subjects_included= [1 5 6 10 11 14];
%   patients_included=[1 2 3 4 5 6 8 9 10 11 12 14 15 16];

% original
 subjects_included= [1 6 10 11];
 patients_included=[1 5 8:16];

% for vocal tremor
%patients_included=[2 12];

numpats1=size(patients_included);
numpats=numpats1(2);
numHCs1=size(subjects_included);
numHCs=numHCs1(2);
numsubs=numHCs+numpats;

temp=16 + subjects_included;
allincluded=[patients_included temp];
totalpats=16;
totalHCs=11;

%% THERSHOLDS AND ARTEFACT REMOVAL
reactiontime_frames=200;

% stdev_cutoff_pre_pats =       500;
% stdev_cutoff_post_pats =      500;
% stdev_cutoff_wholetrial_pats =  500; 
% stdev_cutoff_pre_amp_pats=  500000000;
% stdev_cutoff_post_amp_pats= 500000000;
% stdev_cutoff_wholetrial_amp_pats= 500000000;
% 
% stdev_cutoff_pre_HCs =       500;
% stdev_cutoff_post_HCs =      500;
% stdev_cutoff_wholetrial_HCs =  500; 
% stdev_cutoff_pre_amp_HCs=  500000000;
% stdev_cutoff_post_amp_HCs= 500000000;
% stdev_cutoff_wholetrial_amp_HCs= 500000000;

stdev_cutoff_pre_pats= 85.9631;
stdev_cutoff_post_pats= 90.3280;
stdev_cutoff_wholetrial_pats= 243.0938;

stdev_cutoff_pre_HCs= 41.7298;
stdev_cutoff_post_HCs= 32.0806;
stdev_cutoff_wholetrial_HCs= 163.3917;

stdev_cutoff_pre_amp_pats= 2.2142e+08;
stdev_cutoff_post_amp_pats= 1.8512e+08;
stdev_cutoff_wholetrial_amp_pats= 6.6643e+07;

stdev_cutoff_pre_amp_HCs= 1.9925e+08;
stdev_cutoff_post_amp_HCs= 1.6672e+08;
stdev_cutoff_wholetrial_amp_HCs= 4.1817e+08;




% 
% stdev_cutoff_pre_pats =  62.9157;
% stdev_cutoff_post_pats =      57.7590;
% stdev_cutoff_wholetrial_pats =  220.3432;
% 
% stdev_cutoff_pre_amp_pats=  1.2451e+08;
% stdev_cutoff_post_amp_pats= 9.1693e+07;
% stdev_cutoff_wholetrial_amp_pats= 3.7081e+06;
% 
% stdev_cutoff_pre_HCs =   25.3077;
% stdev_cutoff_post_HCs =   22.7825;
% stdev_cutoff_wholetrial_HCs = 133.1304;
%              
% stdev_cutoff_pre_amp_HCs=  1.4719e+08;
% stdev_cutoff_post_amp_HCs= 8.5181e+07;
% stdev_cutoff_wholetrial_amp_HCs=5.5091e+08;



perf_thresh_pos=100;
perf_thresh_neg=-100;

perf_thresh_pos_cents=50;
perf_thresh_neg_cents=-50;

% perf_thresh_pos_cents=10;
% perf_thresh_neg_cents=-10;

%% for plotting
nframes_to_plot= 1378-5;     %nframes_per_trial-5;
nframes_to_use=1360;         %nframes_per_trial-18;
frame_taxis = (0:(nframes_per_trial-1))/framef;
frame_taxis_to_use = (0:(nframes_to_use-1))/frame_fs;

%% convert frames to seconds
% 1 frame=3.445 ms
% 1ms = 0.29 frames
% 200 frames = 670 ms
% 1s/1000ms = 290 frames
% STEP: 413 frames=3.445*413            = 1422 ms/ 1.4 secs
% usable trial length: 1360 frames      = 4685 ms/ 4.685 secs
% full trial length: 3.445*1378           = 4747 ms/ 4.747 secs

%% Experimental info for reference:

% http://members.efn.org/~qehn/global/building/cents.htm
%     1 - Clear small up
%     2 - Clear big up
%     3 - Clear flat
%     4 - Clear small down
%     5 - Clear big down
%     6 - Masked small up
%     7 - Masked big up
%     8 - Masked flat
%     9 - Masked small down
%     10 - Masked big downs

% times to step
tbase = 1.2; tinc = 0.2;
tstep(1) = tbase;
tstep(2) = tstep(1) + tinc;
tstep(3) = tstep(2) + tinc;
tstep(4) = tstep(3) + tinc;
tstep(5) = tstep(4) + tinc;
istep = round(tstep*frame_rate);


%% FOR SEMS: ZKA to do BY TRIALS INCLUDED NOT TOTAL TRIALS
%SEM: dividing the SD by the square root of N. 
forstdev_HCs=numHCs*8;
forstdev_PATs=numpats*8;

%% for ploting graphs
%patient_colour=[.49 1 .63];
patient_colour='r';
HC_colour='k';
% HC_colour=[.4 .4 .4];
sig_colour=[.3 .3 .8];


% 'Color',[HC_colour]
