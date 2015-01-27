
clear all
close all
set_params;
fig1=figure
cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';

npatients = 0;
% npatients = npatients + 1; %400 and 1000 are ok
% patient_info{npatients}.exprdir = 'SUB01/expr20140321T103415_SUBJ01_measurepitch/speak/';
% patient_info_2{npatients}.exprdir = 'SUB01/expr2014.03.21.T10.46.03_mainrun/speak/';

npatients = npatients + 1;
patient_info{npatients}.exprdir = 'SUB02/expr20140321T121956_Sub2_measurepitch/speak/';
patient_info_2{npatients}.exprdir = 'SUB02/expr2014.03.21.T12.33.58_mainrun/speak/';
% 
% npatients = npatients + 1;
% patient_info{npatients}.exprdir = 'SUB03/expr20140321T142416_Subj3-measurepitch/speak/';
% patient_info_2{npatients}.exprdir = 'SUB03/expr2014.03.21.T14.35.35_mainrun/speak/';

% Subject Loop
for subj=1:npatients
    cd(cerebellar_data_rootdir);
    load (sprintf('%ssorted_data_spectral.mat',patient_info_2{subj}.exprdir));
    for iblock=1:8
        for itrial=1:8
            nfreqs=length(sorted_data(1).wholetrial(1,:))/2+1;
            temp1(itrial,:)=my_spectrum(sorted_data(1).wholetrial(itrial,:),fs,nfreqs);
                    subplot(5,3,itrial)
                    plot(temp1(itrial,:))
                    axis([0 10 0 1])
        end
        
        meanspec(subj,:)=nanmean(temp1);
    end
    
end
