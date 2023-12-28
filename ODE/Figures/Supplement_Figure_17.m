function  Supplement_Figure_17
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
figure('units','normalized','outerposition',[0 0.08 0.8 0.6]);

Age_C={'All ages',['Ages: 0' char(8211) '1'],['Ages: 2' char(8211) '4'],['Ages: 5' char(8211) '12'],['Ages: 13' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+'};

Y_S=[Calibration.Average.Susceptible;
    Annual.Average.Susceptible;
    Two_Dose.Average.Susceptible];

Y_S_Age=[Calibration.Average.Susceptible_Age;
    Annual.Average.Susceptible_Age;
    Two_Dose.Average.Susceptible_Age];
Y_S_Age=Y_S_Age(:,1:7,:);
dx=[0.075 0.32 0.565 0.815];
dy=[0.595 0.17];
for ii=1:8
    subplot('Position',[dx(ii-4.*floor((ii-1)/4)), dy(ceil(ii./4)),0.18 0.39]);
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
    ylim([0.1 0.7])
    box off;
    if(ii<5)
        set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTick',T([1:5:53]),'XTickLabel',[],'YTick',[0.15:0.1:0.65])
    else
        set(gca,'LineWidth',2,'tickdir','out','FontSize',14,'XTick',T([1:5:53]),'YTick',[0.15:0.1:0.65])
        xlabel('Date','fontsize',16)
        xtickformat('MMM d' ); ax=gca; ax.XTickLabel = ax.XTickLabel;
    end
    ylabel({'Susceptbile'},'fontsize',16)
    text(0.05,0.95,Age_C{ii},'Fontsize',16,'units','normalized')
    text(-0.3,0.975,char(64+ii),"FontSize",24,'units','normalized')
%     xlabel('Date','fontsize',16)
if(ii==1)
        legend({'Continual','SD-AVC','FDA-AVC'},'Fontsize',12)
        legend boxoff
end
end
print(gcf,['Supplementary_Figure_17.png'],'-dpng','-r300');    

end

