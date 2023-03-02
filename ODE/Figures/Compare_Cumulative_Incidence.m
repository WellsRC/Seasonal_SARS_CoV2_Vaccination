clear;
clc;
close all;


figure('units','normalized','outerposition',[0 0 1 1]);

Scenarios={'All','Large_Summer','Large_Winter','Similar_Winter_Summer'};

Title_Name={'All scenarios','Large summer peak','Large winter peak','Similar winter and summer peaks'};

CC=[hex2rgb('#000B29');hex2rgb('#967bb6');hex2rgb('#2988BC');hex2rgb('#E1B80D')];

for ss=1:length(Scenarios)
    
    subplot('Position',[0.06+rem(ss-1,2).*0.49,0.58-floor((ss-1)./2).*0.49,0.43,0.38]);
    load(['Analysis_Output_' Scenarios{ss} '.mat'],'IC_Rel_Cases','IC_Rel_Hosp','IC_Rel_Death','xbinedge');
    IC_Rel_Cases=IC_Rel_Cases;
    IC_Rel_Hosp=IC_Rel_Hosp;
    IC_Rel_Death=IC_Rel_Death;
    
    MM=max([max(IC_Rel_Cases) max(IC_Rel_Hosp) max(IC_Rel_Death)]);
    IC_Rel_Cases=IC_Rel_Cases./MM;
    IC_Rel_Hosp=IC_Rel_Hosp./MM;
    IC_Rel_Death=IC_Rel_Death./MM;
    
    plot([-0.5 2.5],[0 0],'color',[0.8 0.8 0.8],'LineWidth',2); hold on
    for jj=1:length(xbinedge)-1
        patch(IC_Rel_Cases(jj).*[-0.45 -0.45 0.45 0.45], 100.*xbinedge([jj jj+1 jj+1 jj]),CC(ss,:),'LineStyle','none'); hold on;
        patch(1+IC_Rel_Hosp(jj).*[-0.45 -0.45 0.45 0.45], 100.*xbinedge([jj jj+1 jj+1 jj]),CC(ss,:),'LineStyle','none'); hold on;
        patch(2+IC_Rel_Death(jj).*[-0.45 -0.45 0.45 0.45], 100.*xbinedge([jj jj+1 jj+1 jj]),CC(ss,:),'LineStyle','none'); hold on;
    end
    box off;
    ytickformat('percentage')
    ylabel('Relative change from continual boosters','Fontsize',16);
    xlabel('Cumulative measure','Fontsize',16);
    title(Title_Name{ss})
    ylim([-45 15]);
    set(gca,'tickdir','out','LineWidth',2,'Fontsize',14,'YTick',[-40:10:10],'YminorTick','on','XTick',[0:2],'XTickLabel',{'Incidence','Hospitalizations','Death'});
end

print(gcf,['Comparison_Campaigns.png'],'-dpng','-r300');