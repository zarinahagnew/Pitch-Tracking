%% calculates distance between pitch tracking and pitch target
% ZKA Jan 2015 

clear all
close all
set_params;

set(0,'DefaultFigureWindowStyle','docked');

posttarg_cond1=100;
posttarg_cond2=300;
posttarg_cond3=0;
posttarg_cond4=-100;
posttarg_cond5=-300;

load /Users/zagnew/Cereb_data/data/DATA.mat

%% PRE WINDOW

% patients
for isub=1:16
    diff_pats_cond1(isub)=abs(0 - nanmean(DATA(isub).mean_cond1_pre));
    diff_pats_cond2(isub)=abs(0 - nanmean(DATA(isub).mean_cond2_pre));
    diff_pats_cond3(isub)=abs(0 - nanmean(DATA(isub).mean_cond3_pre));
    diff_pats_cond4(isub)=abs(0 - nanmean(DATA(isub).mean_cond4_pre));
    diff_pats_cond5(isub)=abs(0 - nanmean(DATA(isub).mean_cond5_pre));
    diff_pats_cond6(isub)=abs(0 - nanmean(DATA(isub).mean_cond6_pre));
    diff_pats_cond7(isub)=abs(0 - nanmean(DATA(isub).mean_cond7_pre));
    diff_pats_cond8(isub)=abs(0 - nanmean(DATA(isub).mean_cond8_pre));
    diff_pats_cond9(isub)=abs(0 - nanmean(DATA(isub).mean_cond9_pre));
    diff_pats_cond10(isub)=abs(0 - nanmean(DATA(isub).mean_cond10_pre));
    
    diff_pats_cond1_post(isub)=abs(posttarg_cond1 - nanmean(DATA(isub).mean_cond1_post));
    diff_pats_cond2_post(isub)=abs(posttarg_cond2 - nanmean(DATA(isub).mean_cond2_post));
    diff_pats_cond3_post(isub)=abs(posttarg_cond3 - nanmean(DATA(isub).mean_cond3_post));
    diff_pats_cond4_post(isub)=abs(posttarg_cond4 - nanmean(DATA(isub).mean_cond4_post));
    diff_pats_cond5_post(isub)=abs(posttarg_cond5 - nanmean(DATA(isub).mean_cond5_post));
    diff_pats_cond6_post(isub)=abs(posttarg_cond1 - nanmean(DATA(isub).mean_cond6_post));
    diff_pats_cond7_post(isub)=abs(posttarg_cond2 - nanmean(DATA(isub).mean_cond7_post));
    diff_pats_cond8_post(isub)=abs(posttarg_cond3 - nanmean(DATA(isub).mean_cond8_post));
    diff_pats_cond9_post(isub)=abs(posttarg_cond4 - nanmean(DATA(isub).mean_cond9_post));
    diff_pats_cond10_post(isub)=abs(posttarg_cond5 - nanmean(DATA(isub).mean_cond10_post));
end

pat_mean_cond1=nanmean(diff_pats_cond1);
pat_mean_cond2=nanmean(diff_pats_cond2);
pat_mean_cond3=nanmean(diff_pats_cond3);
pat_mean_cond4=nanmean(diff_pats_cond4);
pat_mean_cond5=nanmean(diff_pats_cond5);
pat_mean_cond6=nanmean(diff_pats_cond6);
pat_mean_cond7=nanmean(diff_pats_cond7);
pat_mean_cond8=nanmean(diff_pats_cond8);
pat_mean_cond9=nanmean(diff_pats_cond9);
pat_mean_cond10=nanmean(diff_pats_cond10);

pat_mean_cond1_post=nanmean(diff_pats_cond1_post);
pat_mean_cond2_post=nanmean(diff_pats_cond2_post);
pat_mean_cond3_post=nanmean(diff_pats_cond3_post);
pat_mean_cond4_post=nanmean(diff_pats_cond4_post);
pat_mean_cond5_post=nanmean(diff_pats_cond5_post);
pat_mean_cond6_post=nanmean(diff_pats_cond6_post);
pat_mean_cond7_post=nanmean(diff_pats_cond7_post);
pat_mean_cond8_post=nanmean(diff_pats_cond8_post);
pat_mean_cond9_post=nanmean(diff_pats_cond9_post);
pat_mean_cond10_post=nanmean(diff_pats_cond10_post);

pat_mean_noise=[diff_pats_cond1 diff_pats_cond2 diff_pats_cond3 diff_pats_cond4 diff_pats_cond5];
pat_mean_clear=[diff_pats_cond6 diff_pats_cond7 diff_pats_cond8 diff_pats_cond9 diff_pats_cond10];
pat_mean_noise_group=nanmean(pat_mean_noise);
pat_mean_clear_group=nanmean(pat_mean_clear);

