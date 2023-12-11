function Scenario_Calculations(Model_Output,Scenario_Name)

PRCT=sort([50 2.5 25 75 97.5]);


dim_2=size(Model_Output.Cost_Age,2);
dim_3=size(Model_Output.Cost_Age,3);


boot_s=bootstrp(2500,@mean,Model_Output.Incidence_Cumulative_Count);
Output_Summary.PRCT.Cumulative_Count_Incidence=prctile(boot_s,PRCT);
Output_Summary.Average.Cumulative_Count_Incidence=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Hospital_Cumulative_Count);
Output_Summary.PRCT.Cumulative_Count_Hospital=prctile(boot_s,PRCT);
Output_Summary.Average.Cumulative_Count_Hospital=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Death_Cumulative_Count);
Output_Summary.PRCT.Cumulative_Count_Death=prctile(boot_s,PRCT);
Output_Summary.Average.Cumulative_Count_Death=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Cost_Total);
Output_Summary.PRCT.Cost_Total=prctile(boot_s,PRCT);
Output_Summary.Average.Cost_Total=mean(boot_s,1);

boot_s=reshape(bootstrp(2500,@mean,Model_Output.Cost_Age),2500,dim_2,dim_3);
Output_Summary.PRCT.Cost_Age=prctile(boot_s,PRCT);
Output_Summary.Average.Cost_Age=mean(boot_s,1);

boot_s=reshape(bootstrp(2500,@mean,Model_Output.Cost_Compliment_Age),2500,dim_2,dim_3);
Output_Summary.PRCT.Cost_Compliment_Age=prctile(boot_s,PRCT);
Output_Summary.Average.Cost_Compliment_Age=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Incidence);    
Output_Summary.PRCT.Incidence=prctile(boot_s,PRCT);
Output_Summary.Average.Incidence=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Hospital_Admission);  
Output_Summary.PRCT.Hospital_Admission=prctile(boot_s,PRCT);
Output_Summary.Average.Hospital_Admission=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Death);  
Output_Summary.PRCT.Death=prctile(boot_s,PRCT);
Output_Summary.Average.Death=mean(boot_s,1);

boot_s=reshape(bootstrp(2500,@mean,Model_Output.Incidence_Cumulative_Count_Age),2500,dim_2,dim_3);  
Output_Summary.PRCT.Age_Incidence=prctile(boot_s,PRCT);
Output_Summary.Average.Age_Incidence=mean(boot_s);

boot_s=reshape(bootstrp(2500,@mean,Model_Output.Hospital_Cumulative_Count_Age),2500,dim_2,dim_3);  
Output_Summary.PRCT.Age_Hospital=prctile(boot_s,PRCT);
Output_Summary.Average.Age_Hospital=mean(boot_s);

boot_s=reshape(bootstrp(2500,@mean,Model_Output.Death_Cumulative_Count_Age),2500,dim_2,dim_3);  
Output_Summary.PRCT.Age_Death=prctile(boot_s,PRCT);
Output_Summary.Average.Age_Death=mean(boot_s);

boot_s=bootstrp(2500,@mean,Model_Output.SD_Natural_Immunity_Age);  
Output_Summary.PRCT.SD_Natural_Immunity_Age=prctile(boot_s,PRCT,1);
Output_Summary.Average.SD_Natural_Immunity_Age=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Inf_Natural_Immunity_Age);  
Output_Summary.PRCT.Inf_Natural_Immunity_Age=prctile(boot_s,PRCT,1);
Output_Summary.Average.Inf_Natural_Immunity_Age=mean(boot_s,1);


boot_s=bootstrp(2500,@mean,Model_Output.SD_Vaccine_Immunity_Age);  
Output_Summary.PRCT.SD_Vaccine_Immunity_Age=prctile(boot_s,PRCT,1);
Output_Summary.Average.SD_Vaccine_Immunity_Age=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Inf_Vaccine_Immunity_Age);  
Output_Summary.PRCT.Inf_Vaccine_Immunity_Age=prctile(boot_s,PRCT,1);
Output_Summary.Average.Inf_Vaccine_Immunity_Age=mean(boot_s,1);

boot_s=bootstrp(2500,@mean,Model_Output.Susceptible_Age);  
Output_Summary.PRCT.Susceptible_Age=prctile(boot_s,PRCT,1);
Output_Summary.Average.Susceptible_Age=mean(boot_s,1);

save([pwd '/Files/Model_Output_Summary_' Scenario_Name '.mat'],'PRCT','Output_Summary');
end