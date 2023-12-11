clear;
clc;

% L=[];
% p=[];
% for ii=1:476
%     load(['Vaccine_Immunity_18_59_Sample_' num2str(ii) '.mat']);
%     L=[L;Log_L(~isnan(Log_L) & ~isinf(Log_L))];
%     p=[p;x(~isnan(Log_L) & ~isinf(Log_L),:)];
% end
% clear Log_L x
% p=p(~isnan(L),:);
% L=L(~isnan(L));

load('Vaccine_Immunity_18_59_Filler.mat','par_samp','L');
p=par_samp;

w=exp(L)./sum(exp(L));
wc=cumsum(w);
NS=10^4;
par_samp_vi_18_59=zeros(NS,11);
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
    par_samp_vi_18_59(ii,:)=[eps_inf(:);lambda_sd(:); alpha_sd(:);p_sd(:)]';
end

save('Sample_18_to_59_Vaccine_Immunity.mat','par_samp_vi_18_59');