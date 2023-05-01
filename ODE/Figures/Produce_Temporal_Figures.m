clear;
clc;
close all;

State_V='Hospital Admission';
Scenario='Large_Winter_Annual_Campaign_Influenza_Like_Coverage';
Figure_Temporal(State_V,Scenario)


Scenario='Larger_Winter_Baseline_Continual_Vaccination';
Figure_Temporal(State_V,Scenario)
% 

Scenario='Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older';
Figure_Temporal(State_V,Scenario)
% 
% 
% Scenario='All_Two_Campaign_Influenza_Like_Coverage_270_days_65_and_older';
% Figure_Temporal(State_V,Scenario)
% 
% 
% Scenario='All_Two_Campaign_Influenza_Like_Coverage_300_days_65_and_older';
% Figure_Temporal(State_V,Scenario)
% 
% 
% Scenario='All_Two_Campaign_Influenza_Like_Coverage_900_days_65_and_older';
% Figure_Temporal(State_V,Scenario)