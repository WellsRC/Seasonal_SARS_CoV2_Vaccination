function dxdt = Two_Dose_SEIRVS(t,x,beta_I,sigma_E,delta_I,delta_V,gamma_V,gamma_SD,omega_R,eps_V,psi_V,nu_V,C,ph,ph_v,pd,pd_v,Add_dose)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(pd);


span_A=26.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;
S_i2=3+span_A;
S_p=4+span_A;
S_p2=5+span_A;
V=6+span_A;
V2=7+span_A;

E_n=8+span_A;
E_v=9+span_A;
E_v2=10+span_A;
E_p=11+span_A;
E_p2=12+span_A;

I_n=13+span_A;
I_v=14+span_A;
I_v2=15+span_A;
I_p=16+span_A;
I_p2=17+span_A;

R_n=18+span_A;
R_i=19+span_A;
R_i2=20+span_A;
R_p=21+span_A;
R_p2=22+span_A;

CI=23+span_A;
CI_v=24+span_A;
C_Death=25+span_A;
C_Hosp=26+span_A;

% Population size for the age classes
N=x(S_n)+x(S_i)+x(S_i2)+x(S_p)+x(S_p2)+x(V)+x(V2)+x(E_n)+x(E_v)+x(E_v2)+x(E_p)+x(E_p2)+x(I_n)+x(I_v)+x(I_v2)+x(I_p)+x(I_p2)+x(R_n)+x(R_i)+x(R_i2)+x(R_p)+x(R_p2);

% Vaccination rate for the annual vaccination campaign
vac_R=Vaccination_Function(t,nu_V);
if(Add_dose.Time<=t)
    vac_R_2=Vaccination_Function(Add_dose.t0+(t-Add_dose.Time),nu_V);
    vac_R_2(Add_dose.Age==0)=0;
else
    vac_R_2=zeros(size(vac_R));
end

% Transmission rate for
beta_t=Transmission_Rate(t,beta_I);
% Proportion of the age class infected 
I_tot_FI=(x(I_n)+x(I_p)+x(I_p2)+(1-psi_V).*x(I_v)+(1-psi_V).*x(I_v2))./N;
lambda_FI=beta_t.*(C*I_tot_FI);

% No intent to vaccinate
dxdt(S_n)=omega_R.*x(R_n)+gamma_SD.*x(S_p2)-lambda_FI.*x(S_n);
dxdt(E_n)=lambda_FI.*x(S_n)+lambda_FI.*x(S_i)+lambda_FI.*x(S_i2)-sigma_E.*x(E_n);
dxdt(I_n)=sigma_E.*x(E_n)-delta_I.*x(I_n);
dxdt(R_n)=(1-pd).*delta_I.*x(I_n)-omega_R.*x(R_n)+gamma_SD.*x(R_p2);

% Intent to vaccinate
dxdt(S_i)=omega_R.*x(R_i)-lambda_FI.*x(S_i)-vac_R.*x(S_i);
dxdt(R_i)=-omega_R.*x(R_i);

% Vaccinated
dxdt(V)=vac_R.*x(S_i)-(1-eps_V).*lambda_FI.*x(V)-gamma_V.*x(V);
dxdt(E_v)=(1-eps_V).*lambda_FI.*x(V)-sigma_E.*x(E_v);
dxdt(I_v)=sigma_E.*x(E_v)-delta_V.*x(I_v);

% Previosuly vaccinated
dxdt(S_p)=gamma_V.*x(V)-lambda_FI.*x(S_p)-gamma_SD.*x(S_p)-vac_R_2.*x(S_p)+omega_R.*x(R_p);
dxdt(E_p)=lambda_FI.*x(S_p)-sigma_E.*x(E_p);
dxdt(I_p)=sigma_E.*x(E_p)-delta_V.*x(I_p);
dxdt(R_p)=(1-pd_v).*delta_V.*x(I_p)+(1-pd_v).*delta_V.*x(I_v)-omega_R.*x(R_p)-gamma_SD.*x(R_p);

% Intent to vaccinate (2)
dxdt(S_i2)=gamma_SD.*x(S_p)+omega_R.*x(R_i2)-lambda_FI.*x(S_i2)-vac_R_2.*x(S_i2);
dxdt(R_i2)=gamma_SD.*x(R_p)-omega_R.*x(R_i2);

% Vaccinated (2)
dxdt(V2)=vac_R_2.*x(S_p)+vac_R_2.*x(S_i2)-(1-eps_V).*lambda_FI.*x(V2)-gamma_V.*x(V2);
dxdt(E_v2)=(1-eps_V).*lambda_FI.*x(V2)-sigma_E.*x(E_v2);
dxdt(I_v2)=sigma_E.*x(E_v2)-delta_V.*x(I_v2);

% Previosuly vaccinated (2)
dxdt(S_p2)=gamma_V.*x(V2)+omega_R.*x(R_p2)-lambda_FI.*x(S_p2)-gamma_SD.*x(S_p2);
dxdt(E_p2)=lambda_FI.*x(S_p2)-sigma_E.*x(E_p2);
dxdt(I_p2)=sigma_E.*x(E_p2)-delta_V.*x(I_p2);
dxdt(R_p2)=(1-pd_v).*delta_V.*x(I_p2)+(1-pd_v).*delta_V.*x(I_v2)-omega_R.*x(R_p2)-gamma_SD.*x(R_p2);

%Cumulative Infections
dxdt(CI)=lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(S_n);
dxdt(CI_v)=(1-eps_V).*lambda_FI.*x(V)+(1-eps_V).*lambda_FI.*x(V2)+lambda_FI.*x(S_p)+lambda_FI.*x(S_p2);
dxdt(C_Death)=pd_v.*((1-eps_V).*lambda_FI.*x(V)+(1-eps_V).*lambda_FI.*x(V2)+lambda_FI.*x(S_p)+lambda_FI.*x(S_p2))+pd.*(lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(S_n));
dxdt(C_Hosp)=ph_v.*((1-eps_V).*lambda_FI.*x(V)+(1-eps_V).*lambda_FI.*x(V2)+lambda_FI.*x(S_p)+lambda_FI.*x(S_p2))+ph.*(lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(S_n));

end


