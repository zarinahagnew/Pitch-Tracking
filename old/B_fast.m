%% Seperates the good and bad trials for the pitch tracking experiment.
% -------------------------------------------------------------------------
% ZKA March 2014
% this is an automated version which looks at each trial,
% there is a option to play each trial which is commented out for now


%% here we go
clear all
close all

set_params;
amp_thresh=5*(10 ^ 7);                                  %amplitude threshold for cut off
cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
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



originalFolder = pwd;

load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/SubjectShiftsAllSubs
% Subject Loop
for each_subject = 1:npatients

    the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
    cd (the_expr_dir)      
%     the_expr_dir = [cerebellar_data_rootdir (patient_info{each_subject}.exprdir)];
%     cd (the_expr_dir)
%     
    % load the shifted_block alt from each subjects' folder. this is *not*
    % actually shifted, it is the original pert resp. See previous script for details.
    load (sprintf('%sshifted_blockalt.mat',patient_info{each_subject}.exprdir));
    load (sprintf('%svoiceonsetdata.mat',patient_info{each_subject}.exprdir));
    load (sprintf('%sALLDATA.mat',patient_info{each_subject}.exprdir));

    %create empty variable for the good trials
    good_trial=NaN(8,10);
    curdir=cd;
    
    load expr_config.mat;                                   % this loads nframes_per_trial
    
    %% block loop
    for each_block=1:num_blocks;
        
        % create condition orders
        blockcondname=NaN(8,10);
        
        for each_block=1:8;
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
        end
        
        blockx=blockcondname(each_block,:);
        %load singlesubdata
        
        foldernumber=each_block-1;
        cd (the_expr_dir)
        
        folder = sprintf('block%d', foldernumber);
        cd (folder);
        
        
        %% align all trials to voice onset (by deleting the frames before voice onset)
        for itrial=1:10
            for iframe=1:nframes_to_use
                if iframe<=voiceonsetdata{itrial,each_block}
                    shiftedpitch_data{1,each_block}{1,itrial}(iframe)=NaN;
                end
            end
        end
        
        %% REMOVE BAD TRIALS ACCORDING TO PERCEPTUAL SCORE
        load /Users/zagnew/Cereb_data/data/SUB.mat;
        for each_block=1:8
            for d=1:trialsperblock
                if SUB{each_subject}.block{each_block}(d)==1;
                    data_1.goodpitchdata(each_block).data(d,:)=shiftedpitch_data{1,each_block}{1,d}(1:nframes_to_use);     % group data from ypitch_fr
                    %shiftedpitch_data{1,each_block}{1,d}
                    data_1.goodstd.wholetrial(d)=nanstd(shiftedpitch_data{1,each_block}{1, d}(1:nframes_to_use));          % within trial stdev
                    data_1.goodpertresp(each_block).data{d}=shifted_blockalt{d,each_block}(1:nframes_to_use);
                    %data_1.goodpitchdata(each_block).audio(d,:)=outbuff_wav.data(d,:);
                    %amp data
                    data_1.goodampdata(each_block).wholetrial_amp(d,:)= amp_data{each_block}{d}(1:nframes_to_use);
                    data_1.goodstd.wholetrial_amp(d)=nanstd(amp_data{each_block}{d});
                    %pre step
                    data_1.goodpitchdata(each_block).prestep_data(d,:)=shiftedpitch_data{1,each_block}{1, d}(T1:T2);
                    data_1.goodstd.prestep(d)=nanstd(shiftedpitch_data{1,each_block}{1, d}(T1:T2));
                    % amp
                    data_1.goodampdata(each_block).prestep_amp(d,:)=amp_data{each_block}{d}(1,T1:T2);
                    data_1.goodstd.prestep_amp(d)=nanstd(amp_data{each_block}{d}(1,T1:T2));
                    %poststep
                    data_1.goodstd.poststep(d)=nanstd(shiftedpitch_data{1,each_block}{1, d}(T3:T4));
                    data_1.goodpitchdata(each_block).poststep_data(d,:)=shiftedpitch_data{1,each_block}{1, d}(T3:T4);
                    
                    data_1.goodampdata(each_block).poststep_amp(d,:)=amp_data{each_block}{d}(1,T3:T4);
                    data_1.goodstd.poststep_amp(d)=nanstd(amp_data{each_block}{d}(1,T3:T4));
                    
                else
                    data_1.goodpitchdata(each_block).data(d,:)=nan(1,nframes_to_use);
                    data_1.goodpertresp(each_block).data{d}=shifted_blockalt{d,each_block}(1:nframes_to_use);
                    data_1.goodpitchdata(each_block).audio(d,:)=nan(1,(length(outbuff_wav.data(d,:))));
                    data_1.goodstd.wholetrial(d)=[NaN];
                    data_1.goodampdata(each_block).wholetrial_amp(d,:)=[NaN(1,nframes_to_use)];
                    data_1.goodstd.wholetrial_amp(d)=[NaN];
                    data_1.goodpitchdata(each_block).prestep_data(d,:)=[NaN(1,201)];
                    data_1.goodstd.prestep(d)=[NaN];
                    data_1.goodampdata(each_block).prestep_amp(d,:)=[NaN(1,201)];
                    data_1.goodstd.prestep_amp(d)=[NaN];
                    data_1.goodpitchdata(each_block).poststep_data(d,:)=[NaN(1,201)];
                    data_1.goodstd.poststep(d)=[NaN];
                    data_1.goodampdata(each_block).poststep_amp(d,:)=[NaN(1,201)];
                    data_1.goodstd.poststep_amp(d)=[NaN];
                end
            end
        end
        
        
        %% REMOVE FIRST 200 FRAMES (REACTION TIME)
        data_2=data_1; % make copy
        for each_block=1:8
            for d=1:10
                data_2.goodpitchdata(each_block).data(d,1:reactiontime_frames)=NaN;
            end
        end
        
        %% REMOVE BAD TRIALS ACCORDING TO WHERE THERE IS NO AMP SIGNAL
        data_3=data_2;
        for each_block=1:8
            for d=1:10
                for s=1:nframes_to_use                                          %data point loop
                    if data_1.goodampdata(each_block).wholetrial_amp(d,s)<amp_thresh
                        data_3.goodpitchdata(each_block).data(d,s)=NaN;
                    end
                end
            end
        end
        %% REMOVE FIRST 10 FRAMES AFTER BREAK IN VOICING
        % 1. create binary marker array and call it B
        for each_block=1:8
            for d=1:10
                for i=1:length(data_1.goodampdata(each_block).wholetrial_amp(d,:))
                    if data_1.goodampdata(each_block).wholetrial_amp(d,i)>amp_thresh;
                        marker.data(each_block).data(d,i)=80;
                    end
                end
            end
        end
        
        % 2. make marker trials the same length as nframstouse
        for each_block=1:8
            for d=1:10
                padding=nframes_to_use-length(marker.data(each_block).data(d,:));
                marker2.data(each_block).data(d,:) = padarray(marker.data(each_block).data(d,:),[0 padding],'post');
            end
        end
                %3. create a copy of the data from the last stage above and replace the
                data_4=data_3;
                for each_block=1:8
                    for d=1:10
                        for i=1:nframes_to_use-framestoremove
                            if marker2.data(each_block).data(d,i)<10
                                data_4.goodpitchdata(each_block).data(d,i:i+framestoremove)=NaN;
                            end
                        end
                    end
                end
        %% create pre and post windows at this point
        for each_block=1:8
            for d=1:10
                data_4.prestep(each_block).data(d,:)=data_4.goodpitchdata(each_block).data(d, T1:T2);
                data_4.poststep(each_block).data(d,:)=data_4.goodpitchdata(each_block).data(d, T3:T4);
            end
        end
        %% REMOVE ACCORDING TO MOTOR PERFORMANCE
        for each_block=1:8
            for d=1:10
                if blockx(d)==1 | blockx(d)==6
                    pre_target(each_block).data(d)= shiftinhertz_allsubs(each_subject).nostep;
                    post_target(each_block).data(d)=shiftinhertz_allsubs(each_subject).smallstepup;
                elseif blockx(d)==2 | blockx(d)==7
                    pre_target(each_block).data(d)= shiftinhertz_allsubs(each_subject).nostep;
                    post_target(each_block).data(d)=shiftinhertz_allsubs(each_subject).bigstepup;
                elseif blockx(d)==3 | blockx(d)==8
                    pre_target(each_block).data(d)= shiftinhertz_allsubs(each_subject).nostep;
                    post_target(each_block).data(d)=shiftinhertz_allsubs(each_subject).nostep;
                elseif blockx(d)==4 | blockx(d)==9
                    pre_target(each_block).data(d)= shiftinhertz_allsubs(each_subject).nostep;
                    post_target(each_block).data(d)=shiftinhertz_allsubs(each_subject).smallstepdown;
                elseif blockx(d)==5 | blockx(d)==10
                    pre_target(each_block).data(d)= shiftinhertz_allsubs(each_subject).nostep;
                    post_target(each_block).data(d)=shiftinhertz_allsubs(each_subject).bigstepdown;
                else
                    error('something wrong with condition orders..')
                end
            end
        end        
        
        data_5=data_4;
        
        for each_block=1:8
            for d=1:10
                data_5.pre_distfromtarget(each_block).data(d)=nanmean(data_4.prestep(each_block).data(d,:))- pre_target(each_block).data(d);
                data_5.post_distfromtarget(each_block).data(d)=nanmean(data_4.poststep(each_block).data(d,:))- post_target(each_block).data(d);
                
                %if they don't hit the prestep target write nans into the whole trial and prestep data
                if data_5.pre_distfromtarget(each_block).data(d)> perf_thresh_pos || data_5.pre_distfromtarget(each_block).data(d)<perf_thresh_neg
                    data_5.prestep(each_block).data(d,:)=nan(1,201);
                    data_5.goodpitchdata(each_block).data(d,:)=nan(1,1360);
                end
                
                if data_5.post_distfromtarget(each_block).data(d) > perf_thresh_pos || data_5.post_distfromtarget(each_block).data(d)<perf_thresh_neg
                    data_5.poststep(each_block).data(d,:)=nan(1,201);
                    %data_5.goodpitchdata(each_block).data(d,:)=nan(1,1360);

