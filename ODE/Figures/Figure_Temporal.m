function Figure_Temporal(State_V,Scenario)


T_Run=[datenum('September 1, 2022'):datenum('September 1, 2023')];

temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Model_Output_Summary_' Scenario '.mat']);

Scenario_Text=double(Scenario);
Scenario_Text(Scenario_Text==double('_'))=double(' ');
Scenario_Text=char(Scenario_Text);
if(strcmp(State_V,'Incidence'))    
    Y_Plot_PRCT=Output_Summary.PRCT.Incidence;
    Y_Plot_mean=Output_Summary.Average.Incidence;
    yL={'Daily incidence'};    
    CC=[hex2rgb('#DB9501')];
elseif(strcmp(State_V,'Hospital Admission'))
    Y_Plot_PRCT=Output_Summary.PRCT.Hospital_Admission;
    Y_Plot_mean=Output_Summary.Average.Hospital_Admission;
    yL={'Daily new admissions'};
    y_max=8.5*10^4;
    
    CC=[hex2rgb('#C05805')];
elseif(strcmp(State_V,'Hospital Burden'))
    Y_Plot_PRCT=Output_Summary.PRCT.Hospital_Burden;
    Y_Plot_mean=Output_Summary.Average.Hospital_Burden;
    yL={'Current hospitalizations'};
    
    CC=[hex2rgb('#C05805')];
elseif(strcmp(State_V,'Deaths'))
    Y_Plot_PRCT=Output_Summary.PRCT.Death;
    Y_Plot_mean=Output_Summary.Average.Death;
    yL={'Expected deaths from new infections'};
    
    CC=[hex2rgb('#2E2300')];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Incidence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.2 0.6 0.6]);

subplot('Position',[0.065,0.2775,0.9,0.665]);
T_Plot=T_Run(1:end-1);
patch([T_Plot flip(T_Plot)],[Y_Plot_PRCT(PRCT==2.5,:) flip(Y_Plot_PRCT(PRCT==97.5,:))],CC,'LineStyle','none','FaceAlpha',0.2);
hold on;
patch([T_Plot flip(T_Plot)],[Y_Plot_PRCT(PRCT==25,:) flip(Y_Plot_PRCT(PRCT==75,:))],CC,'LineStyle','none','FaceAlpha',0.2);
plot(T_Plot,Y_Plot_PRCT(PRCT==50,:),'-','color',CC,'LineWidth',2);
plot(T_Plot,Y_Plot_mean,'-.','color',CC,'LineWidth',2); 
box off;
grid on;
xlim([T_Run(1) T_Run(end-1)]);
set(gca,'LineWidth',2,'tickdir','out','Xminortick','on','XTick',T_Run(1:28:end),'XTickLabel',datestr(T_Run(1:28:end)),'Fontsize',14)
xtickangle(90);
xlabel('Date','Fontsize',16);
ylabel(yL,'Fontsize',16);
title(Scenario_Text)
end
