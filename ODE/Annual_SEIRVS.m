function dxdt = Annual_SEIRVS(t,x,beta_I,sigma_E,delta_I,delta_V,gamma_V,gamma_SD,omega_R,eps_V,psi_V,nu_V,C,ph,ph_v,pd,pd_v)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(pd);


span_A=17.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;
S_p=3+span_A;
V=4+span_A;

E_n=5+span_A;
E_v=6+span_A;
E_p=7+span_A;

I_n=8+span_A;
I_v=9+span_A;
I_p=10+span_A;

R_n=11+span_A;
R_i=12+span_A;
R_p=13+span_A;

CI=14+span_A;
CI_v=15+span_A;
C_Death=16+span_A;
C_Hosp=17+span_A;

% Population size for the age classes
N=x(S_n)+x(S_i)+x(S_p)+x(V)+x(E_n)+x(E_v)+x(E_p)+x(I_n)+x(I_v)+x(I_p)+x(R_n)+x(R_i)+x(R_p);

% Vaccination rate for the annual vaccination campaign
vac_R=Vaccination_Function(t,nu_V);

% Transmission rate for
beta_t=Transmission_Rate(t,beta_I);
% Proportion of the age class infected 
I_tot_FI=(x(I_n)+x(I_p)+(1-psi_V).*x(I_v))./N;
lambda_FI=beta_t.*(C*I_tot_FI);

% No intent to vaccinate
dxdt(S_n)=omega_R.*x(R_n)+gamma_SD.*x(S_p)-lambda_FI.*x(S_n);
dxdt(E_n)=lambda_FI.*x(S_n)+lambda_FI.*x(S_i)-sigma_E.*x(E_n);
dxdt(I_n)=sigma_E.*x(E_n)-delta_I.*x(I_n);
dxdt(R_n)=(1-pd).*delta_I.*x(I_n)-omega_R.*x(R_n)+gamma_SD.*x(R_p);

% Intent to vaccinate
dxdt(S_i)=omega_R.*x(R_i)-lambda_FI.*x(S_i)-vac_R.*x(S_i);
dxdt(R_i)=-omega_R.*x(R_i);

% Vaccinated
dxdt(V)=vac_R.*x(S_i)-(1-eps_V).*lambda_FI.*x(V)-gamma_V.*x(V);
dxdt(E_v)=(1-eps_V).*lambda_FI.*x(V)-sigma_E.*x(E_v);
dxdt(I_v)=sigma_E.*x(E_v)-delta_V.*x(I_v);

% Previosuly vaccinated
dxdt(S_p)=gamma_V.*x(V)-lambda_FI.*x(S_p)-gamma_SD.*x(S_p)+omega_R.*x(R_p);
dxdt(E_p)=lambda_FI.*x(S_p)-sigma_E.*x(E_p);
dxdt(I_p)=sigma_E.*x(E_p)-delta_V.*x(I_p);
dxdt(R_p)=(1-pd_v).*delta_V.*x(I_p)+(1-pd_v).*delta_V.*x(I_v)-omega_R.*x(R_p)-gamma_SD.*x(R_p);

%Cumulative Infections
dxdt(CI)=lambda_FI.*x(S_i)+lambda_FI.*x(S_n);
dxdt(CI_v)=(1-eps_V).*lambda_FI.*x(V)+lambda_FI.*x(S_p);
dxdt(C_Death)=pd_v.*((1-eps_V).*lambda_FI.*x(V)+lambda_FI.*x(S_p))+pd.*(lambda_FI.*x(S_i)+lambda_FI.*x(S_n));
dxdt(C_Hosp)=ph_v.*((1-eps_V).*lambda_FI.*x(V)+lambda_FI.*x(S_p))+ph.*(lambda_FI.*x(S_i)+lambda_FI.*x(S_n));

end


