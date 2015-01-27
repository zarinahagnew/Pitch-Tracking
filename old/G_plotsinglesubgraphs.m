clear all
close all
set_params;

cerebellar_data_rootdir = '/Users/zagnew/Cereb_data/data/';
cd(cerebellar_data_rootdir)
load DATA.mat
%load DATA_TO_USE.mat
ymin=80;
ymax=250;
%for isubj=1:numsubs
for isubj=1:2
    
fig1=figure
subplot(3,4,1)
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'single subject responses by condition', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
plot(DATA(isubj).mean_cond1_pre)
hold
plot(DATA(isubj).mean_cond2_pre)
plot(DATA(isubj).mean_cond3_pre)
plot(DATA(isubj).mean_cond4_pre)
plot(DATA(isubj).mean_cond5_pre)
axis([0 250 ymin ymax])

subplot(3,4,2)
plot(DATA(isubj).mean_cond6_pre)
hold
plot(DATA(isubj).mean_cond7_pre)
plot(DATA(isubj).mean_cond8_pre)
plot(DATA(isubj).mean_cond9_pre)
plot(DATA(isubj).mean_cond10_pre)
axis([0 250 ymin ymax])


%post

subplot(3,4,5)
plot(DATA(isubj).mean_cond1_post, 'c')
hold
plot(DATA(isubj).mean_cond2_post, 'b')
plot(DATA(isubj).mean_cond3_post, 'k')
plot(DATA(isubj).mean_cond4_post, 'y')
plot(DATA(isubj).mean_cond5_post, 'r')
axis([0 250 ymin ymax])

subplot(3,4,6)
plot(DATA(isubj).mean_cond6_post, 'c')
hold
plot(DATA(isubj).mean_cond7_post, 'b')
plot(DATA(isubj).mean_cond8_post, 'k')
plot(DATA(isubj).mean_cond9_post, 'y')
plot(DATA(isubj).mean_cond10_post, 'r')
axis([0 250 ymin ymax])

%wholetrial
subplot(3,4,9)
plot(DATA(isubj).mean_cond1_wholetrial, 'c')
hold
plot(DATA(isubj).mean_cond2_wholetrial, 'b')
plot(DATA(isubj).mean_cond3_wholetrial, 'k')
plot(DATA(isubj).mean_cond4_wholetrial, 'y')
plot(DATA(isubj).mean_cond5_wholetrial, 'r')
axis([0 1360 ymin ymax])

subplot(3,4,10)
plot(DATA(isubj).mean_cond6_wholetrial, 'c')
hold
plot(DATA(isubj).mean_cond7_wholetrial, 'b')
plot(DATA(isubj).mean_cond8_wholetrial, 'k')
plot(DATA(isubj).mean_cond9_wholetrial, 'y')
plot(DATA(isubj).mean_cond10_wholetrial, 'r')
axis([0 1360 ymin ymax])

subplot(3,4,3)
bar(1, nanmean(DATA(1).StdWithinCond1_within_pre_stdev))
hold all
bar(2, nanmean(DATA(1).StdWithinCond2_within_pre_stdev))
bar(3, nanmean(DATA(1).StdWithinCond3_within_pre_stdev))
bar(4, nanmean(DATA(1).StdWithinCond4_within_pre_stdev))
bar(5, nanmean(DATA(1).StdWithinCond5_within_pre_stdev))

subplot(3,4,4)
bar(1, nanmean(DATA(1).StdWithinCond6_within_pre_stdev))
hold all
bar(2, nanmean(DATA(1).StdWithinCond7_within_pre_stdev))
bar(3, nanmean(DATA(1).StdWithinCond8_within_pre_stdev))
bar(4, nanmean(DATA(1).StdWithinCond9_within_pre_stdev))
bar(5, nanmean(DATA(1).StdWithinCond10_within_pre_stdev))

subplot(3,4,7)
bar(1, nanmean(DATA(1).StdWithinCond1_within_post_stdev))
hold all
bar(2, nanmean(DATA(1).StdWithinCond2_within_post_stdev))
bar(3, nanmean(DATA(1).StdWithinCond3_within_post_stdev))
bar(4, nanmean(DATA(1).StdWithinCond4_within_post_stdev))
bar(5, nanmean(DATA(1).StdWithinCond5_within_post_stdev))

subplot(3,4,8)
bar(1, nanmean(DATA(1).StdWithinCond6_within_post_stdev))
hold all
bar(2, nanmean(DATA(1).StdWithinCond7_within_post_stdev))
bar(3, nanmean(DATA(1).StdWithinCond8_within_post_stdev))
bar(4, nanmean(DATA(1).StdWithinCond9_within_post_stdev))
bar(5, nanmean(DATA(1).StdWithinCond10_within_post_stdev))


subplot(3,4,11)
bar(1, nanmean(DATA(1).StdWithinCond1_within_wholetrial_stdev))
hold all
bar(2, nanmean(DATA(1).StdWithinCond2_within_wholetrial_stdev))
bar(3, nanmean(DATA(1).StdWithinCond3_within_wholetrial_stdev))
bar(4, nanmean(DATA(1).StdWithinCond4_within_wholetrial_stdev))
bar(5, nanmean(DATA(1).StdWithinCond5_within_wholetrial_stdev))

subplot(3,4,12)
bar(1, nanmean(DATA(1).StdWithinCond6_within_wholetrial_stdev))
hold all
bar(2, nanmean(DATA(1).StdWithinCond7_within_wholetrial_stdev))
bar(3, nanmean(DATA(1).StdWithinCond8_within_wholetrial_stdev))
bar(4, nanmean(DATA(1).StdWithinCond9_within_wholetrial_stdev))
bar(5, nanmean(DATA(1).StdWithinCond10_within_wholetrial_stdev))

cd SingleSubjectPlots
saveas(fig1, (['SingleSub_data_',num2str(isubj) '.jpg']))
cd (cerebellar_data_rootdir)

end


