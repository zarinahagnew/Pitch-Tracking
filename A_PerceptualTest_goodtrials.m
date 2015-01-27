%% loads in perceptual test data and writes it to SUBs and saves that
% ZKA oct 2014

cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
cd(cerebellar_data_rootdir)

for isubj=1:27
    for iblock=1:8
        if iblock==1
            SUB{isubj}.block{1}=xlsread('Pats_goodtrials',isubj, '1:10');
        elseif iblock==2
            SUB{isubj}.block{2}=xlsread('Pats_goodtrials',isubj, '11:20');
        elseif iblock==3
            SUB{isubj}.block{iblock}=xlsread('Pats_goodtrials',isubj, '21:30');
        elseif iblock==4
            SUB{isubj}.block{iblock}=xlsread('Pats_goodtrials',isubj, '31:40');
        elseif iblock==5
            SUB{isubj}.block{5}=xlsread('Pats_goodtrials',isubj, '41:50');
        elseif iblock==6
            SUB{isubj}.block{6}=xlsread('Pats_goodtrials',isubj, '51:60');
        elseif iblock==7
            SUB{isubj}.block{7}=xlsread('Pats_goodtrials',isubj, '61:70');
        elseif iblock==8
            SUB{isubj}.block{8}=xlsread('Pats_goodtrials',isubj, '71:80');
            
        end
    end
    
end

save SUB SUB
