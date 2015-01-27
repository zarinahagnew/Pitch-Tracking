%debug

% this is wrong, it is the mean for the whole trial. 

%script G
group_cond1_pats_pre
group_cond1_pats_pre=group_cond1_pats_pre(1:16,:);
group_cond1_pats_pre(1,:)=DATA(1).mean_cond1_pre(1,:); 

% script D
DATA(1).mean_cond1_pre(b)=nanmean(sorted_data(1).prestep(:,b));
sorted_data(1).prestep

% script C
sorted_data(blockx(trial)).prestep(line_counter(blockx(trial)),:)=gooddata(1).prestep(each_block).data(trial,:);



figure
clf
subplot(3,1,1)
plot(group_cond1_pats_to_use_mean(T1:end), 'b')
axis([1 1500 120 180])

subplot(3,1,2)
plot(group_cond1_pats_to_use_mean(T1:T2), 'b')
axis([1 1500 120 180])
nanmean(group_cond1_pats_to_use_mean(T1:T2))
subplot(3,1,3)
plot(group_cond1_pats_to_use_pre_mean, 'b')
axis([1 1500 120 180])
nanmean(group_cond1_pats_to_use_pre_mean)


close all
figure
subplot(2,1,1)
plot(group_cond1_pats_to_use_mean)
subplot(2,1,2)
plot(zscorenorm_GroupMean_pats_cond1)

figure
subplot(2,1,1)
plot(group_cond1_HCs_to_use_mean)
subplot(2,1,2)
plot(zscorenorm_GroupMean_HCs_cond1, 'b')
% hold 
% plot(zscorenorm_GroupMean_pats_cond1, 'm')




subplot(2,1,1)
plot(group_cond2_pats_to_use_mean)
subplot(2,1,2)
plot(zscorenorm_GroupMean_pats_cond2)

subplot(2,1,1)
plot(group_cond4_pats_to_use_mean)
subplot(2,1,2)
plot(zscorenorm_GroupMean_pats_cond4)

