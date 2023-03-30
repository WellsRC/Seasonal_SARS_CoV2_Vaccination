clear;
clc;

NG=25;
NS=10^4;
Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
[Unimodal_Output_All] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg);

save('Unimodal_Output.mat','Unimodal_Output_All');