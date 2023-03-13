clear;
clc;
close all;

load(['Contour_Analysis_All.mat'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Incidence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.05 0.6 0.95]);
temp=Deaths_IC_omega_gamma./Tot_omega_gamma;
temp(Tot_omega_gamma==0)=NaN;
subplot('Position',[0.077,0.148,0.596,0.56]);
X=linspace(0,1,length(bin_omega_R)-1);
Y=linspace(0,1,length(bin_gamma_V)-1);
contourf(X,Y,temp,'LineStyle','None'); hold on
set(gca,'LineWidth',2,'tickdir','out','XTick',linspace(0,1,length(bin_omega_R(1:2:end))),'XTickLabel',{num2str(round(bin_omega_R(1:2:end)'))},'YTick',linspace(0,1,length(bin_gamma_V(1:2:end))),'YTickLabel',{num2str(round(bin_gamma_V(1:2:end)'))},'Fontsize',14);
xtickangle(90);
box off;
load('BW_cmap.mat','cmap');

colormap(cmap);

subplot('Position',[0.676056338028169,0.148,0.310739436619718,0.56]);

plot(pchip(X,sum(temp,1)./sum(temp(:)),linspace(X(1),X(end),10001)),linspace(X(1),X(end),10001),'k','LineWidth',2);
box off;
axis off;
% set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','YTick',X(1:2:end),'YTickLabel','','Fontsize',14);


subplot('Position',[0.077880281690141,0.708896034297963,0.596,0.28]);

plot(linspace(Y(1),Y(end),10001),pchip(Y,sum(temp,2)./sum(temp(:)),linspace(Y(1),Y(end),10001)),'k','LineWidth',2);
box off;
axis off;