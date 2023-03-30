function Age_Dist_Outcomes_Summer_vs_Winter(Scenario)
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

CCS=[hex2rgb('#b2182b')];
CCW=[hex2rgb('#2166ac')];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Larger winter peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([temp_cd 'Comparison_Summary_Large_Winter_' Scenario '.mat']);
xltxt={'incidence','hospitalizations','deaths'};

Per_Increase_W=zeros(6,3);
YW=zeros(6,length(xbin_edges)-1,3);

    min_x=Inf;
    max_x=-Inf; 
for Scenario_Indx=1:3    
    xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
    for ss=1:6
        if(Scenario_Indx==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            YW(ss,:,Scenario_Indx)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
            Per_Increase_W(ss,Scenario_Indx)=sum(YW(ss,xt>=0,Scenario_Indx))./sum(YW(ss,:,Scenario_Indx));
        elseif(Scenario_Indx==2)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            YW(ss,:,Scenario_Indx)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
            Per_Increase_W(ss,Scenario_Indx)=sum(YW(ss,xt>=0,Scenario_Indx))./sum(YW(ss,:,Scenario_Indx));
        elseif(Scenario_Indx==3)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            YW(ss,:,Scenario_Indx)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
            Per_Increase_W(ss,Scenario_Indx)=sum(YW(ss,xt>=0,Scenario_Indx))./sum(YW(ss,:,Scenario_Indx));
        end
        min_x=min(min_x,min(xbin_edges(YW(ss,:,Scenario_Indx)>0)));
        max_x=max(max_x,max(xbin_edges(YW(ss,:,Scenario_Indx)>0)));
    end   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Larger winter peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([temp_cd 'Comparison_Summary_Large_Summer_' Scenario '.mat']);


Per_Increase_S=zeros(6,3);
YS=zeros(6,length(xbin_edges)-1,3);
for Scenario_Indx=1:3    
    xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
    for ss=1:6
        if(Scenario_Indx==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            YS(ss,:,Scenario_Indx)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
            Per_Increase_S(ss,Scenario_Indx)=sum(YS(ss,xt>=0,Scenario_Indx))./sum(YS(ss,:,Scenario_Indx));
        elseif(Scenario_Indx==2)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            YS(ss,:,Scenario_Indx)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
            Per_Increase_S(ss,Scenario_Indx)=sum(YS(ss,xt>=0,Scenario_Indx))./sum(YS(ss,:,Scenario_Indx));
        elseif(Scenario_Indx==3)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            YS(ss,:,Scenario_Indx)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
            Per_Increase_S(ss,Scenario_Indx)=sum(YS(ss,xt>=0,Scenario_Indx))./sum(YS(ss,:,Scenario_Indx));
        end
        min_x=min(min_x,min(xbin_edges(YS(ss,:,Scenario_Indx)>0)));
        max_x=max(max_x,max(xbin_edges(YS(ss,:,Scenario_Indx)>0)));
    end   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
figure('units','normalized','outerposition',[0.2 0.05 0.25 0.9]);
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
for Scenario_Indx=1:3
    subplot('Position',[0.225,0.745-0.325.*(Scenario_Indx-1),0.72,0.235]);
     plot([0 0],[0.5 6.5],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for ii=1:6
        patch(100.*([xt flip(xt)]),ii+[-0.45*YW(ii,:,Scenario_Indx) flip(0.*YW(ii,:,Scenario_Indx))], CCW,'LineStyle','none'); hold on; 
        patch(100.*([xt flip(xt)]),ii+[-0.*YS(ii,:,Scenario_Indx) flip(0.45.*YS(ii,:,Scenario_Indx))], CCS,'LineStyle','none'); hold on; 
    end
    if(Scenario_Indx==1)
        text(-47.75,6.3,'Larger summer peak','color',CCS,'Fontsize',12);
        text(-47.75,5.8,'Larger winter peak','color',CCW,'Fontsize',12);
    end
    ylim([0.5 6.5]);
    xlim(100.*[-0.5 0.5]);
    xtickformat('percentage');
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:18],'YTickLabel',AgeC,'Yminortick','off','XTick',[-100:25:150],'Xminortick','off','Fontsize',16);
    xlabel(['Relative change in ' xltxt{Scenario_Indx}],'Fontsize',18);
    ylabel('Age class','Fontsize',18);
    box off;
    for ii=1:6
       text(100.*(0.4),ii-0.21,['(' num2str(round(100.*Per_Increase_W(ii,Scenario_Indx),1)) '%)'],'color',CCW,'Fontsize',12,'HorizontalAlignment','center') 
       text(100.*(0.4),ii+0.21,['(' num2str(round(100.*Per_Increase_S(ii,Scenario_Indx),1)) '%)'],'color',CCS,'Fontsize',12,'HorizontalAlignment','center') 
    end
    text(-0.278,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
    
end
print(gcf,['Summer_vs_Winter_Age_Distributed_Outcomes_' Scenario '.png'],'-dpng','-r300');    
end
