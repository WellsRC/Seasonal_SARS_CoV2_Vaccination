clear;
clc;

NG=50;
NS=10^4;
Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
[Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = Filter_Peaks(NG,NS,Av,ACg);

save('Baseline_Outputs.mat','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');