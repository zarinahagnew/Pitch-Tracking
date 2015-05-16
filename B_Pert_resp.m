%% Converts pert resp into diff format (largely useless but essential stage)
% -------------------------------------------------------------------------
% ZKA March 2014

% used to shift the pert response to match the pitch data to shift the block alt line, find the point at which voice onset increases from 0 and add this to the
% block alt line, then plot pitch2 inbuff with block alt.
%'voiceframe' is a variable which tlls us how many frames we need to add to
% each block.data to shift it.
% BUT now it doesn't, it uses a fake voice onset array of '0's. So really
% this script simply writes the block.data for each trial to 'shifted_blockalt'
% and saves the shifted pert response and the voice onset/reaction time data

clear all;
close all;

cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data_final_run/';
set_params;
set(0,'DefaultFigureWindowStyle','docked')
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

%list controls here
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


z=0

originalFolder = pwd;
shifted_blockalt={}

% subject Loop
for each_subject = 1:npatients
    z=z+1
    the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
    cd (the_expr_dir)  
    load expr_config.mat %this has the order of conditions       
    
% block loop
    for each_block=1:8
        foldernumber=each_block-1;
        folder = sprintf('block%d', foldernumber);
        cd (folder);
        
        % import data using get_vec_hist6
        pitch=get_vec_hist6('pitch2',3); %two arguments are file name and then file type (float vec)
        block=get_vec_hist6('blockalt',3); %pert response (needs to be shifted in time as only begins in response to voice onsett detect
        voiceonset=get_vec_hist6('voice_onset_detect',2); %voice detect
        outbuff_wav=get_vec_hist6('outbuffer', 3); % playable waveform
        outbuff_pitch=get_vec_hist6('output_pitch', 3); % pich of outbuffer is the target
        
        % sort out x axis
        samples2get = length(pitch.data(2,:));
        fs = 11025;
        framef = fs/32;
        nframes_per_trial = pitch.nvecs;
        taxis = (0:(samples2get-1))/fs;
        frame_taxis = (0:(nframes_per_trial-1))/framef;
        
%% find voice onset: look in the voice onset data and find the position 
% where the value is not zero, record this frame number in voiceframe(w)
        for w=1:voiceonset.ntrials
            x = voiceonset.data(w, :);
            if sum(x)>1
                a = find( x == 1 );
                voiceframe(w)= a(1);
            else
                voiceframe(w)= 1378 
                % check this as ultimately may cause problems, on trials with no voice onset detect it marks voice onset at the end of the trial..                
            end
        end
        
%         
%         % go though each trial and write the data to shifted block alt and
%         % voiceonsetdata (frames)
%         for i=1:voiceonset.ntrials
%             trial=num2str(i);
%             blockalt1=block.data(i,:,2);
%             voiceframe(i);
%             a=zeros(1,(voiceframe(i)));
%             shifted_blockalt{i, each_block}=[a blockalt1];             
%             voiceonsetdata{i, each_block}=voiceframe(i);
%         end        

        voiceframe_fake=ones(1,10);        
        % creates fake voice onset 
        % becuase this was originally written to shift the pert_resp 
        % by the voice onset, but in the end I decided to do it 
        % another way so this is a fake voice onset of '0'. 
        % URGH SORRY FUTURE ME. 
        
        %figure;
        for i=1:voiceonset.ntrials
            blockalt1=block.data(i,:,2); % pert resp
            shifted_blockalt{i, each_block}=blockalt1;                        

            
            trial=num2str(i);
            blockalt1=block.data(i,:,2); % pert resp
            voiceframe_fake(i);
            a=zeros(1,(voiceframe_fake(i)));
            shifted_blockalt{i, each_block}=[a blockalt1];
            voiceonsetdata_fake{i, each_block}=voiceframe_fake(i);
            voiceonsetdata{i, each_block}=voiceframe(i);
            
    
        end
        
        cd .. % into block parent ('speak') folder and save data there
        
        save shifted_blockalt shifted_blockalt
        save voiceonsetdata voiceonsetdata
        save voiceonsetdata_fake voiceonsetdata_fake

    end
    
    cd(cerebellar_data_rootdir); % go home ready for next subject
    close all;
end

fprintf(' \n \n \n \n \n \n \n \n \n \n \n \n Creates shifted_blockalt.mat');

%% sanity check
% % format is shifted_blockalt{trial, block}
% shifted_blockalt - 10 down is the ten conditions
% figure
% subplot(211)
% plot(shifted_blockalt{1,1}) % should be flat
% axis([ 0 1500 -150 150])
% subplot(212)
% plot(shifted_blockalt{2,1}) % should be small down
% axis([ 0 1500 -150 150])
% 
% 
% fprintf(' \n \n \n \n \n \n \n \n \n \n \n \n Red lines show the shift so must come AFTER the green \n \n')
