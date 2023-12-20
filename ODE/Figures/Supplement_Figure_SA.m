function Supplement_Figure_SA(Scenario,SA_Number)
close all;
Y_Err.LineWidth=2;
Y_Err.Cap_Size=8;
XTL=Scenario.Legend;
temp_cd=pwd;
load([temp_cd(1:end-11) 'Contact_Matrix\Contact_USA_85.mat'],'N');
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
Pop=zeros(size(ACg,1),1);
for ii=1:length(Pop)
    Pop(ii)=sum(N(Av>=ACg(ii,1) & Av<=ACg(ii,2)));
end

Tot_Pop=sum(N);

temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_150_days.mat']);
Baseline=Comparison;

load([temp_cd Scenario.Case_1 '.mat'])
Scenario_1=Comparison;
load([temp_cd Scenario.Case_2 '.mat'])
Scenario_2=Comparison;
load([temp_cd Scenario.Case_3 '.mat'])
Scenario_3=Comparison;

dx=linspace(0,1,5);
dx=flip(dx(2:end));

C_Plot=[interp1([0 1],[hex2rgb('#ffffff'); hex2rgb('#0C7BDC')],dx)];
figure('units','normalized','outerposition',[0 0.08 0.8 1]);
subplot('Position',[0.065, 0.77,0.18 0.2])

Y=10^4.*[Baseline.Average.Cumulative_Count_Incidence_dt  Scenario_1.Average.Cumulative_Count_Incidence_dt   Scenario_2.Average.Cumulative_Count_Incidence_dt   Scenario_3.Average.Cumulative_Count_Incidence_dt;]./Tot_Pop;
Y_Err.LB=10^4.*[Baseline.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5)) Scenario_1.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5))   Scenario_2.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5))  Scenario_3.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,2.5));]./Tot_Pop;
Y_Err.UB=10^4.*[Baseline.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5)) Scenario_1.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5))  Scenario_2.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5))  Scenario_3.PRCT.Cumulative_Count_Incidence_dt(ismember(PRCT,97.5));]./Tot_Pop;

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:4],'XTickLabel',XTL)
ylabel({'Incidence','averted per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 4.5])
% ylim([1.8.*10^8 2.6.*10^8])

text(-0.345,1,'A','Fontsize',28,'Units','Normalized')

subplot('Position',[0.315, 0.77,0.18 0.2])

Y=10^4.*[Baseline.Average.Cumulative_Count_Hospital_dt  Scenario_1.Average.Cumulative_Count_Hospital_dt   Scenario_2.Average.Cumulative_Count_Hospital_dt   Scenario_3.Average.Cumulative_Count_Hospital_dt;]./Tot_Pop;
Y_Err.LB=10^4.*[Baseline.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5)) Scenario_1.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5))   Scenario_2.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5))  Scenario_3.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,2.5));]./Tot_Pop;
Y_Err.UB=10^4.*[Baseline.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5)) Scenario_1.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5))  Scenario_2.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5))  Scenario_3.PRCT.Cumulative_Count_Hospital_dt(ismember(PRCT,97.5));]./Tot_Pop;

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:4],'XTickLabel',XTL)
ylabel({'Hospitalizations','averted per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 4.5])


text(-0.345,1,'B','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.77,0.18 0.2])

Y=10^4.*[Baseline.Average.Cumulative_Count_Death_dt  Scenario_1.Average.Cumulative_Count_Death_dt   Scenario_2.Average.Cumulative_Count_Death_dt   Scenario_3.Average.Cumulative_Count_Death_dt;]./Tot_Pop;
Y_Err.LB=10^4.*[Baseline.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5)) Scenario_1.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5))   Scenario_2.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5))  Scenario_3.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,2.5));]./Tot_Pop;
Y_Err.UB=10^4.*[Baseline.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5)) Scenario_1.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5))  Scenario_2.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5))  Scenario_3.PRCT.Cumulative_Count_Death_dt(ismember(PRCT,97.5));]./Tot_Pop;

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:4],'XTickLabel',XTL)
ylabel({'Deaths','averted per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 4.5])
text(-0.345,1,'C','Fontsize',28,'Units','Normalized');

subplot('Position',[0.815, 0.77,0.18 0.2])

Y=(10^4/10^5).*[Baseline.Average.Cost_Total_dt(end)  Scenario_1.Average.Cost_Total_dt(end)   Scenario_2.Average.Cost_Total_dt(end)   Scenario_3.Average.Cost_Total_dt(end);]./Tot_Pop;
Y_Err.LB=(10^4/10^5).*[Baseline.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)' Scenario_1.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)'   Scenario_2.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)'  Scenario_3.PRCT.Cost_Total_dt(ismember(PRCT,2.5),end)']./Tot_Pop;
      
