function Figure_2()
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
dx=linspace(0,1,9);
dx=dx(2:end);
C_Plot=interp1([0 1],[hex2rgb('#ffffff'); hex2rgb('#0C7BDC')],dx);
Y_Err.LineWidth=2;
XTL=cell(8,1);
for ii=1:8
    XTL{ii}=num2str(90+30.*(ii-1));
end

PRCT=[2.5 25 50 75 97.5];

figure('units','normalized','outerposition',[0 0.08 0.8 1]);
subplot('Position',[0.065, 0.77,0.18 0.2])
Y_Err.Cap_Size=10;

Y=zeros(8,1);
Y_Err.LB=zeros(8,1);
Y_Err.UB=zeros(8,1);
for dd=90:30:300
    load([temp_cd 'Marginal_Benefit_Direct_Main_Text_under_2_50_Second_dose_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=100.*Marginal_Benefit.Average.Incidence;
    Y_Err.LB(dd./30-2)=100.*Marginal_Benefit.PRCT.Incidence(PRCT==97.5);
    Y_Err.UB(dd./30-2)=100.*Marginal_Benefit.PRCT.Incidence(PRCT==2.5);
end

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel('Incremental benefit','FontSize',16)
xlabel('Days between doses','FontSize',16)
title('Incidence')
xlim([0.5 8.5])
ylim([0 45])
ytickformat('percentage')

text(-0.345,1.025,'A','Fontsize',28,'Units','Normalized')

subplot('Position',[0.315, 0.77,0.18 0.2])
Y=zeros(8,1);
Y_Err.LB=zeros(8,1);
Y_Err.UB=zeros(8,1);
for dd=90:30:300
    load([temp_cd 'Marginal_Benefit_Direct_Main_Text_under_2_50_Second_dose_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=100.*Marginal_Benefit.Average.Hospitalization;
    Y_Err.LB(dd./30-2)=100.*Marginal_Benefit.PRCT.Hospitalization(PRCT==97.5);
    Y_Err.UB(dd./30-2)=100.*Marginal_Benefit.PRCT.Hospitalization(PRCT==2.5);
end

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel({'Incremental benefit'},'FontSize',16)
title('Hospitalizations')
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])
ylim([0 45])
ytickformat('percentage')

text(-0.345,1.025,'B','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.77,0.18 0.2])
Y=zeros(8,1);
Y_Err.LB=zeros(8,1);
Y_Err.UB=zeros(8,1);
for dd=90:30:300
    load([temp_cd 'Marginal_Benefit_Direct_Main_Text_under_2_50_Second_dose_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=100.*Marginal_Benefit.Average.Death;
    Y_Err.LB(dd./30-2)=100.*Marginal_Benefit.PRCT.Death(PRCT==97.5);
    Y_Err.UB(dd./30-2)=100.*Marginal_Benefit.PRCT.Death(PRCT==2.5);
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel({'Incremental benefit'},'FontSize',16)
title('Deaths')
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])

ylim([0 45])
ytickformat('percentage')
text(-0.345,1.025,'C','Fontsize',28,'Units','Normalized');

subplot('Position',[0.815, 0.77,0.18 0.2])

for dd=90:30:300
    load([temp_cd 'Marginal_Benefit_Direct_Main_Text_under_2_50_Second_dose_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=100.*Marginal_Benefit.Average.Cost;
    Y_Err.LB(dd./30-2)=100.*Marginal_Benefit.PRCT.Cost(PRCT==97.5);
    Y_Err.UB(dd./30-2)=100.*Marginal_Benefit.PRCT.Cost(PRCT==2.5);
end

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel({'Incremental benefit'},'FontSize',16)
title('Direct costs')
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])

ylim([0 45])
ytickformat('percentage')
text(-0.345,1.025,'D','Fontsize',28,'Units','Normalized');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Age_C={['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
Y_Err.LineWidth=1.1;
Y_Err.Cap_Size=0;
subplot('Position',[0.065, 0.41,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=-100.*Comparison.Average.Age_Cumulative_Count_Incidence_rel(:,1:7,end);
    Y_Err.LB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,1:7,end);
    Y_Err.UB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,1:7,end);
end

Error_Bar_Plot(Y,Y_Err,C_Plot);

box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)
ytickformat('percentage');
xlim([0.5 7.5])
ylabel('Incidence reduction','FontSize',16)
xlabel('Age class','FontSize',16)
legend(XTL,'Location','northeast','NumColumns',4);
text(-0.14,1,'E','Fontsize',28,'Units','Normalized');
subplot('Position',[0.565, 0.41,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=-100.*Comparison.Average.Age_Cumulative_Count_Hospital_rel(:,1:7,end);
    Y_Err.LB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,1:7,end);
    Y_Err.UB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,1:7,end);
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)
ytickformat('percentage');
xlim([0.5 7.5])
ylabel('Hospitalziation reduction','FontSize',16)
xlabel('Age class','FontSize',16)
legend(XTL,'Location','northeast','NumColumns',4);
text(-0.14,1,'F','Fontsize',28,'Units','Normalized');

subplot('Position',[0.065, 0.07,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=-100.*Comparison.Average.Age_Cumulative_Count_Death_rel(:,1:7,end);
    Y_Err.LB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,1:7,end);
    Y_Err.UB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,1:7,end);
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)
ytickformat('percentage');

xlim([0.5 7.5])
ylabel('Death reduction','FontSize',16)
xlabel('Age class','FontSize',16)
legend(XTL,'Location','northeast','NumColumns',4);
text(-0.14,1,'G','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.07,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=-100.*Comparison.Average.Cost_Age_rel(:,1:7,end);
    Y_Err.LB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,1:7,end);
    Y_Err.UB(:,dd./30-2)=-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,1:7,end);
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
ytickformat('percentage');
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel('Costs reduction','FontSize',16)
xlabel('Age class','FontSize',16)
legend(XTL,'Location','northeast','NumColumns',4);
text(-0.14,1,'H','Fontsize',28,'Units','Normalized');
print(gcf,['Figure_2.jpg'],'-djpeg','-r600');    
print(gcf,['Figure_2.png'],'-dpng','-r300');    
end
