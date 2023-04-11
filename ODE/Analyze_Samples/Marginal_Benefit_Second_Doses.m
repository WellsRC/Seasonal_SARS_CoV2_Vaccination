function Marginal_Benefit_Second_Doses(Filtered_Output_65,Filtered_Output_50,Filtered_Output_50_to_64,Baseline_Output_All, SA_Scenario)
PRCT=sort([1:99 2.5 97.5]);

Marginal_Benefit_Incidence=(Filtered_Output_65.Incidence_Cumulative_Count-Filtered_Output_50.Incidence_Cumulative_Count)./(Baseline_Output_All.Incidence_Cumulative_Count-Filtered_Output_50_to_64.Incidence_Cumulative_Count)-1;
Marginal_Benefit_Hospitalization=(Filtered_Output_65.Hospital_Cumulative_Count-Filtered_Output_50.Hospital_Cumulative_Count)./(Baseline_Output_All.Hospital_Cumulative_Count-Filtered_Output_50_to_64.Hospital_Cumulative_Count)-1;
Marginal_Benefit_Death=(Filtered_Output_65.Death_Cumulative_Count-Filtered_Output_50.Death_Cumulative_Count)./(Baseline_Output_All.Death_Cumulative_Count-Filtered_Output_50_to_64.Death_Cumulative_Count)-1;
Marginal_Benefit_Cost=(Filtered_Output_65.Cost_Total-Filtered_Output_50.Cost_Total)./(Baseline_Output_All.Cost_Total-Filtered_Output_50_to_64.Cost_Total)-1;

Marginal_Benefit.Average.Incidence=mean(Marginal_Benefit_Incidence);
Marginal_Benefit.Average.Hospitalization=mean(Marginal_Benefit_Hospitalization);
Marginal_Benefit.Average.Death=mean(Marginal_Benefit_Death);
Marginal_Benefit.Average.Cost=mean(Marginal_Benefit_Cost);

Marginal_Benefit.PRCT.Incidence=prctile(Marginal_Benefit_Incidence,PRCT);
Marginal_Benefit.PRCT.Hospitalization=prctile(Marginal_Benefit_Hospitalization,PRCT);
Marginal_Benefit.PRCT.Death=prctile(Marginal_Benefit_Death,PRCT);
Marginal_Benefit.PRCT.Cost=prctile(Marginal_Benefit_Cost,PRCT);


Marginal_Benefit.Histogram.Incidence=fitdist(Marginal_Benefit_Incidence,'Kernel','Kernel','epanechnikov');
Marginal_Benefit.Histogram.Hospitalization=fitdist(Marginal_Benefit_Hospitalization,'Kernel','Kernel','epanechnikov');
Marginal_Benefit.Histogram.Death=fitdist(Marginal_Benefit_Death,'Kernel','Kernel','epanechnikov');
Marginal_Benefit.Histogram.Cost=fitdist(Marginal_Benefit_Cost,'Kernel','Kernel','epanechnikov');

Marginal_Benefit.Less_than_zero.Incidence=mean(Marginal_Benefit_Incidence<0);
Marginal_Benefit.Less_than_zero.Hospitalization=mean(Marginal_Benefit_Hospitalization<0);
Marginal_Benefit.Less_than_zero.Death=mean(Marginal_Benefit_Death<0);
Marginal_Benefit.Less_than_zero.Cost=mean(Marginal_Benefit_Cost<0);

save(['Marginal_Benefit_' SA_Scenario '.mat'],'Marginal_Benefit','PRCT');
end