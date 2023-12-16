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
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_180_days.mat'])
Two_Dose=Comparison;
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_180_days.mat'])
Fast_Waning=Comparison;
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_180_days.mat'])
Slow_Waning=Comparison;

C_Plot=[hex2rgb('#0C7BDC');hex2rgb('#8856a7');hex2rgb('#9ebcda');];
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
ylim([3.*10^7 4.*10^7])

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
ylim([1.8*10^5 2.5.*10^5])
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
ylim([7.5.*10^3 10^4])
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
ylim([5.5.*10^9 7.5.*10^9])
text(-0.335,1,'D','Fontsize',28,'Units','Normalized');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
T= datetime(2022,9,1) + caldays(0:7:364);

load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_under_2_and_50_and_older_180_days.mat'])
Y2=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity_Age(1,5,:));

load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat'])
YA=squeeze(Output_Summary.Average.Inf_Vaccine_Immunity_Age(1,5,:));

subplot('Position',[0.065, 0.4,0.27 0.24])
plot(T,Y2,'-','color',C_Plot(1,:),'LineWidth',2); hold on
plot(T,YA,'-','color','k','LineWidth',2); hold on;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel({'Vaccine immunity','infection'},'FontSize',16)
xlabel('Date','FontSize',16)
xtickformat('MMM d' )

subplot('Position',[0.395, 0.4,0.27 0.24])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel({'Vaccine immunity','infection'},'FontSize',16)
xlabel('Date','FontSize',16)

subplot('Position',[0.725, 0.4,0.27 0.24])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel({'Vaccine immunity','infection'},'FontSize',16)
xlabel('Date','FontSize',16)

subplot('Position',[0.065, 0.07,0.27 0.24])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel({'Vaccine immunity','severe disease'},'FontSize',16)
xlabel('Date','FontSize',16)

subplot('Position',[0.395, 0.07,0.27 0.24])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel({'Vaccine immunity','severe disease'},'FontSize',16)
xlabel('Date','FontSize',16)

subplot('Position',[0.725, 0.07,0.27 0.24])

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14)
ylabel({'Vaccine immunity','severe disease'},'FontSize',16)
xlabel('Date','FontSize',16)


end
