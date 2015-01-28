figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond1_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond1_HCs),'m','LineWidth',1.3)
title(sprintf('Cond1 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond1_wholetrial(1,:), 'k');
hold all
plot(group_cond1_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond1 - average across subjects (HCients)'));
end

% cond2
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond2_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond2_HCs),'m','LineWidth',1.3)
title(sprintf('Cond2 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond2_wholetrial(1,:), 'k');
hold all
plot(group_cond2_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond2 - average across subjects (HCients)'));
end

% cond3
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond3_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond3_HCs),'m','LineWidth',1.3)
title(sprintf('Cond3 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond3_wholetrial(1,:), 'k');
hold all
plot(group_cond3_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond3 - average across subjects (HCients)'));
end

% cond4
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond4_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond4_HCs),'m','LineWidth',1.3)
title(sprintf('Cond4 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond4_wholetrial(1,:), 'k');
hold all
plot(group_cond4_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond4 - average across subjects (HCients)'));
end
 
% cond5
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond5_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond5_HCs),'m','LineWidth',1.3)
title(sprintf('Cond5 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond5_wholetrial(1,:), 'k');
hold all
plot(group_cond5_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond5 - average across subjects (HCients)'));
end

% cond6
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond6_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond6_HCs),'m','LineWidth',1.3)
title(sprintf('Cond5 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond6_wholetrial(1,:), 'k');
hold all
plot(group_cond6_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond6 - average across subjects (HCients)'));
end

% cond7
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond7_wholetrial(1,:), 'k');
hold all
plot(group_cond7_HCs_to_use_mean,'m','LineWidth',1.3)
title(sprintf('Cond1 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond7_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond7_HCs),'b','LineWidth',1.3)
title(sprintf('Cond7 - average across subjects (HCients)'));
end


% cond8
figure
subplot(2,1,1)
for moo=1:totalHCs
plot(DATA(moo).mean_cond8_wholetrial(1,:), 'k');
hold all
plot(nanmean(group_cond8_HCs),'m','LineWidth',1.3)
title(sprintf('Cond8 - average across subjects (HCients)'));
end

subplot(2,1,2)
for moo=1:numHCs
plot(DATA_TO_USE(moo).mean_cond8_wholetrial(1,:), 'k');
hold all
plot(group_cond8_HCs_to_use_mean,'b','LineWidth',1.3)
title(sprintf('Cond8 - average across subjects (HCients)'));
end






