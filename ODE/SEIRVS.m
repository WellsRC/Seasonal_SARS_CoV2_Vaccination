function dxdt = SEIRVS(t,x,beta_I,sigma_E,delta_I,delta_V,gamma_V,omega_R,eps_V,psi_V,nu_V,N,C)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(N);


span_A=11.*[0:(A-1)];
S_n=1+span_A;
S_v=2+span_A;

V=3+span_A;

E=4+span_A;
E_v=5+span_A;

I=6+span_A;
I_v=7+span_A;

R_n=8+span_A;
R_v=9+span_A;

CI=10+span_A;
CI_v=11+span_A;

vac_R=Vaccination_Function(t,nu_V);

I_tot_FI=(x(I)+(1-psi_V).*x(I_v))./N;
lambda_FI=beta_I.*(C*I_tot_FI);

dxdt(S_n)=omega_R.*x(R_n)-lambda_FI.*x(S_n)+gamma_V.*x(V);

dxdt(S_v)=omega_R.*x(R_v)-lambda_FI.*x(S_v)-vac_R.*x(S_v);

dxdt(V)=vac_R.*x(S_v)-lambda_FI.*(1-eps_V).*x(V)-gamma_V.*x(V);

dxdt(E)=lambda_FI.*(x(S_n)+x(S_v))-sigma_E.*x(E);

dxdt(E_v)=lambda_FI.*(1-eps_V).*x(V)-sigma_E.*x(E_v);

dxdt(I)=sigma_E.*x(E)-delta_I.*x(I);

dxdt(I_v)=sigma_E.*x(E_v)-delta_V.*x(I_v);

dxdt(R_n)=delta_I.*x(I)-omega_R.*x(R_n);

dxdt(R_v)=-omega_R.*x(R_v);

dxdt(CI)=lambda_FI.*(x(S_n)+x(S_v));

dxdt(CI_v)=lambda_FI.*(1-eps_V).*x(V);
end

