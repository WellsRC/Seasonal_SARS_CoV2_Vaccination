function [Filtered_Output_All]=Aggregate_Model_Output(ss,Filtered_Output_All,MO,Av,ACg,Pop)
for tt=1:9
    [Filtered_Output_All.Cost_Total(ss,tt),Filtered_Output_All.Cost_Age(ss,:,tt),Filtered_Output_All.Cost_Compliment_Age(ss,:,tt)]=Calculate_Cost(MO.Age_Cumulative_Incidence(:,tt),MO.Age_Cumulative_Hospital(:,tt),MO.Age_Cumulative_Death(:,tt),ACg,Av);


    % Age stratification
    for aa=1:length(ACg(:,1))
        % Age classes
        Filtered_Output_All.Incidence_Cumulative_Count_Age(ss,aa,tt)=sum(MO.Age_Cumulative_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),tt));
        Filtered_Output_All.Death_Cumulative_Count_Age(ss,aa,tt)=sum(MO.Age_Cumulative_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),tt));
        Filtered_Output_All.Hospital_Cumulative_Count_Age(ss,aa,tt)=sum(MO.Age_Cumulative_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),tt));
        
        % Compliment of age classes
        Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age(ss,aa,tt)=sum(MO.Age_Cumulative_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),tt));
        Filtered_Output_All.Death_Cumulative_Count_Compliment_Age(ss,aa,tt)=sum(MO.Age_Cumulative_Death(ACg(aa,1)>Av | Av>ACg(aa,2),tt));
        Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age(ss,aa,tt)=sum(MO.Age_Cumulative_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),tt));
    end

end

for tt=1:53
    % Age stratification
    for aa=1:length(ACg(:,1))
        Filtered_Output_All.SD_Natural_Immunity_Age(ss,aa,tt)=sum(MO.SD_Natural_Immunity(ACg(aa,1)>Av | Av>ACg(aa,2),1+7.*(tt-1)))./sum(Pop(ACg(aa,1)>Av | Av>ACg(aa,2)));
        Filtered_Output_All.Inf_Natural_Immunity_Age(ss,aa,tt)=sum(MO.Infection_Natural_Immunity(ACg(aa,1)>Av | Av>ACg(aa,2),1+7.*(tt-1)))./sum(Pop(ACg(aa,1)>Av | Av>ACg(aa,2)));

        Filtered_Output_All.SD_Vaccine_Immunity_Age(ss,aa,tt)=sum(MO.SD_Vaccine_Immunity(ACg(aa,1)>Av | Av>ACg(aa,2),1+7.*(tt-1)))./sum(Pop(ACg(aa,1)>Av | Av>ACg(aa,2)));
        Filtered_Output_All.Inf_Vaccine_Immunity_Age(ss,aa,tt)=sum(MO.Infection_Vaccine_Immunity(ACg(aa,1)>Av | Av>ACg(aa,2),1+7.*(tt-1)))./sum(Pop(ACg(aa,1)>Av | Av>ACg(aa,2)));

        Filtered_Output_All.Susceptible_Age(ss,aa,tt)=sum(MO.Fully_Susceptible(ACg(aa,1)>Av | Av>ACg(aa,2),1+7.*(tt-1)))./sum(Pop(ACg(aa,1)>Av | Av>ACg(aa,2)));
    end

end

Filtered_Output_All.Incidence(ss,:)=MO.Incidence;
Filtered_Output_All.Hospital_Admission(ss,:)=MO.Hospital_Admission;
Filtered_Output_All.Death(ss,:)=MO.Death;
Filtered_Output_All.Incidence_Cumulative_Count(ss,:)=sum(MO.Incidence);
Filtered_Output_All.Hospital_Cumulative_Count(ss,:)=sum(MO.Hospital_Count);
Filtered_Output_All.Death_Cumulative_Count(ss,:)=sum(MO.Death);
end