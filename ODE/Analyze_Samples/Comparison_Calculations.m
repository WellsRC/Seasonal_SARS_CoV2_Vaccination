function Comparison_Calculations(Alt_Model,Base_Model,Scenario_Name)

PRCT=sort([1:99 2.5 97.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add 0-49 in the analysis for main text (Just in the age not in the
% compliement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Temp_A.Incidence_Cumulative_Count_Age=zeros(size(Alt_Model.Incidence_Cumulative_Count_Age,1),size(Alt_Model.Incidence_Cumulative_Count_Age,2)+1,size(Alt_Model.Incidence_Cumulative_Count_Age,3));
Temp_A.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_A.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_A.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;

Temp_B.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;

for tt=1:9
    Temp_A.Incidence_Cumulative_Count_Age(:,:,tt)=[Alt_Model.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Alt_Model.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Hospital_Cumulative_Count_Age(:,:,tt)=[Alt_Model.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Alt_Model.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Death_Cumulative_Count_Age(:,:,tt)=[Alt_Model.Death_Cumulative_Count_Age(:,:,tt)  sum(Alt_Model.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Cost_Age(:,:,tt)=[Alt_Model.Cost_Age(:,:,tt)  sum(Alt_Model.Cost_Age(:,1:end-2,tt),2)];
    
    Temp_B.Incidence_Cumulative_Count_Age(:,:,tt)=[Base_Model.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Base_Model.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Hospital_Cumulative_Count_Age(:,:,tt)=[Base_Model.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Base_Model.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Death_Cumulative_Count_Age(:,:,tt)=[Base_Model.Death_Cumulative_Count_Age(:,:,tt)  sum(Base_Model.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Cost_Age(:,:,tt)=[Base_Model.Cost_Age(:,:,tt)  sum(Base_Model.Cost_Age(:,1:end-2,tt),2)];
end
Alt_Model.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Alt_Model.Hospital_Cumulative_Count_Age=Temp_A.Hospital_Cumulative_Count_Age;
Alt_Model.Death_Cumulative_Count_Age=Temp_A.Death_Cumulative_Count_Age;
Alt_Model.Cost_Age=Temp_A.Cost_Age;

Base_Model.Incidence_Cumulative_Count_Age=Temp_B.Incidence_Cumulative_Count_Age;
Base_Model.Hospital_Cumulative_Count_Age=Temp_B.Hospital_Cumulative_Count_Age;
Base_Model.Death_Cumulative_Count_Age=Temp_B.Death_Cumulative_Count_Age;
Base_Model.Cost_Age=Temp_B.Cost_Age;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conduct calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

xbin_edges=[-1.00:0.01:1.50];
Comparison.Histogram.Cumulative_Count_Incidence_rel = fitdist(Cumulative_Count_Incidence_rel,'Kernel','Kernel','epanechnikov');
Comparison.Histogram.Cumulative_Count_Hospital_rel = fitdist(Cumulative_Count_Hospital_rel,'Kernel','Kernel','epanechnikov');
Comparison.Histogram.Cumulative_Count_Death_rel = fitdist(Cumulative_Count_Death_rel,'Kernel','Kernel','epanechnikov');
Comparison.Histogram.Cost_rel = fitdist(Cost_Total_rel(:,end),'Kernel','Kernel','epanechnikov');

Comparison.Histogram.Age_Cumulative_Count_Incidence_rel=cell(length(Age_Cumulative_Count_Incidence_rel(1,:,1)),1);
Comparison.Histogram.Age_Cumulative_Count_Hospital_rel=cell(length(Age_Cumulative_Count_Hospital_rel(1,:,1)),1);
Comparison.Histogram.Age_Cumulative_Count_Death_rel=cell(length(Age_Cumulative_Count_Death_rel(1,:,1)),1);
Comparison.Histogram.Cost_Age_rel=cell(length(Cost_Age_rel(1,:,1)),1);

Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel=cell(length(Compliment_Age_Cumulative_Count_Incidence_rel(1,:,1)),1);
Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel=cell(length(Compliment_Age_Cumulative_Count_Hospital_rel(1,:,1)),1);
Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel=cell(length(Compliment_Age_Cumulative_Count_Death_rel(1,:,1)),1);
Comparison.Histogram.Cost_Compliment_Age_rel=cell(length(Cost_Compliment_Age_rel(1,:,1)),1);


Comparison.Alternative_Worse.Cumulative_Count_Incidence=mean(Cumulative_Count_Incidence_dt>0);
Comparison.Alternative_Worse.Cumulative_Count_Hospital=mean(Cumulative_Count_Hospital_dt>0);
Comparison.Alternative_Worse.Cumulative_Count_Death=mean(Cumulative_Count_Death_dt>0);
Comparison.Alternative_Worse.Cost_Total=mean(Cost_Total_dt>0);

Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence=zeros(1,size(Age_Cumulative_Count_Incidence_rel,2));
Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital=zeros(1,size(Age_Cumulative_Count_Hospital_rel,2));
Comparison.Alternative_Worse.Age_Cumulative_Count_Death=zeros(1,size(Age_Cumulative_Count_Death_rel,2));
Comparison.Alternative_Worse.Cost_Age=zeros(1,size(Cost_Age_rel,2));

Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Incidence=zeros(1,size(Compliment_Age_Cumulative_Count_Incidence_rel,2));
Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Hospital=zeros(1,size(Compliment_Age_Cumulative_Count_Hospital_rel,2));
Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Death=zeros(1,size(Compliment_Age_Cumulative_Count_Death_rel,2));
Comparison.Alternative_Worse.Cost_Compliment_Age=zeros(1,size(Cost_Compliment_Age_rel,2));


for aa=1:size(Age_Cumulative_Count_Incidence_rel,2)
    
    Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence(aa)=mean(Age_Cumulative_Count_Incidence_dt(:,aa,end)>0);
    Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital(aa)=mean(Age_Cumulative_Count_Hospital_dt(:,aa,end)>0);
    Comparison.Alternative_Worse.Age_Cumulative_Count_Death(aa)=mean(Age_Cumulative_Count_Death_dt(:,aa,end)>0);
    Comparison.Alternative_Worse.Cost_Age(aa)=mean(Cost_Age_dt(:,aa,end)>0);
    
    
    Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{aa} = fitdist(Age_Cumulative_Count_Incidence_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
    Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{aa} = fitdist(Age_Cumulative_Count_Hospital_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
    Comparison.Histogram.Age_Cumulative_Count_Death_rel{aa} = fitdist(Age_Cumulative_Count_Death_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
    Comparison.Histogram.Cost_Age_rel{aa} = fitdist(Cost_Age_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
end
for aa=1:size(Compliment_Age_Cumulative_Count_Incidence_rel,2)
    Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Incidence(aa)=mean(Compliment_Age_Cumulative_Count_Incidence_dt(:,aa,end)>0);
    Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Hospital(aa)=mean(Compliment_Age_Cumulative_Count_Hospital_dt(:,aa,end)>0);
    Comparison.Alternative_Worse.Compliment_Age_Cumulative_Count_Death(aa)=mean(Compliment_Age_Cumulative_Count_Death_dt(:,aa,end)>0);
    Comparison.Alternative_Worse.Cost_Compliment_Age(aa)=mean(Cost_Compliment_Age_dt(:,aa,end)>0);
    
    Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel{aa} = fitdist(Compliment_Age_Cumulative_Count_Incidence_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
    Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel{aa} = fitdist(Compliment_Age_Cumulative_Count_Hospital_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
    Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel{aa} = fitdist(Compliment_Age_Cumulative_Count_Death_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
    Comparison.Histogram.Cost_Compliment_Age_rel{aa} = fitdist(Cost_Compliment_Age_rel(:,aa,end),'Kernel','Kernel','epanechnikov');
end

save([pwd '/Files/Comparison_Summary_' Scenario_Name '.mat'],'Comparison','PRCT');
end