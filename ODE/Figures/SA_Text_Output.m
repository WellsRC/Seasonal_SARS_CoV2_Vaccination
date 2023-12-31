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




fprintf('=========================================================================== \n');
fprintf(['Supplement: Transition to an annual vaccination campaign\n']);
fprintf('===========================================================================\n');

load([temp_cd 'Model_Output_Summary_Calibration.mat']);

fprintf(['Calibration-Cumulative Count Incidence:' num2str(Output_Summary.Average.Cumulative_Count_Incidence,'%10.0f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Incidence(PRCT==2.5),'%10.0f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Incidence(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Calibration-Cumulative Count Hospital:' num2str(Output_Summary.Average.Cumulative_Count_Hospital,'%10.0f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Hospital(PRCT==2.5),'%10.0f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Hospital(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Calibration-Cumulative Count Death:' num2str(Output_Summary.Average.Cumulative_Count_Death,'%10.0f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Death(PRCT==2.5),'%10.0f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Death(PRCT==97.5),'%10.0f') ') \n']);
fprintf(['Calibration-Cumulative Total Costs:' num2str(Output_Summary.Average.Cost_Total(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cost_Total(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Output_Summary.PRCT.Cost_Total(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);

