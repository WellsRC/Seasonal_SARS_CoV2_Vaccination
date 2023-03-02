clear;
clc;
close all;



Scenarios={'All','Large_Summer','Large_Winter','Similar_Winter_Summer'};

Title_Name={'All scenarios','Large summer peak','Large winter peak','Similar winter and summer peaks'};

CC=[hex2rgb('#000B29');hex2rgb('#967bb6');hex2rgb('#2988BC');hex2rgb('#E1B80D')];

X=zeros(length(Scenarios),3);
for ss=1:length(Scenarios)
    load(['Probability_IC_Better_' Scenarios{ss} '.mat']);
    X(ss,:)=prob_IC;
end

figure('units','normalized','outerposition',[0.2 0.2 0.5 0.5]);
subplot('Position',[0.103,0.153,0.884,0.825]);
hb=bar([1:3],100.*X,'LineStyle','none');
box off;
set(gca,'tickdir','out','LineWidth',2,'Fontsize',14,'YTick',[0:10:100],'YminorTick','on','XTick',[1:3],'XTickLabel',{'Incidence','Hospitalizations','Death'});
ylim([0 100])
ytickformat('percentage')
ylabel('Probability annual booster preferable','Fontsize',16);
xlabel('Cumulative measure','Fontsize',16);

for ss=1:length(Scenarios)
    hb(ss).FaceColor=CC(ss,:);
end
legend(Title_Name,'Fontsize',12,'Location','NorthEast','NumColumns',2);
legend boxoff;

print(gcf,['Probability_Inluenza_Campaign_Preferable.png'],'-dpng','-r300');