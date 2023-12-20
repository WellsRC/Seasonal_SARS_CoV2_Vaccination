function Comparison_Calculations(Baseline_Model,Alternative_Model,Scenario_Name)

PRCT=sort([50 2.5 25 75 97.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add 0-49 in the analysis for main text (Just in the age not in the
% compliement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Temp_A.Incidence_Cumulative_Count_Age=zeros(size(Baseline_Model.Incidence_Cumulative_Count_Age,1),size(Baseline_Model.Incidence_Cumulative_Count_Age,2)+1,size(Baseline_Model.Incidence_Cumulative_Count_Age,3));
Temp_A.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_A.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_A.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;

Temp_B.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Hospital_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Death_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Temp_B.Cost_Age=Temp_A.Incidence_Cumulative_Count_Age;

for tt=1:9
    Temp_A.Incidence_Cumulative_Count_Age(:,:,tt)=[Baseline_Model.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Baseline_Model.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Hospital_Cumulative_Count_Age(:,:,tt)=[Baseline_Model.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Baseline_Model.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Death_Cumulative_Count_Age(:,:,tt)=[Baseline_Model.Death_Cumulative_Count_Age(:,:,tt)  sum(Baseline_Model.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_A.Cost_Age(:,:,tt)=[Baseline_Model.Cost_Age(:,:,tt)  sum(Baseline_Model.Cost_Age(:,1:end-2,tt),2)];
    
    Temp_B.Incidence_Cumulative_Count_Age(:,:,tt)=[Alternative_Model.Incidence_Cumulative_Count_Age(:,:,tt)  sum(Alternative_Model.Incidence_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Hospital_Cumulative_Count_Age(:,:,tt)=[Alternative_Model.Hospital_Cumulative_Count_Age(:,:,tt)  sum(Alternative_Model.Hospital_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Death_Cumulative_Count_Age(:,:,tt)=[Alternative_Model.Death_Cumulative_Count_Age(:,:,tt)  sum(Alternative_Model.Death_Cumulative_Count_Age(:,1:end-2,tt),2)];
    Temp_B.Cost_Age(:,:,tt)=[Alternative_Model.Cost_Age(:,:,tt)  sum(Alternative_Model.Cost_Age(:,1:end-2,tt),2)];
end
Baseline_Model.Incidence_Cumulative_Count_Age=Temp_A.Incidence_Cumulative_Count_Age;
Baseline_Model.Hospital_Cumulative_Count_Age=Temp_A.Hospital_Cumulative_Count_Age;
Baseline_Model.Death_Cumulative_Count_Age=Temp_A.Death_Cumulative_Count_Age;
Baseline_Model.Cost_Age=Temp_A.Cost_Age;

Alternative_Model.Incidence_Cumulative_Count_Age=Temp_B.Incidence_Cumulative_Count_Age;
Alternative_Model.Hospital_Cumulative_Count_Age=Temp_B.Hospital_Cumulative_Count_Age;
Alternative_Model.Death_Cumulative_Count_Age=Temp_B.Death_Cumulative_Count_Age;
Alternative_Model.Cost_Age=Temp_B.Cost_Age;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conduct calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Cumulative_Count_Incidence_dt=Baseline_Model.Incidence_Cumulative_Count-Alternative_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hospital_dt=Baseline_Model.Hospital_Cumulative_Count-Alternative_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_dt=Baseline_Model.Death_Cumulative_Count-Alternative_Model.Death_Cumulative_Count;
Cost_Total_dt=Baseline_Model.Cost_Total-Alternative_Model.Cost_Total;
Cost_Age_dt=Baseline_Model.Cost_Age-Alternative_Model.Cost_Age;
Cost_Compliment_Age_dt=Baseline_Model.Cost_Compliment_Age-Alternative_Model.Cost_Compliment_Age;

Cumulative_Count_Incidence_rel=Cumulative_Count_Incidence_dt./Baseline_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hospital_rel=Cumulative_Count_Hospital_dt./Baseline_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_rel=Cumulative_Count_Death_dt./Baseline_Model.Death_Cumulative_Count;
Cost_Total_rel=Cost_Total_dt./Baseline_Model.Cost_Total;
Cost_Age_rel=Cost_Age_dt./Baseline_Model.Cost_Age;
Cost_Compliment_Age_rel=Cost_Compliment_Age_dt./Baseline_Model.Cost_Compliment_Age;

Age_Cumulative_Count_Incidence_dt=Baseline_Model.Incidence_Cumulative_Count_Age-Alternative_Model.Incidence_Cumulative_Count_Age;
Age_Cumulative_Count_Hospital_dt=Baseline_Model.Hospital_Cumulative_Count_Age-Alternative_Model.Hospital_Cumulative_Count_Age;
Age_Cumulative_Count_Death_dt=Baseline_Model.Death_Cumulative_Count_Age-Alternative_Model.Death_Cumulative_Count_Age;

Compliment_Age_Cumulative_Count_Incidence_dt=Baseline_Model.Incidence_Cumulative_Count_Compliment_Age-Alternative_Model.Incidence_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Hospital_dt=Baseline_Model.Hospital_Cumulative_Count_Compliment_Age-Alternative_Model.Hospital_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Death_dt=Baseline_Model.Death_Cumulative_Count_Compliment_Age-Alternative_Model.Death_Cumulative_Count_Compliment_Age;

Age_Cumulative_Count_Incidence_rel=Age_Cumulative_Count_Incidence_dt./Baseline_Model.Incidence_Cumulative_Count_Age;
Age_Cumulative_Count_Hospital_rel=Age_Cumulative_Count_Hospital_dt./Baseline_Model.Hospital_Cumulative_Count_Age;
Age_Cumulative_Count_Death_rel=Age_Cumulative_Count_Death_dt./Baseline_Model.Death_Cumulative_Count_Age;

Compliment_Age_Cumulative_Count_Incidence_rel=Compliment_Age_Cumulative_Count_Incidence_dt./Baseline_Model.Incidence_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Hospital_rel=Compliment_Age_Cumulative_Count_Hospital_dt./Baseline_Model.Hospital_Cumulative_Count_Compliment_Age;
Compliment_Age_Cumulative_Count_Death_rel=Compliment_Age_Cumulative_Count_Death_dt./Baseline_Model.Death_Cumulative_Count_Compliment_Age;


dim_2=size(Cost_Age_rel,2);
dim_3=size(Cost_Age_rel,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Statistical summary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boot_s=bootstrp(2500,@mean,Cumulative_Count_Incidence_dt);
Comparison.Average.Cumulative_Count_Incidence_dt=mean(boot_s,1);
Comparison.PRCT.Cumulative_Count_Incidence_dt=prctile(boot_s,PRCT);

boot_s=bootstrp(2500,@mean,Cumulative_Count_Hospital_dt);
Comparison.Average.Cumulative_Count_Hospital_dt=mean(Cumulative_Count_Hospital_dt,1);
Comparison.PRCT.Cumulative_Count_Hospital_dt=prctile(boot_s,PRCT);

boot_s=bootstrp(2500,@mean,Cumulative_Count_Death_dt);
Comparison.Average.Cumulative_Count_Death_dt=mean(boot_s,1);
Comparison.PRCT.Cumulative_Count_Death_dt=prctile(boot_s,PRCT);

boot_s=bootstrp(2500,@mean,Cost_Total_dt);
Comparison.Average.Cost_Total_dt=mean(boot_s,1);
Comparison.PRCT.Cost_Total_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Cost_Age_dt),2500,dim_2,dim_3);
Comparison.Average.Cost_Age_dt=mean(boot_s,1);
Comparison.PRCT.Cost_Age_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Cost_Compliment_Age_dt),2500,dim_2-1,dim_3);
Comparison.Average.Cost_Compliment_Age_dt=mean(boot_s,1);
Comparison.PRCT.Cost_Compliment_Age_dt=prctile(boot_s,PRCT);


boot_s=bootstrp(2500,@mean,Cumulative_Count_Incidence_rel);
Comparison.Average.Cumulative_Count_Incidence_rel=mean(boot_s,1);
Comparison.PRCT.Cumulative_Count_Incidence_rel=prctile(boot_s,PRCT);


boot_s=bootstrp(2500,@mean,Cumulative_Count_Hospital_rel);
Comparison.Average.Cumulative_Count_Hospital_rel=mean(boot_s,1);
Comparison.PRCT.Cumulative_Count_Hospital_rel=prctile(boot_s,PRCT);


boot_s=bootstrp(2500,@mean,Cumulative_Count_Death_rel);
Comparison.Average.Cumulative_Count_Death_rel=mean(boot_s,1);
Comparison.PRCT.Cumulative_Count_Death_rel=prctile(boot_s,PRCT);


boot_s=bootstrp(2500,@mean,Cost_Total_rel);
Comparison.Average.Cost_Total_rel=mean(boot_s,1);
Comparison.PRCT.Cost_Total_rel=prctile(boot_s,PRCT);


boot_s=reshape(bootstrp(2500,@mean,Cost_Age_rel),2500,dim_2,dim_3);
Comparison.Average.Cost_Age_rel=mean(boot_s,1);
Comparison.PRCT.Cost_Age_rel=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Cost_Compliment_Age_rel),2500,dim_2-1,dim_3);
Comparison.Average.Cost_Compliment_Age_rel=mean(boot_s,1);
Comparison.PRCT.Cost_Compliment_Age_rel=prctile(boot_s,PRCT);


boot_s=reshape(bootstrp(2500,@mean,Age_Cumulative_Count_Incidence_dt),2500,dim_2,dim_3);
Comparison.Average.Age_Cumulative_Count_Incidence_dt=mean(boot_s,1);
Comparison.PRCT.Age_Cumulative_Count_Incidence_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Age_Cumulative_Count_Hospital_dt),2500,dim_2,dim_3);
Comparison.Average.Age_Cumulative_Count_Hospital_dt=mean(boot_s,1);
Comparison.PRCT.Age_Cumulative_Count_Hospital_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Age_Cumulative_Count_Death_dt),2500,dim_2,dim_3);
Comparison.Average.Age_Cumulative_Count_Death_dt=mean(boot_s,1);
Comparison.PRCT.Age_Cumulative_Count_Death_dt=prctile(boot_s,PRCT);


boot_s=reshape(bootstrp(2500,@mean,Age_Cumulative_Count_Incidence_rel),2500,dim_2,dim_3);
Comparison.Average.Age_Cumulative_Count_Incidence_rel=mean(boot_s,1);
Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Age_Cumulative_Count_Hospital_rel),2500,dim_2,dim_3);
Comparison.Average.Age_Cumulative_Count_Hospital_rel=mean(boot_s,1);
Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Age_Cumulative_Count_Death_rel),2500,dim_2,dim_3);
Comparison.Average.Age_Cumulative_Count_Death_rel=mean(boot_s,1);
Comparison.PRCT.Age_Cumulative_Count_Death_rel=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Compliment_Age_Cumulative_Count_Incidence_dt),2500,dim_2-1,dim_3);
Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt=mean(boot_s,1);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Compliment_Age_Cumulative_Count_Hospital_dt),2500,dim_2-1,dim_3);
Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt=mean(boot_s,1);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Compliment_Age_Cumulative_Count_Death_dt),2500,dim_2-1,dim_3);
Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt=mean(boot_s,1);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Compliment_Age_Cumulative_Count_Incidence_rel),2500,dim_2-1,dim_3);
Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_rel=mean(boot_s,1);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_rel=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Compliment_Age_Cumulative_Count_Hospital_rel),2500,dim_2-1,dim_3);
Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_rel=mean(boot_s,1);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_rel=prctile(boot_s,PRCT);

boot_s=reshape(bootstrp(2500,@mean,Compliment_Age_Cumulative_Count_Death_rel),2500,dim_2-1,dim_3);
Comparison.Average.Compliment_Age_Cumulative_Count_Death_rel=mean(boot_s,1);
Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_rel=prctile(boot_s,PRCT);


save([pwd '/Files/Comparison_Summary_' Scenario_Name '.mat'],'Comparison','PRCT');
end