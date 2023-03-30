clear;
clc;
close all;

State_V='Hospital Admission';
Scenario='All_Baseline_Continual_Vaccination';
Figure_Temporal(State_V,Scenario)

Scenario='Larger_Winter_Baseline_Continual_Vaccination';
Figure_Temporal(State_V,Scenario)

Scenario='Larger_Summer_Baseline_Continual_Vaccination';
Figure_Temporal(State_V,Scenario)

Scenario='Unimodal_Baseline_Continual_Vaccination';
Figure_Temporal(State_V,Scenario)