function Comparison_Calculations(Alt_Model,Base_Model,Scenario_Name)

PRCT=sort([1:99 2.5 97.5]);

Cumulative_Count_Incidence_dt=Alt_Model.Incidence_Cumulative_Count-Base_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hosptial_dt=Alt_Model.Hospital_Cumulative_Count-Base_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_dt=Alt_Model.Death_Cumulative_Count-Base_Model.Death_Cumulative_Count;
Cost_dt=Alt_Model.Cost-Base_Model.Cost;

Cumulative_Count_Incidence_rel=Cumulative_Count_Incidence_dt./Base_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hospital_rel=Cumulative_Count_Hosptial_dt./Base_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_rel=Cumulative_Count_Death_dt./Base_Model.Death_Cumulative_Count;
Cost_rel=Cost_dt./Base_Model.Cost;

Age_Cumulative_Count_Incidence_dt=Alt_Model.Incidence_Cumulative_Count_Age-Base_Model.Incidence_Cumulative_Count_Age;
Age_Cumulative_Count_Hospital_dt=Alt_Model.Hospital_Cumulative_Count_Age-Base_Model.Hospital_Cumulative_Count_Age;
Age_Cumulative_Count_Death_dt=Alt_Model.Death_Cumulative_Count_Age-Base_Model.Death_Cumulative_Count_Age;

Compliment_Age_Cumulative_Count_Incidence_dt=Alt_Model.Incidence_Cumulative_Count_Compliment_Age-Base_Model.Incidence_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Hospital_dt=Alt_Model.Hospital_Cumulative_Count_Compliment_Age-Base_Model.Hospital_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Death_dt=Alt_Model.Death_Cumulative_Count_Compliment_Age-Base_Model.Death_Cumulative_Count_Compliment_Age;

Age_Cumulative_Count_Incidence_rel=Age_Cumulative_Count_Incidence_dt./Base_Model.Incidence_Cumulative_Count_Age;
Age_Cumulative_Count_Hospital_rel=Age_Cumulative_Count_Hospital_dt./Base_Model.Hospital_Cumulative_Count_Age;
Age_Cumulative_Count_Death_rel=Age_Cumulative_Count_Death_dt./Base_Model.Death_Cumulative_Count_Age;

Compliment_Age_Cumulative_Count_Incidence_rel=Compliment_Age_Cumulative_Count_Incidence_dt./Base_Model.Incidence_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Hospital_rel=Compliment_Age_Cumulative_Count_Hospital_dt./Base_Model.Hospital_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Death_rel=Compliment_Age_Cumulative_Count_Death_dt./Base_Model.Death_Cumulative_Count_Compliment_Age;

Comparison.Average.Cumulative_Count_Incidence_dt=mean(Cumulative_Count_Incidence_dt,1);
Comparison.Average.Cumulative_Count_Hospital_dt=mean(Cumulative_Count_Hosptial_dt,1);
Comparison.Average.Cumulative_Count_Death_dt=mean(Cumulative_Count_Death_dt,1);
Comparison.Average.Cumulative_Cost_dt=mean(Cost_dt,1);

Comparison.Average.Cumulative_Count_Incidence_rel=mean(Cumulative_Count_Incidence_rel,1);
Comparison.Average.Cumulative_Count_Hospital_rel=mean(Cumulative_Count_Hospital_rel,1);
Comparison.Average.Cumulative_Count_Death_rel=mean(Cumulative_Count_Death_rel,1);
Comparison.Average.Cost_rel=mean(Cost_rel,1);

Comparison.Average.Age_Cumulative_Count_Incidence_dt=mean(Age_Cumulative_Count_Incidence_dt,1);
Comparison.Average.Age_Cumulative_Count_Hospital_dt=mean(Age_Cumulative_Count_Hospital_dt,1);
Comparison.Average.Age_Cumulative_Count_Death_dt=mean(Age_Cumulative_Count_Death_dt,1);

Comparison.Average.Age_Cumulative_Count_Incidence_rel=mean(Age_Cumulative_Count_Incidence_rel,1);
Comparison.Average.Age_Cumulative_Count_Hospital_rel=mean(Age_Cumulative_Count_Hospital_rel,1);
Comparison.Average.Age_Cumulative_Count_Death_rel=mean(Age_Cumulative_Count_Death_rel,1);

Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt=mean(Compliment_Age_Cumulative_Count_Incidence_dt,1);
Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt=mean(Compliment_Age_Cumulative_Count_Hospital_dt,1);
Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt=mean(Compliment_Age_Cumulative_Count_Death_dt,1);

Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_rel=mean(Compliment_Age_Cumulative_Count_Incidence_rel,1);
Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_rel=mean(Compliment_Age_Cumulative_Count_Hospital_rel,1);
Comparison.Average.Compliment_Age_Cumulative_Count_Death_rel=mean(Compliment_Age_Cumulative_Count_Death_rel,1);

