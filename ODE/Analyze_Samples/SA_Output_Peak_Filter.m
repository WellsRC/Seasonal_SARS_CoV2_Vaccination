function [Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer]=SA_Output_Peak_Filter(SA_Scenario,Filtered_Output_All,R_WP)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Winter and summer peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Filtered_Output_Large_Winter=Filtered_Output_All;
Filtered_Output_Large_Summer=Filtered_Output_All;

if(strcmp('Vaccine_Waning',SA_Scenario))
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Burden(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Admission(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count(R_WP<0,:);
end

Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Burden(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Admission(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count(R_WP<0,:);

if(strcmp('Vaccine_Waning',SA_Scenario))
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(R_WP<0,:);
    Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(R_WP<0,:);
end

Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(R_WP<0,:);

if(strcmp('Vaccine_Waning',SA_Scenario))
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Burden(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Admission(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count(R_WP>0,:);
end

Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Burden(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Admission(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count(R_WP>0,:);

if(strcmp('Vaccine_Waning',SA_Scenario))
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(R_WP>0,:);
    Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(R_WP>0,:);
end

Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(R_WP>0,:);
end