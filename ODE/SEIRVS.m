function dxdt = SEIRVS(t,x,beta_I,sigma_E,delta_I,delta_V,gamma_V,omega_R,eps_V,vac_s,psi_V,nu_V,C,pd,pd_v)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(pd);


span_A=15.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;
V=3+span_A;

E_n=4+span_A;
E_i=5+span_A;
E_v=6+span_A;

I_n=7+span_A;
I_i=8+span_A;
I_v=9+span_A;

R_n=10+span_A;
R_i=11+span_A;
R_v=12+span_A;


N=x(S_n)+x(S_i)+x(V)+x(E_n)+x(E_i)+x(E_v)+x(I_n)+x(I_i)+x(I_v)+x(R_n)+x(R_i)+x(R_v);

CI=13+span_A;
CI_v=14+span_A;
C_Death=15+span_A;

if(vac_s)
    vac_R=nu_V.vac_rate;
else
    vac_R=Vaccination_Function(t,nu_V);
end

beta_t=Transmission_Rate(t,beta_I);

I_tot_FI=(x(I_n)+x(I_i)+(1-psi_V).*x(I_v))./N;
lambda_FI=beta_t.*(C*I_tot_FI);

% No intent to vaccinate
dxdt(S_n)=-lambda_FI.*x(S_n)+omega_R.*x(R_n)+(1-vac_s).*(gamma_V.*x(V)+omega_R.*x(R_v));
dxdt(E_n)=lambda_FI.*x(S_n)+(1-vac_s).*lambda_FI.*x(S_i)-sigma_E.*x(E_n);
dxdt(I_n)=sigma_E.*x(E_n)-delta_I.*x(I_n);
dxdt(R_n)=(1-pd).*delta_I.*x(I_n)-omega_R.*x(R_n);

% Intent to vaccinate
dxdt(S_i)=-lambda_FI.*x(S_i)-vac_R.*x(S_i)+omega_R.*x(R_i)+vac_s.*(gamma_V.*x(V)+omega_R.*x(R_v));
dxdt(E_i)=vac_s.*lambda_FI.*x(S_i)-sigma_E.*x(E_i);
dxdt(I_i)=sigma_E.*x(E_i)-delta_I.*x(I_i);
dxdt(R_i)=(1-pd).*delta_I.*x(I_i)-omega_R.*x(R_i);

% Vaccinated
dxdt(V)=vac_R.*x(S_i)-(1-eps_V).*lambda_FI.*x(V)-gamma_V.*x(V);
dxdt(E_v)=(1-eps_V).*lambda_FI.*x(V)-sigma_E.*x(E_v);
dxdt(I_v)=sigma_E.*x(E_v)-delta_V.*x(I_v);
dxdt(R_v)=(1-pd_v).*delta_V.*x(I_v)-omega_R.*x(R_v);

%Cumulative Infections
dxdt(CI)=lambda_FI.*x(S_i)+lambda_FI.*x(S_n);
dxdt(CI_v)=(1-eps_V).*lambda_FI.*x(V);
dxdt(C_Death)=(1-eps_V).*lambda_FI.*x(V).*pd_v+(lambda_FI.*x(S_i)+lambda_FI.*x(S_n)).*pd;

end


