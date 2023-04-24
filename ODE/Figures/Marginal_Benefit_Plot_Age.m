function Marginal_Benefit_Plot_Age(Scenario_Coverage)
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
xltxt={'incidence','hospitalizations','deaths','cost'};
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
Time_2Dose={'90','120','150','180','210','240','270','300'};
td=[90:30:300];

for Scenario_Indx=1:4    
    CC=CCv(Scenario_Indx,:);
    Outcome_All=zeros(8,5);
    for ss=1:8
       load([temp_cd 'Marginal_Benefit_Two_Campaign_' Scenario_Coverage '_Coverage_' num2str(td(ss)) '_days.mat'])
       if Scenario_Indx==1
           Outcome_All(ss,2)=Marginal_Benefit.PRCT.Incidence(PRCT==2.5);
           Outcome_All(ss,3)=Marginal_Benefit.PRCT.Incidence(PRCT==97.5);

           Outcome_All(ss,4)=Marginal_Benefit.PRCT.Incidence(PRCT==25);
           Outcome_All(ss,5)=Marginal_Benefit.PRCT.Incidence(PRCT==75);

           Outcome_All(ss,1)=Marginal_Benefit.Average.Incidence;
       elseif Scenario_Indx==2
           Outcome_All(ss,2)=Marginal_Benefit.PRCT.Hospitalization(PRCT==2.5);
           Outcome_All(ss,3)=Marginal_Benefit.PRCT.Hospitalization(PRCT==97.5);

           Outcome_All(ss,4)=Marginal_Benefit.PRCT.Hospitalization(PRCT==25);
           Outcome_All(ss,5)=Marginal_Benefit.PRCT.Hospitalization(PRCT==75);

           Outcome_All(ss,1)=Marginal_Benefit.Average.Hospitalization;
       elseif Scenario_Indx==3
           Outcome_All(ss,2)=Marginal_Benefit.PRCT.Death(PRCT==2.5);
           Outcome_All(ss,3)=Marginal_Benefit.PRCT.Death(PRCT==97.5);

           Outcome_All(ss,4)=Marginal_Benefit.PRCT.Death(PRCT==25);
           Outcome_All(ss,5)=Marginal_Benefit.PRCT.Death(PRCT==75);

           Outcome_All(ss,1)=Marginal_Benefit.Average.Death;
       elseif Scenario_Indx==4
           Outcome_All(ss,2)=Marginal_Benefit.PRCT.Cost(PRCT==2.5);
           Outcome_All(ss,3)=Marginal_Benefit.PRCT.Cost(PRCT==97.5);

           Outcome_All(ss,4)=Marginal_Benefit.PRCT.Cost(PRCT==25);
           Outcome_All(ss,5)=Marginal_Benefit.PRCT.Cost(PRCT==75);

           Outcome_All(ss,1)=Marginal_Benefit.Average.Cost;
        end
    end

      subplot('Position',[0.135+0.5.*(rem(Scenario_Indx-1,2)),0.635-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.315]);

    for ss=1:8
       patch(ss+[-0.45 -0.45 0.45 0.45],100.*[Outcome_All(ss,2:3) flip(Outcome_All(ss,2:3))],CC,'LineStyle','none','FaceAlpha',0.25); hold on
       patch(ss+[-0.45 -0.45 0.45 0.45],100.*[Outcome_All(ss,4:5) flip(Outcome_All(ss,4:5))],CC,'LineStyle','none','FaceAlpha',0.5); hold on
       plot(ss+[-0.45 0.45],100.*Outcome_All(ss,[1 1]),'color',CC,'LineWidth',3);
    end
    grid on;
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:8],'XTickLabel',Time_2Dose,'Fontsize',16,'YTick',[-10:5:10])
    xlim([0.45 8.55]);
    ylim([-10 10]);
    box off;
    xtickangle(90);
    ax=gca;
    ytickformat('percentage');
    xlabel('Days to second doses','Fontsize',18);
    ylabel([{'Marginal benefit', xltxt{Scenario_Indx}}],'Fontsize',18);
    text(-0.35,1.08,char(65+(Scenario_Indx-1)),'Fontsize',24,'FontWeight','bold','Units','normalized');
end

print(gcf,['Marginal_Benefit_Second_Dose_Plot_' Scenario_Coverage '.png'],'-dpng','-r300');    
end
