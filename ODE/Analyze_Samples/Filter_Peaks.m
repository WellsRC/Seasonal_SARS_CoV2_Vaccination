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
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
    P_temp=P{1};
    Pop=P_temp.N;
    for ss=1:NS 
        MO=Model_Output{ss};        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1),:)]=Hospital_Admission_Peak(MO.Hospital_Admission,T_Run);
        [Filtered_Output_All]=Aggregate_Model_Output_Baseline(gg,ss,NS,Filtered_Output_All,MO,Av,ACg,Pop);        
    end
    P_All([1:NS]+NS.*(gg-1))=P;
end

P_All=P_All(Pks==1);
Mag_Peaks=Mag_Peaks(Pks==1,:);

R_WP=(Mag_Peaks(:,1)./Mag_Peaks(:,2))-1;
P_Large_Winter=P_All(R_WP>0);
P_Large_Summer=P_All(R_WP<0);
Filtered_Output_All=Output_Peak_Filter(Filtered_Output_All,Pks);
Filtered_Output_Large_Winter=Output_Peak_Filter(Filtered_Output_All,R_WP>0);
Filtered_Output_Large_Summer=Output_Peak_Filter(Filtered_Output_All,R_WP<0);

save('Parameter_Filtered.mat','P_All','P_Large_Winter','P_Large_Summer','R_WP','T_Run');

end

