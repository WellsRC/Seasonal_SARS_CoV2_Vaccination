clear;
clc;

NG=25;
NS=10^4;
Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
[Baseline_Output_All,Baseline_Output_Large_Winter,Baseline_Output_Large_Summer] = Filter_Peaks(NG,NS,Av,ACg);

save('Baseline_Outputs.mat','Baseline_Output_All','Baseline_Output_Large_Winter','Baseline_Output_Large_Summer');