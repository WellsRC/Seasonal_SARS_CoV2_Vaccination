function  F=Likelihood_Reinfection(x,a,b,t,t_end_v,N_State)

lambda_r=10.^x(1:N_State)';
alpha_p=10.^x(N_State+(1:(N_State-1)))';
if(isempty(alpha_p))
    alpha_p=0;
end
p=x(2*N_State-1+(1:N_State))';

opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);

IC=zeros(N_State,1);

IC(1)=p(1);

[T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_r,alpha_p,p), [0 t_end_v(end)],IC, opts);

Model_Est=pchip(T,sum(Y,2),t);

p_end=pchip(T,sum(Y,2),t_end_v);

F=-sum(log(betapdf(Model_Est,a,b)))-sum(log(1-p_end)); % Multiply by length of a such that it has simailr wieght to the data; it was the least arbitray way I could think to construct it

end