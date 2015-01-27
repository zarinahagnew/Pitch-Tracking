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

% define pre and post step window boundaries in frames (not ms)
T1=400;     %689ms
T2=600;     %1378ms
T3=1000;    %3789.5ms
T4=1200;    %4478.5ms
num_blocks=8; % number of blocks to analyse

% should change these to 3s to 320 (*.29)


% define the stdevs to exlude for the pitch data:
% stdev_cutoff_pre = 5.4303;
% stdev_cutoff_post = 9.0586;
% stdev_cutoff_wholetrial = 25.8115;
stdev_cutoff_pre = 500 %10.36;
stdev_cutoff_post =500% 17.13;
stdev_cutoff_wholetrial = 500 %29.40;

% define the stdevs to exlude for the ampl data:
stdev_cutoff_pre_amp = 50000000%3.91;
stdev_cutoff_post_amp = 50000000%5.97;
stdev_cutoff_wholetrial_amp = 50000000%8.98;

%amp_thresh=5*(10 ^ 6); %amplitude threshold for cut off 
amp_thresh=5*(10 ^ 7); %amplitude threshold for cut off 

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
patient_info{npatients}.exprdir = 'HC09/expr2014.09.21.T14.17.36_mainrun/speak/'
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC10/expr2014.09.21.T15.35.54_JL_mainrun/speak/'
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'HC11/expr2014.09.23.t15.27.32_sn_mainrun/speak/'

z=0;
originalFolder = pwd;

for each_subject = 1:npatients

    z=z+1;
    the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
    cd (the_expr_dir)
    
    % load the shifted_block alt from each subjects' folder
    load (sprintf('%sshifted_blockalt.mat',patient_info{each_subject}.exprdir));
    load (sprintf('%svoiceonsetdata.mat',patient_info{each_subject}.exprdir));

    %create empty variable for the good trials
    good_trial=NaN(8,10);
    curdir=cd;
    z=0;
    
    % Subject Loop
    for each_subject = 1:npatients
        z=z+1;
        the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
        cd(the_expr_dir)
        load expr_config.mat; % this loads nframes_per_trial
        
        nframes_to_plot=nframes_per_trial-5;
        nframes_to_use=nframes_per_trial-8;

       % preallocation
        for a=1:10
            pitchdatablock{a}={1:nframes_per_trial};
            pitch_data{a}=pitchdatablock;
        end
        
        %% block loop
        for each_block=1:num_blocks;
            foldernumber=each_block-1;
            folder = sprintf('block%d', foldernumber);
            cd (folder);
            
            pitchdata_old=get_vec_hist6('pitch2',3); %two arguments are file name and then file type (float vec)
            block=get_vec_hist6('blockalt',3); %pert response (needs to be shifted in time as only begins in response to voice onsett detect
            voiceonset=get_vec_hist6('voice_onset_detect',2); %voice detect
            outbuff_wav=get_vec_hist6('outbuffer', 3); % ZKA: playable waveform - do spectral analysis on this signal
            outbuff_pitch=get_vec_hist6('output_pitch', 3); % pich of outbuffer is the target
            amp=get_vec_hist6('weighted_mean_abs_inbuffer2', 3);
            audio=get_vec_hist6('inbuffer2',3);
            voicethresh=get_vec_hist6('thresh_inbuffer_state',2);

            fs = 11025;
            pitch_lims = [90 250]; % sets pitch finding limits
            pitch_lims2plot = [50 300];
            shift_lims2plot = [-300 300];
            
            % john's graph function
            hax=nan(1,7);
            hf = figure;
            set(hf,'Position',[1000         416         560        1082]);
            nspl =7; ispl = 0;
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
            ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);
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
                ypitch2 = vhs.pitch2.data(itrial,:); %forget me
                
                %% play option
                %             while 1
                %                 reply = input('play trial? y/[n]: ','s');
                %                 if isempty(reply) || strcmp(reply,'n')
                %                     break;
                %                 else
                %                     soundsc(y,fs);
                %                 end
                %             end
                
                
                pitchdatablock{itrial}=ypitch_fr;       % writes trials to a block
                ampdatablock{itrial}=yampl_fr;       % writes trials to a block
                
            end
            
            
            amp_data{each_block}=ampdatablock;  % writes block into one chunk ready for filtering accoridng to good or bad trial
            pitch_data{each_block}=pitchdatablock;  % writes block into one chunk ready for filtering accoridng to good or bad trial
            voiceonset_data{each_block}=voiceonset.data;
            voicethresh_data{each_block}=voicethresh.data;
            
