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

xbin_edges=[0.755:0.01:1.155]-1;

Marginal_Benefit.Histogram.Incidence=histcounts(Marginal_Benefit_Incidence,xbin_edges);
Marginal_Benefit.Histogram.Hospitalization=histcounts(Marginal_Benefit_Hospitalization,xbin_edges);
Marginal_Benefit.Histogram.Death=histcounts(Marginal_Benefit_Death,xbin_edges);
Marginal_Benefit.Histogram.Cost=histcounts(Marginal_Benefit_Cost,xbin_edges);

Marginal_Benefit.Less_than_zero.Incidence=sum(Marginal_Benefit_Incidence<0)./length(Marginal_Benefit_Incidence);
Marginal_Benefit.Less_than_zero.Hospitalization=sum(Marginal_Benefit_Hospitalization<0)./length(Marginal_Benefit_Hospitalization);
Marginal_Benefit.Less_than_zero.Death=sum(Marginal_Benefit_Death<0)./length(Marginal_Benefit_Death);
Marginal_Benefit.Less_than_zero.Cost=sum(Marginal_Benefit_Cost<0)./length(Marginal_Benefit_Cost);

save(['Marginal_Benefit_' SA_Scenario '.mat'],'Marginal_Benefit','PRCT','xbin_edges');
end