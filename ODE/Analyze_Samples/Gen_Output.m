clear;
clc;

Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85;0 17;18 64;65 85];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibration
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Scenario=['Calibration_W'];
 max_file_w=3;
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_Calibration_W.mat'],'Filtered_Output_Large_Winter');

Scenario=['Calibration_S'];
 max_file_s=3;
[Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file_s);
save(['Output_Calibration_W.mat'],'Filtered_Output_Large_Summer');

Scenario=['Calibration_U'];
max_file_u=9;
[Filtered_Output_Unimodal] = SA_Output(Scenario,Av,ACg,max_file_u);
save(['Output_Calibration_U.mat'],'Filtered_Output_Unimodal');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Waning
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Scenario=['FDA_Two_Dose_ILC_Slow_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

Scenario=['Annual_ILC_Slow_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

Scenario=['FDA_Two_Dose_ILC_Fast_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

Scenario=['Annual_ILC_Fast_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Annual campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

Scenario=['Annual_ILC_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_Annual_ILC_W.mat'],'Filtered_Output_Large_Winter');

Scenario=['Annual_ILC_S'];
[Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file_s);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Summer');

Scenario=['Annual_ILC_U'];
[Filtered_Output_Unimodal] = SA_Output(Scenario,Av,ACg,max_file_u);
save(['Output_' Scenario '.mat'],'Filtered_Output_Unimodal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FDA policy Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);

    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_S'];
    [Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Summer');
    
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_U'];
    [Filtered_Output_Unimodal] = SA_Output(Scenario,Av,ACg,max_file_u);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Unimodal');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 65+ Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);

    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 50+ Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);

    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 18-49 second doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for red_2d=0.35:0.15:0.65  
    Time_Dose=180;
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduction_' num2str(100.*red_2d) '_18_49'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduction_' num2str(100.*red_2d) '_18_49.mat'],'Filtered_Output_Large_Winter');

    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduction_' num2str(100.*red_2d) '_FDA'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduction_' num2str(100.*red_2d) '_FDA.mat'],'Filtered_Output_Large_Winter');
end


