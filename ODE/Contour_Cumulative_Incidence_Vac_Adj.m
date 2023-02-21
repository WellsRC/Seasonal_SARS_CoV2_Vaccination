clear;
clc;
close all


CC_temp=[hex2rgb('#0571b0');1 1 1;hex2rgb('#ca0020');];
lbx=-1;
z=0;
ubx=1;

r=-1+2.*rand(7,9);
red_v=[0:0.05:0.3];
figure('units','normalized','outerposition',[0.05 0.05 0.43 0.65]);

XTL={'Aug. 2022','Sept. 2022','Oct. 2022','Nov. 2022','Dec. 2022','Jan. 2023','Feb. 2023','Mar. 2023','Apr. 2023'};
subplot('Position',[0.14,0.23,0.7,0.75]);

for xx=1:9
    for yy=1:7
        patch(xx+[-0.5 0.5 0.5 -0.5],100.*red_v(yy)+[-2.5 -2.5 2.5 2.5],interp1([lbx z ubx],CC_temp,r(yy,xx))); hold on;
    end
end
xlim([0.5 9.5]);
ylim([-2.5 32.5]);
box off;

set(gca,'LineWidth',2,'tickdir','out','XTick',[1:9],'XTickLabel',XTL,'Fontsize',14);
xtickangle(90)
ytickformat('percentage')
xlabel('Start of vaccination campaign','Fontsize',18);
ylabel('Reduction in vaccination coverage','Fontsize',18);
text(-0.175,0.9825,'A','FontSize',32,'FontWeight','bold','Units','Normalized');

subplot('Position',[0.86,0.23,0.05,0.75]);
dx=linspace(0,1,1001);
dy=1;
for ii=1:1000
    patch([0 0 dy dy],[dx(ii) dx(ii+1) dx(ii+1) dx(ii)],interp1([lbx z ubx],CC_temp,lbx+(ubx-lbx).*dx(ii)),'LineStyle','none'); hold on
end

 text(1.75,dx(1),['-100%'],'HorizontalAlignment','center','Fontsize',14);
text(1.75,0.5,'0%','HorizontalAlignment','center','Fontsize',14);
text(1.75,dx(end),'100%','HorizontalAlignment','center','Fontsize',14);
text(2.5,0.5,'Change in cumulative incidence','HorizontalAlignment','center','Fontsize',18,'Rotation',270);
axis off;    
