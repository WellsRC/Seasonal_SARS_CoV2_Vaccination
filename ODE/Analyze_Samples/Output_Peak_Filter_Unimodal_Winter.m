function [Filtered_Output_All]=Output_Peak_Filter_Unimodal_Winter(Filtered_Output_All,Peaks)

Filtered_Output_All.Incidence=Filtered_Output_All.Incidence(Peaks==1,:);
Filtered_Output_All.Hospital_Burden=Filtered_Output_All.Hospital_Burden(Peaks==1,:);
Filtered_Output_All.Hospital_Admission=Filtered_Output_All.Hospital_Admission(Peaks==1,:);
Filtered_Output_All.Death=Filtered_Output_All.Death(Peaks==1,:);
Filtered_Output_All.Incidence_Cumulative_Count=Filtered_Output_All.Incidence_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Hospital_Cumulative_Count=Filtered_Output_All.Hospital_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Death_Cumulative_Count=Filtered_Output_All.Death_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Cost=Filtered_Output_All.Cost(Peaks==1,:);

Filtered_Output_All.Incidence_Cumulative_Count_Age=Filtered_Output_All.Incidence_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Death_Cumulative_Count_Age=Filtered_Output_All.Death_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Hospital_Cumulative_Count_Age=Filtered_Output_All.Hospital_Cumulative_Count_Age(Peaks==1,:);

Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age=Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age(Peaks==1,:);
Filtered_Output_All.Death_Cumulative_Count_Compliment_Age=Filtered_Output_All.Death_Cumulative_Count_Compliment_Age(Peaks==1,:);
Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age=Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age(Peaks==1,:);

end