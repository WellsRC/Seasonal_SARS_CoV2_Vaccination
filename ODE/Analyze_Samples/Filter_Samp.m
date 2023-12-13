clear;
clc;

NG=100;
NS=10^3;
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
[Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = Filter_Peaks(NG,NS,Av,ACg);

save('Baseline_Outputs.mat','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

clear;
clc;

NG=100;
NS=10^3;
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
[Filtered_Output_Unimodal] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg);

save('Unimodal_Peak_Winter_Output.mat','Filtered_Output_Unimodal');