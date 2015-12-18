%% anova WTstdev pre post clear noise
anovandata_WTstdev=[group_HC_pre_clear group_HC_pre_noise group_HC_post_clear group_HC_post_noise ...
            group_pat_pre_clear group_pat_pre_noise group_pat_post_clear group_pat_post_noise];       

HClength=length(group_HC_pre_clear)*4;     
patlength=length(group_pat_pre_clear)*4;
test=ones(1,HClength);
test1=ones(1,patlength);
test2=test1*2;
subjectgroup=[test test2];

prelength=length(group_HC_pre_clear)*2
prelength2=length(group_pat_pre_clear)*2

%create window group
clear pre_post
for i=1:prelength
    pre_post{i} = 'pre';
end

for i=prelength+1:prelength*2
    pre_post{i} = 'post';
end

for i=length(pre_post)+1:length(pre_post)+prelength2
    pre_post{i} = 'pre';
end

for i=length(pre_post)+1:length(pre_post)+prelength2
    pre_post{i} = 'post';
end

pre_post=pre_post''

% 
% pre_post2=[pre_post pre_post]
% =pre_post2';

%create condition group
clear condition
clear condition2
for i=1:length(group_HC_pre_clear)
    condition{i}='clear';
end

for i=length(condition)+1:length(group_HC_pre_clear)*2
    condition{i}='noise';
end
condition=[condition condition];

for i=1:length(group_pat_pre_clear)
    condition2{i}='clear';
end

for i=length(condition2)+1:length(condition2)+length(group_pat_pre_clear)
    condition2{i}='noise';
end
condition2=[condition2 condition2]
conditions = [condition condition2]
conditions=conditions';

group1=[subjectgroup];
group2=[pre_post];
group3=[conditions];
p_interaction = anovan(anovandata_WTstdev,{group1 group2 group3},'model','interaction')
% p = anovan(anovandata,{group1 group2 group3}, 1)
p_full = anovan(anovandata_WTstdev,{group1 group2 group3}, 'full')


