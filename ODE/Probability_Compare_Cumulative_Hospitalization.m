clear;
clc;
close all


CC_temp=[1 1 1;hex2rgb('#ffBB00');hex2rgb('#FB6542');hex2rgb('#D61800');hex2rgb('#231B12');];
cx=[0 0.25 0.5 0.75 1];

MMv={'August','October','November','December','January','February','March','April'};
YMv=[2022 2022 2022 2022 2023 2023 2023 2023];

r=zeros(12,8);
for mmv=1:8
    load(['Output_Sample_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '_Comapred_to_September_2022.mat'],'Higher_Cumulative_Count_Month')
   for strat_s=1:12
       r(strat_s,mmv)=Higher_Cumulative_Count_Month(strat_s,2);
   end
end
% Ensure this label is correct with how the analysis is done
MM={'July','August','September','October','November','December','January','February','March','April','May','June'};

lbx=0;
ubx=1;

figure('units','normalized','outerposition',[0.05 0.05 0.43 0.65]);

XTL={'Aug. 2022','Oct. 2022','Nov. 2022','Dec. 2022','Jan. 2023','Feb. 2023','Mar. 2023','Apr. 2023'};
subplot('Position',[0.175,0.23,0.665,0.75]);

for xx=1:8
    for yy=1:12
            patch(xx+[-0.5 0.5 0.5 -0.5],yy+[-0.5 -0.5 0.5 0.5],interp1(cx,CC_temp,r(yy,xx))); hold on;
    end
end
xlim([0.5 8.5]);
ylim([0.5 12.5]);
box off;

set(gca,'LineWidth',2,'tickdir','out','XTick',[1:9],'XTickLabel',XTL,'Fontsize',14,'YTick',[1:12],'YTickLabel',MM);
xtickangle(90)
xlabel('Start of vaccination campaign','Fontsize',18);
ylabel('Month SARS CoV-2 incidence peaks','Fontsize',18);

subplot('Position',[0.86,0.23,0.05,0.75]);
dx=linspace(lbx,ubx,1001);
dy=1;
for ii=1:1000
    patch([0 0 dy dy],[dx(ii) dx(ii+1) dx(ii+1) dx(ii)],interp1(cx,CC_temp,dx(ii)),'LineStyle','none'); hold on
end

 text(1.75,dx(1),[num2str(100.*lbx) '%'],'HorizontalAlignment','center','Fontsize',14);
text(1.75,dx(end),[num2str(100.*ubx) '%'],'HorizontalAlignment','center','Fontsize',14);
text(1.9,mean([lbx ubx]),{'Prob. of greater cumulative hospitalization','than Sept. vaccination campaign'},'HorizontalAlignment','center','Fontsize',16,'Rotation',270);
ylim([lbx ubx]);
axis off;    
