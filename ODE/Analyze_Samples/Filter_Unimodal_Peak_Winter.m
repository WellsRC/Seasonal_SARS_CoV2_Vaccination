function [Filtered_Output_All] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg)

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
Mag_Peaks=NaN.*zeros(NG*NS,1);
Time_Peak=NaN.*zeros(NG*NS,1);
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
    P_temp=P{1};
    Pop=P_temp.N;
    for ss=1:NS 
        MO=Model_Output{ss};        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1)),Time_Peak(ss+NS.*(gg-1))]=Hospital_Admission_Unimodal_Winter_Peak(MO.Hospital_Admission,T_Run);      
        [Filtered_Output_All]=Aggregate_Model_Output_Baseline(gg,ss,NS,Filtered_Output_All,MO,Av,ACg,Pop); 
    end
    P_All([1:NS]+NS.*(gg-1))=P;
end

Count_W=(Time_Peak>=datenum('December 1, 2022') & Time_Peak<datenum('March 1, 2023'));
Count_WN=(Time_Peak>=datenum('November 1, 2022') & Time_Peak<datenum('December 1, 2022'));
Count_WO=(Time_Peak>=datenum('October 1, 2022') & Time_Peak<datenum('November 1, 2022'));

Count_WM=(Time_Peak>=datenum('March 1, 2023') & Time_Peak<datenum('April 1, 2023'));
Count_WA=(Time_Peak>=datenum('April 1, 2023') & Time_Peak<datenum('May 1, 2023'));


p_N=min(0.66.*(sum(Count_W(Pks==1))./3)./sum(Count_WN(Pks==1)),1);% need monthly average
p_O=min(0.33*(sum(Count_W(Pks==1))./3)./sum(Count_WO(Pks==1)),1);% need monthly average

p_M=min(0.66.*(sum(Count_W(Pks==1))./3)./sum(Count_WM(Pks==1)),1);% need monthly average
p_A=min(0.33*(sum(Count_W(Pks==1))./3)./sum(Count_WA(Pks==1)),1);% need monthly average

Weighted_Winter_Peak=zeros(size(Pks));
Weighted_Winter_Peak(Count_W)=1;
Weighted_Winter_Peak(Count_WN)=p_N;
Weighted_Winter_Peak(Count_WO)=p_O;


Weighted_Winter_Peak(Count_WM)=p_M;
Weighted_Winter_Peak(Count_WA)=p_A;

RSW=rand(size(Pks));
Weighted_Selection= RSW<=Weighted_Winter_Peak;

Pks(~Weighted_Selection)=0;

[Filtered_Output_All]=Output_Peak_Filter(Filtered_Output_All,Pks);

P_All=P_All(Pks==1);

save(['Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run');

end

