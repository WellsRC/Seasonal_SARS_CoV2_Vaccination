function [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = Filter_Peaks(NG,NS,Av,ACg)

Filtered_Output_All.Recovered=zeros(NG*NS,6,2);
Filtered_Output_All.Incidence=zeros(NG*NS,365);
Filtered_Output_All.Hospital_Admission=zeros(NG*NS,365);
Filtered_Output_All.Death=zeros(NG*NS,365);
Filtered_Output_All.Incidence_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Hospital_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Death_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Incidence_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Death_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Hospital_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Death_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Cost_Total=zeros(NG*NS,9);
Filtered_Output_All.Cost_Age=zeros(NG*NS,length(ACg(:,1)),9);
Filtered_Output_All.Cost_Compliment_Age=zeros(NG*NS,length(ACg(:,1)),9);

Filtered_Output_All.SD_Natural_Immunity_Age=zeros(NG*NS,length(ACg(:,1)),53);
Filtered_Output_All.Inf_Natural_Immunity_Age=zeros(NG*NS,length(ACg(:,1)),53);
Filtered_Output_All.SD_Vaccine_Immunity_Age=zeros(NG*NS,length(ACg(:,1)),53);
Filtered_Output_All.Inf_Vaccine_Immunity_Age=zeros(NG*NS,length(ACg(:,1)),53);
Filtered_Output_All.Susceptible_Age=zeros(NG*NS,length(ACg(:,1)),53);

P_All=cell(NG*NS,1);

Pks=zeros(NG*NS,1);
Mag_Peaks=NaN.*zeros(NG*NS,2);
Time_Peaks=NaN.*zeros(NG*NS,2);
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
    P_temp=P{1};
    Pop=P_temp.N;
    for ss=1:NS 
        MO=Model_Output{ss};        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1),:),Time_Peaks(ss+NS.*(gg-1),:)]=Hospital_Admission_Peak(MO.Hospital_Admission,T_Run);
        [Filtered_Output_All]=Aggregate_Model_Output_Baseline(gg,ss,NS,Filtered_Output_All,MO,Av,ACg,Pop);        
    end
    P_All([1:NS]+NS.*(gg-1))=P;
end

P_All=P_All(Pks==1);
Mag_Peaks=Mag_Peaks(Pks==1,:);
Time_Peaks=Time_Peaks(Pks==1,:);
R_WP=(Mag_Peaks(:,1)./Mag_Peaks(:,2))-1;

Count_W=(Time_Peaks(:,1)>=datenum('December 1, 2022') & Time_Peaks(:,1)<datenum('March 1, 2023'));
Count_WN=(Time_Peaks(:,1)>=datenum('November 1, 2022') & Time_Peaks(:,1)<datenum('December 1, 2022'));
Count_WO=(Time_Peaks(:,1)>=datenum('October 1, 2022') & Time_Peaks(:,1)<datenum('November 1, 2022'));
Count_WS=(Time_Peaks(:,1)>=datenum('September 1, 2022') & Time_Peaks(:,1)<datenum('October 1, 2022'));

Count_WM=(Time_Peaks(:,1)>=datenum('March 1, 2023') & Time_Peaks(:,1)<datenum('April 1, 2023'));


p_N=min((0.75.*sum(Count_W)./sum(Count_WN))./3,1); % need monthly average
p_O=min((0.5.*sum(Count_W)./sum(Count_WO))./3,1); % need monthly average
p_S=min((0.25.*sum(Count_W)./sum(Count_WS))./3,1); % need monthly average

p_M=min((0.5.*sum(Count_W)./sum(Count_WM))./3,1); % need monthly average

Weighted_Winter_Peak=zeros(size(Time_Peaks(:,1)));
Weighted_Winter_Peak(Count_W)=1;
Weighted_Winter_Peak(Count_WN)=p_N;
Weighted_Winter_Peak(Count_WO)=p_O;
Weighted_Winter_Peak(Count_WS)=p_S;

Weighted_Winter_Peak(Count_WM)=p_M;

Count_S=(Time_Peaks(:,2)>=datenum('June 1, 2023') & Time_Peaks(:,2)<datenum('September 1, 2023'));
Count_SM=(Time_Peaks(:,2)>=datenum('May 1, 2023') & Time_Peaks(:,2)<datenum('June 1, 2023'));
Count_SA=(Time_Peaks(:,2)>=datenum('April 1, 2023') & Time_Peaks(:,2)<datenum('May 1, 2023'));

p_M=min((0.66.*sum(Count_S)./sum(Count_SM))./3,1);
p_A=min((0.33.*sum(Count_S)./sum(Count_SA))./3,1);

Weighted_Summer_Peak=zeros(size(Time_Peaks(:,2)));
Weighted_Summer_Peak(Count_S)=1;
Weighted_Summer_Peak(Count_SM)=p_M;
Weighted_Summer_Peak(Count_SA)=p_A;

RSW=rand(size(R_WP));
RSS=rand(size(R_WP));
Weighted_Selection= double((RSW<=Weighted_Winter_Peak) & (RSS<=Weighted_Summer_Peak));

R_WP=R_WP.*Weighted_Selection;

P_Large_Winter=P_All(R_WP>0);
P_Large_Summer=P_All(R_WP<0);

Filtered_Output_All=Output_Peak_Filter(Filtered_Output_All,Pks);
Filtered_Output_Large_Winter=Output_Peak_Filter(Filtered_Output_All,R_WP>0);
Filtered_Output_Large_Summer=Output_Peak_Filter(Filtered_Output_All,R_WP<0);

R_WP=R_WP(Weighted_Selection==1);
P_All=P_All(Weighted_Selection==1);

save('Parameter_Filtered.mat','P_All','P_Large_Winter','P_Large_Summer','R_WP','T_Run');

end

