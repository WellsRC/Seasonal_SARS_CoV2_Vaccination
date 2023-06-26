function dxdt = Delay_Two_Dose_SEIRVS(t,x,beta_I,sigma_E,delta_I,delta_V,gamma_V,gamma_SD,omega_R,eps_V,psi_V,nu_V,C,ph,ph_v,pd,pd_v,Add_dose,Delay_time)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(pd);


span_A=45.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;
S_i2=3+span_A;
S_p=4+span_A;
S_p2=5+span_A;
nvS_p=6+span_A;
V=7+span_A;
V2=8+span_A;
dS_i=10+span_A;
dS_i2=11+span_A;
dS_p=12+span_A;
dS_p2=13+span_A;
dnvS_p=14+span_A;
dV=15+span_A;
dV2=16+span_A;

E_n=17+span_A;
E_v=18+span_A;
E_v2=19+span_A;
E_p=20+span_A;
E_p2=21+span_A;
dE_v=22+span_A;
dE_v2=23+span_A;
dE_p=24+span_A;
dE_p2=25+span_A;

I_n=26+span_A;
I_v=27+span_A;
I_v2=28+span_A;
I_p=29+span_A;
I_p2=30+span_A;
dI_v=31+span_A;
dI_v2=32+span_A;
dI_p=33+span_A;
dI_p2=34+span_A;

R_n=35+span_A;
R_i=36+span_A;
R_p=37+span_A;
R_p2=38+span_A;
dR_i=39+span_A;
dR_p=40+span_A;
dR_p2=41+span_A;

CI=42+span_A;
CI_v=43+span_A;
C_Death=44+span_A;
C_Hosp=45+span_A;

