function  Supplement_Figure_16
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
figure('units','normalized','outerposition',[0 0.01 0.8 1]);

Age_C={'All ages',['Ages: 0' char(8211) '1'],['Ages: 2' char(8211) '4'],['Ages: 5' char(8211) '12'],['Ages: 13' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+'};

Y_SD_Nat_Immunity=[Calibration.Average.SD_Natural_Immunity;
    Annual.Average.SD_Natural_Immunity;
    Two_Dose.Average.SD_Natural_Immunity];

Y_SD_Nat_Immunity_Age=[Calibration.Average.SD_Natural_Immunity_Age;
    Annual.Average.SD_Natural_Immunity_Age;
    Two_Dose.Average.SD_Natural_Immunity_Age];
Y_SD_Nat_Immunity_Age=Y_SD_Nat_Immunity_Age(:,1:7,:);

Y_SD_Vac_Immunity=[Calibration.Average.SD_Vaccine_Immunity;
    Annual.Average.SD_Vaccine_Immunity;
    Two_Dose.Average.SD_Vaccine_Immunity];

Y_SD_Vac_Immunity_Age=[Calibration.Average.SD_Vaccine_Immunity_Age;
    Annual.Average.SD_Vaccine_Immunity_Age;
    Two_Dose.Average.SD_Vaccine_Immunity_Age];
Y_SD_Vac_Immunity_Age=Y_SD_Vac_Immunity_Age(:,1:7,:);
dx=[0.075 0.32 0.565 0.815];
dy=[0.785 0.565];
for ii=1:8
    subplot('Position',[dx(ii-4.*floor((ii-1)/4)), dy(ceil(ii./4)),0.18 0.2]);
    if(ii==1)
        for jj=1:3
            plot(T,Y_SD_Vac_Immunity(jj,:),'color',C_Plot(jj,:),'LineWidth',2); hold on
            plot(T,Y_SD_Nat_Immunity(jj,:),'-.','color',C_Plot(jj,:),'LineWidth',2); hold on
        end
    else
        for jj=1:3
            plot(T,squeeze(Y_SD_Vac_Immunity_Age(jj,ii-1,:)),'color',C_Plot(jj,:),'LineWidth',2); hold on
            plot(T,squeeze(Y_SD_Nat_Immunity_Age(jj,ii-1,:)),'-.','color',C_Plot(jj,:),'LineWidth',2); hold on
        end    
    end
    xlim([T(1) T(53)])
    ylim([0 0.8])
    box off;
    set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTick',T([1:5:53]),'XTickLabel',[])
    ylabel({'Immunity to','severe disease'},'fontsize',16)
    text(0.05,0.95,Age_C{ii},'Fontsize',16,'units','normalized')
    text(-0.3,1,char(64+ii),"FontSize",24,'units','normalized')
%     xlabel('Date','fontsize',16)
end

Y_Inf_Nat_Immunity=[Calibration.Average.Inf_Natural_Immunity;
    Annual.Average.Inf_Natural_Immunity;
    Two_Dose.Average.Inf_Natural_Immunity];

Y_Inf_Nat_Immunity_Age=[Calibration.Average.Inf_Natural_Immunity_Age;
    Annual.Average.Inf_Natural_Immunity_Age;
    Two_Dose.Average.Inf_Natural_Immunity_Age];
Y_Inf_Nat_Immunity_Age=Y_Inf_Nat_Immunity_Age(:,1:7,:);

Y_Inf_Vac_Immunity=[Calibration.Average.Inf_Vaccine_Immunity;
    Annual.Average.Inf_Vaccine_Immunity;
    Two_Dose.Average.Inf_Vaccine_Immunity];

Y_Inf_Vac_Immunity_Age=[Calibration.Average.Inf_Vaccine_Immunity_Age;
    Annual.Average.Inf_Vaccine_Immunity_Age;
    Two_Dose.Average.Inf_Vaccine_Immunity_Age];
Y_Inf_Vac_Immunity_Age=Y_Inf_Vac_Immunity_Age(:,1:7,:);

dy=[0.345 0.125];
for ii=1:8
    subplot('Position',[dx(ii-4.*floor((ii-1)/4)), dy(ceil(ii./4)),0.18 0.2]);
    if(ii==1)
        for jj=1:3
            plot(T,Y_Inf_Vac_Immunity(jj,:),'color',C_Plot(jj,:),'LineWidth',2); hold on
            plot(T,Y_Inf_Nat_Immunity(jj,:),'-.','color',C_Plot(jj,:),'LineWidth',2); hold on
        end
    else
        for jj=1:3
            plot(T,squeeze(Y_Inf_Vac_Immunity_Age(jj,ii-1,:)),'color',C_Plot(jj,:),'LineWidth',2); hold on
            plot(T,squeeze(Y_Inf_Nat_Immunity_Age(jj,ii-1,:)),'-.','color',C_Plot(jj,:),'LineWidth',2); hold on
        end    
    end
    xlim([T(1) T(53)])
    ylim([0 0.6])
    if(ii<5)
        set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTick',T([1:5:53]),'XTickLabel',[],'YTick',[0:0.1:0.6])
    else
        set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTick',T([1:5:53]))
        xlabel('Date','fontsize',16)
        xtickformat('MMM d' ); ax=gca; ax.XTickLabel = ax.XTickLabel;
    end
    box off;
    ylabel({'Immunity to','infection'},'fontsize',16)
    text(0.05,0.95,Age_C{ii},'Fontsize',16,'units','normalized')
    text(-0.3,1,char(72+ii),"FontSize",24,'units','normalized')
end
legend({'Continual: Vaccine','Continual: Natural','SD-AVC: Vaccine','SD-AVC: Natural','FDA-AVC: Vaccine','FDA-AVC: Natural'},'NumColumns',6,'Position',[0.157933638715726,0.002406542734027,0.738157878737701,0.026715076489287],'Fontsize',16)
legend boxoff;
print(gcf,['Supplementary_Figure_16.png'],'-dpng','-r300');    
end

