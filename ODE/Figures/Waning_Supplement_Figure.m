function Figure_4
close all;
Y_Err.LineWidth=2;
Y_Err.Cap_Size=20;
XTL={'Baseline','Fast waning','Slow waning'};
temp_cd=pwd;
load([temp_cd(1:end-11) 'Contact_Matrix\Contact_USA_85.mat'],'N');
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
Pop=zeros(size(ACg,1),1);
for ii=1:length(Pop)
    Pop(ii)=sum(N(Av>=ACg(ii,1) & Av<=ACg(ii,2)));
end

temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_150_days.mat'])
Two_Dose=Comparison;
load([temp_cd 'Comparison_Summary_Main_Text_Two_Dose_vs_Annual_Fast_Waning_Vaccine.mat'])
Fast_Waning=Comparison;
load([temp_cd 'Comparison_Summary_Main_Text_Two_Dose_vs_Annual_Slow_Waning_Vaccine.mat'])
Slow_Waning=Comparison;

C_Plot=[hex2rgb('#0C7BDC');hex2rgb('#810f7c');hex2rgb('#9ebcda');];
figure('units','normalized','outerposition',[0 0.08 0.8 1]);
subplot('Position',[0.065, 0.77,0.18 0.2])

Y=[-Two_Dose.Average.Cumulative_Count_Incidence_dt;
    -Fast_Waning.Average.Cumulative_Count_Incidence_dt;
    -Slow_Waning.Average.Cumulative_Count_Incidence_dt;];
Y_Err.UB=[-Two_Dose.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5));
       -Fast_Waning.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5))
       -Slow_Waning.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5))];
Y_Err.LB=[-Two_Dose.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5));
       -Fast_Waning.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5))
       -Slow_Waning.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5))];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2 3],'XTickLabel',XTL)
ylabel({'Incidence','averted'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 3.5])
ylim([0 1.8.*10^7])

text(-0.335,1,'A','Fontsize',28,'Units','Normalized')

subplot('Position',[0.315, 0.77,0.18 0.2])

Y=[-Two_Dose.Average.Cumulative_Count_Hospital_dt;
    -Fast_Waning.Average.Cumulative_Count_Hospital_dt;
    -Slow_Waning.Average.Cumulative_Count_Hospital_dt;];
Y_Err.UB=[-Two_Dose.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5));
       -Fast_Waning.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5));
       -Slow_Waning.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5))];
Y_Err.LB=[-Two_Dose.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5));
       -Fast_Waning.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5));
       -Slow_Waning.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5))];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2 3],'XTickLabel',XTL)
ylabel({'Hospitalizations','averted'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 3.5])
ylim([0 2*10^5])
text(-0.335,1,'B','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.77,0.18 0.2])
Y=[-Two_Dose.Average.Cumulative_Count_Death_dt;
    -Fast_Waning.Average.Cumulative_Count_Death_dt;
    -Slow_Waning.Average.Cumulative_Count_Death_dt;];
Y_Err.UB=[-Two_Dose.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5));
       -Fast_Waning.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5))
       -Slow_Waning.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5))];
Y_Err.LB=[-Two_Dose.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5));
       -Fast_Waning.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5))
       -Slow_Waning.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5))];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2 3],'XTickLabel',XTL)
ylabel({'Deaths averted'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 3.5])
ylim([0 8500])
text(-0.335,1,'C','Fontsize',28,'Units','Normalized');

subplot('Position',[0.815, 0.77,0.18 0.2])
Y=[-Two_Dose.Average.Cost_Total_dt(end);
    -Fast_Waning.Average.Cost_Total_dt(end);
   -Slow_Waning.Average.Cost_Total_dt(end)];
Y_Err.UB=[-Two_Dose.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)';
    -Fast_Waning.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)';
       -Slow_Waning.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)'];
Y_Err.LB=[-Two_Dose.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)';
    -Fast_Waning.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)';
       -Slow_Waning.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)'];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2 3],'XTickLabel',XTL)
