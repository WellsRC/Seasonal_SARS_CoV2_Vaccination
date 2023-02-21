function [T_Run,Daily_Incidence,Hospital_Admission,Hospital_Prevalence] = Run_ODE(T_Run,Parameters)

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0));

A=length(Parameters.N);
[T,Y] = ode15s(@(t,x)SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.omega_R,Parameters.eps_V,Parameters.psi_V,Parameters.nu_V,Parameters.N,Parameters.C), [min(T_Run) max(T_Run)], Parameters.X0, opts);


[Daily_Incidence,Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated]=Compute_Daily_Incidence(T,Y,T_Run,Parameters);
[Hospital_Admission,Hospital_Prevalence]=Compute_Hospital(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run);

end

