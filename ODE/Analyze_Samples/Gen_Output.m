clear;
clc;

Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85;0 17;18 64;65 85];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Scenario=['Calibration_W'];
 max_file_w=4;
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

Scenario=['Calibration_S'];
 max_file_s=1;
[Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file_s);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Summer');

Scenario=['Calibration_U'];
max_file_u=8;
[Filtered_Output_Unimodal] = SA_Output(Scenario,Av,ACg,max_file_u);
save(['Output_' Scenario '.mat'],'Filtered_Output_Unimodal');


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
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_64_W.mat'],'Filtered_Output_Large_Winter');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 18-49 Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);

    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_18_49_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Waning
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t_d=1:8    
     Time_Dose=90+30.*(t_d-1);
     Scenario=['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Slow_Waning_Vaccine_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

    Scenario=['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Fast_Waning_Vaccine_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

    Scenario=['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Other_Waning_Vaccine_W'];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
end

Scenario=['Annual_ILC_Slow_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');


Scenario=['Annual_ILC_Fast_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');


Scenario=['Annual_ILC_Other_Waning_Vaccine_W'];
[Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_w);
save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');


