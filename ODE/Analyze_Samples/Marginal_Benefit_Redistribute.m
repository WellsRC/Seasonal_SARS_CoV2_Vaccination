function Marginal_Benefit_Redistribute(Filtered_Output_65,Filtered_Output_50,Filtered_Output_Redistributed, SA_Scenario)
PRCT=sort([1:99 2.5 97.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add 0-49 for main text
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Temp_A.Incidence_Cumulative_Count_Age=zeros(size(Filtered_Output_65.Incidence_Cumulative_Count_Age,1),size(Filtered_Output_65.Incidence_Cumulative_Count_Age,2)+1,size(Filtered_Output_65.Incidence_Cumulative_Count_Age,3));
Temp_A.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_A.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_A.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;

Temp_B.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;

Temp_C.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_C.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_C.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_C.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;


for tt=1:9
    Temp_A.Incidence_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_65.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_65.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Hospital_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_65.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_65.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Death_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_65.Death_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_65.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Cost_Age(:,:,tt)=[Filtered_Output_65.Cost_Age(:,:,tt)  sum(Filtered_Output_65.Cost_Age(:,1:end-2,tt),2)];
    
    Temp_B.Incidence_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_Redistributed.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_Redistributed.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Hospital_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_Redistributed.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_Redistributed.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Death_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_Redistributed.Death_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_Redistributed.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Cost_Age(:,:,tt)=[Filtered_Output_Redistributed.Cost_Age(:,:,tt)  sum(Filtered_Output_Redistributed.Cost_Age(:,1:end-2,tt),2)];

    Temp_C.Incidence_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_50.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_50.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_C.Hospital_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_50.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_50.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_C.Death_Cumulative_Count_Age(:,:,tt)=[Filtered_Output_50.Death_Cumulative_Count_Age(:,:,tt)  sum(Filtered_Output_50.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_C.Cost_Age(:,:,tt)=[Filtered_Output_50.Cost_Age(:,:,tt)  sum(Filtered_Output_50.Cost_Age(:,1:end-2,tt),2)];
    
end
Filtered_Output_65.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Filtered_Output_65.Hospital_Cumulative_Count_Age=Temp_A.Hospital_Cumulative_Count_Age;
Filtered_Output_65.Death_Cumulative_Count_Age=Temp_A.Death_Cumulative_Count_Age;
Filtered_Output_65.Cost_Age=Temp_A.Cost_Age;

Filtered_Output_Redistributed.Incidence_Cumulative_Count_Age=Temp_B.Incidence_Cumulative_Count_Age;
Filtered_Output_Redistributed.Hospital_Cumulative_Count_Age=Temp_B.Hospital_Cumulative_Count_Age;
Filtered_Output_Redistributed.Death_Cumulative_Count_Age=Temp_B.Death_Cumulative_Count_Age;
Filtered_Output_Redistributed.Cost_Age=Temp_B.Cost_Age;

Filtered_Output_50.Incidence_Cumulative_Count_Age=Temp_C.Incidence_Cumulative_Count_Age;
Filtered_Output_50.Hospital_Cumulative_Count_Age=Temp_C.Hospital_Cumulative_Count_Age;
Filtered_Output_50.Death_Cumulative_Count_Age=Temp_C.Death_Cumulative_Count_Age;
Filtered_Output_50.Cost_Age=Temp_C.Cost_Age;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conduct calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Marginal_Benefit_Incidence=(Filtered_Output_65.Incidence_Cumulative_Count-Filtered_Output_Redistributed.Incidence_Cumulative_Count)./(Filtered_Output_65.Incidence_Cumulative_Count-Filtered_Output_50.Incidence_Cumulative_Count)-1;
Marginal_Benefit_Hospitalization=(Filtered_Output_65.Hospital_Cumulative_Count-Filtered_Output_Redistributed.Hospital_Cumulative_Count)./(Filtered_Output_65.Hospital_Cumulative_Count-Filtered_Output_50.Hospital_Cumulative_Count)-1;
Marginal_Benefit_Death=(Filtered_Output_65.Death_Cumulative_Count-Filtered_Output_Redistributed.Death_Cumulative_Count)./(Filtered_Output_65.Death_Cumulative_Count-Filtered_Output_50.Death_Cumulative_Count)-1;
Marginal_Benefit_Cost=(Filtered_Output_65.Cost_Total-Filtered_Output_Redistributed.Cost_Total)./(Filtered_Output_65.Cost_Total-Filtered_Output_50.Cost_Total)-1;


Marginal_Benefit_Incidence_Age=(Filtered_Output_65.Incidence_Cumulative_Count_Age-Filtered_Output_Redistributed.Incidence_Cumulative_Count_Age)./(Filtered_Output_65.Incidence_Cumulative_Count_Age-Filtered_Output_50.Incidence_Cumulative_Count_Age)-1;
Marginal_Benefit_Hospitalization_Age=(Filtered_Output_65.Hospital_Cumulative_Count_Age-Filtered_Output_Redistributed.Hospital_Cumulative_Count_Age)./(Filtered_Output_65.Hospital_Cumulative_Count_Age-Filtered_Output_50.Hospital_Cumulative_Count_Age)-1;
Marginal_Benefit_Death_Age=(Filtered_Output_65.Death_Cumulative_Count_Age-Filtered_Output_Redistributed.Death_Cumulative_Count_Age)./(Filtered_Output_65.Death_Cumulative_Count_Age-Filtered_Output_50.Death_Cumulative_Count_Age)-1;
Marginal_Benefit_Cost_Age=(Filtered_Output_65.Cost_Age-Filtered_Output_Redistributed.Cost_Age)./(Filtered_Output_65.Cost_Age-Filtered_Output_50.Cost_Age)-1;

Marginal_Benefit.Average.Incidence=mean(Marginal_Benefit_Incidence);
Marginal_Benefit.Average.Hospitalization=mean(Marginal_Benefit_Hospitalization);
Marginal_Benefit.Average.Death=mean(Marginal_Benefit_Death);
Marginal_Benefit.Average.Cost=mean(Marginal_Benefit_Cost);

Marginal_Benefit.Average.Incidence_Age=mean(Marginal_Benefit_Incidence_Age,1);
Marginal_Benefit.Average.Hospitalization_Age=mean(Marginal_Benefit_Hospitalization_Age,1);
Marginal_Benefit.Average.Death_Age=mean(Marginal_Benefit_Death_Age,1);
Marginal_Benefit.Average.Cost_Age=mean(Marginal_Benefit_Cost_Age,1);

Marginal_Benefit.PRCT.Incidence=prctile(Marginal_Benefit_Incidence,PRCT);
Marginal_Benefit.PRCT.Hospitalization=prctile(Marginal_Benefit_Hospitalization,PRCT);
Marginal_Benefit.PRCT.Death=prctile(Marginal_Benefit_Death,PRCT);
Marginal_Benefit.PRCT.Cost=prctile(Marginal_Benefit_Cost,PRCT);


Marginal_Benefit.PRCT.Incidence_Age=prctile(Marginal_Benefit_Incidence_Age,PRCT,1);
Marginal_Benefit.PRCT.Hospitalization_Age=prctile(Marginal_Benefit_Hospitalization_Age,PRCT,1);
Marginal_Benefit.PRCT.Death_Age=prctile(Marginal_Benefit_Death_Age,PRCT,1);
Marginal_Benefit.PRCT.Cost_Age=prctile(Marginal_Benefit_Cost_Age,PRCT,1);


Marginal_Benefit.Histogram.Incidence=fitdist(Marginal_Benefit_Incidence,'Kernel','Kernel','epanechnikov');
Marginal_Benefit.Histogram.Hospitalization=fitdist(Marginal_Benefit_Hospitalization,'Kernel','Kernel','epanechnikov');
Marginal_Benefit.Histogram.Death=fitdist(Marginal_Benefit_Death,'Kernel','Kernel','epanechnikov');
Marginal_Benefit.Histogram.Cost=fitdist(Marginal_Benefit_Cost(:,end),'Kernel','Kernel','epanechnikov');

Marginal_Benefit.Histogram.Incidence_Age=cell(length(Marginal_Benefit_Cost_Age(1,:,1)),1);
Marginal_Benefit.Histogram.Hospitalization_Age=cell(length(Marginal_Benefit_Cost_Age(1,:,1)),1);
Marginal_Benefit.Histogram.Death_Age=cell(length(Marginal_Benefit_Cost_Age(1,:,1)),1);
Marginal_Benefit.Histogram.Cost_Age=cell(length(Marginal_Benefit_Cost_Age(1,:,1)),1);

for aa=1:length(Marginal_Benefit_Cost_Age(1,:,1))
    Marginal_Benefit.Histogram.Incidence_Age{aa}=fitdist(Marginal_Benefit_Incidence_Age(:,aa,end),'Kernel','Kernel','epanechnikov');
    Marginal_Benefit.Histogram.Hospitalization_Age{aa}=fitdist(Marginal_Benefit_Hospitalization_Age(:,aa,end),'Kernel','Kernel','epanechnikov');
    Marginal_Benefit.Histogram.Death_Age{aa}=fitdist(Marginal_Benefit_Death_Age(:,aa,end),'Kernel','Kernel','epanechnikov');
    Marginal_Benefit.Histogram.Cost_Age{aa}=fitdist(Marginal_Benefit_Cost_Age(:,aa,end),'Kernel','Kernel','epanechnikov');
end

Marginal_Benefit.Less_than_zero.Incidence=mean(Marginal_Benefit_Incidence<0);
Marginal_Benefit.Less_than_zero.Hospitalization=mean(Marginal_Benefit_Hospitalization<0);
Marginal_Benefit.Less_than_zero.Death=mean(Marginal_Benefit_Death<0);
Marginal_Benefit.Less_than_zero.Cost=mean(Marginal_Benefit_Cost<0);

Marginal_Benefit.Less_than_zero.Incidence_Age=mean(Marginal_Benefit_Incidence_Age(:,:,end)<0,1);
Marginal_Benefit.Less_than_zero.Hospitalization_Age=mean(Marginal_Benefit_Hospitalization_Age(:,:,end)<0,1);
Marginal_Benefit.Less_than_zero.Death_Age=mean(Marginal_Benefit_Death_Age(:,:,end)<0,1);
Marginal_Benefit.Less_than_zero.Cost_Age=mean(Marginal_Benefit_Cost_Age(:,:,end)<0,1);

save([pwd '/Files/Marginal_Benefit_Redistributre_Second_Dose_50_to_64_' SA_Scenario '.mat'],'Marginal_Benefit','PRCT');
end