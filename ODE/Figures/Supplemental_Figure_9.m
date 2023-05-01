function Supplemental_Figure_9
close all;
Scenario='All';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalization','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+','All'};

figure('units','normalized','outerposition',[0.2 0.2 0.5 0.75]);

for Scenario_Indx=1:4
    subplot('Position',[0.13+0.5.*(rem(Scenario_Indx-1,2)),0.64-0.495.*(floor((Scenario_Indx-1)./2)),0.36,0.3475]);
    xt=linspace(-1,1,5001);
    YM=zeros(length(xt),length(AgeC));
    PerLZ=zeros(1,length(AgeC));
    load([temp_cd 'Marginal_Benefit_Two_Campaign_Baseline_Coverage_180_days.mat'])
    for aa=1:6
        if(Scenario_Indx==1)            
            MM=max(pdf(Marginal_Benefit.Histogram.Incidence_Age{aa},xt));
            YM(:,aa)=pdf(Marginal_Benefit.Histogram.Incidence_Age{aa},xt)./MM;
            PerLZ(aa)=Marginal_Benefit.Less_than_zero.Incidence_Age(aa);
        elseif(Scenario_Indx==2)               
            MM=max(pdf(Marginal_Benefit.Histogram.Hospitalization_Age{aa},xt));
            YM(:,aa)=pdf(Marginal_Benefit.Histogram.Hospitalization_Age{aa},xt)./MM;
            PerLZ(aa)=Marginal_Benefit.Less_than_zero.Hospitalization_Age(aa);
        elseif(Scenario_Indx==3)   
            MM=max(pdf(Marginal_Benefit.Histogram.Death_Age{aa},xt));
            YM(:,aa)=pdf(Marginal_Benefit.Histogram.Death_Age{aa},xt)./MM;
            PerLZ(aa)=Marginal_Benefit.Less_than_zero.Death_Age(aa);
        elseif(Scenario_Indx==4)   
            MM=max(pdf(Marginal_Benefit.Histogram.Cost_Age{aa},xt));
            YM(:,aa)=pdf(Marginal_Benefit.Histogram.Cost_Age{aa},xt)./MM;
            PerLZ(aa)=Marginal_Benefit.Less_than_zero.Cost_Age(aa);
        end
    end
    aa=7;
    if(Scenario_Indx==1)            
        MM=max(pdf(Marginal_Benefit.Histogram.Incidence,xt));
        YM(:,aa)=pdf(Marginal_Benefit.Histogram.Incidence,xt)./MM;
        PerLZ(aa)=Marginal_Benefit.Less_than_zero.Incidence;
    elseif(Scenario_Indx==2)               
        MM=max(pdf(Marginal_Benefit.Histogram.Hospitalization,xt));
        YM(:,aa)=pdf(Marginal_Benefit.Histogram.Hospitalization,xt)./MM;
        PerLZ(aa)=Marginal_Benefit.Less_than_zero.Hospitalization;
    elseif(Scenario_Indx==3)   
        MM=max(pdf(Marginal_Benefit.Histogram.Death,xt));
        YM(:,aa)=pdf(Marginal_Benefit.Histogram.Death,xt)./MM;
        PerLZ(aa)=Marginal_Benefit.Less_than_zero.Death;
    elseif(Scenario_Indx==4)   
        MM=max(pdf(Marginal_Benefit.Histogram.Cost,xt));
        YM(:,aa)=pdf(Marginal_Benefit.Histogram.Cost,xt)./MM;
        PerLZ(aa)=Marginal_Benefit.Less_than_zero.Cost;
    end
    
    plot([0 8],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for aa=1:6        
        t1=YM(:,aa)';
        patch(aa+[-0.45.*t1 0.45.*flip(t1)], 100.*([xt flip(xt)]),CC(Scenario_Indx,:),'LineStyle','none'); hold on; 
        text(aa,-31,['(' num2str(100.*PerLZ(aa),'%3.1f') '%)'],'color',CC(Scenario_Indx,:),'Fontsize',10,'HorizontalAlignment','center');
    end
    aa=7;    
    t1=YM(:,aa)';
    patch(aa+0.25+[-0.45.*t1 0.45.*flip(t1)], 100.*([xt flip(xt)]),CC(Scenario_Indx,:),'LineStyle','none'); hold on; 
    text(aa+0.25,-31,['(' num2str(100.*PerLZ(aa),'%3.1f') '%)'],'color',CC(Scenario_Indx,:),'Fontsize',10,'HorizontalAlignment','center');
    plot(mean([6.5 6.75]).*[1 1],[-40 40],'-.','color',[0.7 0.7 0.7],'LineWidth',1.25);
    box off;
    ytickformat('percentage');
    xtickangle(90);
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:6 7.25],'XTickLabel',AgeC,'YTick',[-40:10:40],'Fontsize',16);
    ylim([-35 35]);
    xlim([0.5 7.75]);
    xlabel('Age class','Fontsize',18);
    ylabel([{'Marginal beneift',[lower(Outcome{Scenario_Indx})]}],'Fontsize',18);
    
    text(-0.35,0.985,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
end
print(gcf,['Supplemental_Figure_9.png'],'-dpng','-r300');
end