clear;
clc;

load('Baseline_Outputs.mat');

SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage'};%,'Annual_Campaign_Baseline_Coverage'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

    Scenario_Calculations(Filtered_Output_All,['All_' SA_Scenario{ss}]);
    Scenario_Calculations(Filtered_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss}]);
    Scenario_Calculations(Filtered_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss}]);

    Comparison_Calculations(Filtered_Output_All,Baseline_Output_All,['All_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
    Comparison_Calculations(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
    Comparison_Calculations(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
end

clear;
% clc;
% 
% load(['Output_SA_Annual_Campaign_Influenza_Like_Coverage.mat'],'Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
% Baseline_Output_All=Filtered_Output_All;
% Baseline_Output_Large_Winter=Filtered_Output_Large_Winter;
% Baseline_Output_Large_Summer=Filtered_Output_Large_Summer;
% 
% SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84'};
%     
% 
% for ss=1:length(SA_Scenario)
%     load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
% 
%     Scenario_Calculations(Filtered_Output_All,['All_' SA_Scenario{ss}]);
%     Scenario_Calculations(Filtered_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss}]);
%     Scenario_Calculations(Filtered_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss}]);
% 
%     Comparison_Calculations(Filtered_Output_All,Baseline_Output_All,['All_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
%     Comparison_Calculations(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
%     Comparison_Calculations(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
% end
