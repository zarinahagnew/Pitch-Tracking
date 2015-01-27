
close all
clear all
set_params;

cd(cerebellar_data_rootdir)
TRIALS(1) = load ('SUB01/expr2014.03.21.T10.46.03_mainrun/speak/gooddata.mat');
TRIALS(2) = load ('SUB02/expr2014.03.21.T12.33.58_mainrun/speak/gooddata.mat');
TRIALS(3) = load ('SUB03/expr2014.03.21.T14.35.35_mainrun/speak/gooddata.mat');
TRIALS(4) = load ('SUB04/expr2014.03.21.T17.20.11_mainrun/speak/gooddata.mat');
TRIALS(5) = load ('SUB05/expr2014.03.21.T18.50.52_mainrun/speak/gooddata.mat');
TRIALS(6) = load ('SUB06/expr2014.03.22.T11.05.45_mainrun/speak/gooddata.mat');
TRIALS(7) = load ('SUB07/expr2014.03.22.T12.15.42_mainrun/speak/gooddata.mat');
TRIALS(8) = load ('SUB08/expr2014.03.22.T14.01.48_mainrun/speak/gooddata.mat');
TRIALS(9) = load ('SUB09/expr2014.03.22.T15.52.01_mainrun/speak/gooddata.mat');
TRIALS(10) = load ('SUB10/expr2014.03.22.T16.37.44_mainrun/speak/gooddata.mat');
TRIALS(11) = load ('SUB11/expr2014.03.22.T18.46.44_mainrun/speak/gooddata.mat');
TRIALS(12) = load ('SUB12/expr2014.03.23.T11.03.52_mainrun/speak/gooddata.mat');
TRIALS(13) = load ('SUB13/expr2014.03.23.T13.47.01_mainrun/speak/gooddata.mat');
TRIALS(14) = load ('SUB14/expr2014.03.23.T15.21.00_mainrun/speak/gooddata.mat');
TRIALS(15) = load ('SUB15/expr2014.03.23.T16.32.53_mainrun/speak/gooddata.mat');
TRIALS(16) = load ('SUB16/expr2014.03.23.T18.16.58_mainrun/speak/gooddata.mat');

% % % % list controls here
TRIALS(17) = load ('HC01/expr2014.05.06.T12.36.43_mainrun/speak/gooddata.mat');
TRIALS(18) = load ('HC02/expr2014.06.17.T12.53.53_mainrun/speak/gooddata.mat');
TRIALS(19) = load ('HC03/expr2014.06.17.T13.50.36_mainrun/speak/gooddata.mat');
TRIALS(20) = load ('HC04/expr2014.06.17.T16.22.20_mainrun/speak/gooddata.mat');
TRIALS(21) = load ('HC05/expr2014.06.18.T15.14.02_mainrun/speak/gooddata.mat');
TRIALS(22) = load ('HC06/expr2014.06.18.T16.18.27_mainrun/speak/gooddata.mat');
TRIALS(23) = load ('HC07/expr2014.07.25.T10.29.55_mainrun/speak/gooddata.mat');
TRIALS(24) = load ('HC08/expr2014.08.14.T15.57.52_mainrun/speak/gooddata.mat');
TRIALS(25) = load ('HC09/expr2014.09.21.T14.17.36_mainrun/speak/gooddata.mat');
TRIALS(26) = load ('HC10/expr2014.09.21.T15.35.54_JL_mainrun/speak/gooddata.mat');
TRIALS(27) = load ('HC11/expr2014.09.23.t15.27.32_sn_mainrun/speak/gooddata.mat');

counter=0;
counter_pre=0;
counter_post=0;

for isubj=1:27
    for iblock=1:8
        counter=0;
        counter_pre=0;
        counter_post=0;
        for itrial=1:10
            if sum(isnan(TRIALS(isubj).gooddata.goodpitchdata(iblock).data(itrial,:)))==1360;
                counter=counter+1;
            end
            
            if sum(isnan(TRIALS(isubj).gooddata.prestep(iblock).data(itrial,:)))==201;
                counter_pre=counter_pre+1;
            end
            
            if sum(isnan(TRIALS(isubj).gooddata.poststep(iblock).data(itrial,:)))==201;
                counter_post=counter_post+1;
            end
            
        end
        block_counter(iblock)=counter;
        block_counter_pre(iblock)=counter_pre;
        block_counter_post(iblock)=counter_post;
        
        % check
        if block_counter(iblock)>10
            error('ERRMSG')
        end
        
    end
    sub_counter(isubj)=sum(block_counter);
    sub_counter_pre(isubj)=sum(block_counter_pre);
    sub_counter_post(isubj)=sum(block_counter_post);
    
    
end

sub_counter=80-sub_counter;
sub_counter_pre=80-sub_counter_pre;
sub_counter_post=80-sub_counter_post;

cd GroupData/

xlswrite('WT_validtrials',sub_counter)
xlswrite('WT_validtrials_pre',sub_counter_pre)
xlswrite('WT_validtrials_post',sub_counter_post)

% clf
% for iblock=1:8
%     for moo=1:10
%         subplot(5,2,moo)
%         plot(TRIALS(isubj).gooddata.goodpitchdata(iblock).data(moo,:))
%     end
%     pause
% end




