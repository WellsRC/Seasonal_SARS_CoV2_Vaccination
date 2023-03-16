function Figure_Temporal(State_V,Scenario)

temp_cd=pwd;
temp_cd=temp_cd(1:end-11);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load population and contact matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pop_S=load([temp_cd 'Contact_Matrix/Contact_USA_85.mat'],'N');
Pop_S=sum(Pop_S.N);

T_Run=[datenum('September 1, 2022'):datenum('September 1, 2023')];

temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Model_Output_Summary_' Scenario '.mat']);

Scenario_Text=double(Scenario);
Scenario_Text(Scenario_Text==double('_'))=double(' ');
Scenario_Text=char(Scenario_Text);
if(strcmp(State_V,'Incidence')) 
    PerC=10^3;
    Y_Plot_PRCT=PerC.*Output_Summary.PRCT.Incidence./Pop_S;
    Y_Plot_mean=PerC.*Output_Summary.Average.Incidence./Pop_S;
    yL={['Daily incidence per ' num2str(PerC)]};    
    CC=[hex2rgb('#EDAE01')];
elseif(strcmp(State_V,'Hospital Admission'))
    PerC=10^4;
    Y_Plot_PRCT=PerC.*Output_Summary.PRCT.Hospital_Admission./Pop_S;
    Y_Plot_mean=PerC.*Output_Summary.Average.Hospital_Admission./Pop_S;
    yL={['Daily new admissions  per ' num2str(PerC)]};
    y_max=PerC.*8.5*10^4./Pop_S;
    
    CC=[hex2rgb('#E94F08')];
elseif(strcmp(State_V,'Hospital Burden'))
    PerC=10^4;
    Y_Plot_PRCT=PerC.*Output_Summary.PRCT.Hospital_Burden./Pop_S;
    Y_Plot_mean=PerC.*Output_Summary.Average.Hospital_Burden./Pop_S;
    yL={['Current hospitalizations per ' num2str(PerC)]};
    
    CC=[hex2rgb('#E94F08')];
elseif(strcmp(State_V,'Deaths'))
    PerC=10^6;
    Y_Plot_PRCT=PerC.*Output_Summary.PRCT.Death./Pop_S;
    Y_Plot_mean=PerC.*Output_Summary.Average.Death./Pop_S;
    yL={'Expected deaths from',['new infections per ' num2str(PerC)]};
    
    CC=[hex2rgb('#7F152E')];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daily Incidence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('units','normalized','outerposition',[0.05 0.2 0.6 0.6]);

subplot('Position',[0.087,0.2775,0.9,0.665]);
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