%% REMOVE BAD TRIALS ACCORDING TO STDEV:

            % wholetrial *pitch* data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(pitch_data{1}{d})<stdev_cutoff_wholetrial
                    goodpitchdata(each_block).data(d,:)=pitch_data{each_block}{d}(1:nframes_to_use); %group data from ypitch_fr
                    goodstd.wholetrial(d)=nanstd(pitch_data{each_block}{d}(1:nframes_to_use)); % within trial stdev
                    gooddata_pertresp(each_block).data{d}=shifted_blockalt{d,each_block};
                    goodpitchdata(each_block).audio(d,:)=outbuff_wav.data(d,:);                    
                    
                else
                    goodpitchdata(each_block).data(d,:)=[NaN(1,nframes_to_use)];
                    gooddata_pertresp(each_block).data{d}=shifted_blockalt{d,each_block};
                    goodpitchdata(each_block).audio(d,:)=[NaN(1,(length(outbuff_wav.data(d,:))))];
                    goodstd.wholetrial(d)=[NaN];
                end
            end
            
            % wholetrial *amp* data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(amp.data(d,:))<stdev_cutoff_wholetrial_amp
                    goodampdata(each_block).wholetrial_amp(d,:)= amp_data{each_block}{d}(1:nframes_to_use); 
                    goodstd.wholetrial_amp(d)=nanstd(amp_data{each_block}{d});
                else
                    goodampdata(each_block).wholetrial_amp(d,:)=[NaN(1,nframes_to_use)];
                    goodstd.wholetrial_amp(d)=[NaN];
                end
            end            
%             
            
            % prestep *pitch* data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(pitch_data{1}{d}(T1:T2))< stdev_cutoff_pre
                    goodpitchdata(each_block).prestep_data(d,:)=pitch_data{each_block}{d}(T1:T2);
                    goodstd.prestep(d)=nanstd(pitch_data{each_block}{d}(T1:T2));
                else
                    goodpitchdata(each_block).prestep_data(d,:)=[NaN(1,201)];
                    goodstd.prestep(d)=[NaN];
                    
                end
            end
           
            % prestep *amp* data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(amp.data(d,T1:T2))< stdev_cutoff_pre_amp
                    goodampdata(each_block).prestep_amp(d,:)=amp_data{each_block}{d}(1,T1:T2);
                    goodstd.prestep_amp(d)=nanstd(amp_data{each_block}{d}(1,T1:T2));
                else
                    goodampdata(each_block).prestep_amp(d,:)=[NaN(1,201)];
                    goodstd.prestep_amp(d)=[NaN];
                end
            end
                  
            % post step *pitch* data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(pitch_data{1}{d}(T3:T4))< stdev_cutoff_post
                    goodstd.poststep(d)=nanstd(pitch_data{each_block}{d}(T3:T4));
                    goodpitchdata(each_block).poststep_data(d,:)=pitch_data{each_block}{d}(T3:T4);
                else
                    goodpitchdata(each_block).poststep_data(d,:)=[NaN(1,201)];
                    goodstd.poststep(d)=[NaN];
                end
            end
            
            % post step *amp* data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(amp.data(d,T3:T4))< stdev_cutoff_post_amp
                    goodampdata(each_block).poststep_amp(d,:)=amp_data{each_block}{d}(1,T3:T4);
                    goodstd.poststep_amp(d)=nanstd(amp_data{each_block}{d}(1,T3:T4));
                else
                    goodampdata(each_block).poststep_amp(d,:)=[NaN(1,201)];
                    goodstd.poststep_amp(d)=[NaN];

                end
            end
           
                % write the means stdev of the prestep and post step data
                meanstdev_pre=nanmean(goodstd.prestep);
                meanstdev_post=nanmean(goodstd.poststep);
                meanstdev_preandpost=nanmean(goodstd.prestep);
                meanstdev_pre_amp=nanmean(goodstd.prestep_amp);
                meanstdev_post_amp=nanmean(goodstd.poststep_amp);
                meanstdev_preandpost_amp=nanmean(goodstd.prestep_amp);
                                       
                
