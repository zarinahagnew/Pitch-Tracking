%% Plots group data for subjects that we want to include. These are
% specified in set_params.m. 
% here, data is converted into just the data for the subjects included

% (1) writes each persons data into a single matrix for each condition --------
% (2) PLOT MEAN RESPONSE FOR EACH CONDITION - fig1

clear all
close all
set_params_pitchtracking;
 
cd(cerebellar_data_rootdir)
load DATA;
DATA=DATA(allincluded);

load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/targets_norm
load /Users/zagnew/Dropbox/cerebellum_expr_devel/Zed/meanpitches/subj_MP_allsubs

%% (1) writes each persons data into a single matrix for each condition --------
calc_group_means

%% make targets
test=[zeros(1, stepframe) ones(1, 1360-stepframe)];
smallup=test*100;
bigup=test*300;
smalldown=test*-100;
bigdown=test*-300;
nostep=zeros(1,1360);

targets(1,:)=smallup;
targets(2,:)=bigup;
targets(3,:)=nostep;
targets(4,:)=smalldown;
targets(5,:)=bigdown;
targets(6,:)=smallup;
targets(7,:)=bigup;
targets(8,:)=nostep;
targets(9,:)=smalldown;
targets(10,:)=bigdown;

%% plot group means
fig1final=figure;
boxmin=-345;
boxmax=690;
ymin=-400;
ymax=400;

subplot(2,2,1)
plot(frame_taxis_to_use, HCs_WT(1,:),'LineWidth', 1.3, 'Color',up_gs);
hold all
plot(frame_taxis_to_use,HCs_WT(2,:),'LineWidth',1.3,'Color',bigup_gs);
plot(frame_taxis_to_use,HCs_WT(3,:),'LineWidth',1.3,'Color',flat_gs);
plot(frame_taxis_to_use,HCs_WT(4,:),'LineWidth',1.3,'Color',down_gs);
plot(frame_taxis_to_use,HCs_WT(5,:),'LineWidth',1.3,'Color',bigdown_gs);
goodplot_wide

