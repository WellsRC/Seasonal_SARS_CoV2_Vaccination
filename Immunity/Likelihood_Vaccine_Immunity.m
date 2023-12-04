function F = Likelihood_Vaccine_Immunity(x,a_sd,b_sd,t_sd,a_sd_range,b_sd_range,t_sd_range,y_ubnd,var_ubnd,t_ubnd,y_range_ubnd,var_range_ubnd,t_range_ubnd,a_boost,b_boost,t_boost,a_range,b_range,t_range,N_State)

eps_0=x(1);
if(N_State>1)
    p_red=x(2:(N_State));
    eps_inf=eps_0.*[1;(p_red(:))];
else
    eps_inf=eps_0;
end

lambda_sd=10.^x((N_State)+(1:N_State))';
alpha_sd=10.^x(2.*N_State+(1:(N_State-1)))';
if(isempty(alpha_sd))
    alpha_sd=0;
end
p_sd=x(3*N_State-1+(1:N_State))';

p_sd(p_sd<0 & abs(p_sd)<10^(-10))=0;

opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
IC=zeros(N_State,1);

IC(1)=p_sd(1);

[T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 max([max(t_sd(:)) max(t_sd_range(:)) max(t_ubnd(:)) max(t_boost(:)) max(t_range(:))])],IC, opts);


y_raw=zeros(size(T));
for ii=1:N_State
    y_raw=y_raw+eps_inf(ii).*Y(:,ii);
end

y_sd=pchip(T,sum(Y,2),t_sd);
y_model=pchip(T,y_raw,t_ubnd);
b_symp=y_model(:).*(1-y_model(:)).^2./var_ubnd(:)-(1-y_model(:));
a_symp=b_symp(:).*y_model(:)./(1-y_model(:));
F_ubnd=-sum(log(betacdf(y_ubnd(:),a_symp(:),b_symp(:))-betacdf(0,a_symp(:),b_symp(:))));

y_model=pchip(T,sum(Y,2),t_ubnd);
b_symp=y_model(:).*(1-y_model(:)).^2./var_ubnd(:)-(1-y_model(:));
a_symp=b_symp(:).*y_model(:)./(1-y_model(:));
F_lbnd=-sum(log(betacdf(1,a_symp(:),b_symp(:))-betacdf(y_ubnd(:),a_symp(:),b_symp(:))));

F_ubnd_range=zeros(size(y_range_ubnd));
F_1bnd_range=zeros(size(y_range_ubnd));
for ii=1:length(y_range_ubnd)
    y_model=pchip(T,y_raw,t_range_ubnd(ii,:));
    b_symp=y_model(:).*(1-y_model(:)).^2./var_range_ubnd(ii)-(1-y_model(:));
    a_symp=b_symp(:).*y_model(:)./(1-y_model(:));
    F_ubnd_range(ii)=-mean(log(betacdf(y_range_ubnd(ii),a_symp(:),b_symp(:))-betacdf(0,a_symp(:),b_symp(:))));

    y_model=pchip(T,sum(Y,2),t_range_ubnd(ii,:));
    b_symp=y_model(:).*(1-y_model(:)).^2./var_range_ubnd(ii)-(1-y_model(:));
    a_symp=b_symp(:).*y_model(:)./(1-y_model(:));
    F_1bnd_range(ii)=-mean(log(betacdf(1,a_symp(:),b_symp(:))-betacdf(y_range_ubnd(ii),a_symp(:),b_symp(:))));
end

F_sd=-sum(log(betapdf(y_sd,a_sd,b_sd)));

y_boost=pchip(T,y_raw,t_boost);
F_boost=-sum(log(betapdf(y_boost,a_boost,b_boost)));

F_range=zeros(size(a_range));
for ii=1:length(F_range)
    y_range=pchip(T,y_raw,t_range(ii,1):t_range(ii,2));
    F_range(ii)=-mean(log(betapdf(y_range,a_range(ii),b_range(ii))));
end

F_sd_range=zeros(size(a_sd_range));
for ii=1:length(F_sd_range)
    y_sd_range=pchip(T,sum(Y,2),t_sd_range(ii,1):t_sd_range(ii,2));
    F_sd_range(ii)=-mean(log(betapdf(y_sd_range,a_sd_range(ii),b_sd_range(ii))));
end

F=F_sd+F_ubnd+F_boost+sum(F_range(:))+sum(F_1bnd_range(:))+sum(F_ubnd_range(:))+F_lbnd;
end

