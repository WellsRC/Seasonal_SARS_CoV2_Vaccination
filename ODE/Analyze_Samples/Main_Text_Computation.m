%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Influenza-like coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Scenario Calcualtions and comparison of annula vs two dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load(['Output_Calibration_S.mat'],'Filtered_Output_Large_Summer');
Calibration_Output=Filtered_Output_Large_Summer;
Scenario_Calculations(Calibration_Output,['Calibration_Summer']);

load(['Output_Calibration_U.mat'],'Filtered_Output_Unimodal');
Calibration_Output=Filtered_Output_Unimodal;
Scenario_Calculations(Calibration_Output,['Calibration_U']);

load(['Output_Calibration_W.mat'],'Filtered_Output_Large_Winter');
Calibration_Output=Filtered_Output_Large_Winter;
Scenario_Calculations(Calibration_Output,['Calibration']);

Time_Dose=150;
load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_W.mat'],'Filtered_Output_Large_Winter');
Two_Dose=Filtered_Output_Large_Winter;
Comparison_Calculations(Calibration_Output,Two_Dose,['SM_Calibration_vs_Two_Dose_FDA_' num2str(Time_Dose) '_days_W' ]);

load(['Output_Annual_ILC_W.mat'],'Filtered_Output_Large_Winter');
Annual_Output=Filtered_Output_Large_Winter;
Scenario_Calculations(Annual_Output,['Main_Text_Annual']);
Comparison_Calculations(Calibration_Output,Annual_Output,['SM_Calibration_vs_Annual_W' ]);


for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);    
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_W.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days' ]);

    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_18_49_W.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_18_49_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Main_Text_Annual_vs_Two_Dose_18_49_' num2str(Time_Dose) '_days' ]);

    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_64_W.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_50_64_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Main_Text_Annual_vs_Two_Dose_50_64_' num2str(Time_Dose) '_days' ]);

    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older_W.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_65_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Main_Text_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose) '_days' ]);    
end





