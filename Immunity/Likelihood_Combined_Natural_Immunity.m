function F=Likelihood_Combined_Natural_Immunity(x,a_inf,b_inf,t_inf,t_end_v,a_sd,b_sd,t_sd,N_State_Inf,N_State_SD)

lambda_r_nat=10.^x(1:N_State_Inf)';
alpha_p_nat=10.^x(N_State_Inf+(1:(N_State_Inf-1)))';
p_nat=x(2*N_State_Inf-1+(1:N_State_Inf))';
npar_inf=3*N_State_Inf-1;

lambda_r_sd=10.^x(npar_inf+[1:N_State_SD])';
alpha_p_sd=10.^x(npar_inf+N_State_SD+(1:(N_State_SD-1)))';
p_sd=x(npar_inf+2*N_State_SD-1+(1:N_State_SD))';

opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:(N_State_Inf+N_State_SD));

IC=zeros(N_State_Inf+N_State_SD,1);

IC(1)=p_nat(1);
IC(N_State_Inf+1)=(1-p_nat(1)).*p_sd(1);

[T,Y] = ode15s(@(t,y)Immunity_Wane_Severe_Disease_ODE(t,y,lambda_r_nat,alpha_p_nat,p_nat,lambda_r_sd,alpha_p_sd,p_sd), [0 max([max(t_inf(:)) max(t_end_v(:)) max(t_sd(:))])],IC, opts);


Model_Est_inf=pchip(T,sum(Y(:,1:N_State_Inf),2),t_inf);
p_end=pchip(T,sum(Y(:,1:N_State_Inf),2),t_end_v);

F_inf=-sum(log(betapdf(Model_Est_inf,a_inf,b_inf)))-sum(log(1-p_end));

Model_Est_SD=pchip(T,sum(Y,2),t_sd);

F_sd=-sum(log(betapdf(Model_Est_SD,a_sd,b_sd))); % Multiply by length of a such that it has simailr wieght to the data; it was the least arbitray way I could think to construct it

F=F_inf+F_sd;
end