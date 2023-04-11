function Age_Dist_Outcomes(Scenario)
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_' Scenario '.mat']);
xltxt={'incidence','hospitalizations','deaths','cost'};
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+','All'};
for Scenario_Indx=1:4
    
    subplot('Position',[0.105+0.5.*(rem(Scenario_Indx-1,2)),0.625-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.3525]);
    Per_Increase=zeros(1,6);
    xt=linspace(-1,1,5001);
    Y=zeros(7,length(xt));
    CC=CCv(Scenario_Indx,:);
    
    min_x=Inf;
    max_x=-Inf; 
    for ss=1:6
        if(Scenario_Indx==1)
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{ss},xt));
            Y(ss,:)=pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{ss},xt)./MM;
            Per_Increase(ss)=Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence(ss);
        elseif(Scenario_Indx==2)    
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{ss},xt));
            Y(ss,:)=pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{ss},xt)./MM;
            Per_Increase(ss)=Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital(ss);
        elseif(Scenario_Indx==3)    
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{ss},xt));
            Y(ss,:)=pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{ss},xt)./MM;
            Per_Increase(ss)=Comparison.Alternative_Worse.Age_Cumulative_Count_Death(ss);
        elseif(Scenario_Indx==4)    
            MM=max(pdf(Comparison.Histogram.Cost_Age_rel{ss},xt));
            Y(ss,:)=pdf(Comparison.Histogram.Cost_Age_rel{ss},xt)./MM;
            Per_Increase(ss)=Comparison.Alternative_Worse.Cost_Age(ss);
        end
        min_x=min(min_x,min(xt(Y(ss,:)>0)));
        max_x=max(max_x,max(xt(Y(ss,:)>0)));
    end
    ss=7;
    
    if(Scenario_Indx==1)
        MM=max(pdf(Comparison.Histogram.Cumulative_Count_Incidence_rel,xt));
        Y(ss,:)=pdf(Comparison.Histogram.Cumulative_Count_Incidence_rel,xt)./MM;
        Per_Increase(ss)=Comparison.Alternative_Worse.Cumulative_Count_Incidence;
    elseif(Scenario_Indx==2)    
        MM=max(pdf(Comparison.Histogram.Cumulative_Count_Hospital_rel,xt));
        Y(ss,:)=pdf(Comparison.Histogram.Cumulative_Count_Hospital_rel,xt)./MM;
        Per_Increase(ss)=Comparison.Alternative_Worse.Cumulative_Count_Hospital;
    elseif(Scenario_Indx==3)    
        MM=max(pdf(Comparison.Histogram.Cumulative_Count_Death_rel,xt));
        Y(ss,:)=pdf(Comparison.Histogram.Cumulative_Count_Death_rel,xt)./MM;
        Per_Increase(ss)=Comparison.Alternative_Worse.Cumulative_Count_Death;
    elseif(Scenario_Indx==4)    
        MM=max(pdf(Comparison.Histogram.Cost_rel,xt));
        Y(ss,:)=pdf(Comparison.Histogram.Cost_rel,xt)./MM;
        Per_Increase(ss)=Comparison.Alternative_Worse.Cost_Total;
    end
    plot([0 0],[0.5 7.75],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    plot([-100 100],[6.625 6.625],'-.','color',[0.7 0.7 0.7],'LineWidth',1.25); hold on;
    for ii=1:6
        patch(100.*([xt flip(xt)]),ii+[-0.45.*Y(ii,:) flip(0.45.*Y(ii,:))], CC,'LineStyle','none'); hold on; 
    end
    ii=7;
    patch(100.*([xt flip(xt)]),0.25+ii+[-0.45.*Y(ii,:) flip(0.45.*Y(ii,:))], CC,'LineStyle','none'); hold on; 

    ylim([0.45 7.8]);
    xlim(100.*[-0.6 0.5]);
    xtickformat('percentage');
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:6 7.25],'YTickLabel',AgeC,'Yminortick','off','XTick',[-100:25:150],'Xminortick','off','Fontsize',16);
    xlabel(['Relative change in ' xltxt{Scenario_Indx}],'Fontsize',18);
    ylabel('Age class','Fontsize',18);
    box off;
    for ii=1:6
       text(100.*(0.4),ii,['(' num2str(round(100.*Per_Increase(ii),1)) '%)'],'color',CC,'Fontsize',14,'HorizontalAlignment','center') 
    end
    ii=7;
    text(100.*(0.4),0.25+ii,['(' num2str(round(100.*Per_Increase(ii),1)) '%)'],'color',CC,'Fontsize',14,'HorizontalAlignment','center') 
    text(-0.278,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
end

print(gcf,['Ranked_Age_Distributed_Outcomes_' Scenario '.png'],'-dpng','-r300');    
end
