function Supplement_Figure_8
close all;

CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];


temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


lb_Age=[0 5 13 18 50 65];
ub_Age=[5 13 18 50 65 85];

AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};

l_yb=[0 0.16; 0 0.02; 0 0.002; 0 500];
m_yb=[0 0.07; 0 0.0012; 0 0.00005; 0 35];
l_dy=[0.02 0.005 0.0005 100];
m_dy=[0.01 0.0003 0.00001 5];
figure('units','normalized','outerposition',[0.1 0.06 0.675 1]);
Direct_I=cell(6,1);
Direct_H=cell(6,1);
Direct_D=cell(6,1);
Direct_C=cell(6,1);

Indirect_I=cell(6,1);
Indirect_H=cell(6,1);
Indirect_D=cell(6,1);
Indirect_C=cell(6,1);
for State_Indx=1:4    
    CC=CCv(State_Indx,:);
    Outcome_Matrix=zeros(length(lb_Age));
    Outcome_All=zeros(length(lb_Age),1);
    Outcome_Indirect=zeros(length(lb_Age),1);
    for aa=1:6
       load([temp_cd 'Comparison_Summary_Large_Winter_Annual_Campaign_Baseline_Coverage_Indirect_10000_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '.mat'],'Comparison','PRCT');
       Comparison.Average.Age_Cumulative_Count_Incidence_dt=reshape(Comparison.Average.Age_Cumulative_Count_Incidence_dt,7,9);
       Comparison.Average.Age_Cumulative_Count_Hospital_dt=reshape(Comparison.Average.Age_Cumulative_Count_Hospital_dt,7,9);
       Comparison.Average.Age_Cumulative_Count_Death_dt=reshape(Comparison.Average.Age_Cumulative_Count_Death_dt,7,9);
       Comparison.Average.Cost_Age_dt=reshape(Comparison.Average.Cost_Age_dt,7,9);

       Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt=reshape(Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt,6,9);
       Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt=reshape(Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt,6,9);
       Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt=reshape(Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt,6,9);
       Comparison.Average.Cost_Compliment_Age_dt=reshape(Comparison.Average.Cost_Compliment_Age_dt,6,9);

       if State_Indx==1
           Outcome_All(aa)=-Comparison.Average.Cumulative_Count_Incidence_dt./10000;

           Outcome_Indirect(aa)=-Comparison.Average.Compliment_Age_Cumulative_Count_Incidence_dt(aa,end)./10000;
           
           Outcome_Matrix(:,aa)=-Comparison.Average.Age_Cumulative_Count_Incidence_dt(1:end-1,end)./10000;

           Direct_I{aa}=[num2str(-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==50)./10000,'%3.2f') '(95% PI:' num2str(-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==97.5)./10000,'%3.2f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Incidence_dt(PRCT==2.5)./10000,'%3.2f') ')'];
           Indirect_I{aa}=[num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==50,aa,end)./10000,'%4.3f') '(95% PI:' num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==97.5,aa,end)./10000,'%4.3f') char(8211) num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Incidence_dt(PRCT==2.5,aa,end)./10000,'%4.3f') ')'];
       elseif State_Indx==2
           Outcome_All(aa)=-Comparison.Average.Cumulative_Count_Hospital_dt./10000;

           Outcome_Indirect(aa)=-Comparison.Average.Compliment_Age_Cumulative_Count_Hospital_dt(aa,end)./10000;
           
           Outcome_Matrix(:,aa)=-Comparison.Average.Age_Cumulative_Count_Hospital_dt(1:end-1,end)./10000;

           Direct_H{aa}=[num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==50)./10000,'%4.3f') '(95% PI:' num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==97.5)./10000,'%4.3f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Hospital_dt(PRCT==2.5)./10000,'%4.3f') ')'];
           Indirect_H{aa}=[num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==50,aa,end)./10000,'%5.4f') '(95% PI:' num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==97.5,aa,end)./10000,'%5.4f') char(8211) num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Hospital_dt(PRCT==2.5,aa,end)./10000,'%5.4f') ')'];

       elseif State_Indx==3
           Outcome_All(aa)=-Comparison.Average.Cumulative_Count_Death_dt./10000;
           
           Outcome_Indirect(aa)=-Comparison.Average.Compliment_Age_Cumulative_Count_Death_dt(aa,end)./10000;
           Outcome_Matrix(:,aa)=-Comparison.Average.Age_Cumulative_Count_Death_dt(1:end-1,end)./10000;


           Direct_D{aa}=[num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==50)./10000,'%5.4f') '(95% PI:' num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==97.5)./10000,'%5.4f') char(8211) num2str(-Comparison.PRCT.Cumulative_Count_Death_dt(PRCT==2.5)./10000,'%5.4f') ')'];
           Indirect_D{aa}=[num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==50,aa,end)./10000,'%6.5f') '(95% PI:' num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==97.5,aa,end)./10000,'%6.5f') char(8211) num2str(-Comparison.PRCT.Compliment_Age_Cumulative_Count_Death_dt(PRCT==2.5,aa,end)./10000,'%6.5f') ')'];

       elseif State_Indx==4

           Outcome_All(aa)=-Comparison.Average.Cost_Total_dt(end)./10000;

           Outcome_Indirect(aa)=-Comparison.Average.Cost_Compliment_Age_dt(aa,end)./10000;
           
           Outcome_Matrix(:,aa)=-Comparison.Average.Cost_Age_dt(1:end-1,end)./10000;

           Direct_C{aa}=[num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==50,end)./10000,'%4.1f') '(95% PI:' num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==97.5,end)./10000,'%4.1f') char(8211) num2str(-Comparison.PRCT.Cost_Total_dt(PRCT==2.5,end)./10000,'%4.1f') ')'];
           Indirect_C{aa}=[num2str(-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==50,aa,end)./10000,'%4.1f') '(95% PI:' num2str(-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==97.5,aa,end)./10000,'%4.1f') char(8211) num2str(-Comparison.PRCT.Cost_Compliment_Age_dt(PRCT==2.5,aa,end)./10000,'%4.1f') ')'];

        end
    end
    hh=subplot('Position',[0.51,0.805-0.24.*(State_Indx-1),0.23,0.175]);

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

    subplot('Position',[0.9475,0.805-0.24.*(State_Indx-1),0.01,0.175]);
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

    hh.Position=[0.715,0.805-0.24.*(State_Indx-1),0.23,0.175];
    
    subplot('Position',[0.09,0.805-0.24.*(State_Indx-1),0.22,0.175]);
    bar([1:6],Outcome_All,'LineStyle','none','FaceColor',CC);
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
    text(-0.405,1.04,char(62+3.*(State_Indx)),'Fontsize',22,'FontWeight','bold','Units','normalized');
    
    subplot('Position',[0.41,0.805-0.24.*(State_Indx-1),0.22,0.175]);
    
    bar([1:6],Outcome_Indirect,'LineStyle','none','FaceColor',CC);
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
    text(-0.44,1.04,char(63+3.*(State_Indx)),'Fontsize',22,'FontWeight','bold','Units','normalized');
end
print(gcf,['Supplement_Figure_8.png'],'-dpng','-r300');
end

