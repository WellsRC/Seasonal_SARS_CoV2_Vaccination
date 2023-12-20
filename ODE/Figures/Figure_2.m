function Figure_2()
close all;
temp_cd=pwd;

load([temp_cd(1:end-11) 'Contact_Matrix\Contact_USA_85.mat'],'N');
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
dx=linspace(0,1,9);
dx=dx(2:end);
C_Plot=interp1([0 1],[hex2rgb('#ffffff'); hex2rgb('#0C7BDC')],dx);
Y_Err.LineWidth=2;
XTL=cell(8,1);
for ii=1:8
    XTL{ii}=num2str(90+30.*(ii-1));
end
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
Pop=zeros(1,size(ACg,1));
for ii=1:length(Pop)
    Pop(ii)=sum(N(Av>=ACg(ii,1) & Av<=ACg(ii,2)));
end
Tot_Pop=sum(N);

PRCT=[2.5 25 50 75 97.5];

figure('units','normalized','outerposition',[0 0.08 0.8 1]);
subplot('Position',[0.065, 0.77,0.18 0.2])
Y_Err.Cap_Size=10;

Y=zeros(8,1);
Y_Err.LB=zeros(8,1);
Y_Err.UB=zeros(8,1);
for dd=90:30:300
    
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=10^4.*Comparison.Average.Cumulative_Count_Incidence_dt./Tot_Pop;
    Y_Err.LB(dd./30-2)=10^4.*Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==97.5)./Tot_Pop;
    Y_Err.UB(dd./30-2)=10^4.*Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==2.5)./Tot_Pop;
end

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel({'Incidence','averted per 10,000'},'FontSize',16)
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])
ylim([0 500])


text(-0.345,1.025,'A','Fontsize',28,'Units','Normalized')

subplot('Position',[0.315, 0.77,0.18 0.2])
Y=zeros(8,1);
Y_Err.LB=zeros(8,1);
Y_Err.UB=zeros(8,1);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=10^4.*Comparison.Average.Cumulative_Count_Hospital_dt./Tot_Pop;
    Y_Err.LB(dd./30-2)=10^4.*Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5)./Tot_Pop;
    Y_Err.UB(dd./30-2)=10^4.*Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5)./Tot_Pop;
end

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel({'Hospitalizations','averted per 10,000'},'FontSize',16)
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])
ylim([0 5])


text(-0.345,1.025,'B','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.77,0.18 0.2])
Y=zeros(8,1);
Y_Err.LB=zeros(8,1);
Y_Err.UB=zeros(8,1);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=10^4.*Comparison.Average.Cumulative_Count_Death_dt./Tot_Pop;
    Y_Err.LB(dd./30-2)=10^4.*Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5)./Tot_Pop;
    Y_Err.UB(dd./30-2)=10^4.*Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5)./Tot_Pop;
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL,'YTick',[0:0.05:0.25])
ylabel({'Deaths','averted per 10,000'},'FontSize',16)
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])

ylim([0 0.25])

text(-0.345,1.025,'C','Fontsize',28,'Units','Normalized');

subplot('Position',[0.815, 0.77,0.18 0.2])

for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(dd./30-2)=(10^4.*Comparison.Average.Cost_Total_dt(end)./Tot_Pop)./10^5;
    Y_Err.LB(dd./30-2)=(10^4.*Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./Tot_Pop)./10^5;
    Y_Err.UB(dd./30-2)=(10^4.*Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./Tot_Pop)./10^5;
end

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:8],'XTickLabel',XTL)
ylabel({'Costs ($100,000)','averted per 10,000'},'FontSize',16)
xlabel('Days between doses','FontSize',16)
xlim([0.5 8.5])

ylim([0 1.5])

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
    Y(:,dd./30-2)=10.^4.*Comparison.Average.Age_Cumulative_Count_Incidence_dt(1,1:7,end)./Pop;
    Y_Err.LB(:,dd./30-2)=10.^4.*Comparison.PRCT.Age_Cumulative_Count_Incidence_dt(PRCT==97.5,1:7,end)./Pop;
    Y_Err.UB(:,dd./30-2)=10.^4.*Comparison.PRCT.Age_Cumulative_Count_Incidence_dt(PRCT==2.5,1:7,end)./Pop;
end

Error_Bar_Plot(Y,Y_Err,C_Plot);

box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C);
ylim([0 700])
xlim([0.5 7.5])
ylabel({'Incidence','averted per 10,000'},'FontSize',16)
xlabel('Age group','FontSize',16)
legend(XTL,'Location','northwest','NumColumns',4);
text(-0.14,1,'E','Fontsize',28,'Units','Normalized');
subplot('Position',[0.565, 0.41,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=10.^4.*Comparison.Average.Age_Cumulative_Count_Hospital_dt(1,1:7,end)./Pop;
    Y_Err.LB(:,dd./30-2)=10.^4.*Comparison.PRCT.Age_Cumulative_Count_Hospital_dt(PRCT==97.5,1:7,end)./Pop;
    Y_Err.UB(:,dd./30-2)=10.^4.*Comparison.PRCT.Age_Cumulative_Count_Hospital_dt(PRCT==2.5,1:7,end)./Pop;
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C);
xlim([0.5 7.5])
ylabel({'Hospitalization','averted per 10,000'},'FontSize',16)
xlabel('Age group','FontSize',16)
legend(XTL,'Location','northwest','NumColumns',4);
text(-0.14,1,'F','Fontsize',28,'Units','Normalized');
ylim([0 25])
subplot('Position',[0.065, 0.07,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=10.^4.*Comparison.Average.Age_Cumulative_Count_Death_dt(:,1:7,end)./Pop;
    Y_Err.LB(:,dd./30-2)=10.^4.*Comparison.PRCT.Age_Cumulative_Count_Death_dt(PRCT==97.5,1:7,end)./Pop;
    Y_Err.UB(:,dd./30-2)=10.^4.*Comparison.PRCT.Age_Cumulative_Count_Death_dt(PRCT==2.5,1:7,end)./Pop;
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C);

xlim([0.5 7.5])
ylabel({'Deaths','averted per 10,000'},'FontSize',16)
xlabel('Age group','FontSize',16)
legend(XTL,'Location','northwest','NumColumns',4);
text(-0.14,1,'G','Fontsize',28,'Units','Normalized');
ylim([0 1.3])
subplot('Position',[0.565, 0.07,0.43 0.27])
Y=zeros(7,8);
Y_Err.LB=zeros(7,8);
Y_Err.UB=zeros(7,8);
for dd=90:30:300
    load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(dd) '_days.mat']);
    Y(:,dd./30-2)=(10.^4.*Comparison.Average.Cost_Age_dt(:,1:7,end)./Pop)./10^5;
    Y_Err.LB(:,dd./30-2)=(10.^4.*Comparison.PRCT.Cost_Age_dt(PRCT==97.5,1:7,end)./Pop)./10^5;
    Y_Err.UB(:,dd./30-2)=(10.^4.*Comparison.PRCT.Cost_Age_dt(PRCT==2.5,1:7,end)./Pop)./10^5;
end
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)
ylim([0 7])
xlim([0.5 7.5])
ylabel({'Costs ($100,000)','averted per 10,000'},'FontSize',16)
xlabel('Age group','FontSize',16)
legend(XTL,'Location','northwest','NumColumns',4);
text(-0.14,1,'H','Fontsize',28,'Units','Normalized');
print(gcf,['Figure_2.jpg'],'-djpeg','-r600');    
print(gcf,['Figure_2.png'],'-dpng','-r300');    
end