pat_mean_noise_post=[diff_pats_cond1_post diff_pats_cond2_post diff_pats_cond3_post diff_pats_cond4_post diff_pats_cond5_post];
pat_mean_clear_post=[diff_pats_cond6_post diff_pats_cond7_post diff_pats_cond8_post diff_pats_cond9_post diff_pats_cond10_post];
pat_mean_noise_group_post=nanmean(pat_mean_noise_post);
pat_mean_clear_group_post=nanmean(pat_mean_clear_post);

% stdev
pat_mean_cond1_SEM=nanstd(diff_pats_cond1)/(sqrt(16));
pat_mean_cond2_SEM=nanstd(diff_pats_cond2)/(sqrt(16));
pat_mean_cond3_SEM=nanstd(diff_pats_cond3)/(sqrt(16));
pat_mean_cond4_SEM=nanstd(diff_pats_cond4)/(sqrt(16));
pat_mean_cond5_SEM=nanstd(diff_pats_cond5)/(sqrt(16));
pat_mean_cond6_SEM=nanstd(diff_pats_cond6)/(sqrt(16));
pat_mean_cond7_SEM=nanstd(diff_pats_cond7)/(sqrt(16));
pat_mean_cond8_SEM=nanstd(diff_pats_cond8)/(sqrt(16));
pat_mean_cond9_SEM=nanstd(diff_pats_cond9)/(sqrt(16));
pat_mean_cond10_SEM=nanstd(diff_pats_cond10)/(sqrt(16));

pat_mean_cond1_post_SEM=nanstd(diff_pats_cond1_post)/(sqrt(16))
pat_mean_cond2_post_SEM=nanstd(diff_pats_cond2_post)/(sqrt(16))
pat_mean_cond3_post_SEM=nanstd(diff_pats_cond3_post)/(sqrt(16))
pat_mean_cond4_post_SEM=nanstd(diff_pats_cond4_post)/(sqrt(16))
pat_mean_cond5_post_SEM=nanstd(diff_pats_cond5_post)/(sqrt(16))
pat_mean_cond6_post_SEM=nanstd(diff_pats_cond6_post)/(sqrt(16))
pat_mean_cond7_post_SEM=nanstd(diff_pats_cond7_post)/(sqrt(16))
pat_mean_cond8_post_SEM=nanstd(diff_pats_cond8_post)/(sqrt(16))
pat_mean_cond9_post_SEM=nanstd(diff_pats_cond9_post)/(sqrt(16))
pat_mean_cond10_post_SEM=nanstd(diff_pats_cond10_post)/(sqrt(16))

%pat_mean_noise_stdev=[diff_pats_cond1_stdev diff_pats_cond2_stdev diff_pats_cond3_stdev diff_pats_cond4_stdev diff_pats_cond5_stdev]
pat_mean_clear=[diff_pats_cond6 diff_pats_cond7 diff_pats_cond8 diff_pats_cond9 diff_pats_cond10]
pat_mean_noise_group=nanmean(pat_mean_noise)
pat_mean_clear_group=nanmean(pat_mean_clear)

pat_SEM_noise_group=nanstd(pat_mean_noise)/sqrt(80)
pat_SEM_clear_group=nanstd(pat_mean_clear)/sqrt(80)

pat_mean_noise_post=[diff_pats_cond1_post diff_pats_cond2_post diff_pats_cond3_post diff_pats_cond4_post diff_pats_cond5_post]
pat_mean_clear_post=[diff_pats_cond6_post diff_pats_cond7_post diff_pats_cond8_post diff_pats_cond9_post diff_pats_cond10_post]
pat_mean_noise_group_post=nanmean(pat_mean_noise_post)
pat_mean_clear_group_post=nanmean(pat_mean_clear_post)

pat_SEM_noise_group_post=nanstd(pat_mean_noise_post)/sqrt(80)
pat_SEM_clear_group_post=nanstd(pat_mean_clear_post)/sqrt(80)


%% HCs

