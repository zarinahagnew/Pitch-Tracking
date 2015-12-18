
% what 

figure

y_clear=[GroupMeans.HC.pre_pitchWTstdev(1) GroupMeans.HC.post_pitchWTstdev(1) GroupMeans.pat.pre_pitchWTstdev(1) GroupMeans.pat.post_pitchWTstdev(1);GroupMeans.HC.pre_pitchWTstdev(2) GroupMeans.HC.post_pitchWTstdev(2) GroupMeans.pat.pre_pitchWTstdev(2) GroupMeans.pat.post_pitchWTstdev(2);GroupMeans.HC.pre_pitchWTstdev(3) GroupMeans.HC.post_pitchWTstdev(3) GroupMeans.pat.pre_pitchWTstdev(3) GroupMeans.pat.post_pitchWTstdev(3);GroupMeans.HC.pre_pitchWTstdev(4) GroupMeans.HC.post_pitchWTstdev(4) GroupMeans.pat.pre_pitchWTstdev(4) GroupMeans.pat.post_pitchWTstdev(4);GroupMeans.HC.pre_pitchWTstdev(5) GroupMeans.HC.post_pitchWTstdev(5) GroupMeans.pat.pre_pitchWTstdev(5) GroupMeans.pat.post_pitchWTstdev(5)];
y_noise=[GroupMeans.HC.pre_pitchWTstdev(6) GroupMeans.HC.post_pitchWTstdev(6) GroupMeans.pat.pre_pitchWTstdev(6) GroupMeans.pat.post_pitchWTstdev(6);GroupMeans.HC.pre_pitchWTstdev(7) GroupMeans.HC.post_pitchWTstdev(7) GroupMeans.pat.pre_pitchWTstdev(7) GroupMeans.pat.post_pitchWTstdev(7);GroupMeans.HC.pre_pitchWTstdev(8) GroupMeans.HC.post_pitchWTstdev(8) GroupMeans.pat.pre_pitchWTstdev(8) GroupMeans.pat.post_pitchWTstdev(8);GroupMeans.HC.pre_pitchWTstdev(9) GroupMeans.HC.post_pitchWTstdev(9) GroupMeans.pat.pre_pitchWTstdev(9) GroupMeans.pat.post_pitchWTstdev(9);GroupMeans.HC.pre_pitchWTstdev(10) GroupMeans.HC.post_pitchWTstdev(10) GroupMeans.pat.pre_pitchWTstdev(10) GroupMeans.pat.post_pitchWTstdev(10)];
% haxes(1)=bar(1, GroupMeans.HC.pre_pitchWTstdev(1));
% hold on
% haxes(2)=bar(2, GroupMeans.pat.pre_pitchWTstdev(1), 'r');
% axis([0 3 ymin ymax])


%y = randn(3,4);         % random y values (3 groups of 4 parameters)
errY = 0.1.*y_clear;          % 10% error
h = barwitherr(errY, y_clear);% Plot with errorbars

set(gca,'XTickLabel',{'Condition1','Condition 2','Condition 3'})
legend('Parameter 1','Parameter 2','Parameter 3','Parameter 4')
ylabel('Y Value')
set(h(1),'FaceColor','k');



%
