function [T_Run,Y_Model] = Run_Cont_Booster_ODE(T_Run,Parameters)

opts = odeset('RelTol',1e-8,'AbsTol',1e-8,'NonNegative',1:length(Parameters.X0.Baseline_Campaign));


pd=Parameters.prob_H.*Parameters.prob_death_H;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Influenza coverage: Single booster campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                               
[T,Y] = ode45(@(t,x)Continual_SEIRVS(t,x,Parameters.beta_I,Parameters.sigma_E,Parameters.delta_I,Parameters.omega_R1,Parameters.omega_R2,Parameters.omega_R3,Parameters.omega_R4,Parameters.omega_R5,Parameters.alpha_R1,Parameters.alpha_R2,Parameters.alpha_R4,Parameters.p1_inf,Parameters.p2_inf,Parameters.p3_inf,Parameters.p1_sd,Parameters.p2_sd,Parameters.eps_V1,Parameters.eps_V2,Parameters.eps_V3,Parameters.q1_sd,Parameters.q2_sd,Parameters.q3_sd,Parameters.gammaV_1,Parameters.gammaV_2,Parameters.gammaV_3,Parameters.kappaV_1,Parameters.kappaV_2,Parameters.delta_V,Parameters.psi_V,Parameters.nu_V_SARSCoV2,Parameters.C,Parameters.prob_H,pd), [min(T_Run) max(T_Run)+2],Parameters.X0.Baseline_Campaign, opts);
A=length(pd);
C_Incidence=Y(:,26+28.*[0:(A-1)]);
C_Death=Y(:,27+28.*[0:(A-1)]);
C_Hosp=Y(:,28+28.*[0:(A-1)]);

SD_Natural=zeros(size(Y(:,16+28.*[0:(A-1)])));
I_Natural=zeros(size(Y(:,16+28.*[0:(A-1)])));
for jj=16:25
    SD_Natural=SD_Natural+Y(:,jj+28.*[0:(A-1)]);
    if((jj>=16 && jj<=18)||(jj>=21 && jj<=23))
        I_Natural=I_Natural+Y(:,jj+28.*[0:(A-1)]);
    end
end
SD_Vaccine=zeros(size(Y(:,16+28.*[0:(A-1)])));
I_Vaccine=zeros(size(Y(:,16+28.*[0:(A-1)])));
for jj=3:5
    SD_Vaccine=SD_Vaccine+Y(:,jj+28.*[0:(A-1)]);
    switch jj
        case 3
            I_Vaccine=I_Vaccine+repmat(Parameters.eps_V1',length(T),1).*Y(:,jj+28.*[0:(A-1)]);
        case 4
            I_Vaccine=I_Vaccine+repmat(Parameters.eps_V2',length(T),1).*Y(:,jj+28.*[0:(A-1)]);
        case 5
            I_Vaccine=I_Vaccine+repmat(Parameters.eps_V3',length(T),1).*Y(:,jj+28.*[0:(A-1)]);
    end
end
F_Susceptible=Y(:,1+28.*[0:(A-1)])+Y(:,2+28.*[0:(A-1)]);
                                                                                                                                                                                
[Daily_Incidence,Daily_Hospital,Daily_Death,Age_Cumulative_Incidence,Age_Cumulative_Hospital,Age_Cumulative_Death,~,Daily_Hospital_Age,~]=Compute_Daily_Incidence_Hospital_Death(T,C_Incidence,C_Death,C_Hosp,T_Run,Parameters);
[Hospital_Admission]=Compute_Hospital(Daily_Hospital_Age,T_Run);

[SD_Natural_Immunity,Infection_Natural_Immunity,SD_Vaccine_Immunity,Infection_Vaccine_Immunity,Fully_Susceptible]=Compute_Daily_Immunity(T,SD_Natural,I_Natural,SD_Vaccine,I_Vaccine,F_Susceptible,T_Run);

Y_Model.Incidence=Daily_Incidence;
Y_Model.Death=Daily_Death;
Y_Model.Hospital_Admission=Hospital_Admission;
Y_Model.Hospital_Count=Daily_Hospital;

Y_Model.SD_Natural_Immunity=SD_Natural_Immunity;
Y_Model.Infection_Natural_Immunity=Infection_Natural_Immunity;
Y_Model.SD_Vaccine_Immunity=SD_Vaccine_Immunity;
Y_Model.Infection_Vaccine_Immunity=Infection_Vaccine_Immunity;
Y_Model.Fully_Susceptible=Fully_Susceptible;

Y_Model.Age_Cumulative_Incidence=Age_Cumulative_Incidence;
Y_Model.Age_Cumulative_Death=Age_Cumulative_Death;
Y_Model.Age_Cumulative_Hospital=Age_Cumulative_Hospital;
Y_Model.T_Run=T_Run;
end