ylabel({'Cost','averted'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 3.5])
ylim([0 6.*10^9])
text(-0.335,1,'D','Fontsize',28,'Units','Normalized');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
T= datetime(2022,9,1) + caldays(0:7:364);

subplot('Position',[0.065, 0.37,0.27 0.24])
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_under_2_and_50_and_older_180_days.mat'])
Y2=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity);
YN=squeeze(Output_Summary.Average.Inf_Natural_Immunity);

load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat'])
YA=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity);
YAN=squeeze(Output_Summary.Average.Inf_Natural_Immunity);

plot(T,Y2,'-','color',C_Plot(1,:),'LineWidth',2); hold on;
plot(T,YA,'-.','color',C_Plot(1,:),'LineWidth',2); 
plot(T,YN,'-','color','k','LineWidth',2); 
plot(T,YAN,'-.','color','k','LineWidth',2); 
legend({'Vaccine: Two-dose','Vaccine: Single','Natural: Two-dose','Natural: Single'},'Location','north','NumColumns',2)
ylim([0 0.8])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)

ylabel('Immunity: Infection','FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )
ax=gca;
ax.XTickLabel = ax.XTickLabel;
xlim([T(1) T(end)])
box off;
title('Baseline')
text(-0.2,1,'E','Fontsize',28,'Units','Normalized');
subplot('Position',[0.395, 0.37,0.27 0.24])

load([temp_cd 'Model_Output_Summary_Main_Text_FDA_Two_Dose_ILC_Fast_Waning_Vaccine.mat'])
Y2=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity);
YN=squeeze(Output_Summary.Average.Inf_Natural_Immunity);

load([temp_cd 'Model_Output_Summary_Main_Text_Annual_Fast_Waning_Vaccine.mat'])
YA=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity);
YAN=squeeze(Output_Summary.Average.Inf_Natural_Immunity);

plot(T,Y2,'-','color',C_Plot(2,:),'LineWidth',2); hold on;
plot(T,YA,'-.','color',C_Plot(2,:),'LineWidth',2); 
plot(T,YN,'-','color','k','LineWidth',2); 
plot(T,YAN,'-.','color','k','LineWidth',2); 
legend({'Vaccine: Two-dose','Vaccine: Single','Natural: Two-dose','Natural: Single'},'Location','north','NumColumns',2)
ylim([0 0.8])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)

ylabel('Immunity: Infection','FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )
ax=gca;
ax.XTickLabel = ax.XTickLabel;
xlim([T(1) T(end)])
box off;
title('Fast Waning')
text(-0.2,1,'F','Fontsize',28,'Units','Normalized');

subplot('Position',[0.725, 0.37,0.27 0.24])

load([temp_cd 'Model_Output_Summary_Main_Text_FDA_Two_Dose_ILC_Slow_Waning_Vaccine.mat'])
Y2=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity);
YN=squeeze(Output_Summary.Average.Inf_Natural_Immunity);

load([temp_cd 'Model_Output_Summary_Main_Text_Annual_Slow_Waning_Vaccine.mat'])
YA=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity);
YAN=squeeze(Output_Summary.Average.Inf_Natural_Immunity);
plot(T,Y2,'-','color',C_Plot(3,:),'LineWidth',2); hold on;
plot(T,YA,'-.','color',C_Plot(3,:),'LineWidth',2); 
plot(T,YN,'-','color','k','LineWidth',2); 
plot(T,YAN,'-.','color','k','LineWidth',2); 
legend({'Vaccine: Two-dose','Vaccine: Single','Natural: Two-dose','Natural: Single'},'Location','north','NumColumns',2)
ylim([0 0.8])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)

