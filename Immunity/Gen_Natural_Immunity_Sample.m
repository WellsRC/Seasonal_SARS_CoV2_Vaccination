clear;
clc;
% 
% L=[];
% p=[];
% for ii=1:932
%     load(['Natural_Immunity_Sample_' num2str(ii) '.mat']);
%     L=[L;Log_L];
%     p=[p;x];
% end
% clear Log_L x

load('Natural_Immunity_Filler.mat','par_samp','L');
p=par_samp;
NS=10^4;
par_samp_ni=zeros(NS,13);
stratify_recovered=zeros(NS,5);

w=exp(L)./sum(exp(L));
wc=cumsum(w);
% Number of stages for immunity to infection
N_State_Inf=3;
% Number of additional stages for immunity to severe disease
N_State_SD=2;


T_P=[0:0.1:365];

Y_Inf=zeros(NS,length(T_P));
Y_SD=zeros(NS,length(T_P));

for ii=1:NS
    r=rand(1);
    f=find(r<=wc,1);
    x=p(f,:);

    lambda_r_nat=10.^x(1:N_State_Inf)';
    alpha_p_nat=10.^x(N_State_Inf+(1:(N_State_Inf-1)))';
    p_nat=x(2*N_State_Inf-1+(1:N_State_Inf))';
    npar_inf=3*N_State_Inf-1;
    
    lambda_r_sd=10.^x(npar_inf+[1:N_State_SD])';
    alpha_p_sd=10.^x(npar_inf+N_State_SD+(1:(N_State_SD-1)))';
    p_sd=x(npar_inf+2*N_State_SD-1+(1:N_State_SD))';
    par_samp_ni(ii,:)=[lambda_r_nat(:);alpha_p_nat(:); p_nat(:);lambda_r_sd(:);alpha_p_sd(:);p_sd(:)]';

    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:(N_State_Inf+N_State_SD));

    IC=zeros(N_State_Inf+N_State_SD,1);
    
    IC(1)=p_nat(1);
    IC(N_State_Inf+1)=(1-p_nat(1)).*p_sd(1);

    [T,Y] = ode15s(@(t,y)Immunity_Wane_Severe_Disease_ODE(t,y,lambda_r_nat,alpha_p_nat,p_nat,lambda_r_sd,alpha_p_sd,p_sd), [0 365],IC, opts);
    
    p1=integral(@(t)pchip(T,Y(:,1)./sum(Y,2),t),0,365)./(365);
    p2=integral(@(t)pchip(T,Y(:,2)./sum(Y,2),t),0,365)./(365);
    p3=integral(@(t)pchip(T,Y(:,3)./sum(Y,2),t),0,365)./(365);
    p4=integral(@(t)pchip(T,Y(:,4)./sum(Y,2),t),0,365)./(365);
    p5=integral(@(t)pchip(T,Y(:,5)./sum(Y,2),t),0,365)./(365);
    
    pt=p1+p2+p3+p4+p5;

    p1=p1./pt;
    p2=p2./pt;
    p3=p3./pt;
    p4=p4./pt;
    p5=p5./pt;
    Y_Inf(ii,:)=pchip(T,sum(Y(:,1:N_State_Inf),2),T_P);
    Y_SD(ii,:)=pchip(T,sum(Y,2),T_P);
    
    stratify_recovered(ii,:)=[mean(p1) mean(p2) mean(p3) mean(p4) mean(p5)];
end
save('Plot_Data_Waning_Natural_Immunity.mat','Y_Inf','Y_SD','T_P');
save('Sample_Natural_Immunity.mat','par_samp_ni','stratify_recovered');