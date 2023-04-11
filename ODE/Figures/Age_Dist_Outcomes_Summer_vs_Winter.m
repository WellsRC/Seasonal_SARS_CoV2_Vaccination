function Age_Dist_Outcomes_Summer_vs_Winter(Scenario)
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

CCS=[hex2rgb('#b2182b')];
CCW=[hex2rgb('#2166ac')];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Larger winter peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([temp_cd 'Comparison_Summary_Large_Winter_' Scenario '.mat']);
xltxt={'incidence','hospitalizations','deaths','cost'};
xt=linspace(-1,1,5001);
Per_Increase_W=zeros(6,4);
YW=zeros(6,length(xt),4);

    min_x=Inf;
    max_x=-Inf; 
for Scenario_Indx=1:4    
    for ss=1:6
        if(Scenario_Indx==1)
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{ss},xt));
            YW(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{ss},xt)./MM;
            Per_Increase_W(ss,Scenario_Indx)=Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence(ss);
        elseif(Scenario_Indx==2)    
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{ss},xt));
            YW(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{ss},xt)./MM;
            Per_Increase_W(ss,Scenario_Indx)=Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital(ss);
        elseif(Scenario_Indx==3)    
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{ss},xt));
            YW(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{ss},xt)./MM;
            Per_Increase_W(ss,Scenario_Indx)=Comparison.Alternative_Worse.Age_Cumulative_Count_Death(ss);
        elseif(Scenario_Indx==4)    
            MM=max(pdf(Comparison.Histogram.Cost_Age_rel{ss},xt));
            YW(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Cost_Age_rel{ss},xt)./MM;
            Per_Increase_W(ss,Scenario_Indx)=Comparison.Alternative_Worse.Cost_Age(ss);
        end
        min_x=min(min_x,min(xt(YW(ss,:,Scenario_Indx)>0)));
        max_x=max(max_x,max(xt(YW(ss,:,Scenario_Indx)>0)));
    end   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Larger winter peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([temp_cd 'Comparison_Summary_Large_Summer_' Scenario '.mat']);


Per_Increase_S=zeros(6,4);
YS=zeros(6,length(xt),4);
for Scenario_Indx=1:4    
    for ss=1:6
        if(Scenario_Indx==1)
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{ss},xt));
            YS(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{ss},xt)./MM;
            Per_Increase_S(ss,Scenario_Indx)=Comparison.Alternative_Worse.Age_Cumulative_Count_Incidence(ss);
        elseif(Scenario_Indx==2)    
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{ss},xt));
            YS(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{ss},xt)./MM;
            Per_Increase_S(ss,Scenario_Indx)=Comparison.Alternative_Worse.Age_Cumulative_Count_Hospital(ss);
        elseif(Scenario_Indx==3)    
            MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{ss},xt));
            YS(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{ss},xt)./MM;
            Per_Increase_S(ss,Scenario_Indx)=Comparison.Alternative_Worse.Age_Cumulative_Count_Death(ss);
        elseif(Scenario_Indx==4)    
            MM=max(pdf(Comparison.Histogram.Cost_Age_rel{ss},xt));
            YS(ss,:,Scenario_Indx)=pdf(Comparison.Histogram.Cost_Age_rel{ss},xt)./MM;
            Per_Increase_S(ss,Scenario_Indx)=Comparison.Alternative_Worse.Cost_Age(ss);
        end
        min_x=min(min_x,min(xt(YS(ss,:,Scenario_Indx)>0)));
        max_x=max(max_x,max(xt(YS(ss,:,Scenario_Indx)>0)));
    end   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
for Scenario_Indx=1:4
    
    subplot('Position',[0.105+0.5.*(rem(Scenario_Indx-1,2)),0.625-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.3525]);
     plot([0 0],[0.5 6.5],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for ii=1:6
        patch(100.*([xt flip(xt)]),ii+[-0.45*YW(ii,:,Scenario_Indx) flip(0.*YW(ii,:,Scenario_Indx))], CCW,'LineStyle','none'); hold on; 
        patch(100.*([xt flip(xt)]),ii+[-0.*YS(ii,:,Scenario_Indx) flip(0.45.*YS(ii,:,Scenario_Indx))], CCS,'LineStyle','none'); hold on; 
    end
    if(Scenario_Indx==1)
        text(-47.75,6.3,'Larger summer peak','color',CCS,'Fontsize',12);
        text(-47.75,5.8,'Larger winter peak','color',CCW,'Fontsize',12);
    end
    ylim([0.45 6.55]);
    xlim(100.*[-0.5 0.25]);
    xtickformat('percentage');
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:18],'YTickLabel',AgeC,'Yminortick','off','XTick',[-100:25:150],'Xminortick','off','Fontsize',16);
    xlabel(['Relative change in ' xltxt{Scenario_Indx}],'Fontsize',18);
    ylabel('Age class','Fontsize',18);
    box off;
    for ii=1:6
       text(100.*(0.2),ii-0.21,['(' num2str(round(100.*Per_Increase_W(ii,Scenario_Indx),1)) '%)'],'color',CCW,'Fontsize',10,'HorizontalAlignment','center') 
       text(100.*(0.2),ii+0.21,['(' num2str(round(100.*Per_Increase_S(ii,Scenario_Indx),1)) '%)'],'color',CCS,'Fontsize',10,'HorizontalAlignment','center') 
    end
    text(-0.278,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
    
end
print(gcf,['Summer_vs_Winter_Age_Distributed_Outcomes_' Scenario '.png'],'-dpng','-r300');    
end
