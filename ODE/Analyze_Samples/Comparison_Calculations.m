function Comparison_Calculations(Alt_Model,Base_Model,Scenario_Name)

PRCT=sort([1:99 2.5 97.5]);

Cumulative_Count_Incidence_dt=Alt_Model.Incidence_Cumulative_Count-Base_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hospital_dt=Alt_Model.Hospital_Cumulative_Count-Base_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_dt=Alt_Model.Death_Cumulative_Count-Base_Model.Death_Cumulative_Count;
Cost_Total_dt=Alt_Model.Cost_Total-Base_Model.Cost_Total;
Cost_Age_dt=Alt_Model.Cost_Age-Base_Model.Cost_Age;
Cost_Compliment_Age_dt=Alt_Model.Cost_Compliment_Age-Base_Model.Cost_Compliment_Age;

Cumulative_Count_Incidence_rel=Cumulative_Count_Incidence_dt./Base_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hospital_rel=Cumulative_Count_Hospital_dt./Base_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_rel=Cumulative_Count_Death_dt./Base_Model.Death_Cumulative_Count;
Cost_Total_rel=Cost_Total_dt./Base_Model.Cost_Total;
Cost_Age_rel=Cost_Age_dt./Base_Model.Cost_Age;
Cost_Compliment_Age_rel=Cost_Compliment_Age_dt./Base_Model.Cost_Compliment_Age;

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
Comparison.Average.Cumulative_Count_Hospital_dt=mean(Cumulative_Count_Hospital_dt,1);
Comparison.Average.Cumulative_Count_Death_dt=mean(Cumulative_Count_Death_dt,1);
Comparison.Average.Cost_Total_dt=mean(Cost_Total_dt,1);
Comparison.Average.Cost_Age_dt=mean(Cost_Age_dt,1);
Comparison.Average.Cost_Compliment_Age_dt=mean(Cost_Compliment_Age_dt,1);

Comparison.Average.Cumulative_Count_Incidence_rel=mean(Cumulative_Count_Incidence_rel,1);
Comparison.Average.Cumulative_Count_Hospital_rel=mean(Cumulative_Count_Hospital_rel,1);
Comparison.Average.Cumulative_Count_Death_rel=mean(Cumulative_Count_Death_rel,1);
Comparison.Average.Cost_Total_rel=mean(Cost_Total_rel,1);
Comparison.Average.Cost_Age_rel=mean(Cost_Age_rel,1);
Comparison.Average.Cost_Compliment_Age_rel=mean(Cost_Compliment_Age_rel,1);

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
Comparison.PRCT.Cumulative_Count_Hospital_dt=prctile(Cumulative_Count_Hospital_dt,PRCT);
Comparison.PRCT.Cumulative_Count_Death_dt=prctile(Cumulative_Count_Death_dt,PRCT);
Comparison.PRCT.Cost_Total_dt=prctile(Cost_Total_dt,PRCT);
Comparison.PRCT.Cost_Age_dt=prctile(Cost_Age_dt,PRCT);
Comparison.PRCT.Cost_Compliment_Age_dt=prctile(Cost_Compliment_Age_dt,PRCT);

Comparison.PRCT.Cumulative_Count_Incidence_rel=prctile(Cumulative_Count_Incidence_rel,PRCT);
Comparison.PRCT.Cumulative_Count_Hospital_rel=prctile(Cumulative_Count_Hospital_rel,PRCT);
Comparison.PRCT.Cumulative_Count_Death_rel=prctile(Cumulative_Count_Death_rel,PRCT);
Comparison.PRCT.Cost_Total_rel=prctile(Cost_Total_rel,PRCT);
Comparison.PRCT.Cost_Age_rel=prctile(Cost_Age_rel,PRCT);
Comparison.PRCT.Cost_Compliment_Age_rel=prctile(Cost_Compliment_Age_rel,PRCT);

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
[Comparison.Histogram.Cost_rel,~] = histcounts(Cost_Total_rel,xbin_edges);

