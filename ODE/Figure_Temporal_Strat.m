clear;
clc;
close all;


load('Output_Sample_Vac_Start_September_2022.mat','DI_mean_Strat','DI_PRCT_Strat','T_Run')

Strat_T={'July to September','September to December','December to March','March to July'};
for pt=1:4
    DI_PRCT=DI_PRCT_Strat{pt};
    DI_mean=DI_mean_Strat{pt};
    if(~isempty(DI_mean))
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Daily Incidence
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure('units','normalized','outerposition',[0.05 0.2 0.8 0.6]);

        subplot('Position',[0.059,0.265,0.93,0.675]);
        T_Plot=T_Run(1:end-1);
        patch([T_Plot flip(T_Plot)],[DI_PRCT(1,:) flip(DI_PRCT(5,:))],'k','LineStyle','none','FaceAlpha',0.2);
        hold on;
        patch([T_Plot flip(T_Plot)],[DI_PRCT(2,:) flip(DI_PRCT(4,:))],'k','LineStyle','none','FaceAlpha',0.2);
        plot(T_Plot,DI_PRCT(3,:),'k-','LineWidth',2);
        plot(T_Plot,DI_mean,'k-.','LineWidth',2); 
        plot(datenum('September 1, 2022').*ones(101,1),linspace(0,6,101).*10^6,'r-.','LineWidth',1.5);
        box off;
        ylim([0 6*10^6]);
        xlim([T_Run(1) T_Run(end-1)]);
        set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
        xtickangle(45);
        xlabel('Date','Fontsize',16);
        ylabel('Daily incidence','Fontsize',16);
        title(Strat_T{pt},'Fontsize',18);
        print(gcf,['Daily_Incidence_Stratification_' Strat_T{pt} '.png'],'-dpng','-r300');
    end
end