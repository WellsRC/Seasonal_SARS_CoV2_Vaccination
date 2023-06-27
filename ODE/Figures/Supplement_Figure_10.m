function Supplement_Figure_10
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalization','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+','All'};

figure('units','normalized','outerposition',[0.2 0.2 0.5 0.75]);

for Scenario_Indx=1:4
    subplot('Position',[0.135+0.5.*(rem(Scenario_Indx-1,2)),0.64-0.495.*(floor((Scenario_Indx-1)./2)),0.36,0.3475]);
    xt=linspace(-1,1,5001);
    YM=zeros(1,length(AgeC));
    load([temp_cd 'Marginal_Benefit_Second_Dose_50_to_64_Large_Winter_Two_Campaign_Baseline_Coverage_180_days.mat'])
    for aa=1:6
        if(Scenario_Indx==1)            
            Marginal_Benefit.Average.Incidence_Age=reshape(Marginal_Benefit.Average.Incidence_Age,7,9);
            YM(aa)=Marginal_Benefit.Average.Incidence_Age(aa,end);
        elseif(Scenario_Indx==2)               
            Marginal_Benefit.Average.Hospitalization_Age=reshape(Marginal_Benefit.Average.Hospitalization_Age,7,9);
            YM(aa)=Marginal_Benefit.Average.Hospitalization_Age(aa,end);
        elseif(Scenario_Indx==3)   
            Marginal_Benefit.Average.Death_Age=reshape(Marginal_Benefit.Average.Death_Age,7,9);
            YM(aa)=Marginal_Benefit.Average.Death_Age(aa,end);
        elseif(Scenario_Indx==4)   
            Marginal_Benefit.Average.Cost_Age=reshape(Marginal_Benefit.Average.Cost_Age,7,9);
            YM(aa)=Marginal_Benefit.Average.Cost_Age(aa,end);
        end
    end
    aa=7;
    if(Scenario_Indx==1)            
        YM(aa)=Marginal_Benefit.Average.Incidence;
    elseif(Scenario_Indx==2)               
        YM(aa)=Marginal_Benefit.Average.Hospitalization;
    elseif(Scenario_Indx==3)   
        YM(aa)=Marginal_Benefit.Average.Death;
    elseif(Scenario_Indx==4)   
        YM(aa)=Marginal_Benefit.Average.Cost(end);
    end
    YM=100.*YM;
    plot(mean([6.5 6.75]).*[1 1],[-1 100],'-.','color',[0.7 0.7 0.7],'LineWidth',1.25); hold on;
    bar([1:6 7.25],YM,'LineStyle','none','FaceColor',CC(Scenario_Indx,:));
    box off;
  
    box off;
    ytickformat('percentage');
    xtickangle(90);
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:6 7.25],'XTickLabel',AgeC,'YTick',[0:10:80],'Yminortick','on','Fontsize',16);
    ylim([0 80]);
    xlim([0.5 7.75]);
    xlabel('Age class','Fontsize',18);
    ylabel([{'Marginal beneift',[lower(Outcome{Scenario_Indx})]}],'Fontsize',18);
    
    text(-0.35,0.985,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
end
print(gcf,['Supplement_Figure_10.png'],'-dpng','-r300');
end