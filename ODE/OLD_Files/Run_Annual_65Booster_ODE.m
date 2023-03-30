function [T_Run,T_Month_Age,Y_Model] = Run_Annual_65Booster_ODE(T_Run,Parameters)

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0.Influenza_Campaign));


pd=Parameters.prob_H.*Parameters.prob_death_H;
pd_v=Parameters.prob_H.*(1-Parameters.eps_H).*Parameters.prob_death_H.*(1-Parameters.eps_DH);
T_Month_Age=[datenum('October 1, 2022') datenum('November 1, 2022') datenum('December 1, 2022') datenum('January 1, 2023') datenum('February 1, 2023') datenum('March 1, 2023') datenum('April 1, 2023') datenum('May 1, 2023') datenum('June 1, 2023')  datenum('July 1, 2023')  datenum('August 1, 2023')  datenum('September 1, 2023')];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Influenza coverage: Single booster campaign for under 65 and two doses
% for 65+
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[T,Y] = ode15s(@(t,x)SEIRVVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.delta_V,Parameters.gamma_V,Parameters.omega_R,Parameters.eps_V,Parameters.psi_V,Parameters.nu_V_Influenza,Parameters.C,pd,pd_v), [min(T_Run) max(T_Run)],  Parameters.X0.Influenza_Campaign, opts);
[Daily_Incidence_Annual_Booster_High_Coverage,Daily_Death_Count_Annual_Booster_High_Coverage,Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Age_Cumulative_Incidence_Annual_Booster_High_Coverage,Age_Cumulative_Death_Annual_Booster_High_Coverage]=Compute_Daily_Incidence_Death(T,Y,T_Run,T_Month_Age,Parameters);
[Hospital_Admission_Annual_Booster_High_Coverage,Hospital_Prevalence_Annual_Booster_High_Coverage,Hospital_Count_Annual_Booster_High_Coverage,Age_Cumulative_Hospital_Annual_Booster_High_Coverage]=Compute_Hospital(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run,T_Month_Age);

Y_Model.Annual_Booster.High_Coverage.Incidence=Daily_Incidence_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Death=Daily_Death_Count_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Age_Incidence=Age_Cumulative_Incidence_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Age_Death=Age_Cumulative_Death_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Hospital_Admission=Hospital_Admission_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Hospital_Burden=Hospital_Prevalence_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Hospital_Count=Hospital_Count_Annual_Booster_High_Coverage;
Y_Model.Annual_Booster.High_Coverage.Age_Hospital=Age_Cumulative_Hospital_Annual_Booster_High_Coverage;

end

