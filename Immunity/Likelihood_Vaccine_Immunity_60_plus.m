function F = Likelihood_Vaccine_Immunity_60_plus(x,a_boost,b_boost,t_boost,a_sd,b_sd,t_sd,a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_range_sd,b_range_sd,t_range_sd,N_State)

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

opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
IC=zeros(N_State,1);

IC(1)=p_sd(1);

[T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 2.*365],IC, opts);


y_raw=zeros(size(T));
for ii=1:N_State
    y_raw=y_raw+eps_inf(ii).*Y(:,ii);
end

F_ubnd=zeros(size(var_lbnd_sd));
for ii=1:length(var_lbnd_sd)
    y_model=pchip(T,y_raw,t_lbnd_sd(ii,1):t_lbnd_sd(ii,2));
    b_symp=y_model(:).*(1-y_model(:)).^2./var_lbnd_sd(ii)-(1-y_model(:));
    a_symp=b_symp(:).*y_model(:)./(1-y_model(:));
    F_ubnd(ii)=-mean(log(betacdf(y_lbnd_sd(ii),a_symp(:),b_symp(:))-betacdf(0,a_symp(:),b_symp(:))));
end

F_lbnd_sd=zeros(size(var_lbnd_sd));
for ii=1:length(var_lbnd_sd)
    y_model=pchip(T,sum(Y,2),t_lbnd_sd(ii,1):t_lbnd_sd(ii,2));
    b_symp=y_model(:).*(1-y_model(:)).^2./var_lbnd_sd(ii)-(1-y_model(:));
    a_symp=b_symp(:).*y_model(:)./(1-y_model(:));
    F_lbnd_sd(ii)=-mean(log(betacdf(1,a_symp(:),b_symp(:))-betacdf(y_lbnd_sd(ii),a_symp(:),b_symp(:))));
end


y_boost=pchip(T,y_raw,t_boost);
F_boost=-sum(log(betapdf(y_boost,a_boost,b_boost)));

y_sd=pchip(T,sum(Y,2),t_sd);
F_sd=-(log(betapdf(y_sd,a_sd,b_sd)));
F_sd(isnan(b_sd))=log(y_sd(isnan(b_sd)));

F_range=zeros(size(a_range));
for ii=1:length(F_range)
    y_range=pchip(T,y_raw,t_range(ii,1):t_range(ii,2));
    F_range(ii)=-mean(log(betapdf(y_range,a_range(ii),b_range(ii))));
end

F_range_sd=zeros(size(a_range_sd));
for ii=1:length(F_range_sd)
    y_range_sd=pchip(T,sum(Y,2),t_range_sd(ii,1):t_range_sd(ii,2));
    F_range_sd(ii)=-mean(log(betapdf(y_range_sd,a_range_sd(ii),b_range_sd(ii))));
end

F=sum(F_lbnd_sd(:))+sum(F_ubnd(:))+F_boost+sum(F_range(:))+sum(F_range_sd(:))+sum(F_sd(:));
end

