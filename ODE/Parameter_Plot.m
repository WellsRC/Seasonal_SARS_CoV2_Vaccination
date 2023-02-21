clear;
clc;
close all;

load('Parameter_Analysis.mat')

XT=cell(12,1);

for mm=1:12
    XT{mm}=[MM{mm} ',1 ' num2str(YM(mm))];
end

PN={'Latent period','Infectious period - Unvaccinated (Under 30)','Infectious period - Unvaccinated (30-50)','Infectious period - Unvaccinated (50+)','Infectious period - Vaccinated (Under 30)','Infectious period - Vaccinated (30-50)','Infectious period - Vaccinated (50+)','Vaccine effectiveness (Under 18)','Vaccine effectiveness (18-49)','Vaccine effectiveness (50-64)','Vaccine effectiveness (65+)','Vaccine reduction in transmission','Max. beta','Min. beta','Pase shifht','Vaccination rate','Vaccine immunity duration','Natural immunity duration','Hosptial stay (Under 18)','Hosptial stay (18-50)','Hosptial stay (Over 50)','Prior immunity (under 12)','Prior immunity (12-17)','Prior immunity (18-49)','Prior immunity (50-64)','Prior immunity (65+)','Vaccine intent (under 5)','Vaccine intent (5-12)','Vaccine intent (13-17)','Vaccine intent (18-49)','Vaccine intent (50-64)','Vaccine intent (65+)'};
for ii=1:32
    figure('units','normalized','outerposition',[0.05 0.2 0.8 0.6]);

    subplot('Position',[0.059,0.327927927927928,0.93,0.612072072072072]);
    
    for mm=1:12
        if(~isnan(par_stat(mm,6,ii)))
            patch(mm+[-0.45 -0.45 0.45 0.45],[par_stat(mm,1,ii) par_stat(mm,5,ii) par_stat(mm,5,ii) par_stat(mm,1,ii)],'k','LineStyle','none','FaceAlpha',0.2); hold on;
            patch(mm+[-0.45 -0.45 0.45 0.45],[par_stat(mm,2,ii) par_stat(mm,4,ii) par_stat(mm,4,ii) par_stat(mm,2,ii)],'k','LineStyle','none','FaceAlpha',0.2);
            plot(mm+linspace(-0.45,0.45,101),par_stat(mm,6,ii).*ones(101,1),'k-.','LineWidth',2);
            plot(mm+linspace(-0.45,0.45,101),par_stat(mm,3,ii).*ones(101,1),'k-','LineWidth',2);
        end
    end
    box off;
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:12],'XTickLabel',XT,'Fontsize',14);
    xtickangle(45);
    xlabel('Month incidence peaks','Fontsize',16)
    ym=ylim;
    ylim([0.99*min(ym) 1.01*max(ym)]);
    title(PN{ii})
    
        print(gcf,[PN{ii} '.png'],'-dpng','-r300');
end