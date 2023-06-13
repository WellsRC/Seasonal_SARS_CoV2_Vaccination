clear;
clc;


temp_cd=pwd;
temp_cd=temp_cd(1:end-11);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load population and contact matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pop_S=load([temp_cd 'Contact_Matrix/Contact_USA_85.mat'],'N');
Pop_S=sum(Pop_S.N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Low_Coverage_Continual_Booster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
              
Scenario_Out='Large_Winter_Continual_Vaccination_Baseline_Coverage';
load([temp_cd 'Model_Output_Summary_' Scenario_Out '.mat']);

fprintf('=========================================================================== \n');
fprintf([Scenario_Out ' \n']);
fprintf('===========================================================================\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hospitalizations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PerC=10^5;
M=PerC.*Output_Summary.PRCT.Cumulative_Count_Hospital./Pop_S;
fprintf(['Median cumulative hospitalizations: ' num2str(M(PRCT==50),'%4.1f') ' (95%% prediction interval (PI):' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deaths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PerC=10^5;
M=PerC.*Output_Summary.PRCT.Cumulative_Count_Death./Pop_S;
fprintf(['Median cumulative deaths: ' num2str(M(PRCT==50),'%4.1f') ' (95%% PI:' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% High_Coverage_Annual_Booster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Scenario_Out='Large_Winter_Annual_Campaign_Influenza_Like_Coverage';
load([temp_cd 'Model_Output_Summary_' Scenario_Out '.mat']);

fprintf('=========================================================================== \n');
fprintf([Scenario_Out ' \n']);
fprintf('===========================================================================\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hospitalizations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PerC=10^5;
M=PerC.*Output_Summary.PRCT.Cumulative_Count_Hospital./Pop_S;
fprintf(['Median cumulative hospitalizations: ' num2str(M(PRCT==50),'%4.1f') ' (95%% PI:' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deaths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PerC=10^5;
M=PerC.*Output_Summary.PRCT.Cumulative_Count_Death./Pop_S;
fprintf(['Median cumulative deaths: ' num2str(M(PRCT==50),'%4.1f') ' (95%% PI:' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Comparison between low coverage continual and high coverage annual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Scenario_Out='Large_Winter_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination';
fprintf('=========================================================================== \n');
fprintf(['Comparison:' Scenario_Out '\n']);
fprintf('===========================================================================\n');


load([temp_cd 'Comparison_Summary_' Scenario_Out '.mat'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hospitalizations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M=-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
fprintf(['Median reduction in hospitalizations: ' num2str(M(PRCT==50),'%4.1f') '%% (95%% PI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deaths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M=-100.*Comparison.PRCT.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
fprintf(['Median reduction in deaths: ' num2str(M(PRCT==50),'%4.1f') '%% (95%% PI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Costs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M=-100.*Comparison.PRCT.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
fprintf(['Median reduction in total direct costs: ' num2str(M(PRCT==50),'%4.1f') '%% (95%% PI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);

