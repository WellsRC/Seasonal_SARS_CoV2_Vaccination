clear;
clc;
close all;

State_V='Incidence';
Scenario='All_Annual_Campaign_Influenza_Like_Coverage';
Figure_Temporal(State_V,Scenario)

Scenario='All_Two_Campaign_Influenza_Like_Coverage_90_days_65_and_older';
Figure_Temporal(State_V,Scenario)


Scenario='All_Two_Campaign_Influenza_Like_Coverage_270_days_65_and_older';
Figure_Temporal(State_V,Scenario)


Scenario='All_Two_Campaign_Influenza_Like_Coverage_300_days_65_and_older';
Figure_Temporal(State_V,Scenario)


Scenario='All_Two_Campaign_Influenza_Like_Coverage_900_days_65_and_older';
Figure_Temporal(State_V,Scenario)