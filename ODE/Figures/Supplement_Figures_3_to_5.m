%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Supplement Figure 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close all;
temp_cd=pwd;

temp_cd=temp_cd(1:end-7);

load([temp_cd 'Analyze_Samples\Baseline_Outputs.mat'],'Filtered_Output_Large_Winter');
Winter_Peak_Month=[datenum('September 1, 2022'); datenum('October 1, 2022'); datenum('November 1, 2022'); datenum('December 1, 2022'); datenum('Janaury 1, 2023'); datenum('February 1, 2023'); datenum('March 1, 2023'); datenum('April 1, 2023')]-datenum('August 31, 2022');
Summer_Peak_Month=[datenum('April 1, 2023'); datenum('May 1, 2023'); datenum('June 1, 2023'); datenum('July 1, 2023');  datenum('August 1, 2023');  datenum('September 1, 2023') ]-datenum('August 31, 2022');

Time_Winter_Peak=zeros(size(Filtered_Output_Large_Winter.Hospital_Admission,1),1);
Time_Summer_Peak=zeros(size(Filtered_Output_Large_Winter.Hospital_Admission,1),1);
for ii=1:length(Time_Winter_Peak)
    [m_pks,dt_pks]=findpeaks(Filtered_Output_Large_Winter.Hospital_Admission(ii,:));
    m_Winter=max(m_pks(dt_pks<Winter_Peak_Month(end)));
    m_Summer=max(m_pks(dt_pks>=Summer_Peak_Month(1)));
    Time_Winter_Peak(ii)=find(Filtered_Output_Large_Winter.Hospital_Admission(ii,:)==m_Winter);
    Time_Summer_Peak(ii)=find(Filtered_Output_Large_Winter.Hospital_Admission(ii,:)==m_Summer);
end

Count_Month=zeros(length(Winter_Peak_Month)-1,length(Summer_Peak_Month)-1);

Indx_Month=zeros(size(Filtered_Output_Large_Winter.Hospital_Admission,1),1);

for ii=1:length(Winter_Peak_Month)-1
    Indx_Month(Time_Winter_Peak>=Winter_Peak_Month(ii) & Time_Winter_Peak<Winter_Peak_Month(ii+1))=ii;
    for jj=1:length(Summer_Peak_Month)-1
        Count_Month(ii,jj)=sum(Time_Summer_Peak>=Summer_Peak_Month(jj) & Time_Summer_Peak<Summer_Peak_Month(jj+1) & Time_Winter_Peak>=Winter_Peak_Month(ii) & Time_Winter_Peak<Winter_Peak_Month(ii+1));
    end
end

Count_Month=Count_Month./max(Count_Month(:));
Per_Month=100.*Count_Month./sum(Count_Month(:));

T= datetime(2023,9,1) + caldays(0:364);

H_Data=readtable('data_table_for_weekly_covid19_hospital_admissions_-_the_united_states.csv');
T_Data=datetime(2023,9,1) + caldays(0:101);
HD_P=zeros(length(T_Data),1);
DHA=H_Data.AverageDaily;
DHA_Date=H_Data.Date;
for ii=1:length(HD_P)
    f_indx=find(T_Data(ii)>=DHA_Date,1);
    HD_P(ii)=DHA(f_indx);
end

HA=zeros(3,4,length(T));


HA(1,1,:)=min(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month<=3,:),[],1);
HA(1,2,:)=max(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month<=3,:),[],1);
HA(1,3,:)=median(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month<=3,:),1);
HA(1,4,:)=mean(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month<=3,:),1);

HA(2,1,:)=min(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>3 & Indx_Month<6 ,:),[],1);
HA(2,2,:)=max(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>3 & Indx_Month<6,:),[],1);
HA(2,3,:)=median(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>3 & Indx_Month<6,:),1);
HA(2,4,:)=mean(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>3 & Indx_Month<6,:),1);

HA(3,1,:)=min(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>=6,:),[],1);
HA(3,2,:)=max(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>=6,:),[],1);
HA(3,3,:)=median(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>=6,:),1);
HA(3,4,:)=mean(Filtered_Output_Large_Winter.Hospital_Admission(Indx_Month>=6,:),1);


figure('units','normalized','outerposition',[0.02 0.02 1 1]);

YTL={'Sept.','Oct.','Nov.','Dec.','Jan.','Feb.','Mar.'};
XTL={'Apr.','May','June','July','Aug.'};
subplot('Position',[0.065 0.6 0.4 0.36])

