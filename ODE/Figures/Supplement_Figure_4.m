function  Supplement_Figure_4
close all;

temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
state_out={'incidence','hospitalizations','deaths','cost'};
xtl=cell(8,1);
for ii=1:8
   xtl{ii}=num2str(90+30.*(ii-1)); 
end
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);

for Scenario_Indx=1:4

    Y=zeros(1,8);
    
    subplot('Position',[0.135+0.5.*(rem(Scenario_Indx-1,2)),0.635-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.315]);
    for ss=1:8         
        load([temp_cd 'Marginal_Benefit_50_and_older_Large_Winter_Two_Campaign_Baseline_Coverage_' num2str(90+30.*(ss-1)) '_days.mat'])
        
        Y(ss)=100.*[Marginal_Benefit.Average.Cost];        
    end
    bar(Y,'LineStyle','none','FaceColor',CCv(Scenario_Indx,:));
    ylim([0 3]);
    xlim([0.5 8.5]);
    box off
    set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:8],'XTickLabel',xtl,'Yminortick','on','YTick',[0:3],'Xminortick','off','Fontsize',16);
    ytickformat('percentage');
    xlabel('Days to second doses','Fontsize',18,'Units','normalized','position',[0.5 -0.27 0]);
    ylabel([{'Marginal benefit', state_out{Scenario_Indx}}],'Fontsize',18);
    
    text(-0.35,1.08,char(65+(Scenario_Indx-1)),'Fontsize',24,'FontWeight','bold','Units','normalized');
end
% table()
print(gcf,['Supplement_Figure_4.png'],'-dpng','-r300');    
end