subplot(2,2,2)
plot(frame_taxis_to_use, HCs_WT(6,:), 'Color',[up_gs],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, HCs_WT(7,:), 'Color',[bigup_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, HCs_WT(8,:),  'Color',[flat_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, HCs_WT(9,:),  'Color',[down_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, HCs_WT(10,:),  'Color',[bigdown_gs],'LineWidth',1.3);
axis([0 4 ymin ymax])
goodplot_wide

subplot(2,2,3)
plot(frame_taxis_to_use, pats_WT(1,:), 'Color',[up_gs],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, pats_WT(2,:), 'Color',[bigup_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, pats_WT(3,:), 'Color',[flat_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, pats_WT(4,:), 'Color',[down_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, pats_WT(5,:), 'Color',[bigdown_gs],'LineWidth',1.3);
axis([0 4 ymin ymax])
goodplot

subplot(2,2,4)
plot(frame_taxis_to_use, pats_WT(6,:), 'Color',[up_gs],'LineWidth',1.3);
hold all
plot(frame_taxis_to_use, pats_WT(7,:), 'Color',[bigup_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, pats_WT(8,:), 'Color',[flat_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, pats_WT(9,:), 'Color',[down_gs],'LineWidth',1.3);
plot(frame_taxis_to_use, pats_WT(10,:), 'Color',[bigdown_gs],'LineWidth',1.3);
axis([0 4 ymin ymax])
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/Fig2.pdf');

%% same figure with sems
% -------------------------------------------------------------------------

figure
subplot(2,2,1)
plot(frame_taxis_to_use, HCs_WT(1,:),'LineWidth', 1.3, 'Color',up_gs);
hold all
plot(frame_taxis_to_use,HCs_WT(2,:),'LineWidth',1.3,'Color',bigup_gs);
plot(frame_taxis_to_use,HCs_WT(3,:),'LineWidth',1.3,'Color',flat_gs);
plot(frame_taxis_to_use,HCs_WT(4,:),'LineWidth',1.3,'Color',down_gs);
plot(frame_taxis_to_use,HCs_WT(5,:),'LineWidth',1.3,'Color',bigdown_gs);
%sems
plot(frame_taxis_to_use, HCs_WT(1,:), 'k');
hold all
plot(frame_taxis_to_use,HCs_WT(2,:), 'k');
plot(frame_taxis_to_use,HCs_WT(3,:), 'k');
plot(frame_taxis_to_use,HCs_WT(4,:), 'k');
plot(frame_taxis_to_use,HCs_WT(5,:), 'k');

plot(frame_taxis_to_use, HCs_WT_posSEM(1,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(1,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(2,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(2,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(3,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(3,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(4,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(4,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(5,:),'LineWidth', 1, 'Color',bigdown_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(5,:),'LineWidth', 1, 'Color',bigdown_gs);
goodplot_wide

subplot(2,2,2)
plot(frame_taxis_to_use, HCs_WT(6,:), 'k');
hold all
plot(frame_taxis_to_use, HCs_WT(7,:), 'k');
plot(frame_taxis_to_use, HCs_WT(8,:), 'k');
plot(frame_taxis_to_use, HCs_WT(9,:), 'k');
plot(frame_taxis_to_use, HCs_WT(10,:), 'k');
plot(frame_taxis_to_use, HCs_WT_posSEM(6,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(6,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(7,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(7,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(8,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(8,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(9,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(9,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, HCs_WT_posSEM(10,:),'LineWidth', 1, 'Color',bigdown_gs);
plot(frame_taxis_to_use, HCs_WT_negSEM(10,:),'LineWidth', 1, 'Color',bigdown_gs);
axis([0 4 ymin ymax])
goodplot_wide

subplot(2,2,3)
plot(frame_taxis_to_use, pats_WT(1,:), 'k');
hold all
plot(frame_taxis_to_use, pats_WT(2,:), 'k');
plot(frame_taxis_to_use, pats_WT(3,:), 'k');
plot(frame_taxis_to_use, pats_WT(4,:), 'k');
plot(frame_taxis_to_use, pats_WT(5,:), 'k');
plot(frame_taxis_to_use, pats_WT_posSEM(1,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(1,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(2,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(2,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(3,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(3,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(4,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(4,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(5,:),'LineWidth', 1, 'Color',bigdown_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(5,:),'LineWidth', 1, 'Color',bigdown_gs);
axis([0 4 ymin ymax])
goodplot

subplot(2,2,4)
plot(frame_taxis_to_use, pats_WT(6,:), 'k');
hold all
plot(frame_taxis_to_use, pats_WT(7,:), 'k');
plot(frame_taxis_to_use, pats_WT(8,:), 'k');
plot(frame_taxis_to_use, pats_WT(9,:), 'k');
plot(frame_taxis_to_use, pats_WT(10,:), 'k');
plot(frame_taxis_to_use, pats_WT_posSEM(6,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(6,:),'LineWidth', 1, 'Color',up_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(7,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(7,:),'LineWidth', 1, 'Color',bigup_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(8,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(8,:),'LineWidth', 1, 'Color',flat_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(9,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(9,:),'LineWidth', 1, 'Color',down_gs);
plot(frame_taxis_to_use, pats_WT_posSEM(10,:),'LineWidth', 1, 'Color',bigdown_gs);
plot(frame_taxis_to_use, pats_WT_negSEM(10,:),'LineWidth', 1, 'Color',bigdown_gs);
axis([0 4 ymin ymax])
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/Fig2_with sems.pdf');

%set(h1,'FaceAlpha',0.5);


%% Fig 2 Mean complex variablity
% -------------------------------------------------------------------------
figure
whitebg('white')
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Pitch variability across groups', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center')
y_pitch2=[HC_clear HC_noise ; PAT_clear PAT_noise];
errY2 = [HC_clear_SEM HC_noise_SEM ; PAT_clear_SEM PAT_noise_SEM];

h = barwitherr(errY2, y_pitch2);% Plot with errorbars

set(gca,'XTickLabel',{'Controls','Patients'})
ylabel('Pitch Variability')
set(h(1),'FaceColor',bigdown_gs,'EdgeColor', 'k' ,'LineWidth',1.5);
set(h(2),'FaceColor',bigup_gs,'EdgeColor', 'k' ,'LineWidth',1.5);
goodplot

print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/Group Variability_bar.pdf');


%% Example plot of high freq variability
% -------------------------------------------------------------------------

figure
for trial=1:10
plot(frame_taxis(1:1111),pats_WT(trial,250:end), 'Color',[down_gs],'LineWidth',1.3);
hold on
lowpass_pats_WT(trial,:)=lowpass(pats_WT(trial,250:end), 0.01, 3);
plot(frame_taxis(1:1111),lowpass(pats_WT(trial,250:end), 0.01, 3),'m','LineWidth',1);
goodplot
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/Group Means with low pass filter.pdf');

%% Distance from low pass filter example
figure
for trial=1:5
    subplot(5,1,trial)
    dist_pats_WT(trial,:)=calc_distance(lowpass_pats_WT(trial,:),pats_WT(trial,250:end))
    plot(frame_taxis(1:1111),dist_pats_WT(trial,:),'Color',[down_gs],'LineWidth',1.3);
    h=area(frame_taxis(1:1111),dist_pats_WT(trial,:),'LineStyle',':');
    set(h,'FaceColor',[0.1 0.1 0.1], 'LineStyle','-'); 
    goodplot
    axis([0 3.5 0 150])
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/example_highfreqvariablitybar.pdf');


%% Plot difference between variability in clear and noise trials
figure
for moo=1:5
    subplot(5,1,moo)
    plot(frame_taxis(1:length(PAT.variability_cond(moo,:))), PAT.variability_cond(moo,:)-PAT.variability_cond(moo+5,:),'Color',[up_gs],'LineWidth',1.1);
    hold all
    plot(frame_taxis(1:length(PAT.variability_cond(moo,:))),HC.variability_cond(moo,:)-HC.variability_cond(moo+5,:),'Color',[bigdown_gs],'LineWidth',1.1);    
    axis([0 3.5 -50 100])
    goodplot
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/diff in clear and noise variability.pdf');

% here it is clear minus noise. a flat line shows no difference in
% variability, 
% negative values show increased
% postiive values show less variability in the noise conditions compared to the clear conditions




%% plot distance from target

figure
for trial=1:10
    subplot(2,5,trial)
    distfromtarg_pats_WT(trial,:)=calc_distance(targets(trial,250:end),pats_WT(trial,250:end));
    distfromtarg_HCs_WT(trial,:)=calc_distance(targets(trial,250:end),HCs_WT(trial,250:end));
    
    %plot(frame_taxis(1:1111),distfromtarg_pats_WT(trial,:),'Color',[bigdown_gs],'LineWidth',1.3);
    h=area(frame_taxis(1:1111),distfromtarg_pats_WT(trial,:),'LineStyle',':');
    set(h,'FaceColor',[down_gs], 'LineStyle','-','EdgeColor',[bigdown_gs]);
    
    hold 
    %plot(frame_taxis(1:1111),distfromtarg_HCs_WT(trial,:),'Color',[bigup_gs],'LineWidth',1.3);
    h=area(frame_taxis(1:1111),distfromtarg_HCs_WT(trial,:),'LineStyle',':');
    set(h,'FaceColor',[bigup_gs], 'LineStyle','-','EdgeColor',[flat_gs]);
    goodplot_wide
    axis([0 3.5 0 400])
end
print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/distance from targets.pdf');


% and the bar graph
 nanmean(distfromtarg_pats_WT(trial,:))
figure
whitebg('white')
y_pitch2=[nanmean(distfromtarg_HCs_WT(1,:)) nanmean(distfromtarg_HCs_WT(2,:)) ...
          nanmean(distfromtarg_HCs_WT(3,:)) nanmean(distfromtarg_HCs_WT(4,:)) ...
          nanmean(distfromtarg_HCs_WT(5,:)); nanmean(distfromtarg_HCs_WT(6,:))...
          nanmean(distfromtarg_HCs_WT(7,:)) nanmean(distfromtarg_HCs_WT(8,:)) ...
          nanmean(distfromtarg_HCs_WT(9,:)) nanmean(distfromtarg_HCs_WT(10,:)); ...
          nanmean(distfromtarg_pats_WT(1,:)) nanmean(distfromtarg_pats_WT(2,:)) ...
          nanmean(distfromtarg_pats_WT(3,:)) nanmean(distfromtarg_pats_WT(4,:)) ...
          nanmean(distfromtarg_pats_WT(5,:)) ;nanmean(distfromtarg_pats_WT(6,:))...
          nanmean(distfromtarg_pats_WT(7,:)) nanmean(distfromtarg_pats_WT(8,:))...
          nanmean(distfromtarg_pats_WT(9,:)) nanmean(distfromtarg_pats_WT(10,:))];
          
errY2 =[nanstd(distfromtarg_HCs_WT(1,:))/sqrt(1) nanstd(distfromtarg_HCs_WT(2,:)) ...
          nanstd(distfromtarg_HCs_WT(3,:)) nanstd(distfromtarg_HCs_WT(4,:)) ...
          nanstd(distfromtarg_HCs_WT(5,:)); nanstd(distfromtarg_HCs_WT(6,:))...
          nanstd(distfromtarg_HCs_WT(7,:)) nanstd(distfromtarg_HCs_WT(8,:)) ...
          nanstd(distfromtarg_HCs_WT(9,:)) nanstd(distfromtarg_HCs_WT(10,:)); ...
          nanstd(distfromtarg_pats_WT(1,:)) nanstd(distfromtarg_pats_WT(2,:)) ...
          nanstd(distfromtarg_pats_WT(3,:)) nanstd(distfromtarg_pats_WT(4,:)) ...
          nanstd(distfromtarg_pats_WT(5,:)) ;nanstd(distfromtarg_pats_WT(6,:)) ...
          nanstd(distfromtarg_pats_WT(7,:)) nanstd(distfromtarg_pats_WT(8,:))...
          nanstd(distfromtarg_pats_WT(9,:)) nanstd(distfromtarg_pats_WT(10,:))];
      
      
h = barwitherr(errY2, y_pitch2);% Plot with errorbars
goodplot
set(h(1),'FaceColor',up_gs,'EdgeColor', 'k' ,'LineWidth',1.2);
set(h(2),'FaceColor',bigup_gs,'EdgeColor', 'k' ,'LineWidth',1.2);
set(h(3),'FaceColor',flat_gs,'EdgeColor', 'k' ,'LineWidth',1.2);
set(h(4),'FaceColor',down_gs,'EdgeColor', 'k' ,'LineWidth',1.2);
set(h(5),'FaceColor',bigdown_gs,'EdgeColor', 'k' ,'LineWidth',1.2);




print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/Group Variability_bar.pdf');






%% pre and post windows
figure
subplot(221)
plot(nanmean(HCs_pre(1:5,:)), 'k','LineWidth',1.2);
hold
plot(nanmean(HCs_pre(6:10,:)), 'm','LineWidth',1.2);
goodplot
axis([0 400 -160 -70])

subplot(222)
plot(nanmean(HCs_post(1:5,:)), 'k','LineWidth',1.2);
hold
plot(nanmean(HCs_post(6:10,:)), 'm','LineWidth',1.2);
goodplot
axis([0 400 -160 -70])

subplot(223)
plot(nanmean(pats_pre(1:5,:)), 'k','LineWidth',1.2);
hold
plot(nanmean(pats_pre(6:10,:)), 'm','LineWidth',1.2);
goodplot
axis([0 400 -160 -70])


subplot(224)
plot(nanmean(pats_post(1:5,:)), 'k','LineWidth',1.2);
hold
plot(nanmean(pats_post(6:10,:)), 'm','LineWidth',1.2);
goodplot
axis([0 400 -160 -70])























% 
% 
% %% (3) Normalise all trials to the mean pitch from previous experiment: subj_MP_allsubs
% for i=1:nframes_to_use
%      zscorenorm_GroupMean_HCs_cond1(:,i) = (HCs_WT(1,:) - nanmean(HCs_WT(1,T1_HC:T2_HC)))/nanstd(HCs_WT(1,T1_HC:T2_HC));
%      % 175Hz 
%      zscorenorm_GroupMean_HCs_cond2(:,i) = (HCs_WT(2,:) - nanmean(HCs_WT(2,T1_HC:T2_HC)))/nanstd(HCs_WT(2,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond3(:,i) = (HCs_WT(3,:) - nanmean(HCs_WT(3,T1_HC:T2_HC)))/nanstd(HCs_WT(3,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond4(:,i) = (HCs_WT(4,:) - nanmean(HCs_WT(4,T1_HC:T2_HC)))/nanstd(HCs_WT(4,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond5(:,i) = (HCs_WT(5,:) - nanmean(HCs_WT(5,T1_HC:T2_HC)))/nanstd(HCs_WT(5,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond6(:,i) = (HCs_WT(6,:) - nanmean(HCs_WT(6,T1_HC:T2_HC)))/nanstd(HCs_WT(6,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond7(:,i) = (HCs_WT(7,:) - nanmean(HCs_WT(7,T1_HC:T2_HC)))/nanstd(HCs_WT(7,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond8(:,i) = (HCs_WT(8,:) - nanmean(HCs_WT(8,T1_HC:T2_HC)))/nanstd(HCs_WT(8,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond9(:,i) = (HCs_WT(9,:) - nanmean(HCs_WT(9,T1_HC:T2_HC)))/nanstd(HCs_WT(9,T1_HC:T2_HC));
%      zscorenorm_GroupMean_HCs_cond10(:,i) = (HCs_WT(10,:) - nanmean(HCs_WT(10,T1_HC:T2_HC)))/nanstd(HCs_WT(10,T1_HC:T2_HC));
% 
% 
%      zscorenorm_GroupMean_pats_cond1(:,i) = (pats_WT(1,:) - nanmean(pats_WT(1,T1_pat:T2_pat)))/nanstd(pats_WT(1,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond2(:,i) = (pats_WT(2,:) - nanmean(pats_WT(2,T1_pat:T2_pat)))/nanstd(pats_WT(2,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond3(:,i) = (pats_WT(3,:) - nanmean(pats_WT(3,T1_pat:T2_pat)))/nanstd(pats_WT(3,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond4(:,i) = (pats_WT(4,:) - nanmean(pats_WT(4,T1_pat:T2_pat)))/nanstd(pats_WT(4,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond5(:,i) = (pats_WT(5,:) - nanmean(pats_WT(5,T1_pat:T2_pat)))/nanstd(pats_WT(5,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond6(:,i) = (pats_WT(6,:) - nanmean(pats_WT(6,T1_pat:T2_pat)))/nanstd(pats_WT(6,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond7(:,i) = (pats_WT(7,:) - nanmean(pats_WT(7,T1_pat:T2_pat)))/nanstd(pats_WT(7,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond8(:,i) = (pats_WT(8,:) - nanmean(pats_WT(8,T1_pat:T2_pat)))/nanstd(pats_WT(8,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond9(:,i) = (pats_WT(9,:) - nanmean(pats_WT(9,T1_pat:T2_pat)))/nanstd(pats_WT(9,T1_pat:T2_pat));
%      zscorenorm_GroupMean_pats_cond10(:,i) = (pats_WT(10,:) - nanmean(pats_WT(10,T1_pat:T2_pat)))/nanstd(pats_WT(10,T1_pat:T2_pat));
%          
% end
% 
% 






%% plot patients and controls pitch variability on same graph
figure
for moo=1:5
    subplot(5,1,moo)
    plot(frame_taxis(1:length(PAT.variability_cond(moo,:))), PAT.variability_cond(moo,:)-PAT.variability_cond(moo+5,:),'Color',[up_gs],'LineWidth',1.1);
    hold all
    plot(frame_taxis(1:length(PAT.variability_cond(moo,:))),HC.variability_cond(moo,:)-HC.variability_cond(moo+5,:),'Color',[bigdown_gs],'LineWidth',1.1);    
    axis([0 3.5 -50 100])
    goodplot
end

%% old bits

% 
% 
% %% (2) PLOT MEAN RESPONSE FOR EACH CONDITION
% boxmin=-345;
% boxmax=690;
% ymin=-400;
% ymax=400;
% 
% fig1=figure;
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'Mean responses', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% 
% 
% subplot(2,2,1)
% plot(frame_taxis_to_use, HCs_WT(1,:), 'b','LineWidth', 1.3);
% 
% hold all
% plot(frame_taxis_to_use,HCs_WT(2,:), 'c','LineWidth',1.3);
% plot(frame_taxis_to_use,HCs_WT(3,:), 'k','LineWidth',1.3);
% plot(frame_taxis_to_use,HCs_WT(4,:), 'y','LineWidth',1.3);
% plot(frame_taxis_to_use,HCs_WT(5,:), 'r','LineWidth',1.3);
% 
% %plot(frame_taxis_to_use,windowplot, 'm','LineWidth',1.3);
% axis([0 4 ymin ymax])
% ylabel('Pitch (cents)')
% xlabel('Time (s)')
% title(sprintf('HC clear trials'));
% goodplot
% 
% % rectangle('Position',[T1_HC,boxmin,T2_HC-T1_HC,boxmax],...
% %     'LineWidth',2,'LineStyle','--')
% % rectangle('Position',[T3_HC,boxmin,T4_HC-T3_HC,boxmax],...    
% %     'LineWidth',2,'LineStyle','--')
% % patient_colour=[.49 1 .63];
% % HC_colour=[.4 .4 .4]
% 
% 
% subplot(2,2,2)
% plot(frame_taxis_to_use,HCs_WT(6,:), 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use,HCs_WT(7,:), 'c','LineWidth',1.3);
% plot(frame_taxis_to_use,HCs_WT(8,:), 'k','LineWidth',1.3);
% plot(frame_taxis_to_use,HCs_WT(9,:), 'y','LineWidth',1.3);
% plot(frame_taxis_to_use,HCs_WT(10,:), 'r','LineWidth',1.3);
% axis([0 4 ymin ymax])
% ylabel('Pitch (cents)')
% xlabel('Time (s)')
% title(sprintf('HC masked trials'));
% % rectangle('Position',[T1_HC,boxmin,T2_HC-T1_HC,boxmax],...
% %     'LineWidth',2,'LineStyle','--')
% % rectangle('Position',[T3_HC,boxmin,T4_HC-T3_HC,boxmax],...    
% %     'LineWidth',2,'LineStyle','--')
% goodplot
% 
% subplot(2,2,3)
% plot(frame_taxis_to_use,pats_WT(1,:), 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use,pats_WT(2,:), 'c','LineWidth',1.3);
% plot(frame_taxis_to_use,pats_WT(3,:), 'k','LineWidth',1.3);
% plot(frame_taxis_to_use,pats_WT(4,:), 'y','LineWidth',1.3);
% plot(frame_taxis_to_use,pats_WT(5,:), 'r','LineWidth',1.3);
% axis([0 4 ymin ymax])
% ylabel('Pitch (cents)')
% xlabel('Time (s)')
% title(sprintf('Patients clear trials'));
% % rectangle('Position',[T1_pat,boxmin,T2_pat-T1_pat,boxmax],...
% %     'LineWidth',2,'LineStyle','--')
% % rectangle('Position',[T3_pat,boxmin,T4_pat-T3_pat,boxmax],...    
% %     'LineWidth',2,'LineStyle','--')
% goodplot
% 
% subplot(2,2,4)
% plot(frame_taxis_to_use,pats_WT(6,:), 'b','LineWidth',1.3);
% hold all
% plot(frame_taxis_to_use,pats_WT(7,:), 'c','LineWidth',1.3);
% plot(frame_taxis_to_use,pats_WT(8,:), 'k','LineWidth',1.3);
% plot(frame_taxis_to_use,pats_WT(9,:), 'y','LineWidth',1.3);
% plot(frame_taxis_to_use,pats_WT(10,:), 'r','LineWidth',1.3);
% axis([0 4 ymin ymax])
% title(sprintf('Patients masked trials'));
% ylabel('Pitch (cents)')
% xlabel('Time (s)')
% goodplot
% % rectangle('Position',[T1_pat,boxmin,T2_pat-T1_pat,boxmax],...
% %     'LineWidth',2,'LineStyle','--') 
% % rectangle('Position',[T3_pat,boxmin,T4_pat-T3_pat,boxmax],...
% %     'LineWidth',2,'LineStyle','--')
% print(gcf, '-dpdf', '-r150', '/Users/zagnew/Cereb_data/data_final_run/figures/Mean responses by group.pdf');
% 
% % %% plot all conditions separately
% % 
% % % ------
% % fig2a=figure;
% % annotation('textbox', [0 0.9 1 0.1], ...
% %     'String', 'Mean responses', ...
% %     'EdgeColor', 'none', ...
% %     'HorizontalAlignment', 'center')
% % 
% % subplot(2,1,1)
% % plot(frame_taxis_to_use, HCs_WT(1,:), 'k','LineWidth',1.2);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(1,:), 'r','LineWidth',1.2);
% % plot(frame_taxis_to_use,smallup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % 
% % title(sprintf('Condition 1 - clear'));
% % %line([step_secs step_secs],[-200 200],'LineWidth',2, 'Color',[.8 .8 .8],'LineStyle','--')
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % subplot(2,1,2)
% % plot(frame_taxis_to_use, HCs_WT(6,:), 'k','LineWidth',1.3);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(6,:), 'r','LineWidth',1.3);
% % plot(frame_taxis_to_use,smallup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % title(sprintf('Condition 6 - noise'));
% % 
% % % ------
% % 
% %  
% % ymin=-400;
% % ymax=400;
% % 
% % fig2b=figure;
% % annotation('textbox', [0 0.9 1 0.1], ...
% %     'String', 'Mean responses', ...
% %     'EdgeColor', 'none', ...
% %     'HorizontalAlignment', 'center')
% % 
% % subplot(2,1,1)
% % plot(frame_taxis_to_use, HCs_WT(2,:), 'k','LineWidth',1.2);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(2,:), 'r','LineWidth',1.2);
% % plot(frame_taxis_to_use,bigup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % 
% % title(sprintf('Condition 2 - clear'));
% % %line([step_secs step_secs],[-200 200],'LineWidth',2, 'Color',[.8 .8 .8],'LineStyle','--')
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % subplot(2,1,2)
% % plot(frame_taxis_to_use, HCs_WT(7,:), 'k','LineWidth',1.3);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(7,:), 'r','LineWidth',1.3);
% % plot(frame_taxis_to_use,bigup, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % title(sprintf('Condition 7 - noise'));
% % 
% % % -------
% % 
% % 
% %  
% % ymin=-400;
% % ymax=400;
% % 
% % fig2c=figure;
% % annotation('textbox', [0 0.9 1 0.1], ...
% %     'String', 'Mean responses', ...
% %     'EdgeColor', 'none', ...
% %     'HorizontalAlignment', 'center')
% % 
% % subplot(2,1,1)
% % plot(frame_taxis_to_use, HCs_WT(3,:), 'k','LineWidth',1.2);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(3,:), 'r','LineWidth',1.2);
% % plot(frame_taxis_to_use,nostep, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % 
% % title(sprintf('Condition 3 - clear'));
% % %line([step_secs step_secs],[-200 200],'LineWidth',2, 'Color',[.8 .8 .8],'LineStyle','--')
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % subplot(2,1,2)
% % plot(frame_taxis_to_use, HCs_WT(8,:), 'k','LineWidth',1.3);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(8,:), 'r','LineWidth',1.3);
% % plot(frame_taxis_to_use,nostep, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % title(sprintf('Condition 8 - noise'));
% % 
% % % -------
% %  
% % ymin=-400;
% % ymax=400;
% % 
% % fig2d=figure;
% % annotation('textbox', [0 0.9 1 0.1], ...
% %     'String', 'Mean responses', ...
% %     'EdgeColor', 'none', ...
% %     'HorizontalAlignment', 'center')
% % 
% % subplot(2,1,1)
% % plot(frame_taxis_to_use, HCs_WT(4,:), 'k','LineWidth',1.2);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(4,:), 'r','LineWidth',1.2);
% % plot(frame_taxis_to_use,smalldown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % 
% % title(sprintf('Condition 4 - clear'));
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % subplot(2,1,2)
% % plot(frame_taxis_to_use, HCs_WT(9,:), 'k','LineWidth',1.3);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(9,:), 'r','LineWidth',1.3);
% % plot(frame_taxis_to_use,smalldown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % title(sprintf('Condition 9 - noise'));
% % 
% % % ------
% % 
% %  
% % ymin=-400;
% % ymax=400;
% % 
% % fig2e=figure;
% % annotation('textbox', [0 0.9 1 0.1], ...
% %     'String', 'Mean responses', ...
% %     'EdgeColor', 'none', ...
% %     'HorizontalAlignment', 'center')
% % 
% % subplot(2,1,1)
% % plot(frame_taxis_to_use, HCs_WT(5,:), 'k','LineWidth',1.2);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(5,:), 'r','LineWidth',1.2);
% % plot(frame_taxis_to_use,bigdown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % 
% % title(sprintf('Condition 5 - clear'));
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % subplot(2,1,2)
% % plot(frame_taxis_to_use, HCs_WT(10,:), 'k','LineWidth',1.3);
% % hold all
% % plot(frame_taxis_to_use, pats_WT(10,:), 'r','LineWidth',1.3);
% % plot(frame_taxis_to_use,bigdown, 'b','LineWidth',2,'Color',[.4 .4 .4],'LineStyle','--');
% % axis([0 4 ymin ymax])
% % xlabel('time (s)');
% % ylabel('Pitch (Hz)');
% % 
% % title(sprintf('Condition 10 - noise'));
% 
% % save awl dat
% cd(cerebellar_data_rootdir)
% 
% cd figures
% saveas(fig2a, 'Mean responses by group - small step up.jpg')
% saveas(fig2b, 'Mean responses by group - big step up.jpg')
% saveas(fig2c, 'Mean responses by group - flat.jpg')
% saveas(fig2d, 'Mean responses by group - small step down.jpg')
% saveas(fig2e, 'Mean responses by group - big step down.jpg')


cd(cerebellar_data_rootdir)


save('GROUPDATA')



