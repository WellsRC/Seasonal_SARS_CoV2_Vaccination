clear;
clc;
close all


CC_temp=[hex2rgb('#0571b0');1 1 1;hex2rgb('#ca0020');];




MMv={'August','September','October','November','December','January','February','March','April'};
YMv=[2022 2022 2022 2022 2022 2023 2023 2023 2023];

r=zeros(4,9);
for mmv=1:9
    load(['Output_Sample_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '.mat'],'Cumulative_Count_mean_Strat')
   for strat_s=1:4
       r(strat_s,mmv)=Cumulative_Count_mean_Strat{strat_s}(1);
   end
end
p=r./r(3,2)-1;

lbx=floor(100.*min(p(:)))./100;
z=0;
ubx=ceil(100.*max(p(:)))./100;

figure('units','normalized','outerposition',[0.05 0.05 0.43 0.65]);

XTL={'Aug. 2022','Sept. 2022','Oct. 2022','Nov. 2022','Dec. 2022','Jan. 2023','Feb. 2023','Mar. 2023','Apr. 2023'};
subplot('Position',[0.15,0.23,0.69,0.75]);

for xx=1:9
    for yy=1:4
        patch(xx+[-0.5 0.5 0.5 -0.5],yy+[-0.5 -0.5 0.5 0.5],interp1([lbx z ubx],CC_temp,p(yy,xx))); hold on;
    end
end
xlim([0.5 9.5]);
ylim([0.5 4.5]);
box off;
text(2,3,'X','Fontsize',32,'FontWeight','bold','HorizontalAlignment','center');

set(gca,'LineWidth',2,'tickdir','out','XTick',[1:9],'XTickLabel',XTL,'Fontsize',14,'YTick',[1:4],'YTickLabel',{'Jul-Aug','Sept-Nov','Dec-Feb','Mar-Jun'});
xtickangle(90)
xlabel('Start of vaccination campaign','Fontsize',18);
ylabel('Month SARS CoV-2 incidence peaks','Fontsize',18);

subplot('Position',[0.86,0.23,0.05,0.75]);
dx=linspace(lbx,ubx,1001);
dy=1;
for ii=1:1000
    patch([0 0 dy dy],[dx(ii) dx(ii+1) dx(ii+1) dx(ii)],interp1([lbx z ubx],CC_temp,dx(ii)),'LineStyle','none'); hold on
end

 text(1.75,dx(1),[num2str(100.*lbx) '%'],'HorizontalAlignment','center','Fontsize',14);
text(1.75,z,'0%','HorizontalAlignment','center','Fontsize',14);
text(1.75,dx(end),[num2str(100.*ubx) '%'],'HorizontalAlignment','center','Fontsize',14);
text(2.5,mean([lbx ubx]),'Relative change in cumulative incidence','HorizontalAlignment','center','Fontsize',18,'Rotation',270);
ylim([lbx ubx]);
axis off;    
