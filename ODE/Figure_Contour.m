clear;
clc;
close all;


MMv={'September','October','November','December','January','February','March','April'};
YMv=[2022 2022 2022 2022 2023 2023 2023 2023];

mmv=8;

load(['Output_Sample_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '.mat'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Incidence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.05 0.6 0.95]);
temp=N_DI';
temp(temp==0)=NaN;
subplot('Position',[0.077,0.148,0.596,0.56]);
dTp=(dT(2:end)+dT(1:end-1))./2;
mpp=(mp(2:end)+mp(1:end-1))./2;
contourf(dTp,mpp,temp,'LineStyle','None'); hold on
plot(datenum([MMv{mmv} ' 1, ' num2str(YMv(mmv))]).*ones(length(mpp),1),mpp,'r-.','LineWidth',1.5);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',dT(1:28:end),'XTickLabel',datestr(dT(1:28:end)),'YTick',mp(1:2:end),'Fontsize',14);
xtickangle(45);
ylim([5.5 7])
xlim([datenum('July 1, 2022') datenum('June 30, 2023')]);
xlabel('Date of peak','Fontsize',16);
ylabel('log_{10} Magnitude of peak','Fontsize',16);
box off;
load('BW_cmap.mat','cmap');

colormap(cmap);

subplot('Position',[0.676056338028169,0.148,0.310739436619718,0.56]);

trim_p=sum(N_DI(dTp<datenum([MMv{mmv} ' 1, ' num2str(YMv(mmv))]),:),1)./sum(N_DI(:));
patch([trim_p zeros(size(trim_p))],[mpp flip(mpp)],'r','LineStyle','none','FaceAlpha',0.2); hold on

plot(pchip(mpp,sum(N_DI,1)./sum(N_DI(:)),linspace(mp(1),mp(end),10001)),linspace(mp(1),mp(end),10001),'k','LineWidth',2);
box off;
axis off;
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','YTick',mp(1:2:end),'YTickLabel','','Fontsize',14);

ylim([5.5 7])
xlim([0 0.16])

subplot('Position',[0.077880281690141,0.708896034297963,0.596,0.28]);
trim_dtp=dTp(dTp<datenum([MMv{mmv} ' 1, ' num2str(YMv(mmv))]));
trim_p=sum(N_DI,2)./sum(N_DI(:));
trim_p=trim_p(dTp<datenum([MMv{mmv} ' 1, ' num2str(YMv(mmv))]))';
patch([trim_dtp flip(trim_dtp)],[trim_p zeros(size(trim_p))],'r','LineStyle','none','FaceAlpha',0.2); hold on
plot(dTp,sum(N_DI,2)./sum(N_DI(:)),'k','LineWidth',2);
text(datenum('July 1, 2022'),0.0065,[num2str(round(100.*sum(trim_p))) '%'],'color','r','Fontsize',14)
box off;
axis off;
% set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','YTick',mp(1:2:end),'YTickLabel','','Fontsize',14);

ylim([0 0.01])
xlim([datenum('July 1, 2022') datenum('June 30, 2023')]);


print(gcf,['Daily_Incidence_Contour_' MMv{mmv} '_' num2str(YMv(mmv)) '.png'],'-dpng','-r300');