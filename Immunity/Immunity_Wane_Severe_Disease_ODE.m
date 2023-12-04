function dydt=Immunity_Wane_Severe_Disease_ODE(t,y,lambda_r_nat,alpha_p_nat,p_nat,lambda_r_sd,alpha_p_sd,p_sd)

Nat_Inf=length(lambda_r_nat);
Nat_SD=length(lambda_r_sd);

dydt=zeros(size(y));

% Immunity against infection
dydt(1:Nat_Inf-1)=-lambda_r_nat(1:end-1).*y(1:Nat_Inf-1)-alpha_p_nat(1:end).*(y(1:Nat_Inf-1).*y(2:Nat_Inf)./sum(y(1:Nat_Inf)));
dydt(Nat_Inf)=-lambda_r_nat(end).*y(Nat_Inf);
dydt(2:Nat_Inf)=dydt(2:Nat_Inf)+p_nat(2:end).*(lambda_r_nat(1:end-1).*y(1:Nat_Inf-1)+alpha_p_nat(1:end).*(y(1:Nat_Inf-1).*y(2:Nat_Inf)./sum(y(1:Nat_Inf))));

% Immunity against severe disease
% Inflow from above
dydt(Nat_Inf+1)=p_sd(1).*sum((1-p_nat(2:end)).*(lambda_r_nat(1:end-1).*y(1:Nat_Inf-1)+alpha_p_nat(1:end).*(y(1:Nat_Inf-1).*y(2:Nat_Inf)./sum(y(1:Nat_Inf)))))+p_sd(1).*lambda_r_nat(end).*y(Nat_Inf);
dydt(Nat_Inf+[1:Nat_SD-1])=dydt(Nat_Inf+[1:Nat_SD-1])-lambda_r_sd(1:end-1).*y(Nat_Inf+[1:Nat_SD-1])-alpha_p_sd(1:end).*(y(Nat_Inf+[1:Nat_SD-1]).*y(Nat_Inf+[2:Nat_SD])./sum(y(Nat_Inf+[1:Nat_SD])));
dydt(Nat_Inf+Nat_SD)=dydt(Nat_Inf+Nat_SD)-lambda_r_sd(end).*y(Nat_Inf+Nat_SD);
dydt(Nat_Inf+[2:Nat_SD])=dydt(Nat_Inf+[2:Nat_SD])+p_sd(2:end).*(lambda_r_sd(1:end-1).*y(Nat_Inf+[1:Nat_SD-1])+alpha_p_sd(1:end).*(y(Nat_Inf+[1:Nat_SD-1]).*y(Nat_Inf+[2:Nat_SD])./sum(y(Nat_Inf+[1:Nat_SD]))));

end