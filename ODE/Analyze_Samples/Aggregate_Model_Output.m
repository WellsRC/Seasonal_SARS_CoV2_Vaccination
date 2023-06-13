function [Filtered_Output_All]=Aggregate_Model_Output(gg,ss,NS,Filtered_Output_All,MO,Av,ACg)
for tt=1:9
    [Filtered_Output_All.Cost_Total(ss+NS.*(gg-1),tt),Filtered_Output_All.Cost_Age(ss+NS.*(gg-1),:,tt),Filtered_Output_All.Cost_Compliment_Age(ss+NS.*(gg-1),:,tt)]=Calculate_Cost(MO.Age_Cumulative_Incidence(:,tt),MO.Age_Cumulative_Hospital(:,tt),MO.Age_Cumulative_Death(:,tt),ACg,Av);


    % Age stratification
    for aa=1:length(ACg(:,1))
        % Age classes
        Filtered_Output_All.Incidence_Cumulative_Count_Age(ss+NS.*(gg-1),aa,tt)=sum(MO.Age_Cumulative_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),tt));
        Filtered_Output_All.Death_Cumulative_Count_Age(ss+NS.*(gg-1),aa,tt)=sum(MO.Age_Cumulative_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),tt));
        Filtered_Output_All.Hospital_Cumulative_Count_Age(ss+NS.*(gg-1),aa,tt)=sum(MO.Age_Cumulative_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),tt));
        
        % Compliment of age classes
        Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa,tt)=sum(MO.Age_Cumulative_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),tt));
        Filtered_Output_All.Death_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa,tt)=sum(MO.Age_Cumulative_Death(ACg(aa,1)>Av | Av>ACg(aa,2),tt));
        Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa,tt)=sum(MO.Age_Cumulative_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),tt));
    end

end

% Age stratification
for aa=1:length(ACg(:,1))
    % Age classes
    Filtered_Output_All.Recovered(ss+NS.*(gg-1),aa,:)=sum(MO.Rec_Age(:,ACg(aa,1)<=Av & Av<=ACg(aa,2)),2);
    
end

Filtered_Output_All.Incidence(ss+NS.*(gg-1),:)=MO.Incidence;
Filtered_Output_All.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Hospital_Count;
Filtered_Output_All.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Hospital_Burden;
Filtered_Output_All.Hospital_Admission(ss+NS.*(gg-1),:)=MO.Hospital_Admission;
Filtered_Output_All.Death(ss+NS.*(gg-1),:)=MO.Death;
Filtered_Output_All.Incidence_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Incidence);
Filtered_Output_All.Hospital_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Hospital_Count);
Filtered_Output_All.Death_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Death);
end