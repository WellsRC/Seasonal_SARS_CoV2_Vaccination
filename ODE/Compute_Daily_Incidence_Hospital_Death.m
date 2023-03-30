function [Daily_Incidence,Daily_Hospital,Daily_Death,Age_Cumulative_Incidence,Age_Cumulative_Hospital,Age_Cumulative_Death,Daily_Hospital_Age]=Compute_Daily_Incidence_Hospital_Death(T,C_Incidence_NoVac,C_Incidence_Vac,C_Death,C_Hosp,T_Run,Parameters)

A=length(Parameters.N);
Daily_Incidence_Unvaccinated=zeros(A,T_Run(end)-T_Run(1));
Daily_Incidence_Vaccinated=zeros(A,T_Run(end)-T_Run(1));
Daily_Death=zeros(A,T_Run(end)-T_Run(1));
Daily_Hospital=zeros(A,T_Run(end)-T_Run(1));

Age_Cumulative_Incidence=zeros(A,1);
Age_Cumulative_Death=zeros(A,1);
Age_Cumulative_Hospital=zeros(A,1);
for a=1:A
   Daily_Incidence_Unvaccinated(a,:)=pchip(T,C_Incidence_NoVac(:,a),T_Run(2:end))-pchip(T,C_Incidence_NoVac(:,a),T_Run(1:end-1));
   Daily_Incidence_Vaccinated(a,:)=pchip(T,C_Incidence_Vac(:,a),T_Run(2:end))-pchip(T,C_Incidence_Vac(:,a),T_Run(1:end-1));
   Daily_Death(a,:)=pchip(T,C_Death(:,a),T_Run(2:end))-pchip(T,C_Death(:,a),T_Run(1:end-1));
   Daily_Hospital(a,:)=pchip(T,C_Hosp(:,a),T_Run(2:end))-pchip(T,C_Hosp(:,a),T_Run(1:end-1));
   
   Age_Cumulative_Incidence(a)=C_Incidence_Vac(end,a)+C_Incidence_NoVac(end,a);
   Age_Cumulative_Death(a)=C_Death(end,a);
   Age_Cumulative_Hospital(a)=C_Hosp(end,a);
end
Daily_Hospital_Age=Daily_Hospital;
Daily_Incidence=Daily_Incidence_Unvaccinated+Daily_Incidence_Vaccinated;
Daily_Incidence=sum(Daily_Incidence,1);
Daily_Death=sum(Daily_Death,1);
Daily_Hospital=sum(Daily_Hospital,1);

end