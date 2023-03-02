function [T_Run,Daily_Incidence_Influenza_Campaign,Hospital_Admission_Influenza_Campaign,Daily_Death_Count_Influenza_Campaign,Hospital_Prevalence_Influenza_Campaign,Hospital_Count_Influenza_Campaign,Daily_Incidence_Annual_Campaign,Hospital_Admission_Annual_Campaign,Daily_Death_Count_Annual_Campaign,Hospital_Prevalence_Annual_Campaign,Hospital_Count_Annual_Campaign] = Run_ODE(T_Run,Parameters)

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0.Annual_Campaign));


pd=Parameters.prob_H.*Parameters.prob_death_H;
pd_v=Parameters.prob_H.*(1-Parameters.eps_H).*Parameters.prob_death_H.*(1-Parameters.eps_DH);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seasonal Influenza campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vac_s=false; 
[T,Y] = ode15s(@(t,x)SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.omega_R,Parameters.eps_V,vac_s,Parameters.psi_V,Parameters.nu_V_Influenza,Parameters.C,pd,pd_v), [min(T_Run) max(T_Run)],  Parameters.X0.Influenza_Campaign, opts);
[Daily_Incidence_Influenza_Campaign,Daily_Death_Count_Influenza_Campaign,Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated]=Compute_Daily_Incidence_Death(T,Y,T_Run,Parameters);
[Hospital_Admission_Influenza_Campaign,Hospital_Prevalence_Influenza_Campaign,Hospital_Count_Influenza_Campaign]=Compute_Hospital(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Annual campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vac_s=true; 
[T,Y] = ode15s(@(t,x)SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.omega_R,Parameters.eps_V,vac_s,Parameters.psi_V,Parameters.nu_V_Annual,Parameters.C,pd,pd_v), [min(T_Run) max(T_Run)],  Parameters.X0.Annual_Campaign, opts);
[Daily_Incidence_Annual_Campaign,Daily_Death_Count_Annual_Campaign,Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated]=Compute_Daily_Incidence_Death(T,Y,T_Run,Parameters);
[Hospital_Admission_Annual_Campaign,Hospital_Prevalence_Annual_Campaign,Hospital_Count_Annual_Campaign]=Compute_Hospital(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run);

end

