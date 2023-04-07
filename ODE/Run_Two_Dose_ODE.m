function [T_Run,Y_Model] = Run_Two_Dose_ODE(T_Run,Parameters)

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0.Influenza_Campaign));


pd=Parameters.prob_H.*Parameters.prob_death_H;
pd_v=Parameters.prob_H.*(1-Parameters.eps_H).*Parameters.prob_death_H.*(1-Parameters.eps_DH);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Influenza coverage: Single booster campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[T,Y] = ode15s(@(t,x)Two_Dose_SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.gamma_SD,Parameters.omega_R,Parameters.eps_V,Parameters.psi_V,Parameters.nu_V_Influenza,Parameters.C,Parameters.prob_H,Parameters.prob_H.*(1-Parameters.eps_H),pd,pd_v,Parameters.Add_dose), [min(T_Run) max(T_Run)],Parameters.X0.Influenza_Campaign, opts);
A=length(pd);
C_Incidence_NoVac=Y(:,23+26.*[0:(A-1)]);
C_Incidence_Vac=Y(:,24+26.*[0:(A-1)]);
C_Death=Y(:,25+26.*[0:(A-1)]);
C_Hosp=Y(:,26+26.*[0:(A-1)]);

[Daily_Incidence,Daily_Hospital,Daily_Death,Age_Cumulative_Incidence,Age_Cumulative_Hospital,Age_Cumulative_Death,Daily_Hospital_Age]=Compute_Daily_Incidence_Hospital_Death(T,C_Incidence_NoVac,C_Incidence_Vac,C_Death,C_Hosp,T_Run,Parameters);
[Hospital_Admission,Hospital_Prevalence]=Compute_Hospital(Daily_Hospital_Age,T_Run);

Y_Model.Incidence=Daily_Incidence;
Y_Model.Death=Daily_Death;
Y_Model.Hospital_Admission=Hospital_Admission;
Y_Model.Hospital_Burden=Hospital_Prevalence;
Y_Model.Hospital_Count=Daily_Hospital;
Y_Model.Age_Incidence=Age_Cumulative_Incidence;
Y_Model.Age_Death=Age_Cumulative_Death;
Y_Model.Age_Hospital=Age_Cumulative_Hospital;

end

