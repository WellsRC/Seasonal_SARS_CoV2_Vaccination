%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Influenza-like coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Annual Campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
load(['Output_SA_Annual_Campaign_Influenza_Like_Coverage_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
Baseline_Output_All=Filtered_Output_Unimodal;

Scenario_Calculations(Baseline_Output_All,['Unimodal_Winter_Annual_Campaign_Influenza_Like_Coverage']);

SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_210_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_240_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_270_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_300_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_90_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_210_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_240_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_270_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_300_days_50_and_older','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};
for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');

    Scenario_Calculations(Filtered_Output_Unimodal,['Unimodal_Winter_' SA_Scenario{ss}]);

    Comparison_Calculations(Filtered_Output_Unimodal,Baseline_Output_All,['Unimodal_Winter_' SA_Scenario{ss}]);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Marginal benefit for vaccinating the 50-64 age class
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days','Two_Campaign_Influenza_Like_Coverage_120_days','Two_Campaign_Influenza_Like_Coverage_150_days','Two_Campaign_Influenza_Like_Coverage_180_days','Two_Campaign_Influenza_Like_Coverage_210_days','Two_Campaign_Influenza_Like_Coverage_240_days','Two_Campaign_Influenza_Like_Coverage_270_days','Two_Campaign_Influenza_Like_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_65_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
    Filtered_Output_Unimodal_65=Filtered_Output_Unimodal;
    load(['Output_SA_' SA_Scenario{ss} '_50_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
    Filtered_Output_Unimodal_50=Filtered_Output_Unimodal;
    
    Marginal_Benefit_Second_Doses(Filtered_Output_Unimodal_65,Filtered_Output_Unimodal_50,Baseline_Output_All, ['Unimodal_Winter_' SA_Scenario{ss}]);
end

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Marginal benefit redistributing the second dose for those 50-64
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% load(['Output_SA_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
% Filtered_Output_Unimodal_50_and_older=Filtered_Output_Unimodal;
% load(['Output_SA_Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
% Filtered_Output_Unimodal_65_and_older=Filtered_Output_Unimodal;
% 
% SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};
% for ss=1:length(SA_Scenario)
%     load(['Output_SA_' SA_Scenario{ss} '_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
%        
%     Marginal_Benefit_Redistribute(Filtered_Output_Unimodal_65_and_older,Filtered_Output_Unimodal_50_and_older,Filtered_Output_Unimodal, ['Unimodal_Winter_' SA_Scenario{ss}]); 
% end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Marginal benefit of vaccinating the 65 and older
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days','Two_Campaign_Influenza_Like_Coverage_120_days','Two_Campaign_Influenza_Like_Coverage_150_days','Two_Campaign_Influenza_Like_Coverage_180_days','Two_Campaign_Influenza_Like_Coverage_210_days','Two_Campaign_Influenza_Like_Coverage_240_days','Two_Campaign_Influenza_Like_Coverage_270_days','Two_Campaign_Influenza_Like_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_50_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
    Marginal_Benefit_50(Filtered_Output_Unimodal,Baseline_Output_All,90+30.*(ss-1),['Unimodal_Winter_' SA_Scenario{ss}])
end
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Annual Campaign vs Continual campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load('Unimodal_Peak_Winter_Output.mat');
Baseline_Output_All=Filtered_Output_Unimodal;

Scenario_Calculations(Baseline_Output_All,['Unimodal_WinterContinual_Vaccination_Influenza_Baseline_Coverage']);

SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');

    Comparison_Calculations(Filtered_Output_Unimodal,Baseline_Output_All,['Unimodal_Winter_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Baseline coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Annual Campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
load(['Output_SA_Annual_Campaign_Baseline_Coverage_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
Baseline_Output_All=Filtered_Output_Unimodal;

Scenario_Calculations(Baseline_Output_All,['Unimodal_Winter_Annual_Campaign_Baseline_Coverage']);
SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days_65_and_older','Two_Campaign_Baseline_Coverage_120_days_65_and_older','Two_Campaign_Baseline_Coverage_150_days_65_and_older','Two_Campaign_Baseline_Coverage_180_days_65_and_older','Two_Campaign_Baseline_Coverage_210_days_65_and_older','Two_Campaign_Baseline_Coverage_240_days_65_and_older','Two_Campaign_Baseline_Coverage_270_days_65_and_older','Two_Campaign_Baseline_Coverage_300_days_65_and_older','Two_Campaign_Baseline_Coverage_90_days_50_and_older','Two_Campaign_Baseline_Coverage_120_days_50_and_older','Two_Campaign_Baseline_Coverage_150_days_50_and_older','Two_Campaign_Baseline_Coverage_180_days_50_and_older','Two_Campaign_Baseline_Coverage_210_days_50_and_older','Two_Campaign_Baseline_Coverage_240_days_50_and_older','Two_Campaign_Baseline_Coverage_270_days_50_and_older','Two_Campaign_Baseline_Coverage_300_days_50_and_older','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');

    Scenario_Calculations(Filtered_Output_Unimodal,['Unimodal_Winter_' SA_Scenario{ss}]);

    Comparison_Calculations(Filtered_Output_Unimodal,Baseline_Output_All,['Unimodal_Winter_' SA_Scenario{ss}]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit for vaccinating the 50-64 age class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days','Two_Campaign_Baseline_Coverage_120_days','Two_Campaign_Baseline_Coverage_150_days','Two_Campaign_Baseline_Coverage_180_days','Two_Campaign_Baseline_Coverage_210_days','Two_Campaign_Baseline_Coverage_240_days','Two_Campaign_Baseline_Coverage_270_days','Two_Campaign_Baseline_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_65_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
    Filtered_Output_Unimodal_65=Filtered_Output_Unimodal;
    load(['Output_SA_' SA_Scenario{ss} '_50_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
    Filtered_Output_Unimodal_50=Filtered_Output_Unimodal;
    
    Marginal_Benefit_Second_Doses(Filtered_Output_Unimodal_65,Filtered_Output_Unimodal_50,Baseline_Output_All, ['Unimodal_Winter_' SA_Scenario{ss}]);
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Marginal benefit redistributing the second dose for those 50-64
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% load(['Output_SA_Two_Campaign_Baseline_Coverage_180_days_50_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
% Filtered_Output_Unimodal_50_and_older=Filtered_Output_Unimodal;
% 
% load(['Output_SA_Two_Campaign_Baseline_Coverage_180_days_65_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
% Filtered_Output_Unimodal_65_and_older=Filtered_Output_Unimodal;
% 
% 
% SA_Scenario={'Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};
% for ss=1:length(SA_Scenario)
%     load(['Output_SA_' SA_Scenario{ss} '_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
%        
%     Marginal_Benefit_Redistribute(Filtered_Output_Unimodal_65_and_older,Filtered_Output_Unimodal_50_and_older,Filtered_Output_Unimodal, ['Unimodal_Winter_' SA_Scenario{ss}]); 
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit of vaccinating the 65 and older
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days','Two_Campaign_Baseline_Coverage_120_days','Two_Campaign_Baseline_Coverage_150_days','Two_Campaign_Baseline_Coverage_180_days','Two_Campaign_Baseline_Coverage_210_days','Two_Campaign_Baseline_Coverage_240_days','Two_Campaign_Baseline_Coverage_270_days','Two_Campaign_Baseline_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_50_and_older_Unimodal_Winter.mat'],'Filtered_Output_Unimodal');
    Marginal_Benefit_50(Filtered_Output_Unimodal,Baseline_Output_All,90+30.*(ss-1),['Unimodal_Winter_' SA_Scenario{ss}])
end
