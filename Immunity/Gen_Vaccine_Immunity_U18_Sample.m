clear;
clc;

L=[];
p=[];
for ii=1:707
    load(['Vaccine_Immunity_Under_18_Sample_' num2str(ii) '.mat']);
    L=[L;Log_L];
    p=[p;x];
end
clear Log_L x
p=p(~isnan(L),:);
L=L(~isnan(L));
L=L(p(:,4)>=-4 & p(:,5)>=-4 & p(:,6)>=-4 & p(:,7)>=-2 & p(:,8)>=-2);
p=p(p(:,4)>=-4 & p(:,5)>=-4 & p(:,6)>=-4 & p(:,7)>=-2 & p(:,8)>=-2,:);
w=exp(L)./sum(exp(L));
wc=cumsum(w);
NS=10^4;
par_samp_vi_U18=zeros(NS,11);
% Number of stages for immunity to infection
N_State=3;
for ii=1:NS
    r=rand(1);
    f=find(r<=wc,1);
    x=p(f,:);

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
    par_samp_vi_U18(ii,:)=[eps_inf(:);lambda_sd(:); alpha_sd(:);p_sd(:)]';
end

save('Sample_Under_18_Vaccine_Immunity.mat','par_samp_vi_U18');