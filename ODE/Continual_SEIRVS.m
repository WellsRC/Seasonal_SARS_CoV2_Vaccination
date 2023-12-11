function dxdt = Continual_SEIRVS(t,x,beta_I,sigma_E,delta_I,omega_R1,omega_R2,omega_R3,omega_R4,omega_R5,alpha_R1,alpha_R2,alpha_R4,p1_inf,p2_inf,p3_inf,p1_sd,p2_sd,eps_V1,eps_V2,eps_V3,q1_sd,q2_sd,q3_sd,gammaV_1,gammaV_2,gammaV_3,kappaV_1,kappaV_2,delta_V,psi_V,nu_V,C,ph,pd)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(pd);

NV=28;
span_A=NV.*[0:(A-1)];

% Susceptyible
S_n=1+span_A;
S_i=2+span_A;
% Vaccine associated immunity
V1=3+span_A;
V2=4+span_A;
V3=5+span_A;

% Latent infection
E_n=6+span_A;
F_n=7+span_A;
E_i=8+span_A;
F_i=9+span_A;
EV=10+span_A;

% Infectious period
I_n=11+span_A;
J_n=12+span_A;
I_i=13+span_A;
J_i=14+span_A;
IV=15+span_A;

%Recovered
R1_n=16+span_A;
R2_n=17+span_A;
R3_n=18+span_A;
R4_n=19+span_A;
R5_n=20+span_A;
R1_i=21+span_A;
R2_i=22+span_A;
R3_i=23+span_A;
R4_i=24+span_A;
R5_i=25+span_A;

% Cumualtive
CI=26+span_A;
C_Death=27+span_A;
C_Hosp=28+span_A;

% Population size for the age classes
N=x(S_n)+x(E_n)+x(I_n)+x(R1_n)+x(R2_n)+x(R3_n)+x(R4_n)+x(R5_n)+x(F_n)+x(J_n)+x(S_i)+x(E_i)+x(I_i)+x(R1_i)+x(R2_i)+x(R3_i)+x(R4_i)+x(R5_i)+x(F_i)+x(J_i)+x(V1)+x(V2)+x(V3)+x(EV)+x(IV);

% Vaccination rate for the annual vaccination campaign
vac_R=nu_V.vac_rate;

% Transmission rate for
beta_t=Transmission_Rate(t,beta_I);
% Proportion of the age class infected 
I_tot_FI=(x(I_n)+x(J_n)+x(I_i)+x(J_i)+(1-psi_V).*x(IV))./N;
lambda_FI=beta_t.*(C*I_tot_FI);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% No intent to vaccinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NI_Inf=x(R1_n)+x(R2_n)+x(R3_n);
NI_SD=x(R4_n)+x(R5_n);

NI_Inf(NI_Inf==0)=1;
NI_SD(NI_SD==0)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Inflow to the susceptbile compartment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Full_S_inflow_No_Intent=(1-p1_sd).*((1-p2_inf).*omega_R1.*x(R1_n)+(1-p3_inf).*omega_R2.*x(R2_n)+omega_R3.*x(R3_n));
Full_S_inflow_No_Intent=Full_S_inflow_No_Intent+(1-p1_sd).*((1-p2_inf).*alpha_R1.*x(R1_n).*x(R2_n)./NI_Inf+(1-p3_inf).*alpha_R2.*x(R2_n).*x(R3_n)./NI_Inf);
Full_S_inflow_No_Intent=Full_S_inflow_No_Intent+(1-p2_sd).*(omega_R4.*x(R4_n)+alpha_R4.*x(R4_n).*x(R5_n)./NI_SD);
Full_S_inflow_No_Intent=Full_S_inflow_No_Intent+omega_R5.*x(R5_n);
Full_S_inflow_No_Intent=Full_S_inflow_No_Intent+(1-p1_sd).*(1-p1_inf).*(1-pd).*delta_I.*x(I_n);

dxdt(S_n)=Full_S_inflow_No_Intent-lambda_FI.*x(S_n);
dxdt(E_n)=lambda_FI.*x(S_n)-sigma_E.*x(E_n);
dxdt(I_n)=sigma_E.*x(E_n)-delta_I.*x(I_n);

