clear;
close all;
clc;
load('Plot_Data_Waning_Natural_Immunity.mat','Y_Inf','T_P')

figure('units','normalized','outerposition',[0 0.02 1 1]);
subplot('Position',[0.05,0.58,0.43,0.38])
M_Inf=median(Y_Inf,1);

P_Inf=prctile(Y_Inf,[2.5 25 75 97.5]);

patch([T_P flip(T_P)],[P_Inf(1,:) flip(P_Inf(4,:))],'k','LineStyle','none','Facealpha',0.3); hold on
patch([T_P flip(T_P)],[P_Inf(2,:) flip(P_Inf(3,:))],'k','LineStyle','none','Facealpha',0.3); hold on
plot(T_P,M_Inf,'k','LineWidth',2)
xlim([0 365])
ylim([0 1])
box off;
set(gca,'LineWidth',2,'tickdir','out','YTick',[0:0.1:1],'FontSize',16,'XTick',[0:28:365]);
xlabel('Days post-recovery','fontsize',18)
ylabel('Efficacy against infection','fontsize',18)
title('Natural immunity')
grid on

load('Plot_Data_Waning_Vaccine_Immunity_Under_18.mat','Y_Inf','T_P');
subplot('Position',[0.55,0.58,0.43,0.38])
M_Inf=median(Y_Inf,1);

P_Inf=prctile(Y_Inf,[2.5 25 75 97.5]);

patch([T_P flip(T_P)],[P_Inf(1,:) flip(P_Inf(4,:))],'k','LineStyle','none','Facealpha',0.3); hold on
patch([T_P flip(T_P)],[P_Inf(2,:) flip(P_Inf(3,:))],'k','LineStyle','none','Facealpha',0.3); hold on
plot(T_P,M_Inf,'k','LineWidth',2)
xlim([0 365])
ylim([0 1])
box off;
set(gca,'LineWidth',2,'tickdir','out','YTick',[0:0.1:1],'FontSize',16,'XTick',[0:28:365]);
xlabel('Days post-vaccination','fontsize',18)
ylabel('Efficacy against infection','fontsize',18)
title(['Vaccine immunity: Ages 0' char(8211) '17'])
grid on


load('Plot_Data_Waning_Vaccine_Immunity_18_59.mat','Y_Inf','T_P');
subplot('Position',[0.05,0.09,0.43,0.38])
M_Inf=median(Y_Inf,1);

P_Inf=prctile(Y_Inf,[2.5 25 75 97.5]);

patch([T_P flip(T_P)],[P_Inf(1,:) flip(P_Inf(4,:))],'k','LineStyle','none','Facealpha',0.3); hold on
patch([T_P flip(T_P)],[P_Inf(2,:) flip(P_Inf(3,:))],'k','LineStyle','none','Facealpha',0.3); hold on
plot(T_P,M_Inf,'k','LineWidth',2)
xlim([0 365])
ylim([0 1])
box off;
set(gca,'LineWidth',2,'tickdir','out','YTick',[0:0.1:1],'FontSize',16,'XTick',[0:28:365]);
xlabel('Days post-vaccination','fontsize',18)
ylabel('Efficacy against infection','fontsize',18)
title(['Vaccine immunity: Ages 18' char(8211) '59'])
grid on


load('Plot_Data_Waning_Vaccine_Immunity_60_plus.mat','Y_Inf','T_P');
subplot('Position',[0.55,0.09,0.43,0.38])
M_Inf=median(Y_Inf,1);

P_Inf=prctile(Y_Inf,[2.5 25 75 97.5]);

patch([T_P flip(T_P)],[P_Inf(1,:) flip(P_Inf(4,:))],'k','LineStyle','none','Facealpha',0.3); hold on
patch([T_P flip(T_P)],[P_Inf(2,:) flip(P_Inf(3,:))],'k','LineStyle','none','Facealpha',0.3); hold on
plot(T_P,M_Inf,'k','LineWidth',2)
xlim([0 365])
ylim([0 1])
box off;
set(gca,'LineWidth',2,'tickdir','out','YTick',[0:0.1:1],'FontSize',16,'XTick',[0:28:365]);
xlabel('Days post-vaccination','fontsize',18)
ylabel('Efficacy against infection','fontsize',18)
title(['Vaccine immunity: Ages 60 and older'])
grid on

print(gcf,['Waning_Immunity_Infection.png'],'-dpng','-r600');