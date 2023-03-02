function Figure_Temporal(State_V,Scenario)
close all;

load(['Analysis_Output_' Scenario '.mat']);

if(strcmp(State_V,'Incidence'))    
    Y_AC_PRCT=Incidence_AC_PRCT;
    Y_AC_mean=Incidence_AC_mean;
    
    Y_IC_PRCT=Incidence_IC_PRCT;
    Y_IC_mean=Incidence_IC_mean;
    yL={'Daily incidence'};
elseif(strcmp(State_V,'Hospital Admission'))
    Y_AC_PRCT=Hospital_Admission_AC_PRCT;
    Y_AC_mean=Hospital_Admission_AC_mean;
    
    Y_IC_PRCT=Hospital_Admission_IC_PRCT;
    Y_IC_mean=Hospital_Admission_IC_mean;
    yL={'Daily new admissions'};
    y_max=8.5*10^4;
elseif(strcmp(State_V,'Hospital Burden'))
    Y_AC_PRCT=Hospital_Burden_AC_PRCT;
    Y_AC_mean=Hospital_Burden_AC_mean;
    
    Y_IC_PRCT=Hospital_Burden_IC_PRCT;
    Y_IC_mean=Hospital_Burden_IC_mean;
    yL={'Current hospitalizations'};
elseif(strcmp(State_V,'Deaths'))
    Y_AC_PRCT=Death_AC_PRCT;
    Y_AC_mean=Death_AC_mean;
    
    Y_IC_PRCT=Death_IC_PRCT;
    Y_IC_mean=Death_IC_mean;
    yL={'Expected deaths from new infections'};
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Incidence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.2 0.8 0.6]);

subplot('Position',[0.047,0.2775,0.45,0.665]);
T_Plot=T_Run(1:end-1);
patch([T_Plot flip(T_Plot)],[Y_AC_PRCT(PRCT==2.5,:) flip(Y_AC_PRCT(PRCT==97.5,:))],hex2rgb('#FB6542'),'LineStyle','none','FaceAlpha',0.2);
hold on;
patch([T_Plot flip(T_Plot)],[Y_AC_PRCT(PRCT==25,:) flip(Y_AC_PRCT(PRCT==75,:))],hex2rgb('#FB6542'),'LineStyle','none','FaceAlpha',0.2);
plot(T_Plot,Y_AC_PRCT(PRCT==50,:),'-','color',hex2rgb('#FB6542'),'LineWidth',2);
plot(T_Plot,Y_AC_mean,'-.','color',hex2rgb('#FB6542'),'LineWidth',2); 
box off;
grid on;
xlim([T_Run(1) T_Run(end-1)]);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
xtickangle(90);
xlabel('Date','Fontsize',16);
ylabel(yL,'Fontsize',16);
title('Continual boosters')
ylim([0 y_max]);
subplot('Position',[0.54,0.2775,0.45,0.665]);
T_Plot=T_Run(1:end-1);
patch([T_Plot flip(T_Plot)],[Y_IC_PRCT(PRCT==2.5,:) flip(Y_IC_PRCT(PRCT==97.5,:))],hex2rgb('#375E97'),'LineStyle','none','FaceAlpha',0.2);
hold on;
patch([T_Plot flip(T_Plot)],[Y_IC_PRCT(PRCT==25,:) flip(Y_IC_PRCT(PRCT==75,:))],hex2rgb('#375E97'),'LineStyle','none','FaceAlpha',0.2);
plot(T_Plot,Y_IC_PRCT(PRCT==50,:),'-','color',hex2rgb('#375E97'),'LineWidth',2);
plot(T_Plot,Y_IC_mean,'-.','color',hex2rgb('#375E97'),'LineWidth',2); 
box off;
grid on;
xlim([T_Run(1) T_Run(end-1)]);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
xtickangle(90);
xlabel('Date','Fontsize',16);
ylabel(yL,'Fontsize',16);
title('Annual booster')
ylim([0 y_max]);
end
