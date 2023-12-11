clear;
close all;
clc;

load('Sample_Under_18_Vaccine_Immunity.mat','par_samp_vi_U18');

N_State=3;
T_P=[0:0.1:365];
NS=size(par_samp_vi_U18,1);
Y_Inf=zeros(NS,length(T_P));
Y_SD=zeros(NS,length(T_P));
for ss=1:NS
    eps_inf=par_samp_vi_U18(ss,1:N_State)';
    lambda_sd=par_samp_vi_U18(ss,N_State+(1:N_State))';
    alpha_sd=par_samp_vi_U18(ss,2.*N_State+(1:N_State-1))';
    p_sd=par_samp_vi_U18(ss,3*N_State-1+(1:N_State))';
    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    IC=zeros(N_State,1);
    
    IC(1)=p_sd(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 365],IC, opts);
    
    y_raw=zeros(size(T));
    for ii=1:N_State
        y_raw=y_raw+eps_inf(ii).*Y(:,ii);
    end
    Y_Inf(ss,:)=pchip(T,y_raw,T_P);
    Y_SD(ss,:)=pchip(T,sum(Y,2),T_P);
end

figure('units','normalized','outerposition',[0.2 0.02 0.5 0.8]);
subplot('Position',[0.095042372881356,0.60,0.881652542372881,0.38])
M_Inf=median(Y_Inf,1);

P_Inf=prctile(Y_Inf,[2.5 25 75 97.5]);

patch([T_P flip(T_P)],[P_Inf(1,:) flip(P_Inf(4,:))],'k','LineStyle','none','Facealpha',0.3); hold on
patch([T_P flip(T_P)],[P_Inf(2,:) flip(P_Inf(3,:))],'k','LineStyle','none','Facealpha',0.3); hold on
plot(T_P,M_Inf,'k','LineWidth',2)
xlim([0 365])
ylim([0 1])
box off;
set(gca,'LineWidth',2,'tickdir','out','YTick',[0:0.1:1],'FontSize',16);
xlabel('Days post-vaccination','fontsize',18)
ylabel('Efficacy against infection','fontsize',18)

subplot('Position',[0.095042372881356,0.100,0.881652542372881,0.38])
M_Inf=median(Y_SD,1);

P_Inf=prctile(Y_SD,[2.5 25 76 97.5]);

patch([T_P flip(T_P)],[P_Inf(1,:) flip(P_Inf(4,:))],'r','LineStyle','none','Facealpha',0.3); hold on
patch([T_P flip(T_P)],[P_Inf(2,:) flip(P_Inf(3,:))],'r','LineStyle','none','Facealpha',0.3); hold on
plot(T_P,M_Inf,'r','LineWidth',2)
xlim([0 365])
ylim([0 1])
box off;
set(gca,'LineWidth',2,'tickdir','out','YTick',[0:0.1:1],'FontSize',16);
xlabel('Days post-vaccination','fontsize',18)
ylabel('Efficacy against severe disease','fontsize',18)