%% REMOVE BAD TRIALS ACCORIDNG TO AMP SIGNAL:
% now that we have excluded trials based on their within trial stdev,any
% trials that loose amp
                % wholetrial
                for t=1:1:voiceonset.ntrials %trial loop
                    for s=1:nframes_to_use %data point loop
                        if goodampdata(1,each_block).wholetrial_amp(t,s)>amp_thresh
                            gooddata_SpA_pitch.wholetrial(each_block).wholetrial(t,s)=goodpitchdata(each_block).data(t,s);
                            gooddata_SpA_pitch.AMP_wholetrial(each_block).data(t,s)=goodampdata(each_block).wholetrial_amp(t,s);
                            gooddata_SpA_pitch.gooddata_pertresp(each_block).data{t}=shifted_blockalt{t,:};
                        else
                            gooddata_SpA_pitch.wholetrial(each_block).wholetrial(t,s)=NaN;
                            gooddata_SpA_pitch.AMP_wholetrial(each_block).data(t,s)=NaN;
                            gooddata_SpA_pitch.gooddata_pertresp(each_block).data{t}=shifted_blockalt{t,:};
                            
                        end
                    gooddata_SpA_pitch.audio(each_block).audio(t,:)=goodpitchdata(each_block).audio(t,:);                        
                    end
                    gooddata_SpA_pitch.wholetrial_std(t)=nanstd(gooddata_SpA_pitch.wholetrial(each_block).wholetrial(t,:));
                end

                
                %%
                   
                % prestep                
                for t=1:1:voiceonset.ntrials %trial loop
                    for s=1:201 %data point loop
                        if goodampdata(1,each_block).prestep_amp(t,s)>amp_thresh;
                            gooddata_SpA_pitch.prestep(each_block).data(t,s)=goodpitchdata(each_block).prestep_data(t,s); %% working from here
                            gooddata_SpA_pitch.AMP_pre(each_block).data(t,s)=goodampdata(each_block).prestep_amp(t,s);
                            
                        else
                            gooddata_SpA_pitch.prestep(each_block).data(t,s)=NaN;
                            gooddata_SpA_pitch.AMP_pre(each_block).data(t,s)=NaN;
                            
                        end
                    end
                    gooddata_SpA_pitch.prestep_std(t)=nanstd(gooddata_SpA_pitch.prestep(each_block).data(t,:));
                    
                end
                
                    % poststep                
                for t=1:1:voiceonset.ntrials %trial loop
                    for s=1:201 %data point loop
                        if goodampdata(1,each_block).poststep_amp(t,s)>amp_thresh;
                            gooddata_SpA_pitch.poststep(each_block).data(t,s)=goodpitchdata(each_block).poststep_data(t,s);
                            gooddata_SpA_pitch.AMP_post(each_block).data(t,s)=goodampdata(each_block).poststep_amp(t,s);
                        else
                            gooddata_SpA_pitch.poststep(each_block).data(t,s)=NaN;
                            gooddata_SpA_pitch.AMP_post(each_block).data(t,s)=NaN;
                            
                        end
                    end
                    gooddata_SpA_pitch.poststep_std(t)=nanstd(gooddata_SpA_pitch.poststep(each_block).data(t,:));
                    
                end

         
% put 10 nans in after first inset of amplitude signal

%% Remove trials where there are any nans

time1=200;
time2-1200;
for d=1:voiceonset.ntrials % 10
    if sum(isnan(goodpitchdata(each_block).data(d,time1:time2)))>1
        gooddata_SpA_pitch.wholetrial(each_block).wholetrial(d,:)=gooddata_SpA_pitch.wholetrial(each_block).wholetrial(d,:)
        gooddata_SpA_WF.wholetrial(each_block).wholetrial(d,:)= outbuff_wav.data(d,:);
        gooddata_pertresp(each_block).data{d}=shifted_blockalt{d,each_block};
        %or
          %goodpitchdata(each_block).audio(d,:)=
        
    else
        gooddata_SpA_pitch.wholetrial(each_block).wholetrial(d,:)=[NaN(1,nframes_to_use)];
        gooddata_SpA_WF.wholetrial(each_block).wholetrial(d,:)= outbuff_wav.data(d,:);
        gooddata_pertresp(each_block).data{d}=shifted_blockalt{d,each_block};
        goodpitchdata(each_block).audio(d,:)=[NaN(1,(length(outbuff_wav.data(d,:))))];
                    goodstd.wholetrial(d)=[NaN];
                end
            end
            
            % wholetrial waveform data --------------------------------------
            for d=1:voiceonset.ntrials % 10
                if nanstd(amp.data(d,:))<stdev_cutoff_wholetrial_amp
                    goodampdata(each_block).wholetrial_amp(d,:)= amp_data{each_block}{d}(1:nframes_to_use); 
                    goodstd.wholetrial_amp(d)=nanstd(amp_data{each_block}{d});
                else
                    goodampdata(each_block).wholetrial_amp(d,:)=[NaN(1,nframes_to_use)];
                    goodstd.wholetrial_amp(d)=[NaN];
                end
            end            
            
            outbuff_wav.data
