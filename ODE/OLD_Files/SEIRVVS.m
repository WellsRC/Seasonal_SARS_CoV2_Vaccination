function dxdt = SEIRVVS(t,x,beta_I,sigma_E,delta_I,delta_V,gamma_V,omega_R,eps_V,psi_V,nu_V,C,pd,pd_v)
%SEIRVS Summary of this function goes here
%   Detailed explanation goes here
dxdt=zeros(size(x));
A=length(pd);


span_A=20.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;
V1=3+span_A;
S_i2=4+span_A;
V2=5+span_A;

E_n=6+span_A;
E_i=7+span_A;
E_v1=8+span_A;
E_v2=9+span_A;

I_n=10+span_A;
I_i=11+span_A;
I_v1=12+span_A;
I_v2=13+span_A;

R_n=14+span_A;
R_0i=15+span_A;
R_i=16+span_A;
R_v=17+span_A;


N=x(S_n)+x(S_i)+x(V1)+x(S_i2)+x(V2)+x(E_n)+x(E_i)+x(E_v1)+x(E_v2)+x(I_n)+x(I_i)+x(I_v1)+x(I_v2)+x(R_n)+x(R_i)+x(R_v)+x(R_0i);

CI=18+span_A;
CI_v=19+span_A;
C_Death=20+span_A;

vac_R=Vaccination_Function(t,nu_V);

vac_R2=zeros(size(vac_R));
if(t>=datenum('September 1, 2022')+180)
    vac_R2=Vaccination_Function(t-180,nu_V);
    vac_R2([0:(A-1)]<65)=0;
end


beta_t=Transmission_Rate(t,beta_I);

I_tot_FI=(x(I_n)+x(I_i)+(1-psi_V).*x(I_v1)+(1-psi_V).*x(I_v2))./N;
lambda_FI=beta_t.*(C*I_tot_FI);

% No intent to vaccinate
dxdt(S_n)=-lambda_FI.*x(S_n)+omega_R.*x(R_n)+gamma_V.*x(V2);
dxdt(E_n)=lambda_FI.*x(S_n)+lambda_FI.*x(S_i2)-sigma_E.*x(E_n);
dxdt(I_n)=sigma_E.*x(E_n)-delta_I.*x(I_n);
dxdt(R_n)=(1-pd).*delta_I.*x(I_n)+(1-pd_v).*delta_V.*x(I_v1)-omega_R.*x(R_n);

% Intent to vaccinate (1)
dxdt(R_0i)=-omega_R.*x(R_0i);
dxdt(S_i)=-lambda_FI.*x(S_i)-vac_R.*x(S_i)+omega_R.*x(R_0i);
dxdt(E_i)=lambda_FI.*x(S_i)-sigma_E.*x(E_i);
dxdt(I_i)=sigma_E.*x(E_i)-delta_I.*x(I_i);
dxdt(R_i)=(1-pd).*delta_I.*x(I_i)-omega_R.*x(R_i);

% Vaccinated (1)
dxdt(V1)=vac_R.*x(S_i)-(1-eps_V).*lambda_FI.*x(V1)-gamma_V.*x(V1);
dxdt(E_v1)=(1-eps_V).*lambda_FI.*x(V1)-sigma_E.*x(E_v1);
dxdt(I_v1)=sigma_E.*x(E_v1)-delta_V.*x(I_v1);
dxdt(R_v)=(1-pd_v).*delta_V.*x(I_v1)-omega_R.*x(R_v);

% Intend to vaccinate (2)
dxdt(S_i2)=-lambda_FI.*x(S_i2)-vac_R2.*x(S_i2)+omega_R.*x(R_i)+gamma_V.*x(V1)+omega_R.*x(R_v);

% Vaccinated (2)
dxdt(V2)=vac_R2.*x(S_i2)-(1-eps_V).*lambda_FI.*x(V1)-gamma_V.*x(V1);
dxdt(E_v2)=(1-eps_V).*lambda_FI.*x(V1)-sigma_E.*x(E_v1);
dxdt(I_v2)=sigma_E.*x(E_v1)-delta_V.*x(I_v1);

%Cumulative Infections
dxdt(CI)=lambda_FI.*x(S_i)+lambda_FI.*x(S_n)+lambda_FI.*x(S_i2);
dxdt(CI_v)=(1-eps_V).*lambda_FI.*x(V1)+(1-eps_V).*lambda_FI.*x(V2);
dxdt(C_Death)=(1-eps_V).*(lambda_FI.*x(V1)+lambda_FI.*x(V2)).*pd_v+(lambda_FI.*x(S_i2)+lambda_FI.*x(S_i)+lambda_FI.*x(S_n)).*pd;

end


