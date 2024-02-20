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
fprintf(['Abstract \n']);
fprintf('===========================================================================\n');
Y=zeros(8,1);
Time_Dose=[90:30:300];
for dd=1:8
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose(dd)) '_days.mat']);
    Y(dd)=Comparison.Average.Cost_Total_dt(end);
end

Time_DoseFDA=Time_Dose(Y==max(Y));
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_DoseFDA) '_days.mat']);

fprintf(['Annual vs FDA-proposed Hospital:' num2str(Comparison.Average.Cumulative_Count_Hospital_dt,'%10.0f') ' (95%% UI: ' num2str(Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5),'%10.0f')  char(8211) num2str(Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Annual vs FDA-proposed Death:' num2str(Comparison.Average.Cumulative_Count_Death_dt,'%10.0f') ' (95%% UI: ' num2str(Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5),'%10.0f')  char(8211) num2str(Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Annual vs FDA-proposed  Costs:' num2str(Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);


fprintf('=========================================================================== \n');
fprintf(['Results: Transition to an annual vaccination campaign\n']);
fprintf('===========================================================================\n');

load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat']);


fprintf(['Annual-Cumulative Count Hospital:' num2str(Output_Summary.Average.Cumulative_Count_Hospital,'%10.0f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Hospital(PRCT==2.5),'%10.0f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Hospital(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Annual-Cumulative Count Death:' num2str(Output_Summary.Average.Cumulative_Count_Death,'%10.0f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cumulative_Count_Death(PRCT==2.5),'%10.0f') char(8211) num2str(Output_Summary.PRCT.Cumulative_Count_Death(PRCT==97.5),'%10.0f') ') \n']);
fprintf(['Annual-Cumulative Total Costs:' num2str(Output_Summary.Average.Cost_Total(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Output_Summary.PRCT.Cost_Total(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Output_Summary.PRCT.Cost_Total(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);

fprintf('===========================================================================\n');
fprintf(['Results: Benefits of FDA-proposed\n']);
fprintf('===========================================================================\n');

Y=zeros(8,1);
Y_Age=zeros(8,7);
Time_Dose=[90:30:300];
for dd=1:8
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose(dd)) '_days.mat']);
    Y(dd)=Comparison.Average.Cost_Total_dt(end);
    Y_Age(dd,:)=Comparison.Average.Cost_Age_dt(:,1:7,end);
end
Time_DoseFDA=Time_Dose(Y==max(Y));
fprintf(['Time between doses the maximizes overall costs averted: ' num2str(Time_DoseFDA) ' days \n']);
for aa=1:length(Age_Text)
    fprintf(['Time between doses the maximizes overall costs averted for age group ' Age_Text{aa} ': ' num2str(Time_Dose(Y_Age(:,aa)==max(Y_Age(:,aa)))) ' days \n']);
end

Time_Dose=Time_Dose(Y==max(Y));
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days.mat']);

fprintf(['Annual vs FDA-proposed Hospital:' num2str(Comparison.Average.Cumulative_Count_Hospital_dt,'%10.0f') ' (95%% UI: ' num2str(Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5),'%10.0f')  char(8211) num2str(Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Annual vs FDA-proposed Death:' num2str(Comparison.Average.Cumulative_Count_Death_dt,'%10.0f') ' (95%% UI: ' num2str(Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5),'%10.0f')  char(8211) num2str(Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5),'%10.0f') ')  \n']);
fprintf(['Annual vs FDA-proposed  Costs:' num2str(Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);


fprintf('===========================================================================\n');
fprintf(['Results: Benefits of a second dose among different age groups\n']);
fprintf('===========================================================================\n');

Y65=zeros(8,1);
Y50=zeros(8,1);
Y18=zeros(8,1);
Time_Dose=[90:30:300];
for dd=1:8
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose(dd)) '_days.mat']);
    Y65(dd)=Comparison.Average.Cost_Total_dt(end);

    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_50_64_' num2str(Time_Dose(dd)) '_days.mat']);
    Y50(dd)=Comparison.Average.Cost_Total_dt(end);

    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_18_49_' num2str(Time_Dose(dd)) '_days.mat']);
    Y18(dd)=Comparison.Average.Cost_Total_dt(end);
end

Time_Dose_65=Time_Dose(Y65==max(Y65));
Time_Dose_50=Time_Dose(Y50==max(Y50));
Time_Dose_18=Time_Dose(Y18==max(Y18));

fprintf(['Annual with second dose for 65+: Time between doses the maximizes overall costs averted: ' num2str(Time_Dose_65) ' days \n']);
fprintf(['Annual with second dose for 50-64: Time between doses the maximizes overall costs averted: ' num2str(Time_Dose_50) ' days \n']);
fprintf(['Annual with second dose for 18-49: Time between doses the maximizes overall costs averted: ' num2str(Time_Dose_18) ' days \n']);

load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose_65) '_days.mat']);
fprintf(['Annual with second dose for 65+: Maximal overall costs averted:' num2str(Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);

load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_50_64_' num2str(Time_Dose_50) '_days.mat']);
fprintf(['Annual with second dose for 50-64: Maximal overall costs averted:' num2str(Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);

load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_18_49_' num2str(Time_Dose_18) '_days.mat']);
fprintf(['Annual with second dose for 18-49: Maximal overall costs averted:' num2str(Comparison.Average.Cost_Total_dt(end)./10^9,'%3.2f') ' (95%% UI: ' num2str(Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10^9,'%3.2f') char(8211) num2str(Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10^9,'%3.2f') ') billion USD \n']);

fprintf('===========================================================================\n');
fprintf(['Results: Discussions\n']);
fprintf('===========================================================================\n');

load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_DoseFDA) '_days.mat']);
fprintf(['Relative Annual vs FDA-proposed Hospital: ' num2str(100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%2.0f') '%%\n']);%
fprintf(['Relative Annual vs FDA-proposed Death: ' num2str(100.*Comparison.Average.Cumulative_Count_Death_rel,'%2.0f') '%%\n']);
