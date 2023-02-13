function [T_Run,Cumulative_Incidence,Daily_Incidence,Cumulative_Hospital,Daily_Hospital] = Run_ODE(T_Run,Parameters)

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0));

A=length(Parameters.N);
[T,Y] = ode15s(@(t,x)SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.omega_R,Parameters.eps_V,Parameters.psi_V,Parameters.nu_V,Parameters.N,Parameters.C), [min(T_Run) max(T_Run)], Parameters.X0, opts);

Cumulative_Incidence.Unvaccinated=zeros(length(A),T_Run(end)-T_Run(1));
Cumulative_Incidence.Vaccinated=zeros(length(A),T_Run(end)-T_Run(1));
Cumulative_Hospital.Unvaccinated=zeros(length(A),T_Run(end)-T_Run(1));
Cumulative_Hospital.Vaccinated=zeros(length(A),T_Run(end)-T_Run(1));

Daily_Incidence.Unvaccinated=zeros(length(A),T_Run(end)-T_Run(1));
Daily_Incidence.Vaccinated=zeros(length(A),T_Run(end)-T_Run(1));

Daily_Hospital.Unvaccinated=zeros(length(A),T_Run(end)-T_Run(1));
Daily_Hospital.Vaccinated=zeros(length(A),T_Run(end)-T_Run(1));

for a=1:A
   Daily_Incidence.Unvaccinated(a,:)=pchip(T,Y(:,10+11.*(a-1)),T_Run(2:end))-pchip(T,Y(:,10+11.*(a-1)),T_Run(1:end-1));
   Daily_Incidence.Vaccinated(a,:)=pchip(T,Y(:,11+11.*(a-1)),T_Run(2:end))-pchip(T,Y(:,11+11.*(a-1)),T_Run(1:end-1));
   
   Daily_Hospital.Unvaccinated(a,:)=Parameters.prob_H(a).*Daily_Incidence.Unvaccinated(a,:);
   Daily_Hospital.Vaccinated(a,:)=(1-Parameters.eps_H(a)).*Parameters.prob_H(a).*Daily_Incidence.Vaccinated(a,:);
   
   Cumulative_Incidence.Unvaccinated(a,:)=pchip(T,Y(:,10+11.*(a-1)),T_Run(2:end));
   Cumulative_Incidence.Vaccinated(a,:)=pchip(T,Y(:,11+11.*(a-1)),T_Run(2:end));
   
   Cumulative_Hospital.Unvaccinated(a,:)=Parameters.prob_H(a).*Cumulative_Incidence.Unvaccinated(a,:);
   Cumulative_Hospital.Vaccinated(a,:)=(1-Parameters.eps_H(a)).*Parameters.prob_H(a).*Cumulative_Incidence.Vaccinated(a,:);
   
end

Cumulative_Incidence.Total=Cumulative_Incidence.Unvaccinated+Cumulative_Incidence.Vaccinated;
Daily_Incidence.Total=Daily_Incidence.Unvaccinated+Daily_Incidence.Vaccinated;

Cumulative_Hospital.Total=Cumulative_Hospital.Unvaccinated+Cumulative_Hospital.Vaccinated;
Daily_Hospital.Total=Daily_Hospital.Unvaccinated+Daily_Hospital.Vaccinated;

end

