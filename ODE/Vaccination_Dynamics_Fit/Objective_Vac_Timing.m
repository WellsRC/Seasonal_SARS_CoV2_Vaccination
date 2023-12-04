function F=Objective_Vac_Timing(x,T_Run,Vac_t,T_Eval)
x=10.^x;
nu_V.vac_rate=x(1);
nu_V.t0=T_Run(1);
nu_V.n=x(3);

nu_V.vac_start=datenum('September 1, 2022');
nu_V.vac_delay_start=x(2);
X0=max(Vac_t);

opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1);

[T,Y] = ode15s(@(t,x)ODE_Vac(t,x,nu_V), [min(T_Run) max(T_Run)], X0, opts);
test=(sum(X0).*ones(length(T),1)-sum(Y,2));

M=pchip(T,test,T_Eval);

[~,nLL]=fminbnd(@(z)-sum(log(normpdf(Vac_t(:),M(:),10.^z))),-4,3);

F=-nLL;
end