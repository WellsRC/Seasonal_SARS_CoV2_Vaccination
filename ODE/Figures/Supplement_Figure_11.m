function  Supplement_Figure_11
close all;
Y_Err.LineWidth=2;
Y_Err.Cap_Size=40;
XTL={'Continual','Annual','Two Dose'};
temp_cd=pwd;
load([temp_cd(1:end-11) 'Contact_Matrix\Contact_USA_85.mat'],'N');
Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
Pop=zeros(size(ACg,1),1);
for ii=1:length(Pop)
    Pop(ii)=sum(N(Av>=ACg(ii,1) & Av<=ACg(ii,2)));
end
Tot_Pop=sum(N);

T= datetime(2023,9,1) + caldays(0:7:364);

temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Model_Output_Summary_Main_Text_Annual.mat'])
Annual=Output_Summary;
load([temp_cd 'Model_Output_Summary_Main_Text_Two_Dose_under_2_and_50_and_older_150_days.mat'])
Two_Dose=Output_Summary;
load([temp_cd 'Model_Output_Summary_Calibration.mat'])
Calibration=Output_Summary;

C_Plot=[hex2rgb('#2f4f4f');
    hex2rgb('#FFC20A');
        hex2rgb('#0C7BDC')];
figure('units','normalized','outerposition',[0 0.08 0.8 1]);

Age_C={'All ages',['Ages: 0' char(8211) '1'],['Ages: 2' char(8211) '4'],['Ages: 5' char(8211) '12'],['Ages: 13' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+'};

Y_S=[Calibration.Average.Susceptible;
    Annual.Average.Susceptible;
    Two_Dose.Average.Susceptible];

Y_S_Age=[Calibration.Average.Susceptible_Age;
    Annual.Average.Susceptible_Age;
    Two_Dose.Average.Susceptible_Age];
Y_S_Age=Y_S_Age(:,1:7,:);
dx=[0.075 0.32 0.565 0.815];
dy=[0.775 0.555];
for ii=1:8
    subplot('Position',[dx(ii-4.*floor((ii-1)/4)), dy(ceil(ii./4)),0.18 0.2]);
    if(ii==1)
        for jj=1:3
            plot(T,Y_S(jj,:),'color',C_Plot(jj,:),'LineWidth',2); hold on
        end
    else
        for jj=1:3
            plot(T,squeeze(Y_S_Age(jj,ii-1,:)),'color',C_Plot(jj,:),'LineWidth',2); hold on
        end    
    end
    xlim([T(1) T(53)])
    ylim([0.2 0.5])
    box off;
    set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTickLabel',[],'YTick',[0.2:0.05:0.5])
    ylabel({'Susceptbile'},'fontsize',16)
    text(0.05,0.95,Age_C{ii},'Fontsize',16,'units','normalized')
    text(-0.3,1.05,char(64+ii),"FontSize",24,'units','normalized')
%     xlabel('Date','fontsize',16)
if(ii==1)
        legend({'Continual','SD-AVC','FDA-AVC'},'Fontsize',12)
end
end

Y_Hosp=[Calibration.Average.Hospital_Admission;
    Annual.Average.Hospital_Admission;
    Two_Dose.Average.Hospital_Admission];

Y_Hosp_Age=[Calibration.Average.Age_Hospital;
    Annual.Average.Age_Hospital;
    Two_Dose.Average.Age_Hospital];
Y_Hosp_Age=Y_Hosp_Age(:,1:7,:);
T= datetime(2023,9,1) + caldays(0:364);
dy=[0.335 0.115];
for ii=1:8
    subplot('Position',[dx(ii-4.*floor((ii-1)/4)), dy(ceil(ii./4)),0.18 0.2]);
    if(ii==1)
        for jj=1:3
            plot(T,Y_Hosp(jj,:),'color',C_Plot(jj,:),'LineWidth',2); hold on
        end

        xlim([T(1) T(end)])
    else
        b=bar([1:9],squeeze(Y_Hosp_Age(:,ii-1,:))./10^4,'LineStyle','none','FaceColor','flat'); hold on
        
        for jj=1:length(b)
            b(jj).CData = C_Plot(jj,:);
        end
    end
    if(ii<5)
        set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTickLabel',[])

    else
        set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTickLabel',datestr(datenum('September 1, 2022')+[90:30:300 364],'mmm-dd'))
        xlabel('Date','fontsize',16)
%         xtickformat('MMM d' ); ax=gca; ax.XTickLabel = ax.XTickLabel;
    end
    if(ii==1)
        ylabel({'Hospital admissions'},'fontsize',16)
    else
        ylabel({'Total Hospitalizations','(10,000)'},'fontsize',14)
        
        
    end
%         legend({'Continual','SD-AVC','FDA-AVC'},'Fontsize',12)
    box off;
    text(0.05,0.95,Age_C{ii},'Fontsize',16,'units','normalized')
    text(-0.3,1.05,char(72+ii),"FontSize",24,'units','normalized')
end

end