% Waning of immunity to infection
dxdt(R1_n)=p1_inf.*((1-pd).*delta_I.*x(I_n)+delta_I.*x(J_n))-omega_R1.*x(R1_n)-alpha_R1.*x(R1_n).*x(R2_n)./NI_Inf;
dxdt(R2_n)=p2_inf.*(omega_R1.*x(R1_n)+alpha_R1.*x(R1_n).*x(R2_n)./NI_Inf)-omega_R2.*x(R2_n)-alpha_R2.*x(R2_n).*x(R3_n)./NI_Inf;
dxdt(R3_n)=p3_inf.*(omega_R2.*x(R2_n)+alpha_R2.*x(R2_n).*x(R3_n)./NI_Inf)-omega_R3.*x(R3_n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inflow to SD compartment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SD_inflow_No_Intent=p1_sd.*((1-p2_inf).*omega_R1.*x(R1_n)+(1-p3_inf).*omega_R2.*x(R2_n)+omega_R3.*x(R3_n));
SD_inflow_No_Intent=SD_inflow_No_Intent+p1_sd.*((1-p2_inf).*alpha_R1.*x(R1_n).*x(R2_n)./NI_Inf+(1-p3_inf).*alpha_R2.*x(R2_n).*x(R3_n)./NI_Inf);
SD_inflow_No_Intent=SD_inflow_No_Intent+p1_sd.*(1-p1_inf).*(1-pd).*delta_I.*x(I_n)+(1-p1_inf).*delta_I.*x(J_n);

% Waning of immunity to severe disease
dxdt(R4_n)=SD_inflow_No_Intent-omega_R4.*x(R4_n)-alpha_R4.*x(R4_n).*x(R5_n)./NI_SD-lambda_FI.*x(R4_n);
dxdt(R5_n)=p2_sd.*(omega_R4.*x(R4_n)+alpha_R4.*x(R4_n).*x(R5_n)./NI_SD)-omega_R5.*x(R5_n)-lambda_FI.*x(R5_n);

% Infection but has immunity from previous infection
dxdt(F_n)=lambda_FI.*x(R4_n)+lambda_FI.*x(R5_n)-sigma_E.*x(F_n);
dxdt(J_n)=sigma_E.*x(F_n)-delta_I.*x(J_n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Intent to vaccinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NI_Inf=x(R1_i)+x(R2_i)+x(R3_i);
NI_SD=x(R4_i)+x(R5_i);
N_Vac=x(V1)+x(V2)+x(V3);

NI_Inf(NI_Inf==0)=1;
NI_SD(NI_SD==0)=1;
N_Vac(N_Vac==0)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Inflow to the susceptbile compartment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Full_S_inflow_Intent=(1-p1_sd).*((1-p2_inf).*omega_R1.*x(R1_i)+(1-p3_inf).*omega_R2.*x(R2_i)+omega_R3.*x(R3_i));
Full_S_inflow_Intent=Full_S_inflow_Intent+(1-p1_sd).*((1-p2_inf).*alpha_R1.*x(R1_i).*x(R2_i)./NI_Inf+(1-p3_inf).*alpha_R2.*x(R2_i).*x(R3_i)./NI_Inf);
Full_S_inflow_Intent=Full_S_inflow_Intent+(1-p2_sd).*(omega_R4.*x(R4_i)+alpha_R4.*x(R4_i).*x(R5_i)./NI_SD);
Full_S_inflow_Intent=Full_S_inflow_Intent+omega_R5.*x(R5_i);
Full_S_inflow_Intent=Full_S_inflow_Intent+(1-p1_sd).*(1-p1_inf).*(1-pd).*delta_I.*x(I_i);
% Flow from vaccine compartment
Full_S_inflow_Intent=Full_S_inflow_Intent+(1-q1_sd).*vac_R.*x(S_i);
Full_S_inflow_Intent=Full_S_inflow_Intent+(1-q2_sd).*gammaV_1.*x(V1)+(1-q3_sd).*gammaV_2.*x(V2)+gammaV_3.*x(V3);
Full_S_inflow_Intent=Full_S_inflow_Intent+(1-q2_sd).*kappaV_1.*x(V1).*x(V2)./N_Vac+(1-q3_sd).*kappaV_2.*x(V2).*x(V3)./N_Vac;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unvaccinated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt(S_i)=Full_S_inflow_Intent-lambda_FI.*x(S_i)-vac_R.*x(S_i);
dxdt(E_i)=lambda_FI.*x(S_i)-sigma_E.*x(E_i);
dxdt(I_i)=sigma_E.*x(E_i)-delta_I.*x(I_i);

% Waning of immunity to infection
dxdt(R1_i)=p1_inf.*((1-pd).*delta_I.*x(I_i)+delta_I.*x(J_i)+delta_V.*x(IV))-omega_R1.*x(R1_i)-alpha_R1.*x(R1_i).*x(R2_i)./NI_Inf;
dxdt(R2_i)=p2_inf.*(omega_R1.*x(R1_i)+alpha_R1.*x(R1_i).*x(R2_i)./NI_Inf)-omega_R2.*x(R2_i)-alpha_R2.*x(R2_i).*x(R3_i)./NI_Inf;
dxdt(R3_i)=p3_inf.*(omega_R2.*x(R2_i)+alpha_R2.*x(R2_i).*x(R3_i)./NI_Inf)-omega_R3.*x(R3_i);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inflow to SD compartment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SD_inflow_Intent=p1_sd.*((1-p2_inf).*omega_R1.*x(R1_i)+(1-p3_inf).*omega_R2.*x(R2_i)+omega_R3.*x(R3_i));
SD_inflow_Intent=SD_inflow_Intent+p1_sd.*((1-p2_inf).*alpha_R1.*x(R1_i).*x(R2_i)./NI_Inf+(1-p3_inf).*alpha_R2.*x(R2_i).*x(R3_i)./NI_Inf);
SD_inflow_Intent=SD_inflow_Intent+p1_sd.*(1-p1_inf).*(1-pd).*delta_I.*x(I_i)+(1-p1_inf).*delta_I.*x(J_i)+(1-p1_inf).*delta_V.*x(IV);

% Waning of immunity to severe disease
dxdt(R4_i)=SD_inflow_Intent-omega_R4.*x(R4_i)-alpha_R4.*x(R4_i).*x(R5_i)./NI_SD-lambda_FI.*x(R4_i)-vac_R.*x(R4_i);
dxdt(R5_i)=p2_sd.*(omega_R4.*x(R4_i)+alpha_R4.*x(R4_i).*x(R5_i)./NI_SD)-omega_R5.*x(R5_i)-lambda_FI.*x(R5_i)-vac_R.*x(R5_i);
% Infection but has immunity to severe disease from previous infection
dxdt(F_i)=lambda_FI.*x(R4_i)+lambda_FI.*x(R5_i)-sigma_E.*x(F_i);
dxdt(J_i)=sigma_E.*x(F_i)-delta_I.*x(J_i);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vaccinated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inflow to Vaccination compartment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V_inflow=q1_sd.*vac_R.*x(S_i)+vac_R.*x(R4_i)+vac_R.*x(R5_i)+vac_R.*x(V2)+vac_R.*x(V3);
dxdt(V1)=V_inflow-(1-eps_V1).*lambda_FI.*x(V1)-gammaV_1.*x(V1)-kappaV_1.*x(V1).*x(V2)./N_Vac;
dxdt(V2)=q2_sd.*(gammaV_1.*x(V1)+kappaV_1.*x(V1).*x(V2)./N_Vac)-(1-eps_V2).*lambda_FI.*x(V2)-gammaV_2.*x(V2)-kappaV_2.*x(V2).*x(V3)./N_Vac-vac_R.*x(V2); % those in V2 already have immunity to severe disease so they should just move back to V1 and not have a probability of loosing immunity to severe disease
dxdt(V3)=q3_sd.*(gammaV_2.*x(V2)+kappaV_2.*x(V2).*x(V3)./N_Vac)-(1-eps_V3).*lambda_FI.*x(V3)-gammaV_3.*x(V3)-vac_R.*x(V3); % those in V3 already have immunity to severe disease so they should just move back to V1 and not have a probability of loosing immunity to severe disease

% Infection
dxdt(EV)=(1-eps_V1).*lambda_FI.*x(V1)+(1-eps_V2).*lambda_FI.*x(V2)+(1-eps_V3).*lambda_FI.*x(V3)-sigma_E.*x(EV);
dxdt(IV)=sigma_E.*x(EV)-delta_V.*x(IV);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cumulative counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxdt(CI)=lambda_FI.*x(S_i)+lambda_FI.*x(R4_i)+lambda_FI.*x(R5_i)+lambda_FI.*x(S_n)+lambda_FI.*x(R4_n)+lambda_FI.*x(R5_n)+(1-eps_V1).*lambda_FI.*x(V1)+(1-eps_V2).*lambda_FI.*x(V2)+(1-eps_V3).*lambda_FI.*x(V3);
dxdt(C_Death)=pd.*(lambda_FI.*x(S_i)+lambda_FI.*x(S_n));
dxdt(C_Hosp)=ph.*(lambda_FI.*x(S_i)+lambda_FI.*x(S_n));

end


