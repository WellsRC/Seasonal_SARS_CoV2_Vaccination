function Figure_2
close all;

CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];


temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


lb_Age=[0 5 13 18 50 65];
ub_Age=[5 13 18 50 65 85];

AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};

l_yb=[-0.2 0.8; -0.01 0.04; -0.001 0.003; -200 1000];
m_yb=[-0.15 0.6; -0.002 0.006; -0.0001 0.0002; -40 160];
l_dy=[0.2 0.01 0.001 200];
m_dy=[0.15 0.002 0.0001 40];
figure('units','normalized','outerposition',[0.1 0.06 0.675 1]);
for State_Indx=1:4    
    CC=CCv(State_Indx,:);
    Outcome_Matrix=zeros(length(lb_Age));
    Outcome_All=zeros(length(lb_Age),5);
    Outcome_Indirect=zeros(length(lb_Age),5);
    for aa=1:6
       load([temp_cd 'Comparison_Summary_All_Annual_Campaign_Influenza_Like_Coverage_Indirect_10000_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '.mat'],'Comparison','PRCT');
       if State_Indx==1
           Outcome_All(aa,2)=-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==2.5)./10000;
           Outcome_All(aa,3)=-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==97.5)./10000;

           Outcome_All(aa,4)=-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==25)./10000;
           Outcome_All(aa,5)=-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==75)./10000;

           Outcome_All(aa,1)=-Comparison.Average.Cumulative_Count_Incidence_dt./10000;
           
           Outcome_Indirect(aa,2)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==2.5,aa)./10000;
           Outcome_Indirect(aa,3)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==97.5,aa)./10000;

           Outcome_Indirect(aa,4)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==25,aa)./10000;
           Outcome_Indirect(aa,5)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==75,aa)./10000;

           Outcome_Indirect(aa,1)=-Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt(aa)./10000;
           
           Outcome_Matrix(:,aa)=-Comparison.Average.Age_Cumulative_Count_Incidence_dt(1:end-1)./10000;
       elseif State_Indx==2
           Outcome_All(aa,2)=-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5)./10000;
           Outcome_All(aa,3)=-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5)./10000;

           Outcome_All(aa,4)=-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==25)./10000;
           Outcome_All(aa,5)=-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==75)./10000;

           Outcome_All(aa,1)=-Comparison.Average.Cumulative_Count_Hospital_dt./10000;
           
           Outcome_Indirect(aa,2)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==2.5,aa)./10000;
           Outcome_Indirect(aa,3)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==97.5,aa)./10000;

           Outcome_Indirect(aa,4)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==25,aa)./10000;
           Outcome_Indirect(aa,5)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==75,aa)./10000;

           Outcome_Indirect(aa,1)=-Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt(aa)./10000;
           
           Outcome_Matrix(:,aa)=-Comparison.Average.Age_Cumulative_Count_Hospital_dt(1:end-1)./10000;
       elseif State_Indx==3
           Outcome_All(aa,2)=-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5)./10000;
           Outcome_All(aa,3)=-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5)./10000;

           Outcome_All(aa,4)=-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==25)./10000;
           Outcome_All(aa,5)=-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==75)./10000;

           Outcome_All(aa,1)=-Comparison.Average.Cumulative_Count_Death_dt./10000;
           
           Outcome_Indirect(aa,2)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==2.5,aa)./10000;
           Outcome_Indirect(aa,3)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==97.5,aa)./10000;

           Outcome_Indirect(aa,4)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==25,aa)./10000;
           Outcome_Indirect(aa,5)=-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==75,aa)./10000;

           Outcome_Indirect(aa,1)=-Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt(aa)./10000;
           Outcome_Matrix(:,aa)=-Comparison.Average.Age_Cumulative_Count_Death_dt(1:end-1)./10000;
       elseif State_Indx==4
           Outcome_All(aa,2)=-Comparison.PRCT.Cost_Total_dt(PRCT==2.5)./10000;
           Outcome_All(aa,3)=-Comparison.PRCT.Cost_Total_dt(PRCT==97.5)./10000;

           Outcome_All(aa,4)=-Comparison.PRCT.Cost_Total_dt(PRCT==25)./10000;
           Outcome_All(aa,5)=-Comparison.PRCT.Cost_Total_dt(PRCT==75)./10000;

           Outcome_All(aa,1)=-Comparison.Average.Cost_Total_dt./10000;
           
           Outcome_Indirect(aa,2)=-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==2.5,aa)./10000;
           Outcome_Indirect(aa,3)=-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==97.5,aa)./10000;

           Outcome_Indirect(aa,4)=-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==25,aa)./10000;
           Outcome_Indirect(aa,5)=-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==75,aa)./10000;

           Outcome_Indirect(aa,1)=-Comparison.Average.Cost_Compliment_Age_dt(aa)./10000;
           
           Outcome_Matrix(:,aa)=-Comparison.Average.Cost_Age_dt(1:end-1)./10000;
        end
    end
    hh=subplot('Position',[0.5,0.805-0.24.*(State_Indx-1),0.23,0.175]);

    N_O=Outcome_Matrix;
    for aa=1:6
        N_O(aa,aa)=-Inf;
    end
    N_O=(N_O-min(N_O(N_O>-Inf)))./(max(N_O(:))-min(N_O(N_O>-Inf)));
    for aa=1:6
        for vv=1:6
            if(aa~=vv)
                patch(vv+[-0.5 -0.5 0.5 0.5],aa+[-0.5 0.5 0.5 -0.5],interp1([0 1],[1 1 1; CC],N_O(aa,vv)),'LineStyle','none'); hold on
            else
                patch(vv+[-0.5 -0.5 0.5 0.5],aa+[-0.5 0.5 0.5 -0.5],[0.45 0.45 0.45],'LineStyle','none'); hold on
            end
        end
    end
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:6],'YTick',[1:6],'XTickLabel',AgeC,'YTickLabel',AgeC,'Fontsize',12)
    xlim([0.49 6.5]);
    ylim([0.49 6.5]);
    box off;
    xtickangle(90);
    
    if(State_Indx==4)
        xlabel('Age class receiving additional doses','Fontsize',14);
    end
    ylabel({'Age class','receiving benefit'},'Fontsize',14);
    
    text(-0.325,1.04,char(64+3.*(State_Indx)),'Fontsize',22,'FontWeight','bold','Units','normalized');

    subplot('Position',[0.94,0.805-0.24.*(State_Indx-1),0.01,0.175]);
    for ii=1:101
        patch([-0.5 -0.5 0.5 0.5],ii+[-0.5 0.5 0.5 -0.5],interp1([0 1],[1 1 1; CC],(ii-1)./100),'LineStyle','none'); hold on
    end
    box on;
    % axis off;
    set(gca,'LineWidth',2,'XTick',[],'YTick',[]);
    xlim([-0.5 0.5]);
    ylim([0.5 100.5]);

    text(3,50,'Relative benefit','Rotation',270,'horizontalAlignment','center','Fontsize',14);
    text(3,0.5,'Low','horizontalAlignment','center','Fontsize',14);
    text(3,100,'High','horizontalAlignment','center','Fontsize',14);

    hh.Position=[0.705,0.805-0.24.*(State_Indx-1),0.23,0.175];
    
    subplot('Position',[0.08,0.805-0.24.*(State_Indx-1),0.22,0.175]);

    for aa=1:6
       patch(aa+[-0.45 -0.45 0.45 0.45],[Outcome_All(aa,2:3) flip(Outcome_All(aa,2:3))],CC,'LineStyle','none','FaceAlpha',0.25); hold on
       patch(aa+[-0.45 -0.45 0.45 0.45],[Outcome_All(aa,4:5) flip(Outcome_All(aa,4:5))],CC,'LineStyle','none','FaceAlpha',0.5); hold on
       plot(aa+[-0.45 0.45],Outcome_All(aa,[1 1]),'color',CC,'LineWidth',3);
    end
    grid on;
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:6],'XTickLabel',AgeC,'Fontsize',12,'YTick',[l_yb(State_Indx,1):l_dy(State_Indx):l_yb(State_Indx,2)])
    xlim([0.49 6.5]);
    
    ylim([l_yb(State_Indx,1) l_yb(State_Indx,2)]);
    box off;
    xtickangle(90);
    ax=gca;
    ax.YAxis.Exponent = 0;
    if(State_Indx==4)
        xlabel('Age class receiving additional doses','Fontsize',14);
    end
    
    ylabel([{Outcome{State_Indx} ,'averted per vaccine'}],'Fontsize',14);
    text(-0.34,1.04,char(62+3.*(State_Indx)),'Fontsize',22,'FontWeight','bold','Units','normalized');
    
    subplot('Position',[0.4,0.805-0.24.*(State_Indx-1),0.22,0.175]);

    for aa=1:6
       patch(aa+[-0.45 -0.45 0.45 0.45],[Outcome_Indirect(aa,2:3) flip(Outcome_Indirect(aa,2:3))],CC,'LineStyle','none','FaceAlpha',0.25); hold on
       patch(aa+[-0.45 -0.45 0.45 0.45],[Outcome_Indirect(aa,4:5) flip(Outcome_Indirect(aa,4:5))],CC,'LineStyle','none','FaceAlpha',0.5); hold on
       plot(aa+[-0.45 0.45],Outcome_Indirect(aa,[1 1]),'color',CC,'LineWidth',3);
    end
    grid on;
    set(gca,'LineWidth',2,'tickdir','out','XTick',[1:6],'XTickLabel',AgeC,'Fontsize',12,'YTick',[m_yb(State_Indx,1):m_dy(State_Indx):m_yb(State_Indx,2)])
    xlim([0.49 6.5]);
    
    ylim([m_yb(State_Indx,1) m_yb(State_Indx,2)]);
    box off;
    xtickangle(90);
    ax=gca;
    ax.YAxis.Exponent = 0;
    if(State_Indx==4)
        xlabel('Age class receiving additional doses','Fontsize',14);
    end
    
    ylabel([{['Indirect ' lower(Outcome{State_Indx})] ,'averted per vaccine'}],'Fontsize',14);
    text(-0.42,1.04,char(63+3.*(State_Indx)),'Fontsize',22,'FontWeight','bold','Units','normalized');
end
print(gcf,['Figure_2.png'],'-dpng','-r300');
end

