function Supplement_Figure_7
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_Unimodal_Winter_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat']);
Comparison_Single=Comparison;

load([temp_cd 'Comparison_Summary_Unimodal_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older-Baseline_Continual_Vaccination.mat']);

xltxt={'incidence','hospitalizations','deaths','cost'};
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+','All'};
for Scenario_Indx=1:4
    
    subplot('Position',[0.105+0.5.*(rem(Scenario_Indx-1,2)),0.625-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.3525]);
    xt=linspace(-1,1,5001);
    Y=zeros(7,2);
    CC=CCv(Scenario_Indx,:);
    
    % Single-dose
    for ss=1:6
        if(Scenario_Indx==1)
            Comparison_Single.PRCT.Age_Cumulative_Count_Incidence_rel=reshape(Comparison_Single.PRCT.Age_Cumulative_Count_Incidence_rel,length(PRCT),7,9);
            Comparison_Single.Average.Age_Cumulative_Count_Incidence_rel=reshape(Comparison_Single.Average.Age_Cumulative_Count_Incidence_rel,7,9);
            Out_P=[Comparison_Single.Average.Age_Cumulative_Count_Incidence_rel(ss,end);Comparison_Single.PRCT.Age_Cumulative_Count_Incidence_rel(ismember(PRCT,[2.5 97.5]),ss,end)];

        elseif(Scenario_Indx==2)                
            Comparison_Single.PRCT.Age_Cumulative_Count_Hospital_rel=reshape(Comparison_Single.PRCT.Age_Cumulative_Count_Hospital_rel,length(PRCT),7,9);
            Comparison_Single.Average.Age_Cumulative_Count_Hospital_rel=reshape(Comparison_Single.Average.Age_Cumulative_Count_Hospital_rel,7,9);
            Out_P=[Comparison_Single.Average.Age_Cumulative_Count_Hospital_rel(ss,end);Comparison_Single.PRCT.Age_Cumulative_Count_Hospital_rel(ismember(PRCT,[2.5 97.5]),ss,end)];
        elseif(Scenario_Indx==3)    
            Comparison_Single.PRCT.Age_Cumulative_Count_Death_rel=reshape(Comparison_Single.PRCT.Age_Cumulative_Count_Death_rel,length(PRCT),7,9);
            Comparison_Single.Average.Age_Cumulative_Count_Death_rel=reshape(Comparison_Single.Average.Age_Cumulative_Count_Death_rel,7,9);
            Out_P=[Comparison_Single.Average.Age_Cumulative_Count_Death_rel(ss,end);Comparison_Single.PRCT.Age_Cumulative_Count_Death_rel(ismember(PRCT,[2.5 97.5]),ss,end)];
        elseif(Scenario_Indx==4)    
            Comparison_Single.PRCT.Cost_Age_rel=reshape(Comparison_Single.PRCT.Cost_Age_rel,length(PRCT),7,9);
            Comparison_Single.Average.Cost_Age_rel=reshape(Comparison_Single.Average.Cost_Age_rel,7,9);
            Out_P=[Comparison_Single.Average.Cost_Age_rel(ss,end);Comparison_Single.PRCT.Cost_Age_rel(ismember(PRCT,[2.5 97.5]),ss,end)];
        end
        Y(ss,1)=Out_P(1);
    end
    ss=7;
    if(Scenario_Indx==1)
        Out_P=[Comparison_Single.Average.Cumulative_Count_Incidence_rel Comparison_Single.PRCT.Cumulative_Count_Incidence_rel(ismember(PRCT,[2.5 97.5]))];

    elseif(Scenario_Indx==2)                
        Out_P=[Comparison_Single.Average.Cumulative_Count_Hospital_rel Comparison_Single.PRCT.Cumulative_Count_Hospital_rel(ismember(PRCT,[2.5 97.5]))];
    elseif(Scenario_Indx==3)    
        Out_P=[Comparison_Single.Average.Cumulative_Count_Death_rel Comparison_Single.PRCT.Cumulative_Count_Death_rel(ismember(PRCT,[2.5 97.5]))];
    elseif(Scenario_Indx==4)    
        Out_P=[Comparison_Single.Average.Cost_Total_rel(end);Comparison_Single.PRCT.Cost_Total_rel(ismember(PRCT,[2.5 97.5]),end)];
    end
    Y(ss,1)=Out_P(1);
    % Two-dose for 50+
    for ss=1:6        
        if(Scenario_Indx==1)
            Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=reshape(Comparison.PRCT.Age_Cumulative_Count_Incidence_rel,length(PRCT),7,9);
            Comparison.Average.Age_Cumulative_Count_Incidence_rel=reshape(Comparison.Average.Age_Cumulative_Count_Incidence_rel,7,9);
            Out_P=[Comparison.Average.Age_Cumulative_Count_Incidence_rel(ss,end);Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(ismember(PRCT,[2.5 97.5]),ss,end)];

        elseif(Scenario_Indx==2)                
            Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=reshape(Comparison.PRCT.Age_Cumulative_Count_Hospital_rel,length(PRCT),7,9);
            Comparison.Average.Age_Cumulative_Count_Hospital_rel=reshape(Comparison.Average.Age_Cumulative_Count_Hospital_rel,7,9);
            Out_P=[Comparison.Average.Age_Cumulative_Count_Hospital_rel(ss,end);Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(ismember(PRCT,[2.5 97.5]),ss,end)];
        elseif(Scenario_Indx==3)    
            Comparison.PRCT.Age_Cumulative_Count_Death_rel=reshape(Comparison.PRCT.Age_Cumulative_Count_Death_rel,length(PRCT),7,9);
            Comparison.Average.Age_Cumulative_Count_Death_rel=reshape(Comparison.Average.Age_Cumulative_Count_Death_rel,7,9);
            Out_P=[Comparison.Average.Age_Cumulative_Count_Death_rel(ss,end);Comparison.PRCT.Age_Cumulative_Count_Death_rel(ismember(PRCT,[2.5 97.5]),ss,end)];
        elseif(Scenario_Indx==4)    
            Comparison.PRCT.Cost_Age_rel=reshape(Comparison.PRCT.Cost_Age_rel,length(PRCT),7,9);
            Comparison.Average.Cost_Age_rel=reshape(Comparison.Average.Cost_Age_rel,7,9);
            Out_P=[Comparison.Average.Cost_Age_rel(ss,end);Comparison.PRCT.Cost_Age_rel(ismember(PRCT,[2.5 97.5]),ss,end)];
        end
        Y(ss,2)=Out_P(1);
    end
    ss=7;
    if(Scenario_Indx==1)
        Out_P=[Comparison.Average.Cumulative_Count_Incidence_rel Comparison.PRCT.Cumulative_Count_Incidence_rel(ismember(PRCT,[2.5 97.5]))];

    elseif(Scenario_Indx==2)                
        Out_P=[Comparison.Average.Cumulative_Count_Hospital_rel Comparison.PRCT.Cumulative_Count_Hospital_rel(ismember(PRCT,[2.5 97.5]))];
    elseif(Scenario_Indx==3)    
        Out_P=[Comparison.Average.Cumulative_Count_Death_rel Comparison.PRCT.Cumulative_Count_Death_rel(ismember(PRCT,[2.5 97.5]))];
    elseif(Scenario_Indx==4)    
        Out_P=[Comparison.Average.Cost_Total_rel(end);Comparison.PRCT.Cost_Total_rel(ismember(PRCT,[2.5 97.5]),end)];
    end
    Y(ss,2)=Out_P(1);

    Y=100.*Y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot([0 0],[0.5 7.75],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    plot([-100 100],[6.625 6.625],'-.','color',[0.7 0.7 0.7],'LineWidth',1.25); hold on;
    bh=barh([1:6 7.25],Y,'LineStyle','none');
    bh(2).FaceColor=CC;
    bh(1).FaceColor=interp1([0 1],[1 1 1;CC],0.5);
%     for ii=1:6
%         scatter(Y(ii,1,1),ii+0.2,40,CC,'filled'); hold on
%         plot([Y(ii,2,1) Y(ii,3,1)],[ii+0.2 ii+0.2],'color',CC,'LineWidth',2);
%         scatter(Y(ii,1,2),ii-0.2,40,interp1([0 1],[1 1 1;CC],0.5),'filled'); hold on 
%         plot([Y(ii,2,2) Y(ii,3,2)],[ii-0.2 ii-0.2],'color',interp1([0 1],[1 1 1;CC],0.5),'LineWidth',2);
%     end
%     ii=7;
% 
%         scatter(Y(ii,1,1),ii+0.25+0.2,40,CC,'filled'); hold on
%         plot([Y(ii,2,1) Y(ii,3,1)],[ii+0.2 ii+0.2]+0.25,'color',CC,'LineWidth',2);
%         scatter(Y(ii,1,2),ii+0.25-0.2,40,interp1([0 1],[1 1 1;CC],0.5),'filled'); hold on
%         plot([Y(ii,2,2) Y(ii,3,2)],[ii-0.2 ii-0.2]+0.25,'color',interp1([0 1],[1 1 1;CC],0.5),'LineWidth',2);

    ylim([0.4 7.8]);
    xlim(100.*[-0.4 0.1]);
    xtickformat('percentage');
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:6 7.25],'YTickLabel',AgeC,'Yminortick','off','XTick',[-40:10:10],'Xminortick','on','Fontsize',16);
    xlabel(['Relative change in ' xltxt{Scenario_Indx}],'Fontsize',18);
    ylabel('Age class','Fontsize',18);
    xtickangle(0);
    box off;
    text(-0.278,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');

    text(0.025,0.975,'Two-dose (50+)','color',CC,'Fontsize',12,'Units','normalized');
    text(0.025,0.9,'Single dose','color',interp1([0 1],[1 1 1;CC],0.5),'Fontsize',12,'Units','normalized');
end

print(gcf,['Supplement_Figure_7.png'],'-dpng','-r300');    
end
