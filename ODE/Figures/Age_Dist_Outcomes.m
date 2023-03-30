function Age_Dist_Outcomes(Scenario)
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_' Scenario '.mat']);
xltxt={'incidence','hospitalizations','deaths'};
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];
figure('units','normalized','outerposition',[0.2 0.05 0.25 0.9]);
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
for Scenario_Indx=1:3
    
    subplot('Position',[0.225,0.745-0.325.*(Scenario_Indx-1),0.72,0.235]);
    Per_Increase=zeros(1,6);
    Y=zeros(6,length(xbin_edges)-1);
    CC=CCv(Scenario_Indx,:);
    xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
    min_x=Inf;
    max_x=-Inf; 
    for ss=1:6
        if(Scenario_Indx==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            Y(ss,:)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
            Per_Increase(ss)=sum(Y(ss,xt>=0))./sum(Y(ss,:));
        elseif(Scenario_Indx==2)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            Y(ss,:)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
            Per_Increase(ss)=sum(Y(ss,xt>=0))./sum(Y(ss,:));
        elseif(Scenario_Indx==3)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            Y(ss,:)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
            Per_Increase(ss)=sum(Y(ss,xt>=0))./sum(Y(ss,:));
        end
        min_x=min(min_x,min(xbin_edges(Y(ss,:)>0)));
        max_x=max(max_x,max(xbin_edges(Y(ss,:)>0)));
    end
    plot([0 0],[0.5 6.5],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for ii=1:6
        patch(100.*([xt flip(xt)]),ii+[-0.45.*Y(ii,:) flip(0.45.*Y(ii,:))], CC,'LineStyle','none'); hold on; 
    end

    ylim([0.5 6.5]);
    xlim(100.*[-0.5 0.5]);
    xtickformat('percentage');
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:18],'YTickLabel',AgeC,'Yminortick','off','XTick',[-100:25:150],'Xminortick','off','Fontsize',16);
    xlabel(['Relative change in ' xltxt{Scenario_Indx}],'Fontsize',18);
    ylabel('Age class','Fontsize',18);
    box off;
    for ii=1:6
       text(100.*(0.4),ii,['(' num2str(round(100.*Per_Increase(ii),1)) '%)'],'color',CC,'Fontsize',14,'HorizontalAlignment','center') 
    end
    text(-0.278,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
end

print(gcf,['Ranked_Age_Distributed_Outcomes_' Scenario '.png'],'-dpng','-r300');    
end
