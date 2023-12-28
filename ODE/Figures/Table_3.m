function T = Table_3()

temp_cd=pwd;

temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Main_Scenario={'Baseline';
    'Peak burden of hospitalization';
'Peak burden of hospitalization';
'Reduced vaccination rate';
'Reduced vaccination rate';
'Reduced vaccination uptake';
'Reduced vaccination uptake';
'Reduced uptake of second dose';
'Reduced uptake of second dose';
'Reduced transmission rate';
'Reduced transmission rate';
'Duration of delay (41%% a delay second dose)';
'Duration of delay (41%% a delay second dose)';
'Duration of delay (41%% a delay second dose)';
'Duration of delay (41%% a delay second dose)';
'Duration of delay (64%% a delay second dose)';
'Duration of delay (64%% a delay second dose)';
'Duration of delay (64%% a delay second dose)';
'Duration of delay (64%% a delay second dose)';
'Reduced probability of hospitalization';
'Reduced probability of hospitalization';
'Reduced efficacy against infection';
'Reduced efficacy against infection';
'Increased efficacy against severe disease and infection';
'Increased efficacy against severe disease and infection';
'Waning vaccine immunity';
'Waning vaccine immunity';
'Waning vaccine immunity'};
Sub_Scenario={'Baseline';
    'Summer';
'Single Winter'
'33%%'
'66%%'
'33%%'
'66%%'
'33%%'
'66%%'
'5%%'
'10%%'
'7 days'
'14 days'
'21 days'
'28 days'
'7 days'
'14 days'
'21 days'
'28 days'
'33%%'
'66%%'
'33%%'
'66%%'
'33%%'
'66%%'
'0-17'
'18-59'
'60+'};
Incidence=cell(length(Sub_Scenario),1);
Hospitalizations=cell(length(Sub_Scenario),1);
Deaths=cell(length(Sub_Scenario),1);
Costs=cell(length(Sub_Scenario),1);
Time_Dose_SA=zeros(length(Sub_Scenario),1);

Output_Call={'Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_';
 'Summer_SA_Two_Dose_under_2_and_50_and_older_';
'UW_SA_Two_Dose_under_2_and_50_and_older_';
'Reduced_Vaccination_Rate_33_SA_FDA_';
'Reduced_Vaccination_Rate_66_SA_FDA_';
'Reduced_Coverage_33_SA_FDA_';
'Reduced_Coverage_66_SA_FDA_';
'Reduced_2_Dose_33_SA_FDA_';
'Reduced_2_Dose_66_SA_FDA_';
'Reduced_Transmission_5_SA_FDA_';
'Reduced_Transmission_10_SA_FDA_';
'SA_Delay_7_days_41_Two_Dose_FDA_';
'SA_Delay_14_days_41_Two_Dose_FDA_';
'SA_Delay_21_days_41_Two_Dose_FDA_';
'SA_Delay_28_days_41_Two_Dose_FDA_';
'SA_Delay_7_days_64_Two_Dose_FDA_';
'SA_Delay_14_days_64_Two_Dose_FDA_';
'SA_Delay_21_days_64_Two_Dose_FDA_';
'SA_Delay_28_days_64_Two_Dose_FDA_';
'Reduced_Prob_Hospital_33_SA_FDA_';
'Reduced_Prob_Hospital_66_SA_FDA_';
'Reduced_Infection_Efficacy_33_SA_FDA_';
'Reduced_Infection_Efficacy_66_SA_FDA_';
'Increased_Overall_Efficacy_33_SA_FDA_';
'Increased_Overall_Efficacy_66_SA_FDA_';
'Fast_Waning_SA_Two_Dose_FDA_';
'Other_Waning_SA_Two_Dose_FDA_';
'Slow_Waning_SA_Two_Dose_FDA_'};


Time_Dose=[90:30:300];
for ss=1:length(Sub_Scenario)
    Y=zeros(8,1);
    for t_d=1:8  
        load([temp_cd 'Comparison_Summary_' Output_Call{ss} num2str(Time_Dose(t_d)) '_days.mat']);
        Y(t_d)=Comparison.Average.Cost_Total_dt(end);
    end
    Time_Dose_SA(ss)=Time_Dose(Y==max(Y));
    load([temp_cd 'Comparison_Summary_' Output_Call{ss} num2str(Time_Dose_SA(ss)) '_days.mat']);
    temp=[Comparison.Average.Cumulative_Count_Incidence_dt Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==2.5) Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==97.5)]./10^6;
    Incidence{ss}=[num2str(temp(1),'%4.2f') '(' num2str(temp(2),'%4.2f') char(8211) num2str(temp(3),'%4.2f') ')'];

    temp=[Comparison.Average.Cumulative_Count_Hospital_dt Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5) Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5)]./10^5;
    Hospitalizations{ss}=[num2str(temp(1),'%4.2f') '(' num2str(temp(2),'%4.2f') char(8211) num2str(temp(3),'%4.2f') ')'];

    temp=[Comparison.Average.Cumulative_Count_Death_dt Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5) Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5)]./10^4;
    Deaths{ss}=[num2str(temp(1),'%4.2f') '(' num2str(temp(2),'%4.2f') char(8211) num2str(temp(3),'%4.2f') ')'];

    temp=[Comparison.Average.Cost_Total_dt(end) Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end) Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)]./10^9;
    Costs{ss}=[num2str(temp(1),'%4.2f') '(' num2str(temp(2),'%4.2f') char(8211) num2str(temp(3),'%4.2f') ')'];
end

T=table(Main_Scenario,Sub_Scenario,Incidence,Hospitalizations,Deaths,Costs,Time_Dose_SA);
writetable(T,'Table_3.xlsx');
end

