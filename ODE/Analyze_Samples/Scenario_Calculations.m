function Scenario_Calculations(Model_Output,Scenario_Name)

PRCT=sort([1:99 2.5 97.5]);

Output_Summary.PRCT.Cumulative_Count_Incidence=prctile(Model_Output.Incidence_Cumulative_Count,PRCT);
Output_Summary.Average.Cumulative_Count_Incidence=mean(Model_Output.Incidence_Cumulative_Count,1);
Output_Summary.PRCT.Cumulative_Count_Hospital=prctile(Model_Output.Hospital_Cumulative_Count,PRCT);
Output_Summary.Average.Cumulative_Count_Hospital=mean(Model_Output.Hospital_Cumulative_Count,1);
Output_Summary.PRCT.Cumulative_Count_Death=prctile(Model_Output.Death_Cumulative_Count,PRCT);
Output_Summary.Average.Cumulative_Count_Death=mean(Model_Output.Death_Cumulative_Count,1);
Output_Summary.PRCT.Cost_Total=prctile(Model_Output.Cost_Total,PRCT);
Output_Summary.Average.Cost_Total=mean(Model_Output.Cost_Total,1);
Output_Summary.PRCT.Cost_Age=prctile(Model_Output.Cost_Age,PRCT);
Output_Summary.Average.Cost_Age=mean(Model_Output.Cost_Age,1);
Output_Summary.PRCT.Cost_Compliment_Age=prctile(Model_Output.Cost_Compliment_Age,PRCT);
Output_Summary.Average.Cost_Compliment_Age=mean(Model_Output.Cost_Compliment_Age,1);
    
Output_Summary.PRCT.Incidence=prctile(Model_Output.Incidence,PRCT);
Output_Summary.PRCT.Hospital_Burden=prctile(Model_Output.Hospital_Burden,PRCT);
Output_Summary.PRCT.Hospital_Admission=prctile(Model_Output.Hospital_Admission,PRCT);
Output_Summary.PRCT.Death=prctile(Model_Output.Death,PRCT);

Output_Summary.Average.Incidence=mean(Model_Output.Incidence,1);
Output_Summary.Average.Hospital_Burden=mean(Model_Output.Hospital_Burden,1);
Output_Summary.Average.Hospital_Admission=mean(Model_Output.Hospital_Admission,1);
Output_Summary.Average.Death=mean(Model_Output.Death,1);

Output_Summary.PRCT.Age_Incidence=prctile(Model_Output.Incidence_Cumulative_Count_Age,PRCT);
Output_Summary.PRCT.Age_Hospital=prctile(Model_Output.Hospital_Cumulative_Count_Age,PRCT);
Output_Summary.PRCT.Age_Death=prctile(Model_Output.Death_Cumulative_Count_Age,PRCT);
Output_Summary.PRCT.Age_Recovered=prctile(Model_Output.Recovered,PRCT,1);

Output_Summary.Average.Age_Incidence=mean(Model_Output.Incidence_Cumulative_Count_Age);
Output_Summary.Average.Age_Hospital=mean(Model_Output.Hospital_Cumulative_Count_Age);
Output_Summary.Average.Age_Death=mean(Model_Output.Death_Cumulative_Count_Age);
Output_Summary.Average.Age_Recovered=mean(Model_Output.Recovered,1);

% R0=squeeze(Model_Output.Recovered(:,:,1));
% RT=squeeze(Model_Output.Recovered(:,:,2));
% M=squeeze(mean(R0,1));
% CV=squeeze(cov(R0,1));
% temp1=log(mvnpdf(R0,M,CV));
% temp1(isinf(temp1))=-10^6;
% 
% temp2=log(mvnpdf(RT,M,CV));
% temp2(isinf(temp2))=-10^6;
% Output_Summary.mvn.t0=fitdist(temp1,'Kernel','Kernel','epanechnikov');
% Output_Summary.mvn.tend=fitdist(temp2,'Kernel','Kernel','epanechnikov');

save([pwd '/Files/Model_Output_Summary_' Scenario_Name '.mat'],'PRCT','Output_Summary');
end