%                     subplot(4,1,1)
%                     plot(data_5.goodpitchdata(each_block).data(d,:))
%                     subplot(4,1,2)
%                     plot(data_5.goodpertresp(each_block).data{d})
%                     axis([1 1400 -350 350])

                end
            end
        end
        
        
        %             data_5.post_distfromtarget(1).data(2)
        %             data_5.post_distfromtarget(each_block).data(d)
        %
        %% REMOVE BAD TRIALS ACCORDING TO STDEV:
        
        data_6=data_5; % make copy
        %pitch data
        for each_block=1:8
            for d=1:10
                if nanstd(data_5.goodpitchdata(each_block).data(d,:))>stdev_cutoff_wholetrial
                    data_6.goodpitchdata(each_block).data(d,:)=NaN(1,nframes_to_use);
                end
                
                if nanstd(data_5.prestep(each_block).data(d,:))>stdev_cutoff_pre
                    data_6.prestep(each_block).data(d,:)=nan(1,201);
                end
                
                if nanstd(data_5.poststep(each_block).data(d,:))>stdev_cutoff_post
                    data_6.poststep(each_block).data(d,:)=nan(1,201);
                end
            end
        end
        
        % amp data
        for each_block=1:8
            for d=1:10
                if nanstd(data_5.goodampdata(each_block).wholetrial_amp(d,:))>stdev_cutoff_wholetrial_amp
                    data_6.goodampdata(each_block).wholetrial_amp(d,:)=NaN(1,nframes_to_use);
                end
                
                if nanstd(data_5.goodampdata(each_block).prestep_amp(d,:))>stdev_cutoff_pre_amp
                    data_6.goodampdata(each_block).prestep_amp(d,:)=nan(1,201);
                end
                
                if nanstd(data_5.goodampdata(each_block).poststep_amp(d,:))>stdev_cutoff_post_amp
                    data_6.goodampdata(each_block).poststep_amp(d,:)=nan(1,201);
                end
            end
        end
        
        
        %% calculate WT devs for each subject
        for each_block=1:8
            for d=1:10
                    data_6.WTstd(each_block).wholetrial(d)=nanstd(data_6.goodpitchdata(each_block).data(d,:));          % within trial stdev
                    data_6.WTstd(each_block).prestep(d)=nanstd(data_6(1).goodpitchdata(each_block).prestep_data(d,:));          % within trial stdev
                    data_6.WTstd(each_block).poststep(d)=nanstd(data_6(1).goodpitchdata(each_block).poststep_data(d,:));          % within trial stdev
                    
                    data_6.wholetrial_WTstd_amp(each_block).wholetrial(d)=nanstd(data_6.goodampdata(each_block).wholetrial_amp(d,:));          % within trial stdev
                    data_6.prestep_WTstd_amp(each_block).wholetrial(d)=nanstd(data_6.goodampdata(each_block).prestep_amp(d,:));          % within trial stdev
                    data_6.proststep_WTstd_amp(each_block).wholetrial(d)=nanstd(data_6.goodampdata(each_block).poststep_amp(d,:));          % within trial stdev
            end 
        end
        
        % write out into 'gooddata.mat'
        gooddata=data_6;
        
