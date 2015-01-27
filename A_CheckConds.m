
%% checks the conditions against the pert responses
% ZKA April 2014
% conditions
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

% 
% % cents to shift
% sup=100 % small up
% bup=300 % big up
% nos=0   % no shift
% sdw=-100 % small down
% bdw=-300 % big down
% cents2shift_types = [sup bup nos sdw bdw];
% 
% 


clear all
close all

npatients = 0;
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB01/expr2014.03.21.T10.46.03_mainrun/speak/';
patientdir= '/Users/zarinahagnew/Cereb_data/data/SUB01/expr2014.03.21.T10.46.03_mainrun/speak/';
homedir='/Users/zarinahagnew/Cereb_data/data/'
cd(patientdir)

load (sprintf('%sshifted_blockalt.mat',patient_info{1}.exprdir))
load (sprintf('%sexpr_config.mat',patient_info{1}.exprdir))
load (sprintf('%sgoodpitchdata.mat',patient_info{1}.exprdir))


%creates a variable called blockcondname each row of which is the
%conditions in a block (ten trials)
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

cd block2

pitchdata=get_vec_hist6('pitch2',3); %two arguments are file name and then file type (float vec)
block=get_vec_hist6('blockalt',3); %pert response (needs to be shifted in time as only begins in response to voice onsett detect
voiceonset=get_vec_hist6('voice_onset_detect',2); %voice detect
outbuff_wav=get_vec_hist6('outbuffer', 3); % playable waveform
outbuff_pitch=get_vec_hist6('output_pitch', 3); % pich of outbuffer is the target
amp=get_vec_hist6('weighted_mean_abs_inbuffer2', 3)
audio=get_vec_hist6('inbuffer2',3)


a=figure
for moo=1:10
    c=subplot(2,5,moo)
    annotation('textbox', [0 0.9 1 0.1], ...
        'String', 'pert responses for each block', ...
        'EdgeColor', 'none', ...
        'HorizontalAlignment', 'center')
    title(c,'All trials')
    text(-10,10.2,'Clear     Noise')
    
    one=goodpitchdata(1).data(moo,:)
    two=shifted_blockalt{moo, 1}
    plot(one)
    hold on
    plot(two)
    
end

blockcondname
