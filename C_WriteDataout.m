%% Writes data oiut from vec_hist to arrays
% -------------------------------------------------------------------------
% ZKA March 2014
% loads the vec hists from each subject and converts them to 

%% here we go
clear all
close all

set_params;
load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/subj_MP_allsubs

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
npatients = npatients + 1;
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

% list controls here
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

originalFolder = pwd;
load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/SubjectShiftsAllSubs

for each_subject = 1:npatients
    
    the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
    cd (the_expr_dir)
    
    % load the shifted_block alt from each subjects' folder. this is *not*
    % actually shifted, it is the original pert resp. See previous script for details.
    load (sprintf('%sshifted_blockalt.mat',patient_info{each_subject}.exprdir));
    %load (sprintf('%svoiceonsetdata.mat',patient_info{each_subject}.exprdir));
    load (sprintf('%svoiceonsetdata_fake.mat',patient_info{each_subject}.exprdir));

    %create empty variable for the good trials
    good_trial=NaN(8,10);
    curdir=cd;
    
    load expr_config.mat;                                   % this loads nframes_per_trial
    
    %% block loop
    for each_block=1:num_blocks;
        % create condition orders
        if  each_block == 1
            blockcondname(each_block,:)=trialscript_expr(1:10);
        elseif each_block == 2
            blockcondname(each_block,:)=trialscript_expr(11:20);
        elseif each_block == 3
            blockcondname(each_block,:)=trialscript_expr(21:30);
        elseif each_block == 4
            blockcondname(each_block,:)=trialscript_expr(31:40);
        elseif each_block == 5
            blockcondname(each_block,:)=trialscript_expr(41:50);
        elseif each_block == 6
            blockcondname(each_block,:)=trialscript_expr(51:60);
        elseif each_block == 7
            blockcondname(each_block,:)=trialscript_expr(61:70);
        elseif each_block == 8
            blockcondname(each_block,:)=trialscript_expr(71:80);
        else pwd
        end
        
        blockx=blockcondname(each_block,:);
        
        foldernumber=each_block-1;
        folder = sprintf('block%d', foldernumber);
        cd (the_expr_dir)
        cd (folder);
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
        
        clear pitchdatablock
        clear ampdatablock
        
        for itrial = 1:ntrials
            % improved pitch tracking through get_sig_pitch6
            y = play_vec_hist6(vhs.inbuffer2,itrial,fs,0);  % does something that needs to be done in the play function, without actually playing the track (see last argument)
            ypitch = get_sig_pitch(y,fs,pitch_lims);        % new and improved pitch tracking
            ypitch_fr = interp1(taxis,ypitch,frame_taxis);  % pitch tracking in seconds
            yampl  = get_sig_ampl( y,fs);
            yampl_fr = interp1(taxis,yampl,frame_taxis);
            ypitch2 = vhs.pitch2.data(itrial,:);            %forget me
            
            pitchdatablock{itrial}=ypitch_fr;               % writes trials to a block
            ampdatablock{itrial}=yampl_fr; 
            outbuff_wav_block{itrial}=outbuff_wav.data(itrial,:);
            % writes trials to a block
        end
        
        amp_data{each_block}=ampdatablock;              % writes block into one chunk ready for filtering accoridng to good or bad trial
        pitch_data{each_block}=pitchdatablock;          % writes block into one chunk ready for filtering accoridng to good or bad trial
        voiceonset_data{each_block}=voiceonset.data;
        voicethresh_data{each_block}=voicethresh.data;
        shiftedpitch_data{each_block}=pitchdatablock;
        outbuff_wav_data{each_block}=outbuff_wav_block;
        %shiftedpitch_data{1,each_block}{1,d}(1:nframes_to_use);     % group data from ypitch_fr
        
%             for itrial=1:trialsperblock
%                 for iframe=1:nframes_to_use
%                     if shiftedpitch_data{1,each_block}{1,itrial}(iframe)==NaN;     % group data from ypitch_fr==NaN
%                         shiftedpitch_data_cents{1,each_block}{1,itrial}(iframe)=NaN;
%                     else
%                         shiftedpitch_data{1,each_block}{1,itrial}(iframe)=1200*log2(shiftedpitch_data{1,each_block}{1,itrial}(iframe)/subj_MP_allsubs(meanpitchtag(each_subject)).meanpitch);
%                     end
%                 end
%             end
%         
  
        cd ..

        save ALLDATA.mat shiftedpitch_data amp_data pitch_data outbuff_wav_data voiceonset_data voicethresh_data blockcondname
    end

end