Y_Err.UB=(10^4/10^5).*[Baseline.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)' Scenario_1.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)'  Scenario_2.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)'  Scenario_3.PRCT.Cost_Total_dt(ismember(PRCT,97.5),end)']./Tot_Pop;
       

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:4],'XTickLabel',XTL)
ylabel({'Costs ($100,000)','averted per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 4.5])

text(-0.345,1,'D','Fontsize',28,'Units','Normalized');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Age_C={['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};

Y_Err.Cap_Size=0;
Y_Err.LineWidth=1.5;
subplot('Position',[0.065, 0.39,0.43 0.25])
Y=10^4.*[Baseline.Average.Age_Cumulative_Count_Incidence_dt(:,1:7,end)'./Pop  Scenario_1.Average.Age_Cumulative_Count_Incidence_dt(:,1:7,end)'./Pop   Scenario_2.Average.Age_Cumulative_Count_Incidence_dt(:,1:7,end)'./Pop   Scenario_3.Average.Age_Cumulative_Count_Incidence_dt(:,1:7,end)'./Pop];
Y_Err.LB=10^4.*[Baseline.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,2.5),1:7,end)'./Pop Scenario_1.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,2.5),1:7,end)'./Pop   Scenario_2.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,2.5),1:7,end)'./Pop  Scenario_3.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,2.5),1:7,end)'./Pop];
Y_Err.UB=10^4.*[Baseline.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,97.5),1:7,end)'./Pop Scenario_1.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_2.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_3.PRCT.Age_Cumulative_Count_Incidence_dt(ismember(PRCT,97.5),1:7,end)'./Pop];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel({'Incidence','averted per 10,000'},'FontSize',16)
xlabel('Age class','FontSize',16)
text(-0.14,1,'E','Fontsize',28,'Units','Normalized');

legend(Scenario.Legend,'location','northwest');
subplot('Position',[0.565, 0.39,0.43 0.25])

Y=10^4.*[Baseline.Average.Age_Cumulative_Count_Hospital_dt(:,1:7,end)'./Pop  Scenario_1.Average.Age_Cumulative_Count_Hospital_dt(:,1:7,end)'./Pop   Scenario_2.Average.Age_Cumulative_Count_Hospital_dt(:,1:7,end)'./Pop   Scenario_3.Average.Age_Cumulative_Count_Hospital_dt(:,1:7,end)'./Pop];
Y_Err.LB=10^4.*[Baseline.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,2.5),1:7,end)'./Pop Scenario_1.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,2.5),1:7,end)'./Pop   Scenario_2.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,2.5),1:7,end)'./Pop  Scenario_3.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,2.5),1:7,end)'./Pop];
Y_Err.UB=10^4.*[Baseline.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,97.5),1:7,end)'./Pop Scenario_1.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_2.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_3.PRCT.Age_Cumulative_Count_Hospital_dt(ismember(PRCT,97.5),1:7,end)'./Pop];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel({'Hospitalziation','averted per 10,000'},'FontSize',16)
xlabel('Age class','FontSize',16)
legend(Scenario.Legend,'location','northwest');
% legend(Scenario.Legend,'Location','northoutside','NumColumns',4);
text(-0.14,1,'F','Fontsize',28,'Units','Normalized');

subplot('Position',[0.065, 0.07,0.43 0.25])

Y=10^4.*[Baseline.Average.Age_Cumulative_Count_Death_dt(:,1:7,end)'./Pop  Scenario_1.Average.Age_Cumulative_Count_Death_dt(:,1:7,end)'./Pop   Scenario_2.Average.Age_Cumulative_Count_Death_dt(:,1:7,end)'./Pop   Scenario_3.Average.Age_Cumulative_Count_Death_dt(:,1:7,end)'./Pop];
Y_Err.LB=10^4.*[Baseline.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,2.5),1:7,end)'./Pop Scenario_1.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,2.5),1:7,end)'./Pop   Scenario_2.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,2.5),1:7,end)'./Pop Scenario_3.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,2.5),1:7,end)'./Pop];
Y_Err.UB=10^4.*[Baseline.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,97.5),1:7,end)'./Pop Scenario_1.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_2.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,97.5),1:7,end)'./Pop Scenario_3.PRCT.Age_Cumulative_Count_Death_dt(ismember(PRCT,97.5),1:7,end)'./Pop];


Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)


xlim([0.5 7.5])
ylabel({'Deaths','averted per 10,000'},'FontSize',16)
xlabel('Age class','FontSize',16)
legend(Scenario.Legend,'location','northwest');
% legend(Scenario.Legend,'Location','northoutside','NumColumns',4);
text(-0.14,1,'G','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.07,0.43 0.25])

Y=(10^4/10^5).*[Baseline.Average.Cost_Age_dt(:,1:7,end)'./Pop  Scenario_1.Average.Cost_Age_dt(:,1:7,end)'./Pop   Scenario_2.Average.Cost_Age_dt(:,1:7,end)'./Pop   Scenario_3.Average.Cost_Age_dt(:,1:7,end)'./Pop]; 
Y_Err.LB=(10^4/10^5).*[Baseline.PRCT.Cost_Age_dt(ismember(PRCT,2.5),1:7,end)'./Pop Scenario_1.PRCT.Cost_Age_dt(ismember(PRCT,2.5),1:7,end)'./Pop   Scenario_2.PRCT.Cost_Age_dt(ismember(PRCT,2.5),1:7,end)'./Pop  Scenario_3.PRCT.Cost_Age_dt(ismember(PRCT,2.5),1:7,end)'./Pop]; 
Y_Err.UB=(10^4/10^5).*[Baseline.PRCT.Cost_Age_dt(ismember(PRCT,97.5),1:7,end)'./Pop Scenario_1.PRCT.Cost_Age_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_2.PRCT.Cost_Age_dt(ismember(PRCT,97.5),1:7,end)'./Pop  Scenario_3.PRCT.Cost_Age_dt(ismember(PRCT,97.5),1:7,end)'./Pop]; 

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel({'Costs ($100,000)','averted per 10,000'},'FontSize',16)
xlabel('Age class','FontSize',16)
legend(Scenario.Legend,'location','northwest');
text(-0.14,1,'H','Fontsize',28,'Units','Normalized');
% print(gcf,['Supplementary_Figure_' num2str(SA_Number) '.png'],'-dpng','-r300');    
end
