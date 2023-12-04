function F=Likelihood_Severe_Disease(x,a,b,t,N_State,lambda_r_nat,alpha_p_nat,p_nat)

lambda_r_sd=10.^x(1:N_State)';
alpha_p_sd=10.^x(N_State+(1:(N_State-1)))';
if(isempty(alpha_p_sd))
    alpha_p_sd=0;
end
p_sd=x(2*N_State-1+(1:N_State))';

opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:(length(lambda_r_nat)+N_State));

IC=zeros(length(lambda_r_nat)+N_State,1);

IC(1)=p_nat(1);
IC(length(lambda_r_nat)+1)=(1-p_nat(1)).*p_sd(1);

[T,Y] = ode15s(@(t,y)Immunity_Wane_Severe_Disease_ODE(t,y,lambda_r_nat,alpha_p_nat,p_nat,lambda_r_sd,alpha_p_sd,p_sd), [0 max(t)],IC, opts);

Model_Est=pchip(T,sum(Y,2),t);

F=-sum(log(betapdf(Model_Est,a,b))); % Multiply by length of a such that it has simailr wieght to the data; it was the least arbitray way I could think to construct it

end