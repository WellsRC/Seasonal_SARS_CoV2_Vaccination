function Figure_1
close all;
Y_Err.LineWidth=2;
Y_Err.Cap_Size=40;
XTL={'SD-AVC','FDA-AVC'};
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
load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat'])
Annual=Output_Summary;
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_under_2_and_50_and_older_150_days.mat'])
Two_Dose=Output_Summary;

C_Plot=[hex2rgb('#FFC20A');
        hex2rgb('#0C7BDC')];
figure('units','normalized','outerposition',[0 0.08 0.8 1]);
subplot('Position',[0.075, 0.77,0.18 0.2])

Y=10^4.*[Annual.Average.Cumulative_Count_Incidence;
   Two_Dose.Average.Cumulative_Count_Incidence]./Tot_Pop;
Y_Err.LB=10^4.*[Annual.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5));
       Two_Dose.PRCT.Cumulative_Count_Incidence(ismember(PRCT,2.5))]./Tot_Pop;
Y_Err.UB=10^4.*[Annual.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5));
       Two_Dose.PRCT.Cumulative_Count_Incidence(ismember(PRCT,97.5))]./Tot_Pop;

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2],'XTickLabel',XTL,'YTick',[4500:250:5500])
ylabel({'Incidence','per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 2.5])
ylim([4500 5500])

text(-0.3,1,'A','Fontsize',28,'Units','Normalized')

subplot('Position',[0.32, 0.77,0.18 0.2])

Y=10^4.*[Annual.Average.Cumulative_Count_Hospital;
   Two_Dose.Average.Cumulative_Count_Hospital]./Tot_Pop;
Y_Err.LB=10^4.*[Annual.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5));
       Two_Dose.PRCT.Cumulative_Count_Hospital(ismember(PRCT,2.5))]./Tot_Pop;
