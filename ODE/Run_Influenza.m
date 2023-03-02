function [T_Run,Daily_Incidence_Influenza_Campaign,Hospital_Admission_Influenza_Campaign,Hospital_Death_Count_Influenza_Campaign,Hospital_Prevalence_Influenza_Campaign] = Run_Influenza(T_Run,Parameters)

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0.Annual_Campaign));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seasonal Influenza campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vac_s=false; 
[T,Y] = ode15s(@(t,x)SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.omega_R,Parameters.eps_V,vac_s,Parameters.psi_V,Parameters.nu_V_Influenza,Parameters.N,Parameters.C), [min(T_Run) max(T_Run)],  Parameters.X0.Influenza_Campaign, opts);
[Daily_Incidence_Influenza_Campaign,Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated]=Compute_Daily_Incidence(T,Y,T_Run,Parameters);
[Hospital_Admission_Influenza_Campaign,Hospital_Death_Count_Influenza_Campaign,Hospital_Prevalence_Influenza_Campaign]=Compute_Hospital_Death(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run);

end

