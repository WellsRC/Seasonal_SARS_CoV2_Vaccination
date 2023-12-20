clear;
clc;


temp_cd=pwd;
temp_cd=temp_cd(1:end-11);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load population and contact matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pop_S=load([temp_cd 'Contact_Matrix/Contact_USA_85.mat'],'N');
Pop_S=sum(Pop_S.N);



temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
Age_Text={['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],['65+']};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of single annual dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('=========================================================================== \n');
fprintf(['Results: Switch to an annual vaccination campaign\n']);
fprintf('===========================================================================\n');

load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat']);


fprintf(['Annual campaign-Cumulative Count Hospital:' num2str(Output_Summary.Average.Cumulative_Count_Hospital./10^6,'%3.2f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Hospital(PRCT==2.5)./10^6,'%3.2f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Hospital(PRCT==97.5)./10^6,'%3.2f') ') million \n']);
fprintf(['Annual campaign-Cumulative Count Death:' num2str(Output_Summary.Average.Cumulative_Count_Death,'%10.0f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Death(PRCT==2.5),'%10.0f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Death(PRCT==97.5),'%10.0f') ') \n']);
fprintf(['Annual campaign-Cumulative Total Costs:' num2str(Output_Summary.Average.Cost_Total(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cost_Total(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Output_Summary.PRCT.Cost_Total(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);

Age_Cost=Output_Summary.Average.Cost_Age(:,1:7,end);
age_indx=find(Age_Cost==max(Age_Cost));
fprintf(['Annual campaign-Age Group with greatest medical costs:' Age_Text{age_indx} ' at '  num2str(Output_Summary.Average.Cost_Age(:,age_indx,end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cost_Age(PRCT==2.5,age_indx,end)./10^9,'%3.2f') char(8211) num2str(Output_Summary.PRCT.Cost_Age(PRCT==97.5,age_indx,end)./10^9,'%3.2f') ') billion USD \n']);
fprintf('===========================================================================\n');
fprintf(['Results: Effect of a second dose among individuals under two years of age or 50 years and older\n']);
fprintf('===========================================================================\n');

load([temp_cd 'Marginal_Benefit_Direct_Main_Text_under_2_50_Second_dose_180_days.mat']);
fprintf(['Incremental benefit: Hospitalization:' num2str(100.*Marginal_Benefit.Average.Hospitalization,'%3.1f') '%% (95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Hospitalization(PRCT==2.5),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Hospitalization(PRCT==97.5),'%3.1f') '%%)  \n']);
fprintf(['Incremental benefit: Death:' num2str(100.*Marginal_Benefit.Average.Death,'%3.1f') '%% (95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Death(PRCT==2.5),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Death(PRCT==97.5),'%3.1f') '%%)  \n']);
fprintf(['Incremental benefit: Costs:' num2str(100.*Marginal_Benefit.Average.Cost,'%3.1f') '%% (95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5),'%3.1f') '%%)  \n']);

load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_180_days.mat']);
fprintf(['Two-Dose campaign-Averted Hospital:' num2str(-Comparison.Average.Cumulative_Count_Hospital_dt,'%10.0f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5),'%10.0f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5),'%10.0f') ') \n']);
fprintf(['Two-Dose campaign-Averted Death:' num2str(-Comparison.Average.Cumulative_Count_Death_dt,'%10.0f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5),'%10.0f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5),'%10.0f') ') \n']);
fprintf(['Two-Dose campaign-Averted Costs:' num2str(-Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') char(8211) num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') ') billion USD \n']);

fprintf('===========================================================================\n');
fprintf(['Results: Comparison of outcomes with a second dose only among older adults\n']);
fprintf('===========================================================================\n');


load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_50_vs_young_50_Second_dose_180_days.mat'])
fprintf(['Incremental benefit of vaccinating those undr two:' num2str(100.*Marginal_Benefit.Average.Cost(end),'%3.2f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5,end),'%3.2f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5,end),'%3.2f') '%%) \n']);

age_indx=Marginal_Benefit.Average.Cost_Age(:,1:7,end)==max(Marginal_Benefit.Average.Cost_Age(:,1:7,end));
fprintf(['Maximal Incremental benefit to ' Age_Text{age_indx} ' when vaccinating those undr two:' num2str(100.*Marginal_Benefit.Average.Cost_Age(:,age_indx,end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,age_indx,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,age_indx,end),'%3.1f') '%%) \n']);


load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_65_vs_50_Second_dose_180_days.mat'])
fprintf(['Incremental benefit of vaccinating those 50-64:' num2str(100.*Marginal_Benefit.Average.Cost(end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5,end),'%3.1f') '%%) \n']);

age_indx=Marginal_Benefit.Average.Cost_Age(:,1:7,end)==max(Marginal_Benefit.Average.Cost_Age(:,1:7,end));
fprintf(['Maximal Incremental benefit to ' Age_Text{age_indx} ' when vaccinating those undr two:' num2str(100.*Marginal_Benefit.Average.Cost_Age(:,age_indx,end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,age_indx,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,age_indx,end),'%3.1f') '%%) \n']);


fprintf('===========================================================================\n');
fprintf(['Results: Prioritizing second doses among those 18 to 49 years of age\n']);
fprintf('===========================================================================\n');
load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_18_49_vs_FDA_Reduction35.mat'])
fprintf(['Incremental benefit of vaccinating those 18-49 with a 35%% reduction:' num2str(100.*Marginal_Benefit.Average.Cost(end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5,end),'%3.1f') '%%) \n']);

age_indx=Marginal_Benefit.Average.Cost_Age(:,1:7,end)==max(Marginal_Benefit.Average.Cost_Age(:,1:7,end));
fprintf(['Maximal Incremental benefit to ' Age_Text{age_indx} ' when vaccinating those 18-49 with a 35%% reduction:' num2str(100.*Marginal_Benefit.Average.Cost_Age(:,age_indx,end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,age_indx,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,age_indx,end),'%3.1f') '%%) \n']);

age_indx=Marginal_Benefit.Average.Cost_Age(:,1:7,end)==max(Marginal_Benefit.Average.Cost_Age(:,~age_indx,end));
fprintf(['Maximal Incremental benefit to ' Age_Text{age_indx} ' when vaccinating those 18-49 with a 35%% reduction:' num2str(100.*Marginal_Benefit.Average.Cost_Age(:,age_indx,end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,age_indx,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,age_indx,end),'%3.1f') '%%) \n']);

load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_18_49_vs_FDA_Reduction50.mat'])
fprintf(['Incremental benefit of vaccinating those 18-49 with a 50%% reduction:' num2str(100.*Marginal_Benefit.Average.Cost(end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5,end),'%3.1f') '%%) \n']);

load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_18_49_vs_FDA_Reduction65.mat'])
fprintf(['Incremental benefit of vaccinating those 18-49 with a 65%% reduction:' num2str(100.*Marginal_Benefit.Average.Cost(end),'%3.1f') ' %%(95%% UI: ' num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5,end),'%3.1f') '%%' char(8211) num2str(100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5,end),'%3.1f') '%%) \n']);

fprintf('===========================================================================\n');
fprintf(['Results: Effects of a fast and slow waning vaccine on the benefits of a second dose\n']);
fprintf('===========================================================================\n');
load([temp_cd 'Comparison_Summary_Main_Text_Two_Dose_vs_Annual_Fast_Waning_Vaccine.mat'])
fprintf(['Fast waning-Averted Hospital:' num2str(-Comparison.Average.Cumulative_Count_Hospital_dt,'%10.0f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5),'%10.0f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5),'%10.0f') ') \n']);
fprintf(['Fast waning-Averted Death:' num2str(-Comparison.Average.Cumulative_Count_Death_dt,'%10.0f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5),'%10.0f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5),'%10.0f') ') \n']);
fprintf(['Fast waning-Averted Costs:' num2str(-Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') char(8211) num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') ') billion USD \n']);

load([temp_cd 'Comparison_Summary_Main_Text_Two_Dose_vs_Annual_Slow_Waning_Vaccine.mat'])
fprintf(['Slow waning-Averted Hospital:' num2str(-Comparison.Average.Cumulative_Count_Hospital_dt,'%10.0f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5),'%10.0f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5),'%10.0f') ') \n']);
fprintf(['Slow waning-Averted Death:' num2str(-Comparison.Average.Cumulative_Count_Death_dt,'%10.0f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5),'%10.0f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5),'%10.0f') ') \n']);
fprintf(['Slow waning-Averted Costs:' num2str(-Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') char(8211) num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') ') billion USD \n']);


fprintf('===========================================================================\n');
fprintf(['Discussion \n']);
fprintf('===========================================================================\n');
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_180_days.mat']);
fprintf(['Two-Dose campaign-Averted Hospital:' num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%3.1f') ' %%(95%% UI: ' num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==97.5),'%3.1f') char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5),'%3.1f') ') \n']);
fprintf(['Two-Dose campaign-Averted Death:' num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%3.1f') ' %%(95%% UI: ' num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==97.5),'%3.1f') char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5),'%3.1f') ') \n']);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% comaprison of single dose to two-dose
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% fprintf('=========================================================================== \n');
% fprintf(['Abstract: Comparison of Single dose and Two-doses for 50+ in annual campaign\n']);
% fprintf('===========================================================================\n');
% 
% 
% load([temp_cd 'Comparison_Summary_Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older.mat']);
% 
% fprintf(['Specifying 6-month period between doses, the average reduction in hospitalizations:' num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%2.1f') '%%) \n']);
% fprintf(['Specifying 6-month period between doses, the average reduction in deaths:' num2str(-100.*Comparison.Average.Cumulative_Count_Death_rel,'%2.1f') '%%) \n']);
% fprintf(['Specifying 6-month period between doses, the average reduction in total direct costs:' num2str(-100.*Comparison.Average.Cost_Total_rel(end),'%2.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% comaprison of annual to Baseline 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scenario_Out='Large_Winter_Continual_Vaccination_Baseline_Coverage';
% load([temp_cd 'Model_Output_Summary_' Scenario_Out '.mat']);
% 
% fprintf('=========================================================================== \n');
% fprintf([Scenario_Out ' \n']);
% fprintf('===========================================================================\n');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PerC=10^5;
% M=PerC.*Output_Summary.PRCT.Cumulative_Count_Hospital./Pop_S;
% MA=PerC.*Output_Summary.Average.Cumulative_Count_Hospital./Pop_S;
% fprintf(['Average cumulative hospitalizations: ' num2str(MA,'%4.1f') ' (95%% credible interval (CI):' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PerC=10^5;
% M=PerC.*Output_Summary.PRCT.Cumulative_Count_Death./Pop_S;
% MA=PerC.*Output_Summary.Average.Cumulative_Count_Death./Pop_S;
% fprintf(['Average cumulative deaths: ' num2str(MA,'%4.1f') ' (95%% CI:' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% High_Coverage_Annual_Booster
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Scenario_Out='Large_Winter_Annual_Campaign_Influenza_Like_Coverage';
% load([temp_cd 'Model_Output_Summary_' Scenario_Out '.mat']);
% 
% fprintf('=========================================================================== \n');
% fprintf([Scenario_Out ' \n']);
% fprintf('===========================================================================\n');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PerC=10^5;
% M=PerC.*Output_Summary.PRCT.Cumulative_Count_Hospital./Pop_S;
% MA=PerC.*Output_Summary.Average.Cumulative_Count_Hospital./Pop_S;
% fprintf(['Average cumulative hospitalizations: ' num2str(MA,'%4.1f') ' (95%% CI:' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PerC=10^5;
% M=PerC.*Output_Summary.PRCT.Cumulative_Count_Death./Pop_S;
% MA=PerC.*Output_Summary.Average.Cumulative_Count_Death./Pop_S;
% fprintf(['Average cumulative deaths: ' num2str(MA,'%4.1f') ' (95%% CI:' num2str(M(PRCT==2.5),'%4.1f') char(8211) num2str(M(PRCT==97.5),'%4.1f') ') per ' num2str(PerC) '\n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Comparison between low coverage continual and high coverage annual
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scenario_Out='Large_Winter_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination';
% fprintf('=========================================================================== \n');
% fprintf(['Comparison:' Scenario_Out '\n']);
% fprintf('===========================================================================\n');
% 
% 
% load([temp_cd 'Comparison_Summary_' Scenario_Out '.mat'])
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in hospitalizations: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in deaths: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs: ' num2str(MA(end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs 65+
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-reshape(100.*Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-reshape(100.*Comparison.Average.Cost_Age_rel,7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs for 65+: ' num2str(MA(6,end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,6,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,6,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Comparison between low coverage continual and high coverage annual two doses
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scenario_Out='Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older-Baseline_Continual_Vaccination';
% fprintf('=========================================================================== \n');
% fprintf(['Comparison:' Scenario_Out '\n']);
% fprintf('===========================================================================\n');
% 
% 
% load([temp_cd 'Comparison_Summary_' Scenario_Out '.mat'])
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in hospitalizations: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in deaths: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs: ' num2str(MA(end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs 65+
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-reshape(100.*Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-reshape(100.*Comparison.Average.Cost_Age_rel,7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs for 65+: ' num2str(MA(6,end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,6,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,6,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% comaprison of single dose to two-dose
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% fprintf('=========================================================================== \n');
% fprintf(['Comparison of Single dose and Two-doses for 50+ in annual campaign\n']);
% fprintf('===========================================================================\n');
% 
% XTL={'180'};
% AgeV=[65 50];
% Age_Text={['0' char(8211) '49'],['50' char(8211) '64'],'65+'};
% aa_indx=[7 5 6];
% 
% Y=zeros(1,3);
% load([temp_cd 'Comparison_Summary_Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older.mat']);
% Comparison.Average.Cost_Age_rel=reshape(Comparison.Average.Cost_Age_rel,7,9);
% Comparison.PRCT.Cost_Age_rel=reshape(Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9);
% 
% for aav=1:3
%     aa=aa_indx(aav);
%         Y(1)=Comparison.Average.Cost_Age_rel(aa,end);
%         Y(3)=Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aa,end);
%         Y(2)=Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aa,end);
%     Y=-100.*Y;
%     fprintf(['Specifying 6-month period between doses, the average reduction in total direct costs for ' Age_Text{aav} ': ' num2str(Y(1),'%4.2f') '%% (95%% CI:' num2str(Y(2),'%4.2f') '%%' char(8211) num2str(Y(3),'%4.2f') '%%) \n']);
% end
% 
% 
% 
% t_day=[120 240 270];
% for dd=1:3
%     Y=zeros(1,3);
%     load([temp_cd 'Comparison_Summary_Large_Winter_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(dd)) '_days_50_and_older.mat']);
%     Comparison.Average.Cost_Age_rel=reshape(Comparison.Average.Cost_Age_rel,7,9);
%     Comparison.PRCT.Cost_Age_rel=reshape(Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9);
%     
%     Y(1)=Comparison.Average.Cost_Age_rel(aa,end);
%     Y(3)=Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aa,end);
%     Y(2)=Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aa,end);
%     Y=-100.*Y;
%     fprintf(['Specifying ' num2str(t_day(dd)./30) '-month period between doses, the average reduction in total direct costs for 65+: ' num2str(Y(1),'%4.2f') '%% (95%% CI:' num2str(Y(2),'%4.2f') '%%' char(8211) num2str(Y(3),'%4.2f') '%%) \n']);
% end
% 
% Y=zeros(8,3);
% td=[90:30:300];
% for ss=1:8         
%         load([temp_cd 'Marginal_Benefit_50_and_older_Large_Winter_Two_Campaign_Baseline_Coverage_' num2str(90+30.*(ss-1)) '_days.mat'])
%         
%         out_measure_M=Marginal_Benefit.Average.Cost;
%         out_measure_U=Marginal_Benefit.PRCT.Cost;
%         Y(ss,:)=[out_measure_M out_measure_U(PRCT==2.5) out_measure_U(PRCT==97.5)];
%         
% end
% 
% Y_m=100.*Y(Y(:,1)==max(Y(:,1)),:);
% td=td(Y(:,1)==max(Y(:,1)));
% fprintf(['Maximum marginal benifit for 50+ is at ' num2str(td./30) ' months: ' num2str(Y_m(1),'%4.2f') '%% (95%% CI:' num2str(Y_m(2),'%4.2f') '%%' char(8211) num2str(Y_m(3),'%4.2f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% %% Comparions of 50+ to 65+
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% fprintf('=========================================================================== \n');
% fprintf(['Comparison of 50+ vs 65+\n']);
% fprintf('===========================================================================\n');
% 
% load([temp_cd 'Marginal_Benefit_Second_Dose_50_to_64_Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days.mat'])
% 
% Meas={'Incidence','Hospitalization','Death','Cost'};
% YM=zeros(4,7);
% for Scenario_Indx=1:4
%     for aa=1:6
%         if(Scenario_Indx==1)            
%             Marginal_Benefit.Average.Incidence_Age=reshape(Marginal_Benefit.Average.Incidence_Age,7,9);
%             YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Incidence_Age(aa,end);
%         elseif(Scenario_Indx==2)               
%             Marginal_Benefit.Average.Hospitalization_Age=reshape(Marginal_Benefit.Average.Hospitalization_Age,7,9);
%             YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Hospitalization_Age(aa,end);
%         elseif(Scenario_Indx==3)   
%             Marginal_Benefit.Average.Death_Age=reshape(Marginal_Benefit.Average.Death_Age,7,9);
%             YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Death_Age(aa,end);
%         elseif(Scenario_Indx==4)   
%             Marginal_Benefit.Average.Cost_Age=reshape(Marginal_Benefit.Average.Cost_Age,7,9);
%             YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Cost_Age(aa,end);
%         end
%     end
%     aa=7;
%     if(Scenario_Indx==1)            
%         YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Incidence;
%     elseif(Scenario_Indx==2)               
%         YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Hospitalization;
%     elseif(Scenario_Indx==3)   
%         YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Death;
%     elseif(Scenario_Indx==4)   
%         YM(Scenario_Indx,aa)=Marginal_Benefit.Average.Cost(end);
%     end
% end
% fprintf(['Expanding from 65+ to 50+ has greatest benefit on ' Meas{YM(:,1)==max(YM(:,1))} ' \n']);
% fprintf(['Expanding from 65+ to 50+ has lowest benefit on ' Meas{YM(:,1)==min(YM(:,1))} ' \n']);
% 
% AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],'65+'};
% 
% Ag_Indx=[1 2 3 4 6];
% YM_t=YM(4,[1 2 3 4 6]);
% 
% Marginal_Benefit.Average.Cost_Age=100.*Marginal_Benefit.Average.Cost_Age;
% Marginal_Benefit.PRCT.Cost_Age=reshape(Marginal_Benefit.PRCT.Cost_Age,length(PRCT),7,9);
% Marginal_Benefit.PRCT.Cost_Age=100.*Marginal_Benefit.PRCT.Cost_Age;
% fprintf(['Max effect outside 50-65 is in the ' AgeC{YM_t==max(YM_t)} ' age class:' num2str(Marginal_Benefit.Average.Cost_Age(Ag_Indx(YM_t==max(YM_t)),end),'%4.1f') '%% (95%% CI:' num2str(Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,Ag_Indx(YM_t==max(YM_t)),end),'%4.1f') '%%' char(8211) num2str(Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,Ag_Indx(YM_t==max(YM_t)),end),'%4.1f') '%%) \n']);
% fprintf(['Min effect outside 50-65 is in the ' AgeC{YM_t==min(YM_t)} ' age class:' num2str(Marginal_Benefit.Average.Cost_Age(Ag_Indx(YM_t==min(YM_t)),end),'%4.1f') '%% (95%% CI:' num2str(Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,Ag_Indx(YM_t==min(YM_t)),end),'%4.1f') '%%' char(8211) num2str(Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,Ag_Indx(YM_t==min(YM_t)),end),'%4.1f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Impact of increasing coverage
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% fprintf('=========================================================================== \n');
% fprintf(['Icreasing coverage\n']);
% fprintf('===========================================================================\n');
% Direct=cell(6,1);
% 
% Indirect=cell(6,1);
% 
% 
% lb_Age=[0 5 13 18 50 65];
% ub_Age=[5 13 18 50 65 85];
% 
% AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
% 
% for State_Indx=1:4    
%     Outcome_All=zeros(6,1);
%     Outcome_Indirect=zeros(6,1);
%     for aa=1:6
%        load([temp_cd 'Comparison_Summary_Large_Winter_Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '.mat'],'Comparison','PRCT');
%        Comparison.Average.Age_Cumulative_Count_Incidence_dt=reshape(Comparison.Average.Age_Cumulative_Count_Incidence_dt,7,9);
%        Comparison.Average.Age_Cumulative_Count_Hospital_dt=reshape(Comparison.Average.Age_Cumulative_Count_Hospital_dt,7,9);
%        Comparison.Average.Age_Cumulative_Count_Death_dt=reshape(Comparison.Average.Age_Cumulative_Count_Death_dt,7,9);
%        Comparison.Average.Cost_Age_dt=reshape(Comparison.Average.Cost_Age_dt,7,9);
% 
%        Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt=reshape(Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt,6,9);
%        Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt=reshape(Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt,6,9);
%        Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt=reshape(Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt,6,9);
%        Comparison.Average.Cost_Compliment_Age_dt=reshape(Comparison.Average.Cost_Compliment_Age_dt,6,9);
% 
% 
%        Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt=reshape(Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt,length(PRCT),6,9);
%        Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt=reshape(Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt,length(PRCT),6,9);
%        Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt=reshape(Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt,length(PRCT),6,9);
%        Comparison.PRCT.Cost_Compliment_Age_dt=reshape(Comparison.PRCT.Cost_Compliment_Age_dt,length(PRCT),6,9);
% 
% 
%        if State_Indx==1
%            Outcome_All(aa)=-Comparison.Average.Cumulative_Count_Incidence_dt./10000;
% 
%            Outcome_Indirect(aa)=-Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt(aa,end)./10000;
% 
%            Direct{aa}=[num2str(-Comparison.Average.Cumulative_Count_Incidence_dt./10000,'%4.3f') '; 95%% CI:' num2str(-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==97.5)./10000,'%4.3f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==2.5)./10000,'%4.3f') ];
%            Indirect{aa}=[num2str(-Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt(aa,end)./10000,'%4.3f') '; 95%% CI:' num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==97.5,aa,end)./10000,'%4.3f') char(8211) num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==2.5,aa,end)./10000,'%4.3f') ];
%        elseif State_Indx==2
%            Outcome_All(aa)=-Comparison.Average.Cumulative_Count_Hospital_dt./10000;
% 
%            Outcome_Indirect(aa)=-Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt(aa,end)./10000;
% 
%            Direct{aa}=[num2str(-Comparison.Average.Cumulative_Count_Hospital_dt./10000,'%5.4f') '; 95%% CI:' num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5)./10000,'%5.4f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5)./10000,'%5.4f') ];
%            Indirect{aa}=[num2str(-Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt(aa,end)./10000,'%6.5f') '; 95%% CI:' num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==97.5,aa,end)./10000,'%6.5f') char(8211) num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==2.5,aa,end)./10000,'%6.5f') ];
% 
%        elseif State_Indx==3
%            Outcome_All(aa)=-Comparison.Average.Cumulative_Count_Death_dt./10000;
%            
%            Outcome_Indirect(aa)=-Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt(aa,end)./10000;
% 
% 
%            Direct{aa}=[num2str(-Comparison.Average.Cumulative_Count_Death_dt./10000,'%6.5f') '; 95%% CI:' num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5)./10000,'%6.5f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5)./10000,'%6.5f') ];
%            Indirect{aa}=[num2str(-Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt(aa,end)./10000,'%7.6f') '; 95%% CI:' num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==97.5,aa,end)./10000,'%7.6f') char(8211) num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==2.5,aa,end)./10000,'%7.6f') ];
% 
%        elseif State_Indx==4
% 
%            Outcome_All(aa)=-Comparison.Average.Cost_Total_dt(end)./10000;
% 
%            Outcome_Indirect(aa)=-Comparison.Average.Cost_Compliment_Age_dt(aa,end)./10000;
%            
% 
%            Direct{aa}=[num2str(-Comparison.Average.Cost_Total_dt(end)./10000,'%4.1f') '; 95%% CI:' num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10000,'%4.1f') char(8211) num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10000,'%4.1f') ];
%            Indirect{aa}=[num2str(-Comparison.Average.Cost_Compliment_Age_dt(aa,end)./10000,'%4.1f') '; 95%% CI:' num2str(-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==97.5,aa,end)./10000,'%4.1f') char(8211) num2str(-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==2.5,aa,end)./10000,'%4.1f') ];
% 
%         end
%     end
%     fprintf(['Max direct effect for ' Meas{State_Indx} ' is among '  AgeC{Outcome_All==max(Outcome_All)} ':' Direct{Outcome_All==max(Outcome_All)} '\n']);
%     fprintf(['Max indirect effect for ' Meas{State_Indx} ' is among '  AgeC{Outcome_Indirect==max(Outcome_Indirect)} ':' Indirect{Outcome_Indirect==max(Outcome_Indirect)} '\n']);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% %% Delay
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% 
% fprintf('=========================================================================== \n');
% fprintf(['Delay\n']);
% fprintf('===========================================================================\n');
% load([temp_cd 'Comparison_Summary_Large_Winter_Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_28_days.mat']);
% 
% YA=100.*reshape(Comparison.Average.Age_Cumulative_Count_Incidence_rel,7,9);
% YP=100.*reshape(Comparison.PRCT.Age_Cumulative_Count_Incidence_rel,length(PRCT),7,9);
% fprintf(['Incidence relative change among 65+ due delaying second dose 28 days:' num2str(YA(6,end),'%4.2f') '%% (95%% CI:' num2str(YP(PRCT==2.5,6,end),'%4.2f') '%%' char(8211) num2str(YP(PRCT==97.5,6,end),'%4.2f') '%%) \n']);
% 
% 
% YA=100.*reshape(Comparison.Average.Age_Cumulative_Count_Hospital_rel,7,9);
% YP=100.*reshape(Comparison.PRCT.Age_Cumulative_Count_Hospital_rel,length(PRCT),7,9);
% fprintf(['Hospitalization relative change among 65+ due delaying second dose 28 days:' num2str(YA(6,end),'%4.2f') '%% (95%% CI:' num2str(YP(PRCT==2.5,6,end),'%4.2f') '%%' char(8211) num2str(YP(PRCT==97.5,6,end),'%4.2f') '%%) \n']);
% 
% YA=100.*reshape(Comparison.Average.Age_Cumulative_Count_Death_rel,7,9);
% YP=100.*reshape(Comparison.PRCT.Age_Cumulative_Count_Death_rel,length(PRCT),7,9);
% fprintf(['Death relative change among 65+ due delaying second dose 28 days:' num2str(YA(6,end),'%4.2f') '%% (95%% CI:' num2str(YP(PRCT==2.5,6,end),'%4.2f') '%%' char(8211) num2str(YP(PRCT==97.5,6,end),'%4.2f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %% Unimodal
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% 
% fprintf('=========================================================================== \n');
% fprintf(['Unimodal single dose\n']);
% fprintf('===========================================================================\n');
% 
% load([temp_cd 'Comparison_Summary_Unimodal_Winter_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in hospitalizations: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in deaths: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs: ' num2str(MA(end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs 65+
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-reshape(100.*Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-reshape(100.*Comparison.Average.Cost_Age_rel,7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs for 65+: ' num2str(MA(6,end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,6,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,6,end),'%4.1f') '%%) \n']);
% 
% 
% 
% 
% fprintf('=========================================================================== \n');
% fprintf(['Unimodal single vs two dose dose\n']);
% fprintf('===========================================================================\n');
% 
% XTL={'180'};
% AgeV=[65 50];
% Age_Text={['0' char(8211) '49'],['50' char(8211) '64'],'65+'};
% aa_indx=[7 5 6];
% 
% Y=zeros(1,3);
% load([temp_cd 'Comparison_Summary_Unimodal_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older.mat']);
% Comparison.Average.Cost_Age_rel=reshape(Comparison.Average.Cost_Age_rel,7,9);
% Comparison.PRCT.Cost_Age_rel=reshape(Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9);
% 
% fprintf(['Specifying 6-month period between doses, the average reduction in overall total direct costs: ' num2str(-100.*Comparison.Average.Cost_Total_rel(end),'%4.2f') '%% (95%% CI:' num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==97.5,end),'%4.2f') '%%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==2.5,end),'%4.2f') '%%) \n']);
% 
% for aav=1:3
%     aa=aa_indx(aav);
%         Y(1)=Comparison.Average.Cost_Age_rel(aa,end);
%         Y(3)=Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aa,end);
%         Y(2)=Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aa,end);
%     Y=-100.*Y;
%     fprintf(['Specifying 6-month period between doses, the average reduction in total direct costs for ' Age_Text{aav} ': ' num2str(Y(1),'%4.2f') '%% (95%% CI:' num2str(Y(2),'%4.2f') '%%' char(8211) num2str(Y(3),'%4.2f') '%%) \n']);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Comparison between low coverage continual and hogh coverage two dose summer peak
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scenario_Out='Large_Summer_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination';
% fprintf('=========================================================================== \n');
% fprintf(['Comparison:' Scenario_Out '\n']);
% fprintf('===========================================================================\n');
% 
% 
% load([temp_cd 'Comparison_Summary_' Scenario_Out '.mat'])
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in hospitalizations: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in deaths: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs: ' num2str(MA(end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs 65+
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-reshape(100.*Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-reshape(100.*Comparison.Average.Cost_Age_rel,7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs for 65+: ' num2str(MA(6,end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,6,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,6,end),'%4.1f') '%%) \n']);
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Comparison between low coverage continual and hogh coverage two dose summer peak
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scenario_Out='Large_Summer_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older-Baseline_Continual_Vaccination';
% fprintf('=========================================================================== \n');
% fprintf(['Comparison:' Scenario_Out '\n']);
% fprintf('===========================================================================\n');
% 
% 
% load([temp_cd 'Comparison_Summary_' Scenario_Out '.mat'])
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Hospitalizations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Hospital_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in hospitalizations: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Deaths
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cumulative_Count_Death_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in deaths: ' num2str(MA,'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5),'%4.1f') '%%) \n']);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-100.*Comparison.PRCT.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-100.*Comparison.Average.Cost_Total_rel; % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs: ' num2str(MA(end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,end),'%4.1f') '%%) \n']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Costs 65+
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% M=-reshape(100.*Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% MA=-reshape(100.*Comparison.Average.Cost_Age_rel,7,9); % NEED TO TAKE THE NEGATIVE BASED ON HOW THE CALCULATION WAS CONDUCTED
% fprintf(['Average reduction in total direct costs for 65+: ' num2str(MA(6,end),'%4.1f') '%% (95%% CI:' num2str(M(PRCT==97.5,6,end),'%4.1f') '%%' char(8211) num2str(M(PRCT==2.5,6,end),'%4.1f') '%%) \n']);
% 
% 
