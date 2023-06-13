function [Filtered_Output_All] = SA_Output_U(SA_Scenario,Av,ACg)

temp_cd=pwd;
load([temp_cd(1:end-15) '/' SA_Scenario '.mat'],'Model_Output');
NN=length(Model_Output);

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

end

