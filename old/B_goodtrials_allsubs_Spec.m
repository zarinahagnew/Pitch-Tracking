%% Seperates the good and bad trials for the pitch tracking experiment.
% -------------------------------------------------------------------------
% ZKA March 2014
% this is an automated version which looks at each trial,
% there is a option to play each trial which is commented out for now

%% convert frames to seconds
% 1 frame=3.445 ms
% 1ms = 0.29 frames
% 200 frames = 670 ms

% Experimental info for reference:

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

% each block has ten trials eg: -
% for a=1:10
% plot(pitchdata_old.data(a,:))
% hold
% plot(pitch_data{1}{a}(1,:), 'g')
% pause
% end

% shiftedblock alt (trial, block)

%% here we go
clear all
close all

set_params;
stdev_cutoff_pre =  500; 
stdev_cutoff_post = 500 ;
stdev_cutoff_wholetrial = 500 ;
stdev_cutoff_pre_amp= 500000000;
stdev_cutoff_post_amp=500000000;
stdev_cutoff_wholetrial_amp=500000000;
amp_thresh=5*(10 ^ 7);                                  %amplitude threshold for cut off

% ----

cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
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

originalFolder = pwd;

for each_subject = 1:npatients
    
    the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
    cd (the_expr_dir)
    
    % load the shifted_block alt from each subjects' folder. this is *not*
    % actually shifted, it is the original pert resp. See previous script for details.  
    load (sprintf('%sshifted_blockalt.mat',patient_info{each_subject}.exprdir));
    load (sprintf('%svoiceonsetdata.mat',patient_info{each_subject}.exprdir));
    
    %create empty variable for the good trials
    good_trial=NaN(8,10);
    curdir=cd;
    
    load expr_config.mat;                                   % this loads nframes_per_trial

    % preallocation
    for a=1:10
        pitchdatablock{a}={1:nframes_per_trial};
        pitch_data{a}=pitchdatablock;
    end
    
    %         prealloocation=
    %         goodpitchdata=
    %         goodpertresp=
    %         goodstd=
    %         goodpitchdata=
    %         goodampdata=
    %         gooddata_1=
    %         gooddata=
    %         gooddata_b=
    
    
    %% block loop
    for each_block=1:num_blocks;
        foldernumber=each_block-1;
        folder = sprintf('block%d', foldernumber);
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
            
            %             % play option
            %                         while 1
            %                             reply = input('play trial? y/[n]: ','s');
            %                             if isempty(reply) || strcmp(reply,'n')
            %                                 break;
            %                             else
            %                                 soundsc(y,fs);
            %                             end
            %                         end
            %             pause
            
            pitchdatablock{itrial}=ypitch_fr;               % writes trials to a block
            ampdatablock{itrial}=yampl_fr;                  % writes trials to a block
        end
        
        %preallocation
        amp_data=cell(1,8);
        pitch_data=cell(1,8);
        voiceonset_data=cell(1,8);
        voicethresh_data=cell(1,8);
        shiftedpitch_data=cell(1,8);
        
        for var=1:8
            ampdata{var}=cell(1,1378);
            pitch_data{var}=cell(1,1378);
            voiceonset_data{var}=cell(1,1378);
            voicethresh_data{var}=cell(1,1378);
            shiftedpitch_data{var}=cell(1,1378);
        end

            amp_data{each_block}=ampdatablock;              % writes block into one chunk ready for filtering accoridng to good or bad trial
            pitch_data{each_block}=pitchdatablock;          % writes block into one chunk ready for filtering accoridng to good or bad trial
            voiceonset_data{each_block}=voiceonset.data;
            voicethresh_data{each_block}=voicethresh.data;
            shiftedpitch_data{each_block}=pitchdatablock;
        
            %% align all trials to voice onset (by deleting the frames before voice onset)
            for iframe=1:nframes_to_use
                if iframe<=voiceonsetdata{itrial,each_block}
                    shiftedpitch_data{1,each_block}{1,itrial}(iframe)=NaN;
                end
            end
        
        %% REMOVE BAD TRIALS ACCORDING TO STDEV:

        
        % wholetrial *pitch* data -----------------------------------------
        for d=1:voiceonset.ntrials % 10
            if nanstd(shiftedpitch_data{1,each_block}{1, d})<stdev_cutoff_wholetrial
                goodpitchdata(each_block).data(d,:)=shiftedpitch_data{1,each_block}{1,d}(1:nframes_to_use);     % group data from ypitch_fr
                goodstd.wholetrial(d)=nanstd(shiftedpitch_data{1,each_block}{1, d}(1:nframes_to_use));          % within trial stdev
                goodpertresp(each_block).data{d}=shifted_blockalt{d,each_block}(1:nframes_to_use);
                goodpitchdata(each_block).audio(d,:)=outbuff_wav.data(d,:);
            else
                goodpitchdata(each_block).data(d,:)=[NaN(1,nframes_to_use)];
                goodpertresp(each_block).data{d}=shifted_blockalt{d,each_block}(1:nframes_to_use);
                goodpitchdata(each_block).audio(d,:)=[NaN(1,(length(outbuff_wav.data(d,:))))];
                goodstd.wholetrial(d)=[NaN];
            end
        end
        
        % wholetrial *amp* data -------------------------------------------
        for d=1:voiceonset.ntrials 
            if nanstd(amp.data(d,:))<stdev_cutoff_wholetrial_amp
                goodampdata(each_block).wholetrial_amp(d,:)= amp_data{each_block}{d}(1:nframes_to_use);
                goodstd.wholetrial_amp(d)=nanstd(amp_data{each_block}{d});
            else
                goodampdata(each_block).wholetrial_amp(d,:)=[NaN(1,nframes_to_use)];
                goodstd.wholetrial_amp(d)=[NaN];
            end
        end
        
        % prestep *pitch* data --------------------------------------------
        for d=1:voiceonset.ntrials 
            if nanstd(shiftedpitch_data{1,each_block}{1, d}(T1:T2))< stdev_cutoff_pre
                goodpitchdata(each_block).prestep_data(d,:)=shiftedpitch_data{1,each_block}{1, d}(T1:T2);
                goodstd.prestep(d)=nanstd(shiftedpitch_data{1,each_block}{1, d}(T1:T2));
            else
                goodpitchdata(each_block).prestep_data(d,:)=[NaN(1,201)];
                goodstd.prestep(d)=[NaN];
            end
        end
        
        % prestep *amp* data ----------------------------------------------
        for d=1:voiceonset.ntrials 
            if nanstd(amp.data(d,T1:T2))< stdev_cutoff_pre_amp
                goodampdata(each_block).prestep_amp(d,:)=amp_data{each_block}{d}(1,T1:T2);
                goodstd.prestep_amp(d)=nanstd(amp_data{each_block}{d}(1,T1:T2));
            else
                goodampdata(each_block).prestep_amp(d,:)=[NaN(1,201)];
                goodstd.prestep_amp(d)=[NaN];
            end
        end
        
        % post step *pitch* data ------------------------------------------
        for d=1:voiceonset.ntrials 
            if nanstd(shiftedpitch_data{1,each_block}{1, d}(T3:T4))< stdev_cutoff_post
                goodstd.poststep(d)=nanstd(shiftedpitch_data{1,each_block}{1, d}(T3:T4));
                goodpitchdata(each_block).poststep_data(d,:)=shiftedpitch_data{1,each_block}{1, d}(T3:T4);
            else
                goodpitchdata(each_block).poststep_data(d,:)=[NaN(1,201)];
                goodstd.poststep(d)=[NaN];
            end
        end
        
        % post step *amp* data --------------------------------------------
        for d=1:voiceonset.ntrials % 10
            if nanstd(amp.data(d,T3:T4))< stdev_cutoff_post_amp
                goodampdata(each_block).poststep_amp(d,:)=amp_data{each_block}{d}(1,T3:T4);
                goodstd.poststep_amp(d)=nanstd(amp_data{each_block}{d}(1,T3:T4));
            else
                goodampdata(each_block).poststep_amp(d,:)=[NaN(1,201)];
                goodstd.poststep_amp(d)=[NaN];
                
            end
        end
        
        % writes the means stdev of the prestep and post step data
        meanstdev_pre=nanmean(goodstd.prestep);
        meanstdev_post=nanmean(goodstd.poststep);
        meanstdev_preandpost=nanmean(goodstd.prestep);
        meanstdev_pre_amp=nanmean(goodstd.prestep_amp);
        meanstdev_post_amp=nanmean(goodstd.poststep_amp);
        meanstdev_preandpost_amp=nanmean(goodstd.prestep_amp);
        
        %% REMOVE BAD TRIALS ACCORDING TO WHERE THERE IS AMP SIGNAL =======
        % now that we have excluded trials based on their within trial stdev, now only takes data where the amplitude is greater than x
        % wholetrial
        for t=1:1:voiceonset.ntrials                                        %trial loop
            for s=1:nframes_to_use                                          %data point loop
                if goodampdata(1,each_block).wholetrial_amp(t,s)>amp_thresh 
                    gooddata_1.wholetrial(each_block).wholetrial(t,s)=goodpitchdata(each_block).data(t,s);
                    gooddata.AMP_wholetrial(each_block).data(t,s)=goodampdata(each_block).wholetrial_amp(t,s);
                    gooddata.goodpertresp(each_block).data{t}=shifted_blockalt{t,:};                    
                else
                    gooddata_1.wholetrial(each_block).wholetrial(t,s)=NaN;
                    gooddata.AMP_wholetrial(each_block).data(t,s)=NaN;
                    gooddata.goodpertresp(each_block).data{t}=shifted_blockalt{t,:};                    
                end
                gooddata.audio(each_block).audio(t,:)=goodpitchdata(each_block).audio(t,:);
            end
            gooddata.wholetrial_std(t)=nanstd(gooddata_1.wholetrial(each_block).wholetrial(t,:));
        end
        
        % window data
        for t=1:1:voiceonset.ntrials                                        %trial loop
            for s=1:length(goodampdata(1,each_block).prestep_amp(1,:));     %data point loop
                if goodampdata(1,each_block).prestep_amp(t,s)>amp_thresh
                    gooddata_1.pre(each_block).pre(t,s)=goodpitchdata(each_block).prestep_data(t,s);
                    gooddata.AMP_pre(each_block).data(t,s)=goodampdata(each_block).prestep_amp(t,s);
                    gooddata.goodpertresp(each_block).data{t}=shifted_blockalt{t,:};
                    gooddata_1.post(each_block).post(t,s)=goodpitchdata(each_block).poststep_data(t,s);
                    gooddata.AMP_post(each_block).data(t,s)=goodampdata(each_block).poststep_amp(t,s);
                else
                    gooddata_1.pre(each_block).pre(t,s)=NaN;
                    gooddata.AMP_pre(each_block).data(t,s)=NaN;
                    gooddata.goodpertresp(each_block).data{t}=shifted_blockalt{t,:};
                    gooddata_1.post(each_block).post(t,s)=NaN;
                    gooddata.AMP_post(each_block).data(t,s)=NaN;
                    
                end
                gooddata.audio(each_block).audio(t,:)=goodpitchdata(each_block).audio(t,:);
            end
            gooddata.pre_std(t)=nanstd(gooddata_1.pre(each_block).pre(t,:));
        end
        
        % prestep
        for t=1:1:voiceonset.ntrials
            for s=1:201 
                if goodampdata(1,each_block).prestep_amp(t,s)>amp_thresh;
                    gooddata.prestep(each_block).data(t,s)=goodpitchdata(each_block).prestep_data(t,s);
                    gooddata.AMP_pre(each_block).data(t,s)=goodampdata(each_block).prestep_amp(t,s);
                else
                    gooddata.prestep(each_block).data(t,s)=NaN;
                    gooddata.AMP_pre(each_block).data(t,s)=NaN;
                end
            end
            gooddata.prestep_std(t)=nanstd(gooddata.prestep(each_block).data(t,:));
        end
        
        % poststep
        for t=1:1:voiceonset.ntrials 
            for s=1:201 
                if goodampdata(1,each_block).poststep_amp(t,s)>amp_thresh;
                    gooddata.poststep(each_block).data(t,s)=goodpitchdata(each_block).poststep_data(t,s);
                    gooddata.AMP_post(each_block).data(t,s)=goodampdata(each_block).poststep_amp(t,s);
                else
                    gooddata.poststep(each_block).data(t,s)=NaN;
                    gooddata.AMP_post(each_block).data(t,s)=NaN;
                    
                end
            end
            gooddata.poststep_std(t)=nanstd(gooddata.poststep(each_block).data(t,:));
        end

               
         %% Remove first 250 frames by replacing them with nans ===========
        for t=1:voiceonset.ntrials %trial loop
            gooddata_b.wholetrial(each_block).wholetrial(t,:)=gooddata_1.wholetrial(each_block).wholetrial(t,:);
            for s=1:reactiontime_frames
                gooddata_b.wholetrial(each_block).wholetrial(t,s)=NaN;
            end
        end
                
        %% Remove first 10 frames after break in voicing ==================
        % 1. create binary marker array and call it B
        for itrial=1:10
            for i=1:length(gooddata.AMP_wholetrial(each_block).data(itrial,:))
                if gooddata.AMP_wholetrial(each_block).data(itrial,i)>amp_thresh;
                    marker.data(each_block).data(itrial,i)=80;
                else
                    gooddata.AMP_wholetrial(each_block).data(itrial,i);
                end
            end
            marker.data(each_block).data(itrial,:)
            
            % 2. make marker trials the same length as nframstouse
            padding=nframes_to_use-length(marker.data(each_block).data(itrial,:));
            marker2.data(each_block).data(itrial,:) = padarray(marker.data(each_block).data(itrial,:),[0 padding],'post');
            
            %3. create a copy of the data from the last stage above and replace the
            gooddata.wholetrial(each_block).wholetrial=gooddata_b.wholetrial(each_block).wholetrial;
            framestoremove=50;
            for i=1:nframes_to_use
                if marker2.data(each_block).data(itrial,i)<10
                    gooddata.wholetrial(each_block).wholetrial(itrial,i:i+framestoremove)=NaN;
                end
            end

            %                 % uncomment to plot these as you go :)
            %                 figure
            %                 subplot(4,1,1)
            %                 title(sprintf('orig data in cyan, RT/first 250 frames removed in pinks'));
            %                 plot(gooddata_1.wholetrial(each_block).wholetrial(itrial,:), 'c')
            %                 hold on
            %                 plot(gooddata.wholetrial(each_block).wholetrial(itrial,:), 'm')
            %                 subplot(4,1,2)
            %                 title(sprintf('RT/first 250 frames removed in pink, voice onset ar tifect removed in blue'));
            %                 plot(gooddata.wholetrial(each_block).wholetrial(itrial,:), 'm')
            %                 hold on
            %                 plot(gooddata_b.wholetrial(each_block).wholetrial(itrial,:), 'b')
            %                 subplot(4,1,3)
            %                 title(sprintf('amp marker'));
            %                 plot(marker.data(each_block).data(itrial,:),'g')
            %                 axis([0 1400 0 100])
            %                 subplot(4,1,4)
            %                 title(sprintf('amplitude signal above threshold'));
            %                 plot(gooddata.AMP_wholetrial(each_block).data(itrial,:), 'b')
            %                 pause
            
        end
        
        %         % for the window data:
        %          for itrial=1:10
        %             for i=1:201
        %                 if gooddata.AMP_pre(each_block).data(itrial,i)>amp_thresh;
        %                     marker.data_pre(each_block).data(itrial,i)=80;
        %                 else
        %                     marker.data_pre(each_block).data(itrial,i)=0;
        %                 end
        %             end
        %             gooddata.prestep(each_block).wholetrial=gooddata_1.pre(each_block).pre;
        %             framestoremove=50;
        %             for i=1:201
        %                 if marker.data_pre(each_block).data(itrial,i)<10
        %                     gooddata.pre(each_block).wholetrial(itrial,i:i+framestoremove)=NaN;
        %                 end
        %             end
        %          end
        %          for itrial=1:10
        %             for i=1:201;
        %                 if gooddata.AMP_post(each_block).data(itrial,i)>amp_thresh;
        %                     marker.data_post(each_block).data(itrial,i)=80;
        %                 else
        %                     gooddata.AMP_post(each_block).data(itrial,i);
        %                 end
        %             end
        %             gooddata.poststep(each_block).wholetrial=gooddata_1.post(each_block).post;
        %             framestoremove=50;
        %
        %             for i=1:201
        %                 if marker.data_post(each_block).data(itrial,i)<10
        %                     gooddata.post(each_block).wholetrial(itrial,i:i+framestoremove)=NaN;
        %                 end
        %             end
        %          end
        
        close all;
        cd ..
    end
    save all_B_outputforplotting
    save gooddata gooddata
    save meanstdev_pre
    save meanstdev_post
    save meanstdev_preandpost
    cd(cerebellar_data_rootdir)
    
