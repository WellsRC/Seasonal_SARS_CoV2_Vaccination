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

boot_s=bootstrp(2500,@mean,Model_Output.Hospital_Burden);  
Output_Summary.PRCT.Hospital_Burden=prctile(boot_s,PRCT);
Output_Summary.Average.Hospital_Burden=mean(boot_s,1);

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

boot_s=bootstrp(2500,@mean,Model_Output.Recovered);  
Output_Summary.PRCT.Age_Recovered=prctile(boot_s,PRCT,1);
Output_Summary.Average.Age_Recovered=mean(boot_s,1);

save([pwd '/Files/Model_Output_Summary_' Scenario_Name '.mat'],'PRCT','Output_Summary');
end