function T=Table_2()

Strategy={'Annual','FDA-proposed','Annual with second dose for 65+','Annual with second dose for 50-64','Annual with second dose for 18-49'}';

temp_cd=pwd;

temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Y=zeros(8,1);
Y65=zeros(8,1);
Y50=zeros(8,1);
Y18=zeros(8,1);

Time_Dose=[90:30:300];
for dd=1:8
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose(dd)) '_days.mat']);
    Y(dd)=Comparison.Average.Cost_Total_dt(end);
                   
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose(dd)) '_days.mat']);
    Y65(dd)=Comparison.Average.Cost_Total_dt(end);

    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_50_64_' num2str(Time_Dose(dd)) '_days.mat']);
    Y50(dd)=Comparison.Average.Cost_Total_dt(end);

    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_18_49_' num2str(Time_Dose(dd)) '_days.mat']);
    Y18(dd)=Comparison.Average.Cost_Total_dt(end);
end

Time_Dose_FDA=Time_Dose(Y==max(Y));
Time_Dose_65=Time_Dose(Y65==max(Y65));
Time_Dose_50=Time_Dose(Y50==max(Y50));
Time_Dose_18=Time_Dose(Y18==max(Y18));
Times_Dose_v=[inf; Time_Dose_FDA; Time_Dose_65; Time_Dose_50; Time_Dose_18];

load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat'])
SDAVC=Output_Summary;
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose_FDA) '_days.mat'])
FDAAVC=Output_Summary;
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_65_and_older_'  num2str(Time_Dose_65) '_days.mat'])
S1=Output_Summary;
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_50_64_' num2str(Time_Dose_50) '_days.mat'])
S2=Output_Summary;
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_18_49_' num2str(Time_Dose_18) '_days.mat'])
S3=Output_Summary;
Y=[SDAVC.Average.Cumulative_Count_Incidence./10^6 SDAVC.Average.Cumulative_Count_Hospital./10^5 SDAVC.Average.Cumulative_Count_Death./10^4 SDAVC.Average.Cost_Total(end)./10^9;
   FDAAVC.Average.Cumulative_Count_Incidence./10^6 FDAAVC.Average.Cumulative_Count_Hospital./10^5 FDAAVC.Average.Cumulative_Count_Death./10^4 FDAAVC.Average.Cost_Total(end)./10^9;
   S1.Average.Cumulative_Count_Incidence./10^6 S1.Average.Cumulative_Count_Hospital./10^5 S1.Average.Cumulative_Count_Death./10^4 S1.Average.Cost_Total(end)./10^9;
   S2.Average.Cumulative_Count_Incidence./10^6 S2.Average.Cumulative_Count_Hospital./10^5 S2.Average.Cumulative_Count_Death./10^4 S2.Average.Cost_Total(end)./10^9;
   S3.Average.Cumulative_Count_Incidence./10^6 S3.Average.Cumulative_Count_Hospital./10^5 S3.Average.Cumulative_Count_Death./10^4 S3.Average.Cost_Total(end)./10^9;];

Y_LB=[SDAVC.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5))./10^6 SDAVC.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5))./10^5 SDAVC.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5))./10^4 SDAVC.PRCT.Cost_Total(ismember(PRCT,2.5),end)./10^9;
   FDAAVC.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5))./10^6 FDAAVC.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5))./10^5 FDAAVC.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5))./10^4 FDAAVC.PRCT.Cost_Total(ismember(PRCT,2.5),end)./10^9;
   S1.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5))./10^6 S1.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5))./10^5 S1.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5))./10^4 S1.PRCT.Cost_Total(ismember(PRCT,2.5),end)./10^9;
   S2.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5))./10^6 S2.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5))./10^5 S2.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5))./10^4 S2.PRCT.Cost_Total(ismember(PRCT,2.5),end)./10^9;
   S3.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5))./10^6 S3.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5))./10^5 S3.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5))./10^4 S3.PRCT.Cost_Total(ismember(PRCT,2.5),end)./10^9;];

Y_UB=[SDAVC.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5))./10^6 SDAVC.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5))./10^5 SDAVC.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5))./10^4 SDAVC.PRCT.Cost_Total(ismember(PRCT,97.5),end)./10^9;
   FDAAVC.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5))./10^6 FDAAVC.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5))./10^5 FDAAVC.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5))./10^4 FDAAVC.PRCT.Cost_Total(ismember(PRCT,97.5),end)./10^9;
   S1.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5))./10^6 S1.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5))./10^5 S1.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5))./10^4 S1.PRCT.Cost_Total(ismember(PRCT,97.5),end)./10^9;
   S2.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5))./10^6 S2.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5))./10^5 S2.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5))./10^4 S2.PRCT.Cost_Total(ismember(PRCT,97.5),end)./10^9;
   S3.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5))./10^6 S3.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5))./10^5 S3.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5))./10^4 S3.PRCT.Cost_Total(ismember(PRCT,97.5),end)./10^9;];

Incidence=cell(size(Strategy));
Hospitalizations=cell(size(Strategy));
Deaths=cell(size(Strategy));
Direct_Costs=cell(size(Strategy));
Time_Dose=cell(size(Strategy));

for ii=1:length(Strategy)
    Incidence{ii}=[num2str(Y(ii,1),'%4.2f') '(' num2str(Y_LB(ii,1),'%4.2f') char(8211) num2str(Y_UB(ii,1),'%4.2f') ')'];
    Hospitalizations{ii}=[num2str(Y(ii,2),'%4.2f') '(' num2str(Y_LB(ii,2),'%4.2f') char(8211) num2str(Y_UB(ii,2),'%4.2f') ')'];
    Deaths{ii}=[num2str(Y(ii,3),'%3.2f') '(' num2str(Y_LB(ii,3),'%3.2f') char(8211) num2str(Y_UB(ii,3),'%3.2f') ')'];
    Direct_Costs{ii}=[num2str(Y(ii,4),'%3.2f') '(' num2str(Y_LB(ii,4),'%3.2f') char(8211) num2str(Y_UB(ii,4),'%3.2f') ')'];
    Time_Dose{ii}=[num2str(Times_Dose_v(ii),'%4.0f') ' days'];
end

T=table(Strategy,Incidence,Hospitalizations,Deaths,Direct_Costs,Time_Dose);
writetable(T,'Table_2.xlsx');
end