Comparison.Histogram.Age_Cumulative_Count_Incidence_rel=zeros(length(Age_Cumulative_Count_Incidence_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Age_Cumulative_Count_Hospital_rel=zeros(length(Age_Cumulative_Count_Hospital_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Age_Cumulative_Count_Death_rel=zeros(length(Age_Cumulative_Count_Death_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Cost_Age_rel=zeros(length(Cost_Age_rel(1,:)),length(xbin_edges)-1);

Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel=zeros(length(Compliment_Age_Cumulative_Count_Incidence_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel=zeros(length(Compliment_Age_Cumulative_Count_Hospital_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel=zeros(length(Compliment_Age_Cumulative_Count_Death_rel(1,:)),length(xbin_edges)-1);
Comparison.Histogram.Cost_Compliment_Age_rel=zeros(length(Cost_Compliment_Age_rel(1,:)),length(xbin_edges)-1);


Comparison.Alternative_Worse.Cumulative_Count_Incidence=sum(Cumulative_Count_Incidence_dt>0)./length(Cumulative_Count_Incidence_dt);
Comparison.Alternative_Worse.Cumulative_Count_Hospital=sum(Cumulative_Count_Hospital_dt>0)./length(Cumulative_Count_Hospital_dt);
Comparison.Alternative_Worse.Cumulative_Count_Death_dt=sum(Cumulative_Count_Death_dt>0)./length(Cumulative_Count_Death_dt);
Comparison.Alternative_Worse.Cost_Total_dt=sum(Cost_Total_dt>0)./length(Cost_Total_dt);

Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence=zeros(1,size(Age_Cumulative_Count_Incidence_rel,2));
Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital=zeros(1,size(Age_Cumulative_Count_Hospital_rel,2));
Comparison.Alternative_Worse.Age_Cumulative_Count_Death=zeros(1,size(Age_Cumulative_Count_Death_rel,2));
Comparison.Alternative_Worse.Cost_Age=zeros(1,size(Cost_Age_rel,2));

Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Incidence=zeros(1,size(Compliment_Age_Cumulative_Count_Incidence_rel,2));
Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Hospital=zeros(1,size(Compliment_Age_Cumulative_Count_Hospital_rel,2));
Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Death=zeros(1,size(Compliment_Age_Cumulative_Count_Death_rel,2));
Comparison.Alternative_Worse.Cost_Compliment_Age=zeros(1,size(Cost_Compliment_Age_rel,2));


for aa=1:size(Age_Cumulative_Count_Incidence_rel,2)
    
    Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence(aa)=sum(Age_Cumulative_Count_Incidence_dt(:,aa)>0)./length(Age_Cumulative_Count_Incidence_dt(:,aa));
    Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital(aa)=sum(Age_Cumulative_Count_Hospital_dt(:,aa)>0)./length(Age_Cumulative_Count_Hospital_dt(:,aa));
    Comparison.Alternative_Worse.Age_Cumulative_Count_Death(aa)=sum(Age_Cumulative_Count_Death_dt(:,aa)>0)./length(Age_Cumulative_Count_Death_dt(:,aa));
    Comparison.Alternative_Worse.Cost_Age(aa)=sum(Cost_Age_dt(:,aa)>0)./length(Cost_Age_dt(:,aa));
    
    Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Incidence(aa)=sum(Compliment_Age_Cumulative_Count_Incidence_dt(:,aa)>0)./length(Compliment_Age_Cumulative_Count_Incidence_dt(:,aa));
    Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Hospital(aa)=sum(Compliment_Age_Cumulative_Count_Hospital_dt(:,aa)>0)./length(Compliment_Age_Cumulative_Count_Hospital_dt(:,aa));
    Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Death(aa)=sum(Compliment_Age_Cumulative_Count_Death_dt(:,aa)>0)./length(Compliment_Age_Cumulative_Count_Death_dt(:,aa));
    Comparison.Alternative_Worse.Cost_Compliment_Age(aa)=sum(Cost_Compliment_Age_dt(:,aa)>0)./length(Cost_Compliment_Age_dt(:,aa));
    
    [Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(aa,:),~] = histcounts(Age_Cumulative_Count_Incidence_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(aa,:),~] = histcounts(Age_Cumulative_Count_Hospital_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Age_Cumulative_Count_Death_rel(aa,:),~] = histcounts(Age_Cumulative_Count_Death_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Cost_Age_rel(aa,:),~] = histcounts(Cost_Age_rel(:,aa),xbin_edges);
    
    [Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(aa,:),~] = histcounts(Compliment_Age_Cumulative_Count_Incidence_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(aa,:),~] = histcounts(Compliment_Age_Cumulative_Count_Hospital_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(aa,:),~] = histcounts(Compliment_Age_Cumulative_Count_Death_rel(:,aa),xbin_edges);
    [Comparison.Histogram.Cost_Compliment_Age_rel(aa,:),~] = histcounts(Cost_Compliment_Age_rel(:,aa),xbin_edges);
end

save(['Comparison_Summary_' Scenario_Name '.mat'],'Comparison','PRCT','xbin_edges');
end