%         %% plot all dis
%         for each_block=1:2
%             for d=1:10
%             
%             subplot(5,2,1)
%             plot(data_1.goodpitchdata(each_block).data(d,:))
%             axis([1 1500 70 350])
%             title('raw data')
%             
%             subplot(5,2,3)
%             plot(data_1.goodpertresp(each_block).data{d}, 'r')
%             axis([1 1500 -350 350])
%             title('pert resp')
%             
%             subplot(5,2,5)
%             plot(data_2.goodpitchdata(each_block).data(d,:))
%             axis([1 1500 70 350])
%             title('first 200 frames removed')
%             
%             subplot(5,2,7)
%             plot(data_3.goodpitchdata(each_block).data(d,:))
%             axis([1 1500 70 350])
%             title('thresholded by amp signal')
%             
%             subplot(5,2,9)
%             plot(data_4.goodpitchdata(each_block).data(d,:))
%             axis([1 1500 70 350])
%             title('voice onset artifact removed')
%             
%             subplot(5,2,2)
%             plot(data_4.prestep(each_block).data(d,:), 'c')
%             hold
%             plot(data_4.poststep(each_block).data(d,:), 'm')
%             axis([1 201 70 350])
%             title('pre and post step')
%             
%             subplot(5,2,4)
%             bar(1, data_5.post_distfromtarget(each_block).data(d), 'c')
%             hold
%             bar(2, data_5.post_distfromtarget(each_block).data(d), 'm')
%             axis([0 3 -15 15])
%             title('mean distance from target')
%             
%             subplot(5,2,6)
%             plot(data_5.prestep(each_block).data(d,:), 'c')
%             hold
%             plot(data_5.poststep(each_block).data(d,:), 'm')
%             axis([1 201 70 350])
%             title('pre and post step')
%             
%             subplot(5,2,8)
%             plot(data_6.goodpitchdata(each_block).data(d,:), 'c')
%             axis([1 1500 70 350])
%             title('stdev thresholded: whole trial')
%             
%             subplot(5,2,10)
%             plot(data_6.prestep(each_block).data(d,:), 'c')
%             hold
%             plot(data_6.poststep(each_block).data(d,:), 'c')
%             axis([1 201 70 350])
%             title('stdev thresholded: pre and post step')
%             pause
%             
%             end
%         end
        
        %% calculate gaps
        for each_block=1:8
            for d=1:10
                gaps(each_block).data(d,:)=isnan(data_6.goodpitchdata(each_block).data(d,:));
                
                
            end
        end
        
        cd (the_expr_dir)
        save gaps gaps
        
        %         figure
        %         subplot(2,1,1);
        %         plot(data_6.goodpitchdata(each_block).data(d,:))
        %
        %         subplot(2,1,2);
        %         plot(gaps(each_block).data(d,:))
        %
    end
    
    save gooddata gooddata
end

cd ..


%% ------------------------------------------------------------------------
% 
% 127.9738
% 
% 
% smallstepup:    105.9439
% bigstepup:      112.2410
% nostep:         100
% smallstepdown:  94.3896
% bigstepdown:    89.0940





