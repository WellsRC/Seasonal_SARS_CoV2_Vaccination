function Figure_3()
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

C_Plot=[hex2rgb('#E1BE6A');
   hex2rgb('#40B0A6');];
Y_Err.Cap_Size=18;
Y_Err.LineWidth=2;
Age_C={'All',['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
Y=zeros(8,2);
Y_Err.LB=zeros(8,2);
Y_Err.UB=zeros(8,2);
load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_50_vs_young_50_Second_dose_180_days.mat'])
Y(1,1)=Marginal_Benefit.Average.Cost(end);
Y_Err.LB(1,1)=Marginal_Benefit.PRCT.Cost(PRCT==2.5,end);
Y_Err.UB(1,1)=Marginal_Benefit.PRCT.Cost(PRCT==97.5,end);

Y(2:end,1)=Marginal_Benefit.Average.Cost_Age(1,1:7,end);
Y_Err.LB(2:end,1)=Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,1:7,end);
Y_Err.UB(2:end,1)=Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,1:7,end);
load([temp_cd 'Marginal_Benefit_Second_Dose_Main_Text_65_vs_50_Second_dose_180_days.mat'])
Y(1,2)=Marginal_Benefit.Average.Cost(end);
Y_Err.LB(1,2)=Marginal_Benefit.PRCT.Cost(PRCT==2.5,end);
Y_Err.UB(1,2)=Marginal_Benefit.PRCT.Cost(PRCT==97.5,end);

Y(2:end,2)=Marginal_Benefit.Average.Cost_Age(1,1:7,end);
Y_Err.LB(2:end,2)=Marginal_Benefit.PRCT.Cost_Age(PRCT==2.5,1:7,end);
Y_Err.UB(2:end,2)=Marginal_Benefit.PRCT.Cost_Age(PRCT==97.5,1:7,end);

figure('units','normalized','outerposition',[0 0.08 0.8 0.8]);
subplot('Position',[0.065, 0.59,0.93 0.38])
Error_Bar_Plot(Y,Y_Err,C_Plot);
box off;
set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:8],'XTickLabel',Age_C,'FontSize',14)
ylabel('Incremental benefit','FontSize',16)
xlabel('Age class','FontSize',16)
legend({'FDA vs 50 or older','50 or older vs 65 or older'},'Location','northwest')


Y=rand(8,3);
C_Plot=[hex2rgb('#e5f5e0')
        hex2rgb('#a1d99b')
        hex2rgb('#31a354')];
subplot('Position',[0.065, 0.1,0.93 0.38])
b=bar([1:8],Y,'LineStyle','none');
for bb=1:length(b)
    b(bb).FaceColor = 'flat';
    for ii=1:size(Y,1)
        b(bb).CData(ii,:) = C_Plot(bb,:);
    end
end
box off;
set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:8],'XTickLabel',Age_C,'FontSize',14)
ylabel('Incremental benefit','FontSize',16)
xlabel('Age class','FontSize',16)
legend({'15% reduction','35% reduction','65% reduction'},'Location','northwest')
end