% Population size for the age classes
N=x(S_n)+x(E_n)+x(I_n)+x(R_n)+x(dS_i)+x(dS_i2)+x(dS_p)+x(dS_p2)+x(dnvS_p)+x(dV)+x(dV2)+x(dE_v)+x(dE_v2)+x(dE_p)+x(dE_p2)+x(dI_v)+x(dI_v2)+x(dI_p)+x(dI_p2)+x(dR_i)+x(dR_p)+x(dR_p2)+x(S_i)+x(S_i2)+x(S_p)+x(S_p2)+x(nvS_p)+x(V)+x(V2)+x(E_v)+x(E_v2)+x(E_p)+x(E_p2)+x(I_v)+x(I_v2)+x(I_p)+x(I_p2)+x(R_i)+x(R_p)+x(R_p2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vaccination rate for the annual vaccination campaign
vac_R=Vaccination_Function(t,nu_V);
if(Add_dose.Time<=t)
    vac_R_2=Vaccination_Function(Add_dose.t0+(t-Add_dose.Time),nu_V);
    vac_R_2(Add_dose.Age==0)=0;
else
    vac_R_2=zeros(size(vac_R));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vaccination rate for the annual vaccination campaign
if(nu_V.t0<=(t-Delay_time))
    dvac_R=Vaccination_Function((t-Delay_time),nu_V);
else    
    dvac_R=zeros(size(nu_V.vac_rate));
end
if(Add_dose.Time<=(t-Delay_time))
    dvac_R_2=Vaccination_Function(Add_dose.t0+((t-Delay_time)-Add_dose.Time),nu_V);
    dvac_R_2(Add_dose.Age==0)=0;
else
    dvac_R_2=zeros(size(vac_R));
end


% Transmission rate for
beta_t=Transmission_Rate(t,beta_I);
% Proportion of the age class infected 
I_tot_FI=(x(I_n)+x(dI_p)+x(dI_p2)+(1-psi_V).*x(dI_v)+(1-psi_V).*x(dI_v2)+x(I_p)+x(I_p2)+(1-psi_V).*x(I_v)+(1-psi_V).*x(I_v2))./N;
lambda_FI=beta_t.*(C*I_tot_FI);

% No intent to vaccinate
dxdt(S_n)=omega_R.*x(R_n)+gamma_SD.*x(S_p2)+gamma_SD.*x(nvS_p)+gamma_SD.*x(dS_p2)+gamma_SD.*x(dnvS_p)-lambda_FI.*x(S_n);
dxdt(E_n)=lambda_FI.*x(S_n)+lambda_FI.*x(S_i)+lambda_FI.*x(S_i2)+lambda_FI.*x(dS_i)+lambda_FI.*x(dS_i2)-sigma_E.*x(E_n);
dxdt(I_n)=sigma_E.*x(E_n)-delta_I.*x(I_n);
dxdt(R_n)=(1-pd).*delta_I.*x(I_n)-omega_R.*x(R_n)+gamma_SD.*x(R_p2)+gamma_SD.*x(R_p)+gamma_SD.*x(dR_p2)+gamma_SD.*x(dR_p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Intent to vaccinate
dxdt(S_i)=omega_R.*x(R_i)-lambda_FI.*x(S_i)-vac_R.*x(S_i);
dxdt(R_i)=-omega_R.*x(R_i);

% Vaccinated
dxdt(V)=vac_R.*x(S_i)-(1-eps_V).*lambda_FI.*x(V)-gamma_V.*x(V);
dxdt(E_v)=(1-eps_V).*lambda_FI.*x(V)-sigma_E.*x(E_v);
dxdt(I_v)=sigma_E.*x(E_v)-delta_V.*x(I_v);

% Previosuly vaccinated

dxdt(S_p)=gamma_V.*x(V)-lambda_FI.*x(S_p)-gamma_SD.*x(S_p)-vac_R_2.*x(S_p);
dxdt(E_p)=lambda_FI.*x(S_p)+lambda_FI.*x(nvS_p)-sigma_E.*x(E_p);
dxdt(I_p)=sigma_E.*x(E_p)-delta_V.*x(I_p);
dxdt(R_p)=(1-pd_v).*delta_V.*x(I_p)+(1-pd_v).*delta_V.*x(I_v)-omega_R.*x(R_p)-gamma_SD.*x(R_p);

dxdt(nvS_p)=omega_R.*x(R_p)-lambda_FI.*x(nvS_p)-gamma_SD.*x(nvS_p);

% Intent to vaccinate (2)
dxdt(S_i2)=gamma_SD.*x(S_p)-lambda_FI.*x(S_i2)-vac_R_2.*x(S_i2);

% Vaccinated (2)
dxdt(V2)=vac_R_2.*x(S_p)+vac_R_2.*x(S_i2)-(1-eps_V).*lambda_FI.*x(V2)-gamma_V.*x(V2);
dxdt(E_v2)=(1-eps_V).*lambda_FI.*x(V2)-sigma_E.*x(E_v2);
dxdt(I_v2)=sigma_E.*x(E_v2)-delta_V.*x(I_v2);

% Previosuly vaccinated (2)
dxdt(S_p2)=gamma_V.*x(V2)+omega_R.*x(R_p2)-lambda_FI.*x(S_p2)-gamma_SD.*x(S_p2);
dxdt(E_p2)=lambda_FI.*x(S_p2)-sigma_E.*x(E_p2);
dxdt(I_p2)=sigma_E.*x(E_p2)-delta_V.*x(I_p2);
dxdt(R_p2)=(1-pd_v).*delta_V.*x(I_p2)+(1-pd_v).*delta_V.*x(I_v2)-omega_R.*x(R_p2)-gamma_SD.*x(R_p2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Intent to vaccinate
dxdt(dS_i)=omega_R.*x(dR_i)-lambda_FI.*x(dS_i)-dvac_R.*x(dS_i);
dxdt(dR_i)=-omega_R.*x(dR_i);

% Vaccinated
dxdt(dV)=dvac_R.*x(dS_i)-(1-eps_V).*lambda_FI.*x(dV)-gamma_V.*x(dV);
dxdt(dE_v)=(1-eps_V).*lambda_FI.*x(dV)-sigma_E.*x(dE_v);
dxdt(dI_v)=sigma_E.*x(dE_v)-delta_V.*x(dI_v);

% Previosuly vaccinated

dxdt(dS_p)=gamma_V.*x(dV)-lambda_FI.*x(dS_p)-gamma_SD.*x(dS_p)-dvac_R_2.*x(dS_p);
dxdt(dE_p)=lambda_FI.*x(dS_p)+lambda_FI.*x(dnvS_p)-sigma_E.*x(dE_p);
dxdt(dI_p)=sigma_E.*x(dE_p)-delta_V.*x(dI_p);
dxdt(dR_p)=(1-pd_v).*delta_V.*x(dI_p)+(1-pd_v).*delta_V.*x(dI_v)-omega_R.*x(dR_p)-gamma_SD.*x(dR_p);

dxdt(dnvS_p)=omega_R.*x(dR_p)-lambda_FI.*x(dnvS_p)-gamma_SD.*x(dnvS_p);

% Intent to vaccinate (2)
dxdt(dS_i2)=gamma_SD.*x(dS_p)-lambda_FI.*x(dS_i2)-dvac_R_2.*x(dS_i2);

% Vaccinated (2)
dxdt(dV2)=dvac_R_2.*x(dS_p)+dvac_R_2.*x(dS_i2)-(1-eps_V).*lambda_FI.*x(dV2)-gamma_V.*x(dV2);
dxdt(dE_v2)=(1-eps_V).*lambda_FI.*x(dV2)-sigma_E.*x(dE_v2);
dxdt(dI_v2)=sigma_E.*x(dE_v2)-delta_V.*x(dI_v2);

% Previosuly vaccinated (2)
dxdt(dS_p2)=gamma_V.*x(dV2)+omega_R.*x(dR_p2)-lambda_FI.*x(dS_p2)-gamma_SD.*x(dS_p2);
dxdt(dE_p2)=lambda_FI.*x(dS_p2)-sigma_E.*x(dE_p2);
dxdt(dI_p2)=sigma_E.*x(dE_p2)-delta_V.*x(dI_p2);
dxdt(dR_p2)=(1-pd_v).*delta_V.*x(dI_p2)+(1-pd_v).*delta_V.*x(dI_v2)-omega_R.*x(dR_p2)-gamma_SD.*x(dR_p2);

%Cumulative Infections
dxdt(CI)=lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(dS_i2)+lambda_FI.*x(dS_i)+lambda_FI.*x(S_n);
dxdt(CI_v)=(1-eps_V).*lambda_FI.*x(V)+(1-eps_V).*lambda_FI.*x(V2)+lambda_FI.*x(nvS_p)+lambda_FI.*x(S_p)+lambda_FI.*x(S_p2)+(1-eps_V).*lambda_FI.*x(dV)+(1-eps_V).*lambda_FI.*x(dV2)+lambda_FI.*x(dnvS_p)+lambda_FI.*x(dS_p)+lambda_FI.*x(dS_p2);
dxdt(C_Death)=pd_v.*((1-eps_V).*lambda_FI.*x(V)+(1-eps_V).*lambda_FI.*x(V2)+lambda_FI.*x(nvS_p)+lambda_FI.*x(S_p)+lambda_FI.*x(S_p2)+(1-eps_V).*lambda_FI.*x(dV)+(1-eps_V).*lambda_FI.*x(dV2)+lambda_FI.*x(dnvS_p)+lambda_FI.*x(dS_p)+lambda_FI.*x(dS_p2))+pd.*(lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(dS_i2)+lambda_FI.*x(dS_i)+lambda_FI.*x(S_n));
dxdt(C_Hosp)=ph_v.*((1-eps_V).*lambda_FI.*x(V)+(1-eps_V).*lambda_FI.*x(V2)+lambda_FI.*x(nvS_p)+lambda_FI.*x(S_p)+lambda_FI.*x(S_p2)+(1-eps_V).*lambda_FI.*x(dV)+(1-eps_V).*lambda_FI.*x(dV2)+lambda_FI.*x(dnvS_p)+lambda_FI.*x(dS_p)+lambda_FI.*x(dS_p2))+ph.*(lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(dS_i2)+lambda_FI.*x(dS_i)+lambda_FI.*x(S_n));

end


