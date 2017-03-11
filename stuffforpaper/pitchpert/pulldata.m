


uiopen('/Users/zagnew/Cereb_data/stuffforpaper/pitchpert/final comp2.fig',1)

h = gcf
get(h, 'Children')
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
objTypes = get(dataObjs, 'Type');  %type of low-level graphics object

xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
ydata = get(dataObjs, 'YData');
zdata = get(dataObjs, 'ZData');

%% SEM is SEM - mean << fix this

controls_mean=ydata{3,:}
patients_mean=ydata{6,:}

controls_std=ydata{2,:}
patients_std=ydata{5,:}

data.control_peakcomp=max(controls_mean)
data.patient_peakcomp=max(patients_mean)
data.control_peakcompstd=max(controls_std)
data.patient_peakcompstd=max(patients_std)

data.control_tpeak_frames=find(controls_mean==data.control_peakcomp)
data.patient_tpeak_frames=find(patients_mean==data.patient_peakcomp)

data.control_tpeak_secs=xdata{1}(data.control_tpeak_frames)
data.patient_tpeak_secs=xdata{1}(data.patient_tpeak_frames)


data.control_peakcomp
data.patient_peakcomp

cd /Users/zagnew/Cereb_data/stuffforpaper/pitchpert
save data