end


%% sanity check #1
% 
% 
% each_block=2;
% blockspec(2)
% for itrial=1:10;
%             % plot all stages
%             subplot(5,1,1)
%             plot(pitch_data{1,each_block}{1,itrial},'m')            
%             axis([0 1400 100 200])
%             %title(sprintf('raw data'));
%             subplot(5,1,2)
%             plot(shiftedpitch_data{1,each_block}{1,itrial},'c')
%             axis([0 1400 100 200])
%             %title(sprintf('minus voice onset'));            
%             subplot(5,1,3)
%             plot(goodpitchdata(each_block).data(itrial,:), 'b') 
%             axis([0 1400 100 200])
%             %title(sprintf('trials removed by stdev'));                        
%             subplot(5,1,4)
%             plot(goodpertresp(each_block).data{itrial},'y')
%             axis([0 1400 -350 350])
%             %title(sprintf('original pert resp'));                        
%             subplot(5,1,5)
%             plot(gooddata.wholetrial(each_block).wholetrial(itrial,:), 'r')
%             axis([0 1400 100 200])
%             pause
% end


%% -----------------------------------------------------------------------





% %% back up for onset artifact removal
%
% close all
% amp_thresh=5*(10 ^ 7); %amplitude threshold for cut off
% % 50000000
% amp_thresh_plot=ones(1, 1500);
% amp_thresh_plot=amp_thresh_plot*amp_thresh;
%
% %% create binary marker array and call it B
% for iblock=1:2
%     for itrial=1:10
%
%         for i=1:length(gooddata.AMP_wholetrial(iblock).data(3,:))
%             if gooddata.AMP_wholetrial(iblock).data(itrial,i)>amp_thresh;
%                 marker.data(iblock).data(itrial,i)=80;
%             else
%                 gooddata.AMP_wholetrial(iblock).data(itrial,i);
%             end
%         end
%
%         %% create copy
%         gooddata_2.wholetrial(iblock).wholetrial=gooddata_1.wholetrial(iblock).wholetrial;
%         for i=1:1370
%             if marker.data(iblock).data(itrial,i)<10
%                 gooddata_2.wholetrial(iblock).wholetrial(itrial,i:i+50)=NaN;
%             end
%         end
%
%         figure
%         subplot(3,1,1)
%
%         plot(gooddata_1.wholetrial(iblock).wholetrial(itrial,:), 'c')
%         hold on
%         plot(gooddata_2.wholetrial(iblock).wholetrial(itrial,:), 'm')
%
%         subplot(3,1,2)
%         plot(marker.data(iblock).data(itrial,:),'g')
%         axis([0 1400 0 100])
%
%         subplot(3,1,3)
%         plot(gooddata.AMP_wholetrial(iblock).data(itrial,:), 'b')
%         pause
%
%     end
%     close all
% end
%
%
%


