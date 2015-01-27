# Pitch-Tracking
http://members.efn.org/~qehn/global/building/cents.htm

Exp notes

seconds_per_trial_req = 4.0;

% cents to shift
sup=100 % small up
bup=300 % big up
nos=0   % no shift
sdw=-100 % small down
bdw=-300 % big down
cents2shift_types = [sup bup nos sdw bdw];


fs = 11025;     % I'd rather just get this from p.fusp_init.sample_rate, but I need it before running init_fusp_lite()
data_size = 32; % I'd rather just get this from p.fusp_init.sample_rate, but I need it before running init_fusp_lite()
frame_rate = fs/data_size;


% frame to seconds
frame_fs = fs/data_size;
frame_num=413;
frame_num=50
framestosecs=(frame_num)/frame_fs


seconds_per_trial_req = 4.0;
nframes_per_trial = round(seconds_per_trial_req*frame_rate);
seconds_per_trial = nframes_per_trial/frame_rate;

% times to step
tbase = 1.2; tinc = 0.2;
tstep(1) = tbase;
tstep(2) = tstep(1) + tinc;
tstep(3) = tstep(2) + tinc;
tstep(4) = tstep(3) + tinc;
tstep(5) = tstep(4) + tinc;
istep = round(tstep*frame_rate);
