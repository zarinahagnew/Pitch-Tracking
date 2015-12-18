% split patients and controls and calcs distance from target
for condnn=1:10
GroupData(1).cond(condnn).distfromtarg_WT_PATS=GroupData(1).cond(condnn).distfromtarg_WT(1:numpats,:)
GroupData(1).cond(condnn).distfromtarg_WT_HCs=GroupData(1).cond(condnn).distfromtarg_WT(numpats+1:numsubs,:)
GroupData(1).cond(condnn).distfromtarg_pre_PATS=GroupData(1).cond(condnn).distfromtarg_pre(1:numpats,:)
GroupData(1).cond(condnn).distfromtarg_WT_HCs=GroupData(1).cond(condnn).distfromtarg_WT(numpats+1:numsubs,:)
end

figure
for condnn=1:10
    subplot(2,5,condnn)
    plot(frame_taxis(1:1360),nanmean(GroupData(1).cond(condnn).distfromtarg_WT_PATS), 'm','LineWidth',1.3);
    hold on
    plot(frame_taxis(1:1360),targets(condnn,:), 'k','LineWidth',1.3);
    goodplot
    axis([0 4 -350 350])
end

figure
for condnn=1:10
    subplot(2,5,condnn)
    plot(frame_taxis(1:1360),nanmean(GroupData(1).cond(condnn).distfromtarg_WT_HCs), 'm','LineWidth',1.3);
    hold on
    plot(frame_taxis(1:1360),targets(condnn,:), 'k','LineWidth',1.3);
    goodplot
    axis([0 4 -350 350])
end