ylabel('Immunity: Infection','FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )
ax=gca;
ax.XTickLabel = ax.XTickLabel;
xlim([T(1) T(end)])

box off;
title('Slow Waning')
text(-0.2,1,'G','Fontsize',28,'Units','Normalized');

subplot('Position',[0.065, 0.065,0.27 0.24])
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_under_2_and_50_and_older_180_days.mat'])
Y2=squeeze(Output_Summary.Average.SD_Vaccine_Immunity);
YN=squeeze(Output_Summary.Average.SD_Natural_Immunity);

load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat'])
YA=squeeze(Output_Summary.Average.SD_Vaccine_Immunity);
YAN=squeeze(Output_Summary.Average.SD_Natural_Immunity);
plot(T,Y2,'-','color',C_Plot(1,:),'LineWidth',2); hold on;
plot(T,YA,'-.','color',C_Plot(1,:),'LineWidth',2); 
plot(T,YN,'-','color','k','LineWidth',2); 
plot(T,YAN,'-.','color','k','LineWidth',2); 
legend({'Vaccine: Two-dose','Vaccine: Single','Natural: Two-dose','Natural: Single'},'Location','north','NumColumns',2)
ylim([0 1])
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel('Immunity: Severe Disease','FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )
ax=gca;
ax.XTickLabel = ax.XTickLabel;
xlim([T(1) T(end)])
box off;
text(-0.2,1,'H','Fontsize',28,'Units','Normalized');
subplot('Position',[0.395, 0.065,0.27 0.24])

load([temp_cd 'Model_Output_Summary_Main_Text_FDA_Two_Dose_ILC_Fast_Waning_Vaccine.mat'])
Y2=squeeze(Output_Summary.Average.SD_Vaccine_Immunity);
YN=squeeze(Output_Summary.Average.SD_Natural_Immunity);

load([temp_cd 'Model_Output_Summary_Main_Text_Annual_Fast_Waning_Vaccine.mat'])
YA=squeeze(Output_Summary.Average.SD_Vaccine_Immunity);
YAN=squeeze(Output_Summary.Average.SD_Natural_Immunity);

plot(T,Y2,'-','color',C_Plot(2,:),'LineWidth',2); hold on;
plot(T,YA,'-.','color',C_Plot(2,:),'LineWidth',2); 
plot(T,YN,'-','color','k','LineWidth',2); 
plot(T,YAN,'-.','color','k','LineWidth',2); 
legend({'Vaccine: Two-dose','Vaccine: Single','Natural: Two-dose','Natural: Single'},'Location','north','NumColumns',2)
ylim([0 1])
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel('Immunity: Severe Disease','FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )
ax=gca;
ax.XTickLabel = ax.XTickLabel;
xlim([T(1) T(end)])
box off;
text(-0.2,1,'I','Fontsize',28,'Units','Normalized');
subplot('Position',[0.725, 0.065,0.27 0.24])

load([temp_cd 'Model_Output_Summary_Main_Text_FDA_Two_Dose_ILC_Slow_Waning_Vaccine.mat'])
Y2=squeeze(Output_Summary.Average.SD_Vaccine_Immunity);
YN=squeeze(Output_Summary.Average.SD_Natural_Immunity);

load([temp_cd 'Model_Output_Summary_Main_Text_Annual_Slow_Waning_Vaccine.mat'])
YA=squeeze(Output_Summary.Average.SD_Vaccine_Immunity);
YAN=squeeze(Output_Summary.Average.SD_Natural_Immunity);

plot(T,Y2,'-','color',C_Plot(3,:),'LineWidth',2); hold on;
plot(T,YA,'-.','color',C_Plot(3,:),'LineWidth',2); 
plot(T,YN,'-','color','k','LineWidth',2); 
plot(T,YAN,'-.','color','k','LineWidth',2); 
legend({'Vaccine: Two-dose','Vaccine: Single','Natural: Two-dose','Natural: Single'},'Location','north','NumColumns',2)
ylim([0 1])
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel('Immunity: Severe Disease','FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )
ax=gca;
ax.XTickLabel = ax.XTickLabel;
xlim([T(1) T(end)])
text(-0.2,1,'J','Fontsize',28,'Units','Normalized');
print(gcf,['Figure_4.jpg'],'-djpeg','-r600');    
print(gcf,['Figure_4.png'],'-dpng','-r300');
end
