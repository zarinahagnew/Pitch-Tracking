clear all
close all
set_params_pitchtracking;
% T1=400;     %689ms
% T2=600;     %1378ms
% T3=1000;    %3789.5ms
% T4=1200;    %4478.5ms
% num_blocks=8; % number of blocks to analyse



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
    load all_B_outputforplotting
    
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
    ispl = ispl + 1; hax(ispl) = subplot(nspl,1,ispl);%
    ntrials = vhs.inbuffer2.ntrials;
    y = play_vec_hist6(vhs.inbuffer2,1,fs,0);
    
    nsamps = length(y);
    taxis = (0:(nsamps-1))/fs;
    nframes = vhs.pitch2.nvecs;
    data_size = vhs.inbuffer2.vec_size;
    frame_fs = fs/data_size;
    frame_taxis = (0:(nframes-1))/frame_fs;
    
    
    framestosecs=(frame_num)/frame_fs
    
    frame_taxis_to_use = (0:(nframes_to_use-1))/frame_fs;
    frame_taxis_window = (0:201)/frame_fs;
    T_gap=T3-T2;

for each_block=1:8
    %calculates the data for the windows
    for itrial=1:10
        temp(each_block).data(itrial,:)= [NaN(1,T1) goodpitchdata(each_block).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(each_block).poststep_data(itrial,:)];
        T_gap2=length(goodpitchdata(each_block).data) - length(temp(each_block).data(itrial,:));
        window_goodpitchdata(each_block).data(itrial,:)= [NaN(1,T1) goodpitchdata(each_block).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(each_block).poststep_data(itrial,:) NaN(1,T_gap2)];
    end
        
%         % plots all trials one by one
%         % comment out to get other figures
%         
%         for t=1:1:voiceonset.ntrials %trial loop
%             %frame_taxis_long = (0:((length(shifted_blockalt{t,each_block})-1)))/frame_fs;
%             axes(hax(1)) % original pitch tracking
%             hpl = plot(frame_taxis(1:nframes_to_plot),pitch_data{each_block}{t}(1:nframes_to_plot));
%             axis([taxis(1) taxis(end) pitch_lims2plot]);
%             title(sprintf('trial(%d)',t));
%             axes(hax(2)) % amp signal
%             hpl = plot(frame_taxis(1:nframes_to_use),(gooddata.AMP_wholetrial(each_block).data(t,1:nframes_to_use)), 'r');
%             axes(hax(3))
%             hpl = plot(frame_taxis(1:nframes_to_use),(gooddata.wholetrial(each_block).wholetrial(t,1:nframes_to_use)), 'b');% axis([taxis(1) taxis(end) pitch_lims2plot]);
%             hold
%             hpl = plot(frame_taxis(1:nframes_to_use),window_goodpitchdata(each_block).data(t,1:nframes_to_use), 'm');
%             hold off
%             axes(hax(4))
%             hpl = plot(frame_taxis(1:nframes_to_use),shifted_blockalt{t,each_block}(1:nframes_to_use), 'g'); axis([0 4 shift_lims2plot])
%             axes(hax(5))
%             hpl = plot(frame_taxis(1:nframes_to_use),voiceonset_data{each_block}(t,1:nframes_to_use), 'c');
%             axis([0 4 -0.1 1.1])
%             axes(hax(6))
%             hpl = plot(frame_taxis(1:nframes_to_use),voicethresh_data{each_block}(t,1:nframes_to_use), 'm');
%             axis([0 4 -0.1 1.1])
%             axes(hax(7))
%             hpl = plot(frame_taxis(1:nframes_to_use),window_goodpitchdata(each_block).data(t,1:nframes_to_use), 'r');
%             %axis([0 4 -0.1 1.1])
%             pause
%         end
%         
        
        for itrial=1:10
            temp(each_block).data(itrial,:)= [NaN(1,T1) goodpitchdata(each_block).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(each_block).poststep_data(itrial,:)];
            T_gap2=length(goodpitchdata(each_block).data) - length(temp(1).data(itrial,:));
            window_goodpitchdata(each_block).data(itrial,:)= [NaN(1,T1) goodpitchdata(each_block).prestep_data(itrial,:) NaN(1,(T_gap)) goodpitchdata(each_block).poststep_data(itrial,:) NaN(1,T_gap2)];
        end
        
        fig1=figure;
        for itrial=1:10
            plot(frame_taxis(1:nframes_to_use),pitch_data{each_block}{itrial}(1, 1:nframes_to_use))
            title(sprintf('block(%d)',t));
            hold on
            plot(frame_taxis(1:nframes_to_use),window_goodpitchdata(each_block).data(itrial,:), 'm');
        end 
    end
    
    % plots all trials in one figure
    fig2=figure;
    title(sprintf('All trials per subject',t));

    for each_block=1:3
        for itrial=1:10
            plot(frame_taxis(1:1370),pitch_data{each_block}{itrial}(1, 1:1370), 'b')
            hold all
            plot(frame_taxis(1:1370),window_goodpitchdata(each_block).data(itrial,:), 'm');
        end
    end
    
    saveas(fig2, 'alltrialsplotted.jpg')
    %close all
    
end

