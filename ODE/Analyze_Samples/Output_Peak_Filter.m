function [Filtered_Output_All]=Output_Peak_Filter(Filtered_Output_All,Peaks)

Filtered_Output_All.Recovered=Filtered_Output_All.Recovered(Peaks==1,:,:);
Filtered_Output_All.Incidence=Filtered_Output_All.Incidence(Peaks==1,:);
Filtered_Output_All.Hospital_Admission=Filtered_Output_All.Hospital_Admission(Peaks==1,:);
Filtered_Output_All.Death=Filtered_Output_All.Death(Peaks==1,:);
Filtered_Output_All.Incidence_Cumulative_Count=Filtered_Output_All.Incidence_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Hospital_Cumulative_Count=Filtered_Output_All.Hospital_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Death_Cumulative_Count=Filtered_Output_All.Death_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Cost_Total=Filtered_Output_All.Cost_Total(Peaks==1,:);
Filtered_Output_All.Cost_Age=Filtered_Output_All.Cost_Age(Peaks==1,:,:);

Filtered_Output_All.Cost_Compliment_Age=Filtered_Output_All.Cost_Compliment_Age(Peaks==1,:,:);
Filtered_Output_All.Incidence_Cumulative_Count_Age=Filtered_Output_All.Incidence_Cumulative_Count_Age(Peaks==1,:,:);
Filtered_Output_All.Death_Cumulative_Count_Age=Filtered_Output_All.Death_Cumulative_Count_Age(Peaks==1,:,:);
Filtered_Output_All.Hospital_Cumulative_Count_Age=Filtered_Output_All.Hospital_Cumulative_Count_Age(Peaks==1,:,:);

Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age=Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age(Peaks==1,:,:);
Filtered_Output_All.Death_Cumulative_Count_Compliment_Age=Filtered_Output_All.Death_Cumulative_Count_Compliment_Age(Peaks==1,:,:);
Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age=Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age(Peaks==1,:,:);

Filtered_Output_All.SD_Natural_Immunity_Age=Filtered_Output_All.SD_Natural_Immunity_Age(Peaks==1,:,:);
Filtered_Output_All.Inf_Natural_Immunity_Age=Filtered_Output_All.Inf_Natural_Immunity_Age(Peaks==1,:,:);
Filtered_Output_All.SD_Vaccine_Immunity_Age=Filtered_Output_All.SD_Vaccine_Immunity_Age(Peaks==1,:,:);
Filtered_Output_All.Inf_Vaccine_Immunity_Age=Filtered_Output_All.Inf_Vaccine_Immunity_Age(Peaks==1,:,:);
Filtered_Output_All.Susceptible_Age=Filtered_Output_All.Susceptible_Age(Peaks==1,:,:);

end