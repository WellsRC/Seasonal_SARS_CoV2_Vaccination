function [Daily_Incidence,Daily_Death,Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Age_Cumulative_Incidence,Age_Cumulative_Death]=Compute_Daily_Incidence_Death(T,Y,T_Run,T_Month_Age,Parameters)

A=length(Parameters.N);
Daily_Incidence_Unvaccinated=zeros(A,T_Run(end)-T_Run(1));
Daily_Incidence_Vaccinated=zeros(A,T_Run(end)-T_Run(1));
Daily_Death=zeros(A,T_Run(end)-T_Run(1));

Age_Cumulative_Incidence=zeros(A,length(T_Month_Age));
Age_Cumulative_Death=zeros(A,length(T_Month_Age));
for a=1:A
   Daily_Incidence_Unvaccinated(a,:)=pchip(T,Y(:,13+15.*(a-1)),T_Run(2:end))-pchip(T,Y(:,13+15.*(a-1)),T_Run(1:end-1));
   Daily_Incidence_Vaccinated(a,:)=pchip(T,Y(:,14+15.*(a-1)),T_Run(2:end))-pchip(T,Y(:,14+15.*(a-1)),T_Run(1:end-1));
   Daily_Death(a,:)=pchip(T,Y(:,15+15.*(a-1)),T_Run(2:end))-pchip(T,Y(:,15+15.*(a-1)),T_Run(1:end-1));
   Age_Cumulative_Incidence(a,:)=pchip(T,Y(:,13+15.*(a-1)),T_Month_Age)+pchip(T,Y(:,14+15.*(a-1)),T_Month_Age);
   Age_Cumulative_Death(a,:)=pchip(T,Y(:,15+15.*(a-1)),T_Month_Age);
end
Daily_Incidence=Daily_Incidence_Unvaccinated+Daily_Incidence_Vaccinated;

Daily_Incidence=sum(Daily_Incidence,1);
Daily_Death=sum(Daily_Death,1);
end