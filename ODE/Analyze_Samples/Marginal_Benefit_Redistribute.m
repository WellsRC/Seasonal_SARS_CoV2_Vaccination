function Marginal_Benefit_Redistribute(Filtered_Output_65,Filtered_Output_50,Filtered_Output_Redistributed, SA_Scenario)
PRCT=sort([50 2.5 25 75 97.5]);

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

Marginal_Benefit_Incidence=1-(Filtered_Output_65.Incidence_Cumulative_Count-Filtered_Output_Redistributed.Incidence_Cumulative_Count)./(Filtered_Output_65.Incidence_Cumulative_Count-Filtered_Output_50.Incidence_Cumulative_Count);
Marginal_Benefit_Hospitalization=1-(Filtered_Output_65.Hospital_Cumulative_Count-Filtered_Output_Redistributed.Hospital_Cumulative_Count)./(Filtered_Output_65.Hospital_Cumulative_Count-Filtered_Output_50.Hospital_Cumulative_Count);
Marginal_Benefit_Death=1-(Filtered_Output_65.Death_Cumulative_Count-Filtered_Output_Redistributed.Death_Cumulative_Count)./(Filtered_Output_65.Death_Cumulative_Count-Filtered_Output_50.Death_Cumulative_Count);
Marginal_Benefit_Cost=1-(Filtered_Output_65.Cost_Total-Filtered_Output_Redistributed.Cost_Total)./(Filtered_Output_65.Cost_Total-Filtered_Output_50.Cost_Total);


Marginal_Benefit_Incidence_Age=1-(Filtered_Output_65.Incidence_Cumulative_Count_Age-Filtered_Output_Redistributed.Incidence_Cumulative_Count_Age)./(Filtered_Output_65.Incidence_Cumulative_Count_Age-Filtered_Output_50.Incidence_Cumulative_Count_Age);
Marginal_Benefit_Hospitalization_Age=1-(Filtered_Output_65.Hospital_Cumulative_Count_Age-Filtered_Output_Redistributed.Hospital_Cumulative_Count_Age)./(Filtered_Output_65.Hospital_Cumulative_Count_Age-Filtered_Output_50.Hospital_Cumulative_Count_Age);
Marginal_Benefit_Death_Age=1-(Filtered_Output_65.Death_Cumulative_Count_Age-Filtered_Output_Redistributed.Death_Cumulative_Count_Age)./(Filtered_Output_65.Death_Cumulative_Count_Age-Filtered_Output_50.Death_Cumulative_Count_Age);
Marginal_Benefit_Cost_Age=1-(Filtered_Output_65.Cost_Age-Filtered_Output_Redistributed.Cost_Age)./(Filtered_Output_65.Cost_Age-Filtered_Output_50.Cost_Age);

dim_2=size(Marginal_Benefit_Cost_Age,2);
dim_3=size(Marginal_Benefit_Cost_Age,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Statistical summary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

boot_s=bootstrp(2500,@mean,Marginal_Benefit_Incidence);
Marginal_Benefit.Average.Incidence=mean(boot_s);
Marginal_Benefit.PRCT.Incidence=prctile(boot_s,PRCT);

boot_s=bootstrp(2500,@mean,Marginal_Benefit_Hospitalization);
Marginal_Benefit.Average.Hospitalization=mean(boot_s);
Marginal_Benefit.PRCT.Hospitalization=prctile(boot_s,PRCT);

boot_s=bootstrp(2500,@mean,Marginal_Benefit_Death);
Marginal_Benefit.Average.Death=mean(boot_s);
Marginal_Benefit.PRCT.Death=prctile(boot_s,PRCT);

boot_s=bootstrp(2500,@mean,Marginal_Benefit_Cost);
Marginal_Benefit.Average.Cost=mean(boot_s);
Marginal_Benefit.PRCT.Cost=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Incidence_Age),2500,dim_2,dim_3);
Marginal_Benefit.Average.Incidence_Age=mean(boot_s,1);
Marginal_Benefit.PRCT.Incidence_Age=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Hospitalization_Age),2500,dim_2,dim_3);
Marginal_Benefit.Average.Hospitalization_Age=mean(boot_s,1);
Marginal_Benefit.PRCT.Hospitalization_Age=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Death_Age),2500,dim_2,dim_3);
Marginal_Benefit.Average.Death_Age=mean(boot_s,1);
Marginal_Benefit.PRCT.Death_Age=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Cost_Age),2500,dim_2,dim_3);
Marginal_Benefit.Average.Cost_Age=mean(boot_s,1);
Marginal_Benefit.PRCT.Cost_Age=prctile(boot_s,PRCT);

save([pwd '/Files/Marginal_Benefit_Redistributre_Second_Dose_50_to_64_' SA_Scenario '.mat'],'Marginal_Benefit','PRCT');
end