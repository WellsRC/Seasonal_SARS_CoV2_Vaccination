function F=Fit_Vac_Timing_Alt(x,T_Run,Vac_t,T_Eval)
x=10.^x;
nu_V.vac_rate=x(1);
X0=x(2);

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1);

[T,Y] = ode15s(@(t,x)ODE_Vac_Alt(t,x,nu_V.vac_rate), [min(T_Run) max(T_Run)], X0, opts);
test=(sum(X0).*ones(length(T),1)-sum(Y,2));

M=pchip(T,test,T_Eval);

F=(M(:)-Vac_t(:)).^2;

F=mean(F(:));
end