function [Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer]=Output_Peak_Filter(Filtered_Output_All,R_WP,Peaks)

Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence=Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Burden(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Admission(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Death=Filtered_Output_All.Annual_Booster.Low_Coverage.Death(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count(Peaks==1,:);

Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence=Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Burden(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Admission(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Death=Filtered_Output_All.Continual_Booster.Low_Coverage.Death(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count(Peaks==1,:);

Filtered_Output_All.Annual_Booster.High_Coverage.Incidence=Filtered_Output_All.Annual_Booster.High_Coverage.Incidence(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Death=Filtered_Output_All.Annual_Booster.High_Coverage.Death(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count(Peaks==1,:);

Filtered_Output_All.Continual_Booster.High_Coverage.Incidence=Filtered_Output_All.Continual_Booster.High_Coverage.Incidence(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Burden(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Admission(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Death=Filtered_Output_All.Continual_Booster.High_Coverage.Death(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count(Peaks==1,:);

Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(Peaks==1,:);

Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(Peaks==1,:);

Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(Peaks==1,:);

Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age(Peaks==1,:);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(Peaks==1,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Winter and summer peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Filtered_Output_Large_Winter=Filtered_Output_All;
Filtered_Output_Large_Summer=Filtered_Output_All;

Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Incidence=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Incidence(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Burden(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Admission(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Death=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Death(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Death_Cumulative_Count(R_WP<0,:);

Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Burden(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Admission(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count(R_WP<0,:);

Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Burden(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Admission(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count(R_WP<0,:);

Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Incidence=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Incidence(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Burden(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Admission(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Death=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Death(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Incidence_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Cumulative_Count(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Death_Cumulative_Count(R_WP<0,:);

Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(R_WP<0,:);

Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(R_WP<0,:);

Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(R_WP<0,:);

Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age(R_WP<0,:);
Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Summer.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(R_WP<0,:);

Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Incidence=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Incidence(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Burden(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Admission(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Death=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Death(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Death_Cumulative_Count(R_WP>0,:);

Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Burden=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Burden(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Admission=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Admission(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count(R_WP>0,:);

Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Burden(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Admission(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count(R_WP>0,:);

Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Incidence=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Incidence(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Burden=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Burden(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Admission=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Admission(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Death=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Death(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Incidence_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Incidence_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Cumulative_Count(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Death_Cumulative_Count=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Death_Cumulative_Count(R_WP>0,:);

Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(R_WP>0,:);

Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(R_WP>0,:);

Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(R_WP>0,:);

Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age(R_WP>0,:);
Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=Filtered_Output_Large_Winter.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(R_WP>0,:);

end