%% sanity checks ==============================================s% % %plot prestep data




% %
% % %plot poststep data
% figure
% each_block=2
% for a=1:10;
%     subplot(2,2,1)
%     plot(frame_taxis,goodpitchdata(each_block).data(a,:))
%     axis([0 1378 0 300])
%     subplot(2,2,2)
%     plot(frame_taxis,goodampdata(each_block).wholetrial_amp(a,:), 'r')
%     axis([0 1378 0 500000000])
%
%     subplot(2,2,3)
%     plot(frame_taxis,gooddata.wholetrial(each_block).wholetrial(a,:))
%         axis([0 1378 0 300])
%
%     subplot(2,2,4)
%     plot(frame_taxis,gooddata.AMP_wholetrial(each_block).data(a,:), 'r')
%     axis([0 1378 0 500000000])
%     pause;
% end


%-------------------------------------------------------------------------

% figure
% for a=1:10;
%     subplot(2,2,1)
%     plot(goodpitchdata(each_block).prestep_data(a,:))
%     axis([0 300 0 300])
%     subplot(2,2,2)
%     plot(goodampdata(each_block).prestep_amp(a,:), 'r')
%     axis([0 300 0 5000000000])
%
%     subplot(2,2,3)
%     plot(gooddata.prestep(each_block).data(a,:))
%         axis([0 300 0 300])
%
%     subplot(2,2,4)
%     plot(gooddata.AMP_pre(each_block).data(a,:), 'r')
%     axis([0 300 0 5000000000])
%     pause;
% end