Comparison.PRCT.Cumulative_Count_Incidence_dt=prctile(Cumulative_Count_Incidence_dt,PRCT);
Comparison.PRCT.Cumulative_Count_Hospital_dt=prctile(Cumulative_Count_Hosptial_dt,PRCT);
Comparison.PRCT.Cumulative_Count_Death_dt=prctile(Cumulative_Count_Death_dt,PRCT);
Comparison.PRCT.Cost_dt=prctile(Cost_dt,PRCT);

Comparison.PRCT.Cumulative_Count_Incidence_rel=prctile(Cumulative_Count_Incidence_rel,PRCT);
Comparison.PRCT.Cumulative_Count_Hospital_rel=prctile(Cumulative_Count_Hospital_rel,PRCT);
Comparison.PRCT.Cumulative_Count_Death_rel=prctile(Cumulative_Count_Death_rel,PRCT);
Comparison.PRCT.Cost_rel=prctile(Cost_rel,PRCT);

Comparison.PRCT.Age_Cumulative_Count_Incidence_dt=prctile(Age_Cumulative_Count_Incidence_dt,PRCT);
Comparison.PRCT.Age_Cumulative_Count_Hospital_dt=prctile(Age_Cumulative_Count_Hospital_dt,PRCT);
Comparison.PRCT.Age_Cumulative_Count_Death_dt=prctile(Age_Cumulative_Count_Death_dt,PRCT);

Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=prctile(Age_Cumulative_Count_Incidence_rel,PRCT);
Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=prctile(Age_Cumulative_Count_Hospital_rel,PRCT);
Comparison.PRCT.Age_Cumulative_Count_Death_rel=prctile(Age_Cumulative_Count_Death_rel,PRCT);

Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt=prctile(Compliment_Age_Cumulative_Count_Incidence_dt,PRCT);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt=prctile(Compliment_Age_Cumulative_Count_Hospital_dt,PRCT);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt=prctile(Compliment_Age_Cumulative_Count_Death_dt,PRCT);

Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_rel=prctile(Compliment_Age_Cumulative_Count_Incidence_rel,PRCT);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_rel=prctile(Compliment_Age_Cumulative_Count_Hospital_rel,PRCT);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_rel=prctile(Compliment_Age_Cumulative_Count_Death_rel,PRCT);

xbin_edges=[-1.005:0.01:1.505];
[Comparison.Histogram.Cumulative_Count_Incidence_rel,~] = histcounts(Cumulative_Count_Incidence_rel,xbin_edges);
[Comparison.Histogram.Cumulative_Count_Hospital_rel,~] = histcounts(Cumulative_Count_Hospital_rel,xbin_edges);
[Comparison.Histogram.Cumulative_Count_Death_rel,~] = histcounts(Cumulative_Count_Death_rel,xbin_edges);
[Comparison.Histogram.Cost_rel,~] = histcounts(Cost_rel,xbin_edges);

Comparison.Histogram.Age_Cumulative_Count_Incidence_rel=zeros(length(Age_Cumulative_Count_Incidence_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Age_Cumulative_Count_Hospital_rel=zeros(length(Age_Cumulative_Count_Hospital_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Age_Cumulative_Count_Death_rel=zeros(length(Age_Cumulative_Count_Death_rel(1,:)),length(xbin_edges)-1);

Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel=zeros(length(Compliment_Age_Cumulative_Count_Incidence_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel=zeros(length(Compliment_Age_Cumulative_Count_Hospital_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel=zeros(length(Compliment_Age_Cumulative_Count_Death_rel(1,:)),length(xbin_edges)-1);

for aa=1:size(Age_Cumulative_Count_Incidence_rel,2)
    [Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(aa,:),~] = histcounts(Age_Cumulative_Count_Incidence_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(aa,:),~] = histcounts(Age_Cumulative_Count_Hospital_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Age_Cumulative_Count_Death_rel(aa,:),~] = histcounts(Age_Cumulative_Count_Death_rel(:,aa),xbin_edges);
    
    [Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(aa,:),~] = histcounts(Compliment_Age_Cumulative_Count_Incidence_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(aa,:),~] = histcounts(Compliment_Age_Cumulative_Count_Hospital_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(aa,:),~] = histcounts(Compliment_Age_Cumulative_Count_Death_rel(:,aa),xbin_edges);
end

save(['Comparison_Summary_' Scenario_Name '.mat'],'Comparison','PRCT','xbin_edges');
end