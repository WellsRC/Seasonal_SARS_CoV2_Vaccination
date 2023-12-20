function [Filtered_Output_All] = SA_Output(SA_Scenario,Av,ACg,max_file)

temp_cd=pwd;
load([temp_cd(1:end-19) 'Contact_Matrix/Contact_USA_85.mat'],'N');
for mm=1:max_file
    load([temp_cd(1:end-15) '/' SA_Scenario '_' num2str(mm) '.mat'],'Model_Output');
    if(mm==1)
        Model_Output_A=Model_Output;
    else
        Model_Output_A=[Model_Output_A; Model_Output];
    end

end
NN=length(Model_Output_A);

Filtered_Output_All.Recovered=zeros(NN,6,2);
Filtered_Output_All.Incidence=zeros(NN,365);
Filtered_Output_All.Hospital_Admission=zeros(NN,365);
Filtered_Output_All.Hospital_Count=zeros(NN,365);
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

Filtered_Output_All.SD_Natural_Immunity=zeros(NN,53);
Filtered_Output_All.Inf_Natural_Immunity=zeros(NN,53);
Filtered_Output_All.SD_Vaccine_Immunity=zeros(NN,53);
Filtered_Output_All.Inf_Vaccine_Immunity=zeros(NN,53);
Filtered_Output_All.Susceptible=zeros(NN,53);

Filtered_Output_All.SD_Natural_Immunity_Age=zeros(NN,length(ACg(:,1)),53);
Filtered_Output_All.Inf_Natural_Immunity_Age=zeros(NN,length(ACg(:,1)),53);
Filtered_Output_All.SD_Vaccine_Immunity_Age=zeros(NN,length(ACg(:,1)),53);
Filtered_Output_All.Inf_Vaccine_Immunity_Age=zeros(NN,length(ACg(:,1)),53);
Filtered_Output_All.Susceptible_Age=zeros(NN,length(ACg(:,1)),53);

for ss=1:NN 
    MO=Model_Output_A{ss};    
    [Filtered_Output_All]=Aggregate_Model_Output(ss,Filtered_Output_All,MO,Av,ACg,N);
end

end