%-------------------------------------------------------------------------

% % %plot poststep data
% figure
% for a=1:10;
%     subplot(2,2,1)
%     plot(goodpitchdata(each_block).poststep_data(a,:))
%     axis([0 300 0 300])
%     subplot(2,2,2)
%     plot(goodampdata(each_block).poststep_amp(a,:), 'r')
%     axis([0 300 0 5000000000])
%
%     subplot(2,2,3)
%     plot(gooddata.poststep(each_block).data(a,:))
%         axis([0 300 0 300])
%
%     subplot(2,2,4)
%     plot(gooddata.AMP_post(each_block).data(a,:), 'r')
%     axis([0 300 0 5000000000])
%     pause;
% end
%

%-------------------------------------------------------------------------
% sanity  check
% %             figure
% %             plot(amp_data{each_block}{d}, 'g')
% %             figure
% %             plot(amp.data(d,:))
% %
% %             nanstd(amp_data{each_block}{d})
% %             nanstd(amp.data(d,:))
%
% %
% for a=1:10;
%     plot(gooddata.prestep(each_block).data(a,:));
%     pause;
% end
%
% plot(goodpitchdata(each_block).prestep_data(1,:))


    
    %trialscript1: [9 2 1 9 2 5 6 8 9 5]
    %trialscript2: [1 4 5 5 7 10 3 4 8 2]
% 
% blockspec(1)
% figure
% clf
% for mee=1:10;
% plot(gooddata.wholetrial(1).wholetrial(mee,:))
% axis([0 1400 50 260])
% pause
% end


% 
