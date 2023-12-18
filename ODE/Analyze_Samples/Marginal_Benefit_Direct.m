function Marginal_Benefit_Direct(Two_Dose_Model,Baseline,Time_Second_Dose,Scenario_Name)

PRCT=sort([50 2.5 25 75 97.5]);
Time_temp=[90:30:300 365];
Incidence_Second_Dose_Alt=sum(Two_Dose_Model.Incidence(:,1:Time_Second_Dose),2);
Death_Second_Dose_Alt=sum(Two_Dose_Model.Death(:,1:Time_Second_Dose),2);
Hospital_Second_Dose_Alt=sum(Two_Dose_Model.Hospital_Count(:,1:Time_Second_Dose),2);
Cost_Total_Second_Dose_Alt=Two_Dose_Model.Cost_Total(:,Time_temp==Time_Second_Dose);

Incidence_Second_Dose_Baseline=sum(Baseline.Incidence(:,1:Time_Second_Dose),2);
Death_Second_Dose_Baseline=sum(Baseline.Death(:,1:Time_Second_Dose),2);
Hospital_Second_Dose_Baseline=sum(Baseline.Hospital_Count(:,1:Time_Second_Dose),2);
Cost_Total_Second_Dose_Baseline=Baseline.Cost_Total(:,Time_temp==Time_Second_Dose);


Marginal_Benefit_Incidence=1-(Two_Dose_Model.Incidence_Cumulative_Count-Incidence_Second_Dose_Alt)./(Baseline.Incidence_Cumulative_Count-Incidence_Second_Dose_Baseline);
Marginal_Benefit_Hospitalization=1-(Two_Dose_Model.Hospital_Cumulative_Count-Hospital_Second_Dose_Alt)./(Baseline.Hospital_Cumulative_Count-Hospital_Second_Dose_Baseline);
Marginal_Benefit_Death=1-(Two_Dose_Model.Death_Cumulative_Count-Death_Second_Dose_Alt)./(Baseline.Death_Cumulative_Count-Death_Second_Dose_Baseline);
Marginal_Benefit_Cost=1-(Two_Dose_Model.Cost_Total(:,end)-Cost_Total_Second_Dose_Alt)./(Baseline.Cost_Total(:,end)-Cost_Total_Second_Dose_Baseline);


Age_Incidence_Second_Dose_Alt=Two_Dose_Model.Incidence_Cumulative_Count_Age(:,:,Time_temp==Time_Second_Dose);
Age_Death_Second_Dose_Alt=Two_Dose_Model.Death_Cumulative_Count_Age(:,:,Time_temp==Time_Second_Dose);
Age_Hospital_Second_Dose_Alt=Two_Dose_Model.Hospital_Cumulative_Count_Age(:,:,Time_temp==Time_Second_Dose);
Age_Cost_Total_Second_Dose_Alt=Two_Dose_Model.Cost_Age(:,:,Time_temp==Time_Second_Dose);

Age_Incidence_Second_Dose_Baseline=Baseline.Incidence_Cumulative_Count_Age(:,:,Time_temp==Time_Second_Dose);
Age_Death_Second_Dose_Baseline=Baseline.Death_Cumulative_Count_Age(:,:,Time_temp==Time_Second_Dose);
Age_Hospital_Second_Dose_Baseline=Baseline.Hospital_Cumulative_Count_Age(:,:,Time_temp==Time_Second_Dose);
Age_Cost_Total_Second_Dose_Baseline=Baseline.Cost_Age(:,:,Time_temp==Time_Second_Dose);


Marginal_Benefit_Age_Incidence=1-(Two_Dose_Model.Incidence_Cumulative_Count(:,:,end)-Age_Incidence_Second_Dose_Alt)./(Baseline.Incidence_Cumulative_Count(:,:,end)-Age_Incidence_Second_Dose_Baseline);
Marginal_Benefit_Age_Hospitalization=1-(Two_Dose_Model.Hospital_Cumulative_Count(:,:,end)-Age_Hospital_Second_Dose_Alt)./(Baseline.Hospital_Cumulative_Count(:,:,end)-Age_Hospital_Second_Dose_Baseline);
Marginal_Benefit_Age_Death=1-(Two_Dose_Model.Death_Cumulative_Count(:,:,end)-Age_Death_Second_Dose_Alt)./(Baseline.Death_Cumulative_Count(:,:,end)-Age_Death_Second_Dose_Baseline);
Marginal_Benefit_Age_Cost=1-(Two_Dose_Model.Cost_Age(:,:,end)-Age_Cost_Total_Second_Dose_Alt)./(Baseline.Cost_Age(:,:,end)-Age_Cost_Total_Second_Dose_Baseline);

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

dim_2=size(Marginal_Benefit_Age_Incidence,2);
dim_3=size(Marginal_Benefit_Age_Incidence,3);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Age_Incidence),2500,dim_2,dim_3);  
Marginal_Benefit.Average.Age_Incidence=mean(boot_s);
Marginal_Benefit.PRCT.Age_Incidence=prctile(boot_s,PRCT);

dim_2=size(Marginal_Benefit_Age_Hospitalization,2);
dim_3=size(Marginal_Benefit_Age_Hospitalization,3);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Age_Hospitalization),2500,dim_2,dim_3);  
Marginal_Benefit.Average.Age_Hospitalization=mean(boot_s);
Marginal_Benefit.PRCT.Age_Hospitalization=prctile(boot_s,PRCT);

dim_2=size(Marginal_Benefit_Age_Death,2);
dim_3=size(Marginal_Benefit_Age_Death,3);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Age_Death),2500,dim_2,dim_3);  
Marginal_Benefit.Average.Age_Death=mean(boot_s);
Marginal_Benefit.PRCT.Age_Death=prctile(boot_s,PRCT);

dim_2=size(Marginal_Benefit_Age_Cost,2);
dim_3=size(Marginal_Benefit_Age_Cost,3);

boot_s=reshape(bootstrp(2500,@mean,Marginal_Benefit_Age_Cost),2500,dim_2,dim_3);  
Marginal_Benefit.Average.Age_Cost=mean(boot_s);
Marginal_Benefit.PRCT.Age_Cost=prctile(boot_s,PRCT);


save([pwd '/Files/Marginal_Benefit_Direct_' Scenario_Name '.mat'], 'Marginal_Benefit','PRCT');
end

