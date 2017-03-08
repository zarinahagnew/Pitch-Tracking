
%% anova with each subject mean distance clear vs masked trials
% called by PlotGroupData.m

%anova 1. 
anovandata_distfrommean=[reshape(distfromtarg_HCs_WT,[1, 11110]), reshape(distfromtarg_pats_WT,[1, 11110])];        
conditionlength=1111*5;
grouplength=1111*10;

group1=ones(1, 11110);
group2=group1*2;
group=[group1 group2];

cond1=ones(1,1111*5)
cond2=cond1*2
cond=[cond1 cond2 cond1 cond2]

%create group
clear condition
for i=1:1111*5
    condition{i} = 'clear';
end

for i=1111*5+1:1111*10
    condition{i} = 'noise';
end
condition=[condition condition];
condition=condition';

meandist_anova.group1=[group];
meandist_anova.group2=[condition];
%meandist_anova.group2=cond;

[meandist_anova.p_full,meandist_anova.table,meandist_anova.stats,meandist_anova.terms] = ...
    anovan(anovandata_distfrommean,{meandist_anova.group1 meandist_anova.group2}, 'interaction')

%results = multcompare(stats,'Dimension',[1 2])

meandist_anova.posthoctests=multcompare(meandist_anova.stats)

save /Users/zagnew/Cereb_data/data_final_run/GroupData/stats/meandist_anova_clearvnoise meandist_anova


%% anova with all condition  modeled separately
conditionlength=1111;
grouplength=1111*10;

group1=ones(1, 11110);
group2=group1*2;
group=[group1 group2];

clear cond
cond1=ones(1,1111)
cond2=cond1*2
cond3=cond1*3
cond4=cond1*4
cond5=cond1*5
cond6=cond1*6
cond7=cond1*7
cond8=cond1*8
cond9=cond1*9
cond10=cond1*10
cond=[cond1 cond2 cond3 cond4 cond5 cond6 cond7 cond8 cond9 cond10]
cond=[cond cond]

meandist_anova.group1=[group];
meandist_anova.group3=[cond];

[meandist_anova_.p_full,meandist_anova.table,meandist_anova.stats,meandist_anova.terms] = ...
    anovan(anovandata_distfrommean,{meandist_anova.group1 meandist_anova.group3}, 'interaction')

save /Users/zagnew/Cereb_data/data_final_run/GroupData/stats/meandist_anova_allconds meandist_anova

%% early and late windows anova

% distfromtarg_HCs_clear_EW=nanmean(distfromtarg_HCs_WT(1:5,170:471));
% distfromtarg_HCs_clear_LW=nanmean(distfromtarg_HCs_WT(1:5,472:942));
% distfromtarg_HCs_masked_EW=nanmean(distfromtarg_HCs_WT(6:10,170:471));
% distfromtarg_HCs_masked_LW=nanmean(distfromtarg_HCs_WT(6:10,472:942));
% 
% distfromtarg_pats_clear_EW=nanmean(distfromtarg_pats_WT(1:5,170:471));
% distfromtarg_pats_clear_LW=nanmean(distfromtarg_pats_WT(1:5,472:942));
% distfromtarg_pats_masked_EW=nanmean(distfromtarg_pats_WT(6:10,170:471));
% distfromtarg_pats_masked_LW=nanmean(distfromtarg_pats_WT(6:10,472:942));

anovandata_distfrommean_EWLW=[...
    distfromtarg_HCs_clear_EW distfromtarg_HCs_clear_LW distfromtarg_HCs_masked_EW distfromtarg_HCs_masked_LW ...
    distfromtarg_pats_clear_EW distfromtarg_pats_clear_LW distfromtarg_pats_masked_EW distfromtarg_pats_masked_LW];

group1=ones(1, 1544);
group2=group1*2;
group=[group1 group2];

subjs=ones(1, 386)
subjs2=subjs*2

subjects = [subjs subjs subjs subjs subjs2 subjs2 subjs2 subjs2];

clear cond
cond1=ones(1,772)
cond2=cond1*2
cond=[cond1 cond2 cond1 cond2];

wind1=ones(1,length(distfromtarg_HCs_clear_EW))
wind2=wind1*2
window=[wind1 wind2 wind1 wind2 wind1 wind2 wind1 wind2];

meandist_EWLW_anova.group1=[group];
meandist_EWLW_anova.group2=[cond];
meandist_EWLW_anova.group3=[window];
meandist_EWLW_anova.group4=[subjects];

% straight up interactions
[meandist_EWLW_anova.p_full,meandist_EWLW_anova.table,meandist_EWLW_anova.stats,meandist_EWLW_anova.terms] = ...
anovan(anovandata_distfrommean_EWLW,{meandist_EWLW_anova.group1 meandist_EWLW_anova.group2 meandist_EWLW_anova.group3},'model',3,'varnames',{'group','condition','time window'})

% post hoc test
meandist_EWLW_anova.results = multcompare(meandist_EWLW_anova.stats,'Dimension',[1 2 3])
multcompare(meandist_EWLW_anova.stats)

[c, m, h, nms]=multcompare(meandist_EWLW_anova.stats, 'alpha', 0.05,'ctype','bonferroni')
multcompare(meandist_EWLW_anova.stats, 'alpha', 0.05,'ctype','hsd')
multcompare(meandist_EWLW_anova.stats, 'alpha', 0.05,'ctype','tukey-kramer')



save /Users/zagnew/Cereb_data/data_final_run/GroupData/stats/meandist_EWLW_anova


% % % subject as random factor
% % anovan(anovandata_distfrommean_EWLW,{meandist_EWLW_anova.group1 meandist_EWLW_anova.group2 meandist_EWLW_anova.group3,meandist_EWLW_anova.group4},'model',2, 'random',4,'varnames',{'group','condition','time window', 'subjects'})
% % anovan(anovandata_distfrommean_EWLW,{meandist_EWLW_anova.group1 meandist_EWLW_anova.group2 meandist_EWLW_anova.group3},'model',2, 'random',3,'varnames',{'group','condition','time window'})
% [meandist_EWLW_anova.p_full,meandist_EWLW_anova.table,meandist_EWLW_anova.stats,meandist_EWLW_anova.terms] = ...
% anovan(anovandata_distfrommean_EWLW,{meandist_EWLW_anova.group1 meandist_EWLW_anova.group2 meandist_EWLW_anova.group3},'model',2,'varnames',{'group','condition','time window'})
% 

%anovatbl = anova(anovandata_distfrommean_EWLW,'WithinModel',WM)


