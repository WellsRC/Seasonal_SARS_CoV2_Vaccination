clear;
clc;

NG=500;
NS=10^3;
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85;0 17;18 64;65 85];
[Filtered_Output_Unimodal] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg);
save(['Unimodal_Peak_Winter_Output.mat'],'Filtered_Output_Unimodal');
