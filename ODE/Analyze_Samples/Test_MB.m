function Test_MB(Two_Dose_Model,Baseline,Time_Second_Dose,Scenario_Name)

Incidence_Second_Dose_Alt=sum(Two_Dose_Model.Incidence(:,1:Time_Second_Dose),2);
Death_Second_Dose_Alt=sum(Two_Dose_Model.Death(:,1:Time_Second_Dose),2);
Hospital_Second_Dose_Alt=sum(Two_Dose_Model.Hospital_Burden(:,1:Time_Second_Dose),2);

Incidence_Second_Dose_Baseline=sum(Baseline.Incidence(:,1:Time_Second_Dose),2);
Death_Second_Dose_Baseline=sum(Baseline.Death(:,1:Time_Second_Dose),2);
Hospital_Second_Dose_Baseline=sum(Baseline.Hospital_Burden(:,1:Time_Second_Dose),2);


Marginal_Benefit.Incidence=1-(Two_Dose_Model.Incidence_Cumulative_Count-Incidence_Second_Dose_Alt)./(Baseline.Incidence_Cumulative_Count-Incidence_Second_Dose_Baseline);
Marginal_Benefit.Hospital=1-(Two_Dose_Model.Hospital_Cumulative_Count-Hospital_Second_Dose_Alt)./(Baseline.Hospital_Cumulative_Count-Hospital_Second_Dose_Baseline);
Marginal_Benefit.Death=1-(Two_Dose_Model.Death_Cumulative_Count-Death_Second_Dose_Alt)./(Baseline.Death_Cumulative_Count-Death_Second_Dose_Baseline);


Marginal_Benefit.Incidence_dt=Baseline.Incidence_Cumulative_Count-Two_Dose_Model.Incidence_Cumulative_Count;
Marginal_Benefit.Hospital_dt=Baseline.Hospital_Cumulative_Count-Two_Dose_Model.Hospital_Cumulative_Count;
Marginal_Benefit.Death_dt=Two_DoseBaseline_Model.Death_Cumulative_Count-Two_Dose_Model.Death_Cumulative_Count;

save(['Marginal_Benefit_65_and_older_' Scenario_Name '.mat'], 'Marginal_Benefit');
end

