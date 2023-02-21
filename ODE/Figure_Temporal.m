clear;
clc;
close all;

load('Output_Sample.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Incidence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.2 0.8 0.6]);

subplot('Position',[0.059,0.265,0.93,0.675]);
T_Plot=T_Run(1:end-1);
patch([T_Plot flip(T_Plot)],[DI_PRCT(1,:) flip(DI_PRCT(5,:))],'k','LineStyle','none','FaceAlpha',0.2);
hold on;
patch([T_Plot flip(T_Plot)],[DI_PRCT(2,:) flip(DI_PRCT(4,:))],'k','LineStyle','none','FaceAlpha',0.2);
plot(T_Plot,DI_PRCT(3,:),'k-','LineWidth',2);
plot(T_Plot,DI_mean,'k-.','LineWidth',2); 
box off;

xlim([T_Run(1) T_Run(end-1)]);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
xtickangle(45);
xlabel('Date','Fontsize',16);
ylabel('Daily incidence','Fontsize',16);

print(gcf,['Daily_Incidence.png'],'-dpng','-r300');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Hospital admission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.2 0.8 0.6]);

subplot('Position',[0.059,0.265,0.93,0.675]);
T_Plot=T_Run(1:end-1);
patch([T_Plot flip(T_Plot)],[DH_PRCT(1,:) flip(DH_PRCT(5,:))],'k','LineStyle','none','FaceAlpha',0.2);
hold on;
patch([T_Plot flip(T_Plot)],[DH_PRCT(2,:) flip(DH_PRCT(4,:))],'k','LineStyle','none','FaceAlpha',0.2);
plot(T_Plot,DH_PRCT(3,:),'k-','LineWidth',2);
plot(T_Plot,DH_mean,'k-.','LineWidth',2); 
box off;

xlim([T_Run(1) T_Run(end-1)]);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
xtickangle(45);
xlabel('Date','Fontsize',16);
ylabel('Daily hospital admission','Fontsize',16);

print(gcf,['Daily_Hospital_Admission.png'],'-dpng','-r300');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Hospital Prevalence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.2 0.8 0.6]);

subplot('Position',[0.059,0.265,0.93,0.675]);
T_Plot=T_Run(1:end-1);
patch([T_Plot flip(T_Plot)],[PH_PRCT(1,:) flip(PH_PRCT(5,:))],'k','LineStyle','none','FaceAlpha',0.2);
hold on;
patch([T_Plot flip(T_Plot)],[PH_PRCT(2,:) flip(PH_PRCT(4,:))],'k','LineStyle','none','FaceAlpha',0.2);
plot(T_Plot,PH_PRCT(3,:),'k-','LineWidth',2);
plot(T_Plot,PH_mean,'k-.','LineWidth',2); 
box off;

xlim([T_Run(1) T_Run(end-1)]);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
xtickangle(45);
xlabel('Date','Fontsize',16);
ylabel('Daily hospital occupancy','Fontsize',16);

print(gcf,['Daily_Hospital_Prevalence.png'],'-dpng','-r300');