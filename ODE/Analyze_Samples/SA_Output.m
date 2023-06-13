function [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario,Av,ACg)

temp_cd=pwd;
load([temp_cd(1:end-15) '/' SA_Scenario '.mat'],'Model_Output','R_WP');
NN=length(R_WP);

Filtered_Output_All.Recovered=zeros(NN,6,2);
Filtered_Output_All.Incidence=zeros(NN,365);
Filtered_Output_All.Hospital_Count=zeros(NN,365);
Filtered_Output_All.Hospital_Burden=zeros(NN,365);
Filtered_Output_All.Hospital_Admission=zeros(NN,365);
Filtered_Output_All.Death=zeros(NN,365);
Filtered_Output_All.Incidence_Cumulative_Count=zeros(NN,1);
Filtered_Output_All.Hospital_Cumulative_Count=zeros(NN,1);
Filtered_Output_All.Death_Cumulative_Count=zeros(NN,1);
Filtered_Output_All.Incidence_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Death_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Hospital_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Death_Cumulative_Count_Compliment_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Cost_Total=zeros(NN,9);
Filtered_Output_All.Cost_Age=zeros(NN,length(ACg(:,1)),9);
Filtered_Output_All.Cost_Compliment_Age=zeros(NN,length(ACg(:,1)),9);

for ss=1:NN 
    MO=Model_Output{ss};    
    [Filtered_Output_All]=Aggregate_Model_Output(1,ss,0,Filtered_Output_All,MO,Av,ACg);
end

Filtered_Output_Large_Winter=Output_Peak_Filter(Filtered_Output_All,R_WP>0);
Filtered_Output_Large_Summer=Output_Peak_Filter(Filtered_Output_All,R_WP<0);

end

