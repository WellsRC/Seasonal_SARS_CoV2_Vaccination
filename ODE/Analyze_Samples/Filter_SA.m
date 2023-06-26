clear;
clc;

Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Annual campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage','Annual_Campaign_Baseline_Coverage'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
end

SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_Unimodal_Winter'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Unimodal] = SA_Output_U(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Unimodal');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additional doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};

for ss=1:length(SA_Scenario)
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
end

SA_Scenario={'Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49'};

for ss=1:length(SA_Scenario)
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
end

SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17_Unimodal_Winter','Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49_Unimodal_Winter'};

for ss=1:length(SA_Scenario)
    [Filtered_Output_Unimodal]=SA_Output_U(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Unimodal');
end

SA_Scenario={'Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_0_to_4_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_5_to_12_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_13_to_17_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_18_to_49_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_50_to_64_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_65_to_84_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_0_to_4_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_5_to_12_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_13_to_17_Unimodal_Winter','Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_18_to_49_Unimodal_Winter'};

for ss=1:length(SA_Scenario)
    [Filtered_Output_Unimodal]=SA_Output_U(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Unimodal');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_210_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_240_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_270_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_300_days_65_and_older','Two_Campaign_Influenza_Like_Coverage_90_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_120_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_150_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_210_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_240_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_270_days_50_and_older','Two_Campaign_Influenza_Like_Coverage_300_days_50_and_older'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
end

SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days_65_and_older','Two_Campaign_Baseline_Coverage_120_days_65_and_older','Two_Campaign_Baseline_Coverage_150_days_65_and_older','Two_Campaign_Baseline_Coverage_180_days_65_and_older','Two_Campaign_Baseline_Coverage_210_days_65_and_older','Two_Campaign_Baseline_Coverage_240_days_65_and_older','Two_Campaign_Baseline_Coverage_270_days_65_and_older','Two_Campaign_Baseline_Coverage_300_days_65_and_older','Two_Campaign_Baseline_Coverage_90_days_50_and_older','Two_Campaign_Baseline_Coverage_120_days_50_and_older','Two_Campaign_Baseline_Coverage_150_days_50_and_older','Two_Campaign_Baseline_Coverage_180_days_50_and_older','Two_Campaign_Baseline_Coverage_210_days_50_and_older','Two_Campaign_Baseline_Coverage_240_days_50_and_older','Two_Campaign_Baseline_Coverage_270_days_50_and_older','Two_Campaign_Baseline_Coverage_300_days_50_and_older'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
end

SA_Scenario={'Two_Campaign_Influenza_Like_Coverage_90_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_120_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_150_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_180_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_210_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_240_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_270_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_300_days_65_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_90_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_120_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_150_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_210_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_240_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_270_days_50_and_older_Unimodal_Winter','Two_Campaign_Influenza_Like_Coverage_300_days_50_and_older_Unimodal_Winter'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Unimodal]=SA_Output_U(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Unimodal');
end

SA_Scenario={'Two_Campaign_Baseline_Coverage_90_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_120_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_150_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_180_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_210_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_240_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_270_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_300_days_65_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_90_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_120_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_150_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_180_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_210_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_240_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_270_days_50_and_older_Unimodal_Winter','Two_Campaign_Baseline_Coverage_300_days_50_and_older_Unimodal_Winter'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Unimodal]=SA_Output_U(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Unimodal');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SA_Scenario={'Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_7_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_14_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_21_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_30_Delay_28_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_7_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_14_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_21_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_28_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_7_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_14_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_21_days','Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_28_days','Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older_Proportion_Delay_60_Delay_28_days'};
for ss=1:length(SA_Scenario)
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario{ss},Av,ACg);
    save(['Output_SA_' SA_Scenario{ss} '.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
end