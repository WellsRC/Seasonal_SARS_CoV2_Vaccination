clear;
clc;

NG=10;
NS=10^4;
Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
[Filtered_Output_Unimodal] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg);

save('Unimodal_Peak_Winter_Output.mat','Filtered_Output_Unimodal');