function Incidence_Vaccine_Timing(Peak_Scenario,Central_Tendancy)


MMv={'August','September','October','November','December','January','February','March','April'};
YMv=[2022 2022 2022 2022 2022 2023 2023 2023 2023];

DI_plot=zeros(9,365);
for mmv=1:9
   load(['Output_Sample_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '.mat'],'DI_PRCT_Strat','DI_mean_Strat','T_Run'); 
   if(strcmp(Central_Tendancy,'Mean'))
       temp_plot=DI_mean_Strat{Peak_Scenario};
   else
       temp_plot=DI_PRCT_Strat{Peak_Scenario};
       temp_plot=temp_plot(3,:);
   end
   DI_plot(mmv,:)=temp_plot;
end
lbc=min(floor(10.*log10(DI_plot(:)))./10);
ubc=max(ceil(10.*log10(DI_plot(:)))./10);
CC_temp=[1 1 1; 0 0 0];

figure('units','normalized','outerposition',[0.05 0.05 0.53 0.75]);

YTL={'Aug. 2022','Sept. 2022','Oct. 2022','Nov. 2022','Dec. 2022','Jan. 2023','Feb. 2023','Mar. 2023','Apr. 2023'};
subplot('Position',[0.17,0.23,0.7,0.75]);

for mmv=1:9
    for dd=1:length(T_Run)-1
        patch(T_Run(dd)+[-0.5 -0.5 0.5 0.5],mmv+[-0.5 0.5 0.5 -0.5],interp1([lbc ubc],CC_temp,log10(DI_plot(mmv,dd))),'LineStyle','none'); hold on;
    end
    plot(datenum([MMv{mmv} ,' 1, ' num2str(YMv(mmv))]).*ones(101,1),mmv+linspace(-0.5,0.5,101),'r-.','LineWidth',2);
end

xlim([T_Run(1)-0.5 T_Run(end-1)+0.5]);
ylim([0.5 9.5]);

box off;

set(gca,'LineWidth',2,'tickdir','out','XTick',T_Run(1:28:365),'XTickLabel',datestr(T_Run(1:28:365)),'YTick',[1:9],'YTickLabel',YTL,'Fontsize',14);
xtickangle(90);
xlabel('Date','Fontsize',18);
ylabel('Month vaccine campaign starts','Fontsize',18);

subplot('Position',[0.89,0.23,0.05,0.75]);
dx=linspace(0,1,1001);
dy=1;
for ii=1:1000
    patch([0 0 dy dy],[dx(ii) dx(ii+1) dx(ii+1) dx(ii)],interp1([lbc ubc],CC_temp,lbc+(ubc-lbc).*dx(ii)),'LineStyle','none'); hold on
end

 text(1.75,dx(1),num2str(lbc),'HorizontalAlignment','center','Fontsize',14);
text(1.75,dx(end),num2str(ubc),'HorizontalAlignment','center','Fontsize',14);
text(1.8,0.5,'log_{10} daily incidence','HorizontalAlignment','center','Fontsize',18,'Rotation',270);
axis off;    

end

