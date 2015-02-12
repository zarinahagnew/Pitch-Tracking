
clear all
close all
set_params;
fs_spec=345;

fig1=figure
cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';

npatients = 0;
npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB01/expr20140321T103415_SUBJ01_measurepitch/speak/';
patient_info_2{npatients}.exprdir = 'SUB01/expr2014.03.21.T10.46.03_mainrun/speak/';

npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB02/expr20140321T121956_Sub2_measurepitch/speak/';
patient_info_2{npatients}.exprdir = 'SUB02/expr2014.03.21.T12.33.58_mainrun/speak/';

npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB03/expr20140321T142416_Subj3-measurepitch/speak/';
patient_info_2{npatients}.exprdir = 'SUB03/expr2014.03.21.T14.35.35_mainrun/speak/';

fig2=figure
% Subject Loop
for isubj=1:npatients
    the_expr_dir = [cerebellar_data_rootdir (patient_info_2{isubj}.exprdir)];
    cd (the_expr_dir);    
    load (sprintf('%ssorted_data_spectral.mat',patient_info_2{isubj}.exprdir));
    %for iblock=1:8
    for icond=1:10
        for itrial=1:8
            nfreqs=length(sorted_data(icond).wholetrial(1,250:end))/2+1;
            temp1(icond).data(itrial,:)=my_spectrum(sorted_data(icond).wholetrial(itrial,250:end),fs_spec,nfreqs);
            subplot(5,3,itrial)
            plot(temp1(icond).data(itrial,:))
            axis([0 100 0 40])
        end
        meanspec(isubj,:).cond(icond,:)=nanmean(temp1(icond).data);        
        figure
        plot(meanspec(isubj,:).cond(icond,:), 'm', 'LineWidth', 1.2)
        axis([0 100 0 40])
        goodplot
    end
    for icond=1:10
    SPEC(isubj,:).condition(1)=meanspec(isubj).cond(icond,:)
    end
    
    
    
    cd(cerebellar_data_rootdir);
    save GroupData/meanspec.mat meanspec
end

%Pat_GpSpec=nanmean(SPEC(isubj,:))

%% Group analysis
% 
% for moo=1:npatients
% 
% end


%% working on the loop and savingggg