for isub=1:11            
    diff_HC_cond1(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond1_pre));
    diff_HC_cond2(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond2_pre));
    diff_HC_cond3(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond3_pre));
    diff_HC_cond4(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond4_pre));
    diff_HC_cond5(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond5_pre));
    diff_HC_cond6(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond6_pre));
    diff_HC_cond7(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond7_pre));
    diff_HC_cond8(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond8_pre));
    diff_HC_cond9(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond9_pre));
    diff_HC_cond10(isub)=abs(0 - nanmean(DATA(isub+16).mean_cond10_pre));
    
    diff_HC_cond1_post(isub)=abs(posttarg_cond1 - nanmean(DATA(isub+16).mean_cond1_post));
    diff_HC_cond2_post(isub)=abs(posttarg_cond2 - nanmean(DATA(isub+16).mean_cond2_post));
    diff_HC_cond3_post(isub)=abs(posttarg_cond3 - nanmean(DATA(isub+16).mean_cond3_post));
    diff_HC_cond4_post(isub)=abs(posttarg_cond4 - nanmean(DATA(isub+16).mean_cond4_post));
    diff_HC_cond5_post(isub)=abs(posttarg_cond5 - nanmean(DATA(isub+16).mean_cond5_post));
    diff_HC_cond6_post(isub)=abs(posttarg_cond1 - nanmean(DATA(isub+16).mean_cond6_post));
    diff_HC_cond7_post(isub)=abs(posttarg_cond2 - nanmean(DATA(isub+16).mean_cond7_post));
    diff_HC_cond8_post(isub)=abs(posttarg_cond3 - nanmean(DATA(isub+16).mean_cond8_post));
    diff_HC_cond9_post(isub)=abs(posttarg_cond4 - nanmean(DATA(isub+16).mean_cond9_post));
    diff_HC_cond10_post(isub)=abs(posttarg_cond5 - nanmean(DATA(isub+16).mean_cond10_post));
    
    end

HC_mean_cond1=nanmean(diff_HC_cond1);
HC_mean_cond2=nanmean(diff_HC_cond2);
HC_mean_cond3=nanmean(diff_HC_cond3);
HC_mean_cond4=nanmean(diff_HC_cond4);
HC_mean_cond5=nanmean(diff_HC_cond5);
HC_mean_cond6=nanmean(diff_HC_cond6);
HC_mean_cond7=nanmean(diff_HC_cond7);
HC_mean_cond8=nanmean(diff_HC_cond8);
HC_mean_cond9=nanmean(diff_HC_cond9);
HC_mean_cond10=nanmean(diff_HC_cond10);

HC_mean_noise=[diff_HC_cond1 diff_HC_cond2 diff_HC_cond3 diff_HC_cond4 diff_HC_cond5];
HC_mean_clear=[diff_HC_cond6 diff_HC_cond7 diff_HC_cond8 diff_HC_cond9 diff_HC_cond10];
HC_mean_noise_group=nanmean(HC_mean_noise);
HC_mean_clear_group=nanmean(HC_mean_clear);

HC_mean_cond1_post=nanmean(diff_HC_cond1_post);
HC_mean_cond2_post=nanmean(diff_HC_cond2_post);
HC_mean_cond3_post=nanmean(diff_HC_cond3_post);
HC_mean_cond4_post=nanmean(diff_HC_cond4_post);
HC_mean_cond5_post=nanmean(diff_HC_cond5_post);
HC_mean_cond6_post=nanmean(diff_HC_cond6_post);
HC_mean_cond7_post=nanmean(diff_HC_cond7_post);
HC_mean_cond8_post=nanmean(diff_HC_cond8_post);
HC_mean_cond9_post=nanmean(diff_HC_cond9_post);
HC_mean_cond10_post=nanmean(diff_HC_cond10_post);

HC_mean_noise_post=[diff_HC_cond1_post diff_HC_cond2_post diff_HC_cond3_post diff_HC_cond4_post diff_HC_cond5_post];
HC_mean_clear_post=[diff_HC_cond6_post diff_HC_cond7_post diff_HC_cond8_post diff_HC_cond9_post diff_HC_cond10_post];
HC_mean_noise_group_post=nanmean(HC_mean_noise_post);
HC_mean_clear_group_post=nanmean(HC_mean_clear_post);

HC_SEM_noise_group=nanstd(HC_mean_noise)/sqrt(55);
HC_SEM_clear_group=nanstd(HC_mean_clear)/sqrt(55);

HC_SEM_noise_group_post=nanstd(HC_mean_noise_post)/sqrt(55);
HC_SEM_clear_group_post=nanstd(HC_mean_clear_post)/sqrt(55);

%% ttests
% within group
ttest(pat_mean_noise,pat_mean_clear)
ttest(pat_mean_noise_post,pat_mean_clear_post)
ttest(HC_mean_noise,HC_mean_clear)
ttest(HC_mean_noise_post,HC_mean_clear_post)

% across group
ttest2(pat_mean_noise, HC_mean_noise)
ttest2(pat_mean_clear, HC_mean_clear)
ttest2(pat_mean_noise_post, HC_mean_noise_post)
ttest2(pat_mean_clear_post, HC_mean_clear_post)


%% plot this

% clf
% subplot(2,2,1)
% bar(1,pat_mean_noise_group, 'k')
% hold all
% bar(2,pat_mean_clear_group, 'k')
% axis([0 3 -2 2])
% 
% subplot(2,2,2)
% bar(1,HC_mean_noise_group, 'r')
% hold
% bar(2,HC_mean_clear_group, 'r')
% axis([0 3 -2 2])
% 
% subplot(2,2,3)
% bar(1,pat_mean_noise_group_post, 'k')
% hold all
% bar(2,pat_mean_clear_group_post, 'k')
% axis([0 3 -2 2])
% 
% subplot(2,2,4)
% bar(1,HC_mean_noise_group_post, 'r')
% hold all
% bar(2,HC_mean_clear_group_post, 'r')
% axis([0 3 -2 2])


%% plot mean performance with error bars

distfromtarg_data=[pat_mean_noise_group pat_mean_clear_group; ...
          HC_mean_noise_group HC_mean_clear_group; ...
          pat_mean_noise_group_post pat_mean_clear_group_post; ...
          HC_mean_noise_group_post HC_mean_clear_group_post]

errY2= [pat_SEM_noise_group pat_SEM_clear_group; ...
        HC_SEM_noise_group HC_SEM_clear_group; ...
        pat_SEM_noise_group_post pat_SEM_clear_group_post; ...
        HC_SEM_noise_group_post HC_SEM_clear_group_post]
figure
whitebg('white')

h = barwitherr(errY2, distfromtarg_data);% Plot with errorbars
set(gca,'XTickLabel',{'patients (pre)','controls (pre)','patients(post)','controls(post)'})
ylabel('distance from target pitch (Hz)')
set(h(1),'FaceColor','k');
set(h(2),'FaceColor','w');
title(sprintf('Motor performance'));

%% anova (pre and post data)
anovadata=[pat_mean_noise pat_mean_clear pat_mean_noise_post pat_mean_clear_post ...
           HC_mean_noise HC_mean_clear HC_mean_noise_post HC_mean_clear_post]  
anovadata=abs(anovadata)       ;
       
PAT_size=length(pat_mean_noise)
HC_size=length(HC_mean_noise)

%create subject group
pattest=ones(1,320);
HCtest=ones(1,220);
test2=HCtest*2;
subjectgroup=[pattest test2];

%create window group
for i=1:PAT_size*2
    pre_post_1{i} = 'pre';
end

for i=1:PAT_size*2
    pre_post_2{i} = 'post';
end

temp_1=[pre_post_1 pre_post_2]

for i=1:HC_size*2
    pre_post_3{i} = 'pre';
end

for i=1:HC_size*2
    pre_post_4{i} = 'post';
end
temp_2=[pre_post_3 pre_post_4]

pre_post=[temp_1 temp_2]
pre_post=pre_post'

%create condition group
for i=1:PAT_size
    condition_1{i}='noise';
end

for i=1:PAT_size
    condition_2{i}='clear';
end

for i=1:HC_size
    condition_3{i}='noise';
end

for i=1:HC_size
    condition_4{i}='clear';
end

condition=[condition_1 condition_2 condition_1 condition_2 condition_3 condition_4 condition_3 condition_4]
condition=condition'

group1=[subjectgroup];
group2=[pre_post];
group3=[condition];
p = anovan(anovadata,{group1 group2 group3},'model','interaction');

%% pre step anova
anovadata_prestep=[pat_mean_noise pat_mean_clear HC_mean_noise HC_mean_clear]  
  
PAT_size=length(pat_mean_noise)
HC_size=length(HC_mean_noise)

%create subject group
pattest=ones(1,160);
HCtest=ones(1,110);
test2=HCtest*2;
subjectgroup=[pattest test2];

%create condition group
for i=1:PAT_size
    condition_1{i}='noise';
end

for i=1:PAT_size
    condition_2{i}='clear';
end

for i=1:HC_size
    condition_3{i}='noise';
end

for i=1:HC_size
    condition_4{i}='clear';
end

condition=[condition_1 condition_2 condition_3 condition_4]
condition=condition'

group1=[subjectgroup];
group2=[condition];
p = anovan(anovadata_prestep,{group1 group2},'model','interaction');

%% caluclate distance between performance and target
%create targets
test=[zeros(1, stepframe) ones(1, 1360-stepframe)]
smallup=test*100;
bigup=test*300;
smalldown=test*-100;
bigdown=test*-300;
nostep=zeros(1,1360);

% calulate distances for each subject
for isubj=1:27
dist_from_targ_cond1(isubj,:)=calc_distance(smallup, DATA(isubj).mean_cond1_wholetrial);
dist_from_targ_cond2(isubj,:)=calc_distance(bigup, DATA(isubj).mean_cond2_wholetrial);
dist_from_targ_cond3(isubj,:)=calc_distance(nostep, DATA(isubj).mean_cond3_wholetrial);
dist_from_targ_cond4(isubj,:)=calc_distance(smalldown, DATA(isubj).mean_cond4_wholetrial);
dist_from_targ_cond5(isubj,:)=calc_distance(bigdown, DATA(isubj).mean_cond5_wholetrial);
dist_from_targ_cond6(isubj,:)=calc_distance(smallup, DATA(isubj).mean_cond6_wholetrial);
dist_from_targ_cond7(isubj,:)=calc_distance(bigup, DATA(isubj).mean_cond7_wholetrial);
dist_from_targ_cond8(isubj,:)=calc_distance(nostep, DATA(isubj).mean_cond8_wholetrial);
dist_from_targ_cond9(isubj,:)=calc_distance(smalldown, DATA(isubj).mean_cond9_wholetrial);
dist_from_targ_cond10(isubj,:)=calc_distance(bigdown, DATA(isubj).mean_cond10_wholetrial);
end

PAT.meandist_from_targ(1,:) = nanmean(dist_from_targ_cond1(1:16,:));
PAT.meandist_from_targ(2,:) = nanmean(dist_from_targ_cond2(1:16,:));
PAT.meandist_from_targ(3,:) = nanmean(dist_from_targ_cond3(1:16,:));
PAT.meandist_from_targ(4,:) = nanmean(dist_from_targ_cond4(1:16,:));
PAT.meandist_from_targ(5,:) = nanmean(dist_from_targ_cond5(1:16,:));
PAT.meandist_from_targ(6,:) = nanmean(dist_from_targ_cond6(1:16,:));
PAT.meandist_from_targ(7,:) = nanmean(dist_from_targ_cond7(1:16,:));
PAT.meandist_from_targ(8,:) = nanmean(dist_from_targ_cond8(1:16,:));
PAT.meandist_from_targ(9,:) = nanmean(dist_from_targ_cond9(1:16,:));
PAT.meandist_from_targ(10,:) = nanmean(dist_from_targ_cond10(1:16,:));

HC.meandist_from_targ(1,:) = nanmean(dist_from_targ_cond1(17:27,:));
HC.meandist_from_targ(2,:) = nanmean(dist_from_targ_cond2(17:27,:));
HC.meandist_from_targ(3,:) = nanmean(dist_from_targ_cond3(17:27,:));
HC.meandist_from_targ(4,:) = nanmean(dist_from_targ_cond4(17:27,:));
HC.meandist_from_targ(5,:) = nanmean(dist_from_targ_cond5(17:27,:));
HC.meandist_from_targ(6,:) = nanmean(dist_from_targ_cond6(17:27,:));
HC.meandist_from_targ(7,:) = nanmean(dist_from_targ_cond7(17:27,:));
HC.meandist_from_targ(8,:) = nanmean(dist_from_targ_cond8(17:27,:));
HC.meandist_from_targ(9,:) = nanmean(dist_from_targ_cond9(17:27,:));
HC.meandist_from_targ(10,:) = nanmean(dist_from_targ_cond10(17:27,:));

plot(smallup)
hold on
plot(DATA(1).mean_cond1_wholetrial)

clf
subplot(211)
plot(PAT.meandist_from_targ(1,:))
axis([0 1300 0 350])

subplot(212)
plot(HC.meandist_from_targ(1,:))
axis([0 1300 0 350])



% group mean distance - across all noise and clear trials
PAT.cleartrials_groupmean=mean(PAT.meandist_from_targ(1:5,:));
PAT.noisetrials_groupmean=mean(PAT.meandist_from_targ(6:10,:));
HC.cleartrials_groupmean=mean(HC.meandist_from_targ(1:5,:));
HC.noisetrials_groupmean=mean(HC.meandist_from_targ(6:10,:));

fig3=figure
subplot(211)
plot(PAT.cleartrials_groupmean, 'k', 'LineWidth', 1.3)
hold on
plot(PAT.noisetrials_groupmean, 'm', 'LineWidth', 1.3)
axis([0 1400 0 400])
subplot(212)
plot(HC.cleartrials_groupmean, 'k', 'LineWidth', 1.3)
hold on
plot(HC.noisetrials_groupmean, 'm', 'LineWidth', 1.3)
axis([0 1400 0 400])



