function Age_Dist(Scenario)
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_' Scenario '.mat']);
xbinedge=[-1:0.01:1];
CC=hex2rgb('#000B29');
% Scenarios={'All','Large_Summer','Large_Winter'};
figure('units','normalized','outerposition',[0 0.025 0.8 0.9]);

% ts=strcmp(Scenario,Scenarios);
AgeC={'All Ages','Ages: 0-4','Ages: 5-17','Ages: 18-49','Ages: 50-64','Ages: 65 and older'};
for ss=1:6
    subplot('Position',[0.06+rem((ss-1),3).*0.33,0.59-floor(ss./4).*0.49,0.27,0.375]);
    
    if(ss==1)
        MM=max([max(Comparison.Histogram.Cumulative_Count_Incidence_rel) max(Comparison.Histogram.Cumulative_Count_Hospital_rel) max(Comparison.Histogram.Cumulative_Count_Death_rel)]);
        Plot_IC_Rel_Cases=Comparison.Histogram.Cumulative_Count_Incidence_rel./MM;
        Plot_IC_Rel_Hosp=Comparison.Histogram.Cumulative_Count_Hospital_rel./MM;
        Plot_IC_Rel_Death=Comparison.Histogram.Cumulative_Count_Death_rel./MM;
    else
        
        MM=max([max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss-1,:)) max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss-1,:)) max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss-1,:))]);
        Plot_IC_Rel_Cases=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss-1,:)./MM;
        Plot_IC_Rel_Hosp=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss-1,:)./MM;
        Plot_IC_Rel_Death=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss-1,:)./MM;
    end    
    
    plot([-0.5 2.5],[0 0],'color',[0.8 0.8 0.8],'LineWidth',2); hold on
    for jj=1:length(xbinedge)-1
        patch(Plot_IC_Rel_Cases(jj).*[-0.45 -0.45 0.45 0.45], 100.*xbinedge([jj jj+1 jj+1 jj]),CC,'LineStyle','none'); hold on;
        patch(1+Plot_IC_Rel_Hosp(jj).*[-0.45 -0.45 0.45 0.45], 100.*xbinedge([jj jj+1 jj+1 jj]),CC,'LineStyle','none'); hold on;
        patch(2+Plot_IC_Rel_Death(jj).*[-0.45 -0.45 0.45 0.45], 100.*xbinedge([jj jj+1 jj+1 jj]),CC,'LineStyle','none'); hold on;
    end
    box off;
    ytickformat('percentage')
    ylim([-100 140]);
    set(gca,'tickdir','out','LineWidth',2,'Fontsize',14,'YTick',[-100:20:140],'YminorTick','on','XTick',[0:2],'XTickLabel',{'Incidence','Hospitalizations','Death'}); 
    title(AgeC{ss})
    ylabel('Relative to baseline','Fontsize',16);
    xlabel('Cumulative measure','Fontsize',16);
end
end