%             
                       
                
%% Visual Inspection: 
% uncomment this section to plot things trial by trial to see how it looks: -----------------             
% T_gap=T3-T2;
% 
% for itrial=1:10
%     temp(1).data(itrial,:)= [NaN(1,T1) goodpitchdata(1).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(1).poststep_data(itrial,:)];
%     T_gap2=length(goodpitchdata(1).data) - length(temp(1).data(itrial,:));
%     window_goodpitchdata(1).data(itrial,:)= [NaN(1,T1) goodpitchdata(1).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(1).poststep_data(itrial,:) NaN(1,T_gap2)];
% end
% 
% 
%             for t=1:1:voiceonset.ntrials %trial loop
%                     %frame_taxis_long = (0:((length(shifted_blockalt{t,each_block})-1)))/frame_fs;
%                     axes(hax(1)) % original pitch tracking
%                     hpl = plot(frame_taxis(1:nframes_to_plot),pitch_data{each_block}{t}(1:nframes_to_plot)); 
%                     axis([taxis(1) taxis(end) pitch_lims2plot]);
%                     title(sprintf('trial(%d)',t));
%                     axes(hax(2)) % amp signal
%                     hpl = plot(frame_taxis(1:nframes_to_use),(gooddata_SpA_pitch.AMP_wholetrial(each_block).data(t,1:nframes_to_use)), 'r');                  
%                     axes(hax(3))
%                     hpl = plot(frame_taxis(1:nframes_to_use),(gooddata_SpA_pitch.wholetrial(each_block).wholetrial(t,1:nframes_to_use)), 'b');% axis([taxis(1) taxis(end) pitch_lims2plot]);
%                     hold
%                     hpl = plot(frame_taxis(1:nframes_to_use),window_goodpitchdata(each_block).data(t,1:nframes_to_use), 'm'); 
%                     hold off
%                     axes(hax(4))
%                     hpl = plot(frame_taxis(1:nframes_to_use),shifted_blockalt{t,each_block}(1:nframes_to_use), 'g'); axis([0 4 shift_lims2plot])
%                     axes(hax(5))
%                     hpl = plot(frame_taxis(1:nframes_to_use),voiceonset_data{each_block}(t,1:nframes_to_use), 'c'); 
%                     axis([0 4 -0.1 1.1])
%                     axes(hax(6))
%                     hpl = plot(frame_taxis(1:nframes_to_use),voicethresh_data{each_block}(t,1:nframes_to_use), 'm'); 
%                     axis([0 4 -0.1 1.1])
%                     axes(hax(7))
%                     hpl = plot(frame_taxis(1:nframes_to_use),window_goodpitchdata(each_block).data(t,1:nframes_to_use), 'r'); 
%                     %axis([0 4 -0.1 1.1])
%                     pause
%                  end


%% plot the windows over the trial to check ===============================
% % 
% T_gap=T3-T2;
% 
% for itrial=1:10
%     temp(1).data(itrial,:)= [NaN(1,T1) goodpitchdata(1).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(1).poststep_data(itrial,:)];
%     T_gap2=length(goodpitchdata(1).data) - length(temp(1).data(itrial,:));
%     window_goodpitchdata(1).data(itrial,:)= [NaN(1,T1) goodpitchdata(1).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(1).poststep_data(itrial,:) NaN(1,T_gap2)];
% end
% 
% figure
% for itrial=1:10
%     plot(frame_taxis(1:1370),pitch_data{1}{itrial}(1, 1:1370))
%     title(sprintf('trial(%d)',t));
%     hold on
%     plot(frame_taxis(1:1370),window_goodpitchdata(1).data(itrial,:), 'r');
% end
close all;
cd ..
        end
        save gooddata_SpA_pitch gooddata_SpA_pitch
        save meanstdev_pre
        save meanstdev_post
        save meanstdev_preandpost
        cd(cerebellar_data_rootdir)

    end
end


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
%     plot(frame_taxis,gooddata_SpA_pitch.wholetrial(each_block).wholetrial(a,:))
%         axis([0 1378 0 300])
% 
%     subplot(2,2,4)
%     plot(frame_taxis,gooddata_SpA_pitch.AMP_wholetrial(each_block).data(a,:), 'r')
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
%     plot(gooddata_SpA_pitch.prestep(each_block).data(a,:))
%         axis([0 300 0 300])
% 
%     subplot(2,2,4)
%     plot(gooddata_SpA_pitch.AMP_pre(each_block).data(a,:), 'r')
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
%     plot(gooddata_SpA_pitch.poststep(each_block).data(a,:))
%         axis([0 300 0 300])
% 
%     subplot(2,2,4)
%     plot(gooddata_SpA_pitch.AMP_post(each_block).data(a,:), 'r')
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
%     plot(gooddata_SpA_pitch.prestep(each_block).data(a,:));
%     pause;
% end
% 
% plot(goodpitchdata(each_block).prestep_data(1,:))