for ii=1:length(YTL)
    for jj=1:length(XTL)
        patch((jj-1)+[0 0 1 1],(ii-1)+[0 1 1 0],hex2rgb('#E94F08'),'FaceAlpha',Count_Month(ii,jj),'LineStyle','none'); 
        text(0.5+(jj-1),0.5+(ii-1),[num2str(Per_Month(ii,jj),'%3.1f') '%'],'fontsize',14,'HorizontalAlignment','center');
        hold on
    end
end
set(gca,'LineWidth',2,'TickDir','out','XTick',(1:length(XTL))-0.5,'XTickLabel',XTL,'YTick',(1:length(YTL))-0.5,'YTickLabel',YTL,'Fontsize',16);
xlabel('Month of summer peak','Fontsize',18)
ylabel('Month of winter peak','Fontsize',18)
ylim([0 length(YTL)])
xlim([0 length(XTL)])
text(-0.14,1.05,'A','Units','normalized','FontSize',28)

subplot('Position',[0.55 0.6 0.4 0.36])
Y1=squeeze(HA(1,1,:))';
Y2=squeeze(HA(1,2,:))';
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(1,3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(1,4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);
plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:55000,'Yminortick','on');
title('Winter peak: September 1 to November 30')
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 55000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend('Range','Median','Mean','Observed data')
text(-0.14,1.05,'B','Units','normalized','FontSize',28)

subplot('Position',[0.065 0.11 0.4 0.36])
Y1=squeeze(HA(2,1,:))';
Y2=squeeze(HA(2,2,:))';
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(2,3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(2,4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);
plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:55000,'Yminortick','on');
title('Winter peak: December 1 to January 31')
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 55000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend('Range','Median','Mean','Observed data')
text(-0.14,1.05,'C','Units','normalized','FontSize',28)

subplot('Position',[0.55 0.11 0.4 0.36])
Y1=squeeze(HA(3,1,:))';
Y2=squeeze(HA(3,2,:))';
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(3,3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(3,4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);
plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:55000,'Yminortick','on');
title('Winter peak: February 1 to March 31')
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 55000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend('Range','Median','Mean','Observed data')
text(-0.14,1.05,'D','Units','normalized','FontSize',28)
print(gcf,['Supplement_Figure_3.png'],'-dpng','-r600');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Supplement Figure 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close all;
temp_cd=pwd;

temp_cd=temp_cd(1:end-7);

load([temp_cd 'Analyze_Samples\Baseline_Outputs.mat'],'Filtered_Output_Large_Summer');
Winter_Peak_Month=[datenum('September 1, 2022'); datenum('October 1, 2022'); datenum('November 1, 2022'); datenum('December 1, 2022'); datenum('Janaury 1, 2023'); datenum('February 1, 2023'); datenum('March 1, 2023'); datenum('April 1, 2023')]-datenum('August 31, 2022');
Summer_Peak_Month=[datenum('April 1, 2023'); datenum('May 1, 2023'); datenum('June 1, 2023'); datenum('July 1, 2023');  datenum('August 1, 2023');  datenum('September 1, 2023') ]-datenum('August 31, 2022');

Time_Winter_Peak=zeros(size(Filtered_Output_Large_Summer.Hospital_Admission,1),1);
Time_Summer_Peak=zeros(size(Filtered_Output_Large_Summer.Hospital_Admission,1),1);
for ii=1:length(Time_Winter_Peak)
    [m_pks,dt_pks]=findpeaks(Filtered_Output_Large_Summer.Hospital_Admission(ii,:));
    m_Winter=max(m_pks(dt_pks<Winter_Peak_Month(end)));
    m_Summer=max(m_pks(dt_pks>=Summer_Peak_Month(1)));
    Time_Winter_Peak(ii)=find(Filtered_Output_Large_Summer.Hospital_Admission(ii,:)==m_Winter);
    Time_Summer_Peak(ii)=find(Filtered_Output_Large_Summer.Hospital_Admission(ii,:)==m_Summer);
end

Count_Month=zeros(length(Winter_Peak_Month)-1,length(Summer_Peak_Month)-1);

Indx_Month=zeros(size(Filtered_Output_Large_Summer.Hospital_Admission,1),1);

for ii=1:length(Winter_Peak_Month)-1
    Indx_Month(Time_Winter_Peak>=Winter_Peak_Month(ii) & Time_Winter_Peak<Winter_Peak_Month(ii+1))=ii;
    for jj=1:length(Summer_Peak_Month)-1
        Count_Month(ii,jj)=sum(Time_Summer_Peak>=Summer_Peak_Month(jj) & Time_Summer_Peak<Summer_Peak_Month(jj+1) & Time_Winter_Peak>=Winter_Peak_Month(ii) & Time_Winter_Peak<Winter_Peak_Month(ii+1));
    end