Y_Err.UB=10^4.*[Annual.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5));
       Two_Dose.PRCT.Cumulative_Count_Hospital(ismember(PRCT,97.5))]./Tot_Pop;

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2],'XTickLabel',XTL,'YTick',[25:2:35])
ylabel({'Hospitalizations','per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 2.5])
ylim([25 35])

text(-0.3,1,'B','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.77,0.18 0.2])
Y=10^4.*[Annual.Average.Cumulative_Count_Death;
   Two_Dose.Average.Cumulative_Count_Death]./Tot_Pop;
Y_Err.LB=10^4.*[Annual.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5));
       Two_Dose.PRCT.Cumulative_Count_Death(ismember(PRCT,2.5))]./Tot_Pop;
Y_Err.UB=10^4.*[Annual.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5));
       Two_Dose.PRCT.Cumulative_Count_Death(ismember(PRCT,97.5))]./Tot_Pop;

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2],'XTickLabel',XTL)
ylabel({'Deaths','per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 2.5])
ylim([1 1.4])
text(-0.3,1,'C','Fontsize',28,'Units','Normalized');

subplot('Position',[0.815, 0.77,0.18 0.2])
Y=10^4.*[Annual.Average.Cost_Total(end);
   Two_Dose.Average.Cost_Total(end)]./(10.^6.*Tot_Pop);
Y_Err.LB=10^4.*[Annual.PRCT.Cost_Total(ismember(PRCT,2.5),end)';
       Two_Dose.PRCT.Cost_Total(ismember(PRCT,2.5),end)']./(10.^6.*Tot_Pop);
Y_Err.UB=10^4.*[Annual.PRCT.Cost_Total(ismember(PRCT,97.5),end)';
       Two_Dose.PRCT.Cost_Total(ismember(PRCT,97.5),end)']./(10.^6.*Tot_Pop);

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1 2],'XTickLabel',XTL,'YTick',[0.5:0.1:1.1])
ylabel({'Costs ($, million)','per 10,000'},'FontSize',16)
xlabel('Strategy','FontSize',16)
xlim([0.5 2.5])
ylim([0.5 1.1])
text(-0.3,1,'D','Fontsize',28,'Units','Normalized');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Age_C={['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};

Y_Err.Cap_Size=10;
Y_Err.LineWidth=1.5;
subplot('Position',[0.075, 0.42,0.43 0.28])

Y=10^4.*[Annual.Average.Age_Incidence(:,1:7,end)'./Pop  Two_Dose.Average.Age_Incidence(:,1:7,end)'./Pop];
Y_Err.LB=10^4.*[Annual.PRCT.Age_Incidence(ismember(PRCT,2.5),1:7,end)'./Pop  Two_Dose.PRCT.Age_Incidence(ismember(PRCT,2.5),1:7,end)'./Pop];
Y_Err.UB=10^4.*[Annual.PRCT.Age_Incidence(ismember(PRCT,97.5),1:7,end)'./Pop Two_Dose.PRCT.Age_Incidence(ismember(PRCT,97.5),1:7,end)'./Pop];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel('Incidence per 10,000','FontSize',16)
xlabel('Age group','FontSize',16)
legend({'SD-AVC','FDA-AVC'},'Location','northwest');
legend boxoff
text(-0.14,1,'E','Fontsize',28,'Units','Normalized');
subplot('Position',[0.565, 0.42,0.43 0.28])

Y=10^4.*[Annual.Average.Age_Hospital(:,1:7,end)'./Pop  Two_Dose.Average.Age_Hospital(:,1:7,end)'./Pop];
Y_Err.LB=10^4.*[Annual.PRCT.Age_Hospital(ismember(PRCT,2.5),1:7,end)'./Pop  Two_Dose.PRCT.Age_Hospital(ismember(PRCT,2.5),1:7,end)'./Pop];
Y_Err.UB=10^4.*[Annual.PRCT.Age_Hospital(ismember(PRCT,97.5),1:7,end)'./Pop Two_Dose.PRCT.Age_Hospital(ismember(PRCT,97.5),1:7,end)'./Pop];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel('Hospitalziation per 10,000','FontSize',16)
xlabel('Age group','FontSize',16)
legend({'SD-AVC','FDA-AVC'},'Location','northwest');
legend boxoff
text(-0.14,1,'F','Fontsize',28,'Units','Normalized');

subplot('Position',[0.075, 0.07,0.43 0.28])

Y=10^4.*[Annual.Average.Age_Death(:,1:7,end)'./Pop  Two_Dose.Average.Age_Death(:,1:7,end)'./Pop];
Y_Err.LB=10^4.*[Annual.PRCT.Age_Death(ismember(PRCT,2.5),1:7,end)'./Pop  Two_Dose.PRCT.Age_Death(ismember(PRCT,2.5),1:7,end)'./Pop];
Y_Err.UB=10^4.*[Annual.PRCT.Age_Death(ismember(PRCT,97.5),1:7,end)'./Pop Two_Dose.PRCT.Age_Death(ismember(PRCT,97.5),1:7,end)'./Pop];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)


xlim([0.5 7.5])
ylabel('Deaths per 10,000','FontSize',16)
xlabel('Age group','FontSize',16)
legend({'SD-AVC','FDA-AVC'},'Location','northwest');
legend boxoff
text(-0.14,1,'G','Fontsize',28,'Units','Normalized');

subplot('Position',[0.565, 0.07,0.43 0.28])

Y=10^4.*[Annual.Average.Cost_Age(:,1:7,end)'./(10.^6.*Pop)  Two_Dose.Average.Cost_Age(:,1:7,end)'./(10.^6.*Pop)];
Y_Err.LB=10^4.*[Annual.PRCT.Cost_Age(ismember(PRCT,2.5),1:7,end)'./(10.^6.*Pop)  Two_Dose.PRCT.Cost_Age(ismember(PRCT,2.5),1:7,end)'./(10.^6.*Pop)];
Y_Err.UB=10^4.*[Annual.PRCT.Cost_Age(ismember(PRCT,97.5),1:7,end)'./(10.^6.*Pop) Two_Dose.PRCT.Cost_Age(ismember(PRCT,97.5),1:7,end)'./(10.^6.*Pop)];

Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;

set(gca,'LineWidth',2,'TickDir','out','Fontsize',14,'XTick',[1:7],'XTickLabel',Age_C)

xlim([0.5 7.5])
ylabel('Costs ($, million) per 10,000','FontSize',16)
xlabel('Age group','FontSize',16)
legend({'SD-AVC','FDA-AVC'},'Location','northwest');
legend boxoff
text(-0.14,1,'H','Fontsize',28,'Units','Normalized');
print(gcf,['Figure_1.jpg'],'-djpeg','-r600');    
print(gcf,['Figure_1.png'],'-dpng','-r600');    
end
