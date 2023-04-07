function [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer]=Output_Measures_SA(Filtered_Output_All,R_WP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Larger summer peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Filtered_Output_Large_Winter=Filtered_Output_All;
Filtered_Output_Large_Summer=Filtered_Output_All;

Filtered_Output_Large_Summer.Incidence=Filtered_Output_Large_Summer.Incidence(R_WP<0,:);
Filtered_Output_Large_Summer.Hospital_Burden=Filtered_Output_Large_Summer.Hospital_Burden(R_WP<0,:);
Filtered_Output_Large_Summer.Hospital_Admission=Filtered_Output_Large_Summer.Hospital_Admission(R_WP<0,:);
Filtered_Output_Large_Summer.Death=Filtered_Output_Large_Summer.Death(R_WP<0,:);
Filtered_Output_Large_Summer.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Incidence_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Hospital_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Death_Cumulative_Count=Filtered_Output_Large_Summer.Death_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Cost_Total=Filtered_Output_Large_Summer.Cost_Total(R_WP<0);
Filtered_Output_Large_Summer.Cost_Age=Filtered_Output_Large_Summer.Cost_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Cost_Compliment_Age=Filtered_Output_Large_Summer.Cost_Compliment_Age(R_WP<0,:);

Filtered_Output_Large_Summer.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Incidence_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Death_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Hospital_Cumulative_Count_Age(R_WP<0,:);

Filtered_Output_Large_Summer.Incidence_Cumulative_Count_Compliment_Age=Filtered_Output_Large_Summer.Incidence_Cumulative_Count_Compliment_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Death_Cumulative_Count_Compliment_Age=Filtered_Output_Large_Summer.Death_Cumulative_Count_Compliment_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Hospital_Cumulative_Count_Compliment_Age=Filtered_Output_Large_Summer.Hospital_Cumulative_Count_Compliment_Age(R_WP<0,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Larger winter peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Filtered_Output_Large_Winter.Incidence=Filtered_Output_Large_Winter.Incidence(R_WP>0,:);
Filtered_Output_Large_Winter.Hospital_Burden=Filtered_Output_Large_Winter.Hospital_Burden(R_WP>0,:);
Filtered_Output_Large_Winter.Hospital_Admission=Filtered_Output_Large_Winter.Hospital_Admission(R_WP>0,:);
Filtered_Output_Large_Winter.Death=Filtered_Output_Large_Winter.Death(R_WP>0,:);
Filtered_Output_Large_Winter.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Incidence_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Hospital_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Death_Cumulative_Count=Filtered_Output_Large_Winter.Death_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Cost_Total=Filtered_Output_Large_Winter.Cost_Total(R_WP>0);
Filtered_Output_Large_Winter.Cost_Age=Filtered_Output_Large_Winter.Cost_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Cost_Compliment_Age=Filtered_Output_Large_Winter.Cost_Compliment_Age(R_WP>0,:);

Filtered_Output_Large_Winter.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Incidence_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Death_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Hospital_Cumulative_Count_Age(R_WP>0,:);

Filtered_Output_Large_Winter.Incidence_Cumulative_Count_Compliment_Age=Filtered_Output_Large_Winter.Incidence_Cumulative_Count_Compliment_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Death_Cumulative_Count_Compliment_Age=Filtered_Output_Large_Winter.Death_Cumulative_Count_Compliment_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Hospital_Cumulative_Count_Compliment_Age=Filtered_Output_Large_Winter.Hospital_Cumulative_Count_Compliment_Age(R_WP>0,:);
end