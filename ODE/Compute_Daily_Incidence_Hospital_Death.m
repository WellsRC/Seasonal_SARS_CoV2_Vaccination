function [Daily_Incidence,Daily_Hospital,Daily_Death,Age_Cumulative_Incidence,Age_Cumulative_Hospital,Age_Cumulative_Death,Age_Incidence,Age_Hospital,Age_Death]=Compute_Daily_Incidence_Hospital_Death(T,C_Incidence_NoVac,C_Incidence_Vac,C_Death,C_Hosp,T_Run,Parameters)

A=length(Parameters.N);
Daily_Incidence_Unvaccinated=zeros(A,T_Run(end)-T_Run(1));
Daily_Incidence_Vaccinated=zeros(A,T_Run(end)-T_Run(1));
Daily_Death=zeros(A,T_Run(end)-T_Run(1));
Daily_Hospital=zeros(A,T_Run(end)-T_Run(1));

T_Snap=T_Run(1)+[90:30:300 T_Run(end)-T_Run(1)];
Age_Cumulative_Incidence=zeros(A,length(T_Snap));
Age_Cumulative_Death=zeros(A,length(T_Snap));
Age_Cumulative_Hospital=zeros(A,length(T_Snap));


for a=1:A
   Daily_Incidence_Unvaccinated(a,:)=pchip(T,C_Incidence_NoVac(:,a),T_Run(2:end))-pchip(T,C_Incidence_NoVac(:,a),T_Run(1:end-1));
   Daily_Incidence_Vaccinated(a,:)=pchip(T,C_Incidence_Vac(:,a),T_Run(2:end))-pchip(T,C_Incidence_Vac(:,a),T_Run(1:end-1));
   Daily_Death(a,:)=pchip(T,C_Death(:,a),T_Run(2:end))-pchip(T,C_Death(:,a),T_Run(1:end-1));
   Daily_Hospital(a,:)=pchip(T,C_Hosp(:,a),T_Run(2:end))-pchip(T,C_Hosp(:,a),T_Run(1:end-1));
   
   Age_Cumulative_Incidence(a,:)=pchip(T,C_Incidence_Vac(:,a),T_Snap)+pchip(T,C_Incidence_NoVac(:,a),T_Snap);
   Age_Cumulative_Death(a,:)=pchip(T,C_Death(:,a),T_Snap);
   Age_Cumulative_Hospital(a,:)=pchip(T,C_Hosp(:,a),T_Snap);
   
end
Age_Hospital=Daily_Hospital;
Daily_Incidence=Daily_Incidence_Unvaccinated+Daily_Incidence_Vaccinated;
Age_Incidence=Daily_Incidence;
Age_Death=Daily_Death;

Daily_Incidence=sum(Daily_Incidence,1);
Daily_Death=sum(Daily_Death,1);
Daily_Hospital=sum(Daily_Hospital,1);

end