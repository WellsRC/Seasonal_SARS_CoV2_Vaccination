clear;
clc;

Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Baseline: Two Peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Baseline_Outputs.mat');

Scenario_Calculations(Filtered_Output_Large_Winter,['Larger_Winter_Baseline_Continual_Vaccination']);
Scenario_Calculations(Filtered_Output_Large_Summer,['Larger_Summer_Baseline_Continual_Vaccination']);

Scenario_Calculations_Raw(Filtered_Output_Large_Winter,['Larger_Winter_Baseline_Continual_Vaccination']);
Scenario_Calculations_Raw(Filtered_Output_Large_Summer,['Larger_Summer_Baseline_Continual_Vaccination']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Baseline: One Peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Unimodal_Peak_Winter_Output.mat');
Scenario_Calculations(Filtered_Output_Unimodal,['Unimodal_Baseline_Continual_Vaccination']);
Scenario_Calculations_Raw(Filtered_Output_Unimodal,['Unimodal_Baseline_Continual_Vaccination']);