end

Count_Month=Count_Month./max(Count_Month(:));
Per_Month=100.*Count_Month./sum(Count_Month(:));

T= datetime(2023,9,1) + caldays(0:364);

H_Data=readtable('data_table_for_weekly_covid19_hospital_admissions_-_the_united_states.csv');
T_Data=datetime(2023,9,1) + caldays(0:101);
HD_P=zeros(length(T_Data),1);
DHA=H_Data.AverageDaily;
DHA_Date=H_Data.Date;
for ii=1:length(HD_P)
    f_indx=find(T_Data(ii)>=DHA_Date,1);
    HD_P(ii)=DHA(f_indx);
end

HA=zeros(4,length(T));

HA(1,:)=min(Filtered_Output_Large_Summer.Hospital_Admission,[],1);
HA(2,:)=max(Filtered_Output_Large_Summer.Hospital_Admission,[],1);
HA(3,:)=median(Filtered_Output_Large_Summer.Hospital_Admission,1);
HA(4,:)=mean(Filtered_Output_Large_Summer.Hospital_Admission,1);

figure('units','normalized','outerposition',[0.02 0.1 1 0.6]);

YTL={'Sept.','Oct.','Nov.','Dec.','Jan.','Feb.','Mar.'};
XTL={'Apr.','May','June','July','Aug.'};
subplot('Position',[0.065 0.2 0.4 0.72])

for ii=1:length(YTL)
    for jj=1:length(XTL)
        patch((jj-1)+[0 0 1 1],(ii-1)+[0 1 1 0],hex2rgb('#E94F08'),'FaceAlpha',Count_Month(ii,jj),'LineStyle','none'); 
        text(0.5+(jj-1),0.5+(ii-1),[num2str(Per_Month(ii,jj),'%3.1f') '%'],'fontsize',14,'HorizontalAlignment','center');
        hold on
    end
end
set(gca,'LineWidth',2,'TickDir','out','XTick',(1:length(XTL))-0.5,'XTickLabel',XTL,'YTick',(1:length(YTL))-0.5,'YTickLabel',YTL,'Fontsize',16);
xlabel('Month of summer peak','Fontsize',18)
ylabel('Month of winter peak','Fontsize',18)
ylim([0 length(YTL)])
xlim([0 length(XTL)])
text(-0.14,1.05,'A','Units','normalized','FontSize',28)

subplot('Position',[0.55 0.2 0.4 0.72])
Y1=squeeze(HA(1,:));
Y2=squeeze(HA(2,:));
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);
plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:40000,'Yminortick','on');
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 40000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend({'Range','Median','Mean','Observed data'},'Location','northwest')
text(-0.14,1.05,'B','Units','normalized','FontSize',28)
print(gcf,['Supplement_Figure_4.png'],'-dpng','-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Supplement Figure 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close all;
temp_cd=pwd;

temp_cd=temp_cd(1:end-7);

load([temp_cd 'Analyze_Samples\Unimodal_Peak_Winter_Output.mat'],'Filtered_Output_Unimodal');
Winter_Peak_Month=[datenum('October 1, 2022'); datenum('November 1, 2022'); datenum('December 1, 2022'); datenum('Janaury 1, 2023'); datenum('February 1, 2023'); datenum('March 1, 2023'); datenum('April 1, 2023') ; datenum('May 1, 2023')]-datenum('August 31, 2022');

Time_Winter_Peak=zeros(size(Filtered_Output_Unimodal.Hospital_Admission,1),1);
for ii=1:length(Time_Winter_Peak)
    Time_Winter_Peak(ii)=find(Filtered_Output_Unimodal.Hospital_Admission(ii,:)==max(Filtered_Output_Unimodal.Hospital_Admission(ii,:)));
end

Count_Month=zeros(length(Winter_Peak_Month)-1,1);

Indx_Month=zeros(size(Filtered_Output_Unimodal.Hospital_Admission,1),1);

for ii=1:length(Winter_Peak_Month)-1
    Indx_Month(Time_Winter_Peak>=Winter_Peak_Month(ii) & Time_Winter_Peak<Winter_Peak_Month(ii+1))=ii;
    Count_Month(ii)=sum(Time_Winter_Peak>=Winter_Peak_Month(ii) & Time_Winter_Peak<Winter_Peak_Month(ii+1));
end

Per_Month=100.*Count_Month./sum(Count_Month(:));

T= datetime(2023,9,1) + caldays(0:364);

H_Data=readtable('data_table_for_weekly_covid19_hospital_admissions_-_the_united_states.csv');
T_Data=datetime(2023,9,1) + caldays(0:101);
HD_P=zeros(length(T_Data),1);
DHA=H_Data.AverageDaily;
DHA_Date=H_Data.Date;
for ii=1:length(HD_P)
    f_indx=find(T_Data(ii)>=DHA_Date,1);
    HD_P(ii)=DHA(f_indx);
end

HA=zeros(3,3,length(T));

HA(1,1,:)=min(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month<=2,:),[],1);
HA(1,2,:)=max(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month<=2,:),[],1);
HA(1,3,:)=median(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month<=2,:),1);
HA(1,4,:)=mean(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month<=2,:),1);

HA(2,1,:)=min(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>2 & Indx_Month<5,:),[],1);
HA(2,2,:)=max(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>2 & Indx_Month<5,:),[],1);
HA(2,3,:)=median(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>2 & Indx_Month<5,:),1);
HA(2,4,:)=mean(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>2 & Indx_Month<5,:),1);

HA(3,1,:)=min(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>=5,:),[],1);
HA(3,2,:)=max(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>=5,:),[],1);
HA(3,3,:)=median(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>=5,:),1);
HA(3,4,:)=mean(Filtered_Output_Unimodal.Hospital_Admission(Indx_Month>=5,:),1);


figure('units','normalized','outerposition',[0.02 0.02 1 1]);

XTL={'Oct.','Nov.','Dec.','Jan.','Feb.','Mar.','Apr.'};

subplot('Position',[0.065 0.6 0.4 0.36])
bar(1:length(XTL),Per_Month,'FaceColor',hex2rgb('#E94F08'),'LineStyle','none');
box off
set(gca,'LineWidth',2,'TickDir','out','XTickLabel',XTL,'Fontsize',16);
xlabel('Month of winter peak','Fontsize',18)
ylabel('Percentage of samples')
ytickformat('percentage')
ylim([0 45])
xlim([0.5 length(XTL)+0.5])
text(-0.14,1.05,'A','Units','normalized','FontSize',28)

subplot('Position',[0.55 0.6 0.4 0.36])
Y1=squeeze(HA(1,1,:))';
Y2=squeeze(HA(1,2,:))';
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(1,3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(1,4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);

plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:50000,'Yminortick','on');
title('Winter peak: October 1 to November 30')
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 50000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend('Range','Median','Mean','Observed data')
text(-0.14,1.05,'B','Units','normalized','FontSize',28)

subplot('Position',[0.065 0.11 0.4 0.36])
Y1=squeeze(HA(2,1,:))';
Y2=squeeze(HA(2,2,:))';
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(2,3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(2,4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);
plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:50000,'Yminortick','on');
title('Winter peak: December 1 to Janaury 31')
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 50000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend('Range','Median','Mean','Observed data')
text(-0.14,1.05,'C','Units','normalized','FontSize',28)

subplot('Position',[0.55 0.11 0.4 0.36])
Y1=squeeze(HA(3,1,:))';
Y2=squeeze(HA(3,2,:))';
patch([T flip(T)], [Y1 flip(Y2)],hex2rgb('#E94F08'),'FaceAlpha',0.3,'LineStyle','none'); hold on
YM=squeeze(HA(3,3,:));
plot(T,YM,'color',hex2rgb('#E94F08'),'LineWidth',2);
YM=squeeze(HA(3,4,:));
plot(T,YM,'-.','color',hex2rgb('#E94F08'),'LineWidth',2);
plot(T_Data,HD_P,'k','LineStyle','-.','LineWidth',1.5);
box off;
xlim([T(1) T(end)])
set(gca,'LineWidth',2,'TickDir','out','XTick',T(1:28:end),'Fontsize',16,'YTick',0:10000:50000,'Yminortick','on');
title('Winter peak: February 1 to April 30')
xlabel('Date','Fontsize',18)
ylabel('Hospital admissions','Fontsize',18)
ylim([0 50000])
xtickformat('MMM d' )
ax = gca; % axes handle
ax.YAxis.Exponent = 0;
legend('Range','Median','Mean','Observed data')
text(-0.14,1.05,'D','Units','normalized','FontSize',28)
print(gcf,['Supplement_Figure_5.png'],'-dpng','-r600');