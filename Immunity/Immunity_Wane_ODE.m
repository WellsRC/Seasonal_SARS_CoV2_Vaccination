function dydt=Immunity_Wane_ODE(t,y,lambda_r,alpha_p,p)

dydt=zeros(size(y));
dydt(1:end-1)=-lambda_r(1:end-1).*y(1:end-1)-alpha_p(1:end).*(y(1:end-1).*y(2:end)./sum(y));
dydt(end)=-lambda_r(end).*y(end);
dydt(2:end)=dydt(2:end)+p(2:end).*(lambda_r(1:end-1).*y(1:end-1)+alpha_p(1:end).*(y(1:end-1).*y(2:end)./sum(y)));


end