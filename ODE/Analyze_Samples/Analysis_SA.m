%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Influenza-like coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Annual Campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
load(['Output_SA_Annual_Campaign_Influenza_Like_Coverage.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
Baseline_Output_Large_Winter=Filtered_Output_Large_Winter;
Baseline_Output_Large_Summer=Filtered_Output_Large_Summer;

Scenario_Calculations(Baseline_Output_Large_Winter,['Large_Winter_Annual_Campaign_Influenza_Like_Coverage']);
Scenario_Calculations(Baseline_Output_Large_Summer,['Large_Summer_Annual_Campaign_Influenza_Like_Coverage']);

SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_210_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_240_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_270_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_300_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_90_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_90_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_120_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_150_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_180_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_210_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_240_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_270_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_300_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_210_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_240_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_270_days_50_to_64','Two_Campaign_Influenza_Like_Coverage_300_days_50_to_64','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_7_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_14_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_21_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_28_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_7_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_14_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_21_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_28_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_7_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_14_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_21_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_28_days','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older_Proportion_Delay_30_Delay_7_days','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older_Proportion_Delay_30_Delay_14_days','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older_Proportion_Delay_30_Delay_21_days','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older_Proportion_Delay_30_Delay_28_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

    Scenario_Calculations(Filtered_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss}]);
    Scenario_Calculations(Filtered_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss}]);

    Comparison_Calculations(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss} ]);
    Comparison_Calculations(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss} ]);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Marginal benefit for vaccinating the 50-64 age class
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days','Two_Campaign_Influenza_Like_Coverage_120_days','Two_Campaign_Influenza_Like_Coverage_150_days','Two_Campaign_Influenza_Like_Coverage_180_days','Two_Campaign_Influenza_Like_Coverage_210_days','Two_Campaign_Influenza_Like_Coverage_240_days','Two_Campaign_Influenza_Like_Coverage_270_days','Two_Campaign_Influenza_Like_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Filtered_Output_Winter_65=Filtered_Output_Large_Winter;
    Filtered_Output_Summer_65=Filtered_Output_Large_Summer;
    load(['Output_SA_' SA_Scenario{ss} '_50_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Filtered_Output_Winter_50=Filtered_Output_Large_Winter;
    Filtered_Output_Summer_50=Filtered_Output_Large_Summer;
    load(['Output_SA_' SA_Scenario{ss} '_50_to_64.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Filtered_Output_Winter_50_to_64=Filtered_Output_Large_Winter;
    Filtered_Output_Summer_50_to_64=Filtered_Output_Large_Summer;
    
    Marginal_Benefit_Second_Doses(Filtered_Output_Winter_65,Filtered_Output_Winter_50,Baseline_Output_Large_Winter, ['Large_Winter_' SA_Scenario{ss}]);
    Marginal_Benefit_Second_Doses(Filtered_Output_Summer_65,Filtered_Output_Summer_50,Baseline_Output_Large_Summer, ['Large_Summer_' SA_Scenario{ss}]);
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Marginal benefit redistributing the second dose for those 50-64
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
load(['Output_SA_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
Filtered_Output_Winter_50_and_older=Filtered_Output_Large_Winter;
Filtered_Output_Summer_50_and_older=Filtered_Output_Large_Summer;

load(['Output_SA_Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
Filtered_Output_Winter_65_and_older=Filtered_Output_Large_Winter;
Filtered_Output_Summer_65_and_older=Filtered_Output_Large_Summer;

SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};
for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
       
    Marginal_Benefit_Redistribute(Filtered_Output_Winter_65_and_older,Filtered_Output_Winter_50_and_older,Filtered_Output_Large_Winter, ['Large_Winter_' SA_Scenario{ss}]); 
    Marginal_Benefit_Redistribute(Filtered_Output_Summer_65_and_older,Filtered_Output_Summer_50_and_older,Filtered_Output_Large_Summer, ['Large_Summer_' SA_Scenario{ss}]); 
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Marginal benefit of vaccinating the 65 and older
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days','Two_Campaign_Influenza_Like_Coverage_120_days','Two_Campaign_Influenza_Like_Coverage_150_days','Two_Campaign_Influenza_Like_Coverage_180_days','Two_Campaign_Influenza_Like_Coverage_210_days','Two_Campaign_Influenza_Like_Coverage_240_days','Two_Campaign_Influenza_Like_Coverage_270_days','Two_Campaign_Influenza_Like_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Marginal_Benefit_65(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,90+30.*(ss-1),['Large_Winter_' SA_Scenario{ss}])
    Marginal_Benefit_65(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,90+30.*(ss-1),['Large_Summer_' SA_Scenario{ss}])
end
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Annual Campaign vs Continual campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load('Baseline_Outputs.mat');
Baseline_Output_Large_Winter=Filtered_Output_Large_Winter;
Baseline_Output_Large_Summer=Filtered_Output_Large_Summer;

Scenario_Calculations(Baseline_Output_Large_Winter,['Large_Winter_Continual_Vaccination_Baseline_Coverage']);
Scenario_Calculations(Baseline_Output_Large_Summer,['Large_Summer_Continual_Vaccination_Baseline_Coverage']);

SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

    Comparison_Calculations(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
    Comparison_Calculations(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss} '-Baseline_Continual_Vaccination']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Baseline coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Annual Campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
load(['Output_SA_Annual_Campaign_Baseline_Coverage.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
Baseline_Output_Large_Winter=Filtered_Output_Large_Winter;
Baseline_Output_Large_Summer=Filtered_Output_Large_Summer;

Scenario_Calculations(Baseline_Output_Large_Winter,['Large_Winter_Annual_Campaign_Baseline_Coverage']);
Scenario_Calculations(Baseline_Output_Large_Summer,['Large_Summer_Annual_Campaign_Baseline_Coverage']);

SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days_65_and_older','Two_Campaign_Baseline_Coverage_120_days_65_and_older','Two_Campaign_Baseline_Coverage_150_days_65_and_older','Two_Campaign_Baseline_Coverage_180_days_65_and_older','Two_Campaign_Baseline_Coverage_210_days_65_and_older','Two_Campaign_Baseline_Coverage_240_days_65_and_older','Two_Campaign_Baseline_Coverage_270_days_65_and_older','Two_Campaign_Baseline_Coverage_300_days_65_and_older','Two_Campaign_Baseline_Coverage_90_days_50_and_older','Two_Campaign_Baseline_Coverage_120_days_50_and_older','Two_Campaign_Baseline_Coverage_150_days_50_and_older','Two_Campaign_Baseline_Coverage_180_days_50_and_older','Two_Campaign_Baseline_Coverage_90_days_50_to_64','Two_Campaign_Baseline_Coverage_120_days_50_to_64','Two_Campaign_Baseline_Coverage_150_days_50_to_64','Two_Campaign_Baseline_Coverage_180_days_50_to_64','Two_Campaign_Baseline_Coverage_210_days_50_and_older','Two_Campaign_Baseline_Coverage_240_days_50_and_older','Two_Campaign_Baseline_Coverage_270_days_50_and_older','Two_Campaign_Baseline_Coverage_300_days_50_and_older','Two_Campaign_Baseline_Coverage_210_days_50_to_64','Two_Campaign_Baseline_Coverage_240_days_50_to_64','Two_Campaign_Baseline_Coverage_270_days_50_to_64','Two_Campaign_Baseline_Coverage_300_days_50_to_64','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

    Scenario_Calculations(Filtered_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss}]);
    Scenario_Calculations(Filtered_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss}]);

    Comparison_Calculations(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,['Large_Winter_' SA_Scenario{ss} ]);
    Comparison_Calculations(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,['Large_Summer_' SA_Scenario{ss} ]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit for vaccinating the 50-64 age class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days','Two_Campaign_Baseline_Coverage_120_days','Two_Campaign_Baseline_Coverage_150_days','Two_Campaign_Baseline_Coverage_180_days','Two_Campaign_Baseline_Coverage_210_days','Two_Campaign_Baseline_Coverage_240_days','Two_Campaign_Baseline_Coverage_270_days','Two_Campaign_Baseline_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Filtered_Output_Winter_65=Filtered_Output_Large_Winter;
    Filtered_Output_Summer_65=Filtered_Output_Large_Summer;
    load(['Output_SA_' SA_Scenario{ss} '_50_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Filtered_Output_Winter_50=Filtered_Output_Large_Winter;
    Filtered_Output_Summer_50=Filtered_Output_Large_Summer;
    load(['Output_SA_' SA_Scenario{ss} '_50_to_64.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Filtered_Output_Winter_50_to_64=Filtered_Output_Large_Winter;
    Filtered_Output_Summer_50_to_64=Filtered_Output_Large_Summer;
    
    Marginal_Benefit_Second_Doses(Filtered_Output_Winter_65,Filtered_Output_Winter_50,Baseline_Output_Large_Winter, ['Large_Winter_' SA_Scenario{ss}]);
    Marginal_Benefit_Second_Doses(Filtered_Output_Summer_65,Filtered_Output_Summer_50,Baseline_Output_Large_Summer, ['Large_Summer_' SA_Scenario{ss}]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit redistributing the second dose for those 50-64
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
load(['Output_SA_Two_Campaign_Baseline_Coverage_180_days_50_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
Filtered_Output_Winter_50_and_older=Filtered_Output_Large_Winter;
Filtered_Output_Summer_50_and_older=Filtered_Output_Large_Summer;

load(['Output_SA_Two_Campaign_Baseline_Coverage_180_days_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
Filtered_Output_Winter_65_and_older=Filtered_Output_Large_Winter;
Filtered_Output_Summer_65_and_older=Filtered_Output_Large_Summer;


SA_Scenario={'Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};
for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
       
    Marginal_Benefit_Redistribute(Filtered_Output_Winter_65_and_older,Filtered_Output_Winter_50_and_older,Filtered_Output_Large_Winter, ['Large_Winter_' SA_Scenario{ss}]); 
    Marginal_Benefit_Redistribute(Filtered_Output_Summer_65_and_older,Filtered_Output_Summer_50_and_older,Filtered_Output_Large_Summer, ['Large_Summer_' SA_Scenario{ss}]); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit of vaccinating the 65 and older
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days','Two_Campaign_Baseline_Coverage_120_days','Two_Campaign_Baseline_Coverage_150_days','Two_Campaign_Baseline_Coverage_180_days','Two_Campaign_Baseline_Coverage_210_days','Two_Campaign_Baseline_Coverage_240_days','Two_Campaign_Baseline_Coverage_270_days','Two_Campaign_Baseline_Coverage_300_days'};

for ss=1:length(SA_Scenario)
    load(['Output_SA_' SA_Scenario{ss} '_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    Marginal_Benefit_65(Filtered_Output_Large_Winter,Baseline_Output_Large_Winter,90+30.*(ss-1),['Large_Winter_' SA_Scenario{ss}])
    Marginal_Benefit_65(Filtered_Output_Large_Summer,Baseline_Output_Large_Summer,90+30.*(ss-1),['Large_Summer_' SA_Scenario{ss}])
end
