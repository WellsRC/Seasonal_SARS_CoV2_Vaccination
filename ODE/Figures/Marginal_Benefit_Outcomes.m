function Marginal_Benefit_Outcomes()
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
xltxt={'incidence','hospitalizations','deaths','cost'};
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
Time_2Dose={'90','120','150','180','210','240','270','300'};
td=[90:30:300];
for Scenario_Indx=1:4
    
    subplot('Position',[0.115+0.5.*(rem(Scenario_Indx-1,2)),0.625-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.3525]);
    Per_Increase=zeros(1,6);
    xt=linspace(-1,1,5001);
    Y=zeros(8,length(xt));
    CC=CCv(Scenario_Indx,:);
    
    min_x=Inf;
    max_x=-Inf; 
    for ss=1:8
        load([temp_cd 'Marginal_Benefit_Two_Campaign_Influenza_Like_Coverage_' num2str(td(ss)) '_days.mat'])
        if(Scenario_Indx==1)
            MM=max(pdf(Marginal_Benefit.Histogram.Incidence,xt));
            Y(ss,:)=pdf(Marginal_Benefit.Histogram.Incidence,xt)./MM;
            Per_Increase(ss)=Marginal_Benefit.Less_than_zero.Incidence;
        elseif(Scenario_Indx==2)    
            MM=max(pdf(Marginal_Benefit.Histogram.Hospitalization,xt));
            Y(ss,:)=pdf(Marginal_Benefit.Histogram.Hospitalization,xt)./MM;
            Per_Increase(ss)=Marginal_Benefit.Less_than_zero.Hospitalization;
        elseif(Scenario_Indx==3)    
            MM=max(pdf(Marginal_Benefit.Histogram.Death,xt));
            Y(ss,:)=pdf(Marginal_Benefit.Histogram.Death,xt)./MM;
            Per_Increase(ss)=Marginal_Benefit.Less_than_zero.Death;
        elseif(Scenario_Indx==4)    
            MM=max(pdf(Marginal_Benefit.Histogram.Cost,xt));
            Y(ss,:)=pdf(Marginal_Benefit.Histogram.Cost,xt)./MM;
            Per_Increase(ss)=Marginal_Benefit.Less_than_zero.Cost;
        end
        min_x=min(min_x,min(xt(Y(ss,:)>0)));
        max_x=max(max_x,max(xt(Y(ss,:)>0)));
    end
    plot([0 0],[0.5 8.5],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for ii=1:8
        patch(100.*([xt flip(xt)]),ii+[-0.45.*Y(ii,:) flip(0.45.*Y(ii,:))], CC,'LineStyle','none'); hold on; 
    end

    ylim([0.45 8.55]);
    xlim(100.*[-0.25 0.2]);
    xtickformat('percentage');
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:8],'YTickLabel',Time_2Dose,'Yminortick','off','XTick',[-20:10:20],'Xminortick','off','Fontsize',16);
    xlabel(['Marginal benefit: ' xltxt{Scenario_Indx}],'Fontsize',18);
    ylabel({'Days to','second dose'},'Fontsize',18);
    box off;
    for ii=1:8
       text(-100.*(0.2),ii,['(' num2str(round(100.*Per_Increase(ii),1)) '%)'],'color',CC,'Fontsize',14,'HorizontalAlignment','center') 
    end
    text(-0.278,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
end

print(gcf,['Marginal_Benefit_Second_Dose.png'],'-dpng','-r300');    
end
