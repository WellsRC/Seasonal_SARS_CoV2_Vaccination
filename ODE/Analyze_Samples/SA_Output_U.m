function [Filtered_Output_All] = SA_Output_U(SA_Scenario,Av,ACg)

temp_cd=pwd;
load([temp_cd(1:end-15) '/' SA_Scenario '.mat'],'Model_Output');
NN=length(Model_Output);

Filtered_Output_All.Incidence=zeros(NN,365);
Filtered_Output_All.Hospital_Burden=zeros(NN,365);
Filtered_Output_All.Hospital_Admission=zeros(NN,365);
Filtered_Output_All.Death=zeros(NN,365);
Filtered_Output_All.Incidence_Cumulative_Count=zeros(NN,1);
Filtered_Output_All.Hospital_Cumulative_Count=zeros(NN,1);
Filtered_Output_All.Death_Cumulative_Count=zeros(NN,1);
Filtered_Output_All.Incidence_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Death_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Hospital_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Death_Cumulative_Count_Compliment_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Cost_Total=zeros(NN,1);
Filtered_Output_All.Cost_Age=zeros(NN,length(ACg(:,1)));
Filtered_Output_All.Cost_Compliment_Age=zeros(NN,length(ACg(:,1)));

for ss=1:NN 
    MO=Model_Output{ss};
    
    [Filtered_Output_All.Cost_Total(ss),Filtered_Output_All.Cost_Age(ss,:),Filtered_Output_All.Cost_Compliment_Age(ss,:)]=Calculate_Cost(MO.Age_Incidence(:,end),MO.Age_Hospital(:,end),MO.Age_Death(:,end),ACg,Av);

    Filtered_Output_All.Incidence(ss,:)=MO.Incidence;
    Filtered_Output_All.Hospital_Burden(ss,:)=MO.Hospital_Burden;
    Filtered_Output_All.Hospital_Admission(ss,:)=MO.Hospital_Admission;
    Filtered_Output_All.Death(ss,:)=MO.Death;
    Filtered_Output_All.Incidence_Cumulative_Count(ss,:)=sum(MO.Incidence);
    Filtered_Output_All.Hospital_Cumulative_Count(ss,:)=sum(MO.Hospital_Count);
    Filtered_Output_All.Death_Cumulative_Count(ss,:)=sum(MO.Death);
    
    for aa=1:length(ACg(:,1))
        Filtered_Output_All.Incidence_Cumulative_Count_Age(ss,aa)=sum(MO.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
        Filtered_Output_All.Death_Cumulative_Count_Age(ss,aa)=sum(MO.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
        Filtered_Output_All.Hospital_Cumulative_Count_Age(ss,aa)=sum(MO.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end)); 

        Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age(ss,aa)=sum(MO.Age_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),end));
        Filtered_Output_All.Death_Cumulative_Count_Compliment_Age(ss,aa)=sum(MO.Age_Death(ACg(aa,1)>Av | Av>ACg(aa,2),end));
        Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age(ss,aa)=sum(MO.Age_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),end));
    end
end

end

