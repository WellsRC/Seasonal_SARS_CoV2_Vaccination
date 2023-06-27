function Supplement_Figure_6
close all;
Scenario='Large_Winter';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];

xt=linspace(-1,1,5001);
t_day=[7:7:28];
XTL={'7','14','21','28'};
Age_Text={['0' char(8211) '49'],['50' char(8211) '64'],'65+'};
aa_indx=[7 5 6];

figure('units','normalized','outerposition',[0.1 0.05 0.75 1]);

for Scenario_Indx=1:4    

    Y=zeros(3,length(XTL),3);
    for pp=1:3
        for mm=1:length(XTL)
            load([temp_cd 'Comparison_Summary_' Scenario '_Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_' num2str(30.*pp) '_Delay_' num2str(t_day(mm)) '_days.mat']);
            Comparison.Average.Age_Cumulative_Count_Incidence_rel=reshape(Comparison.Average.Age_Cumulative_Count_Incidence_rel,7,9);
            Comparison.Average.Age_Cumulative_Count_Hospital_rel=reshape(Comparison.Average.Age_Cumulative_Count_Hospital_rel,7,9);
            Comparison.Average.Age_Cumulative_Count_Death_rel=reshape(Comparison.Average.Age_Cumulative_Count_Death_rel,7,9);
            Comparison.Average.Cost_Age_rel=reshape(Comparison.Average.Cost_Age_rel,7,9);
            for aav=1:3 
                aa=aa_indx(aav);
                if(Scenario_Indx==1)
                    Y(aav,mm,pp)=Comparison.Average.Age_Cumulative_Count_Incidence_rel(aa,end);
                elseif(Scenario_Indx==2)   
                    Y(aav,mm,pp)=Comparison.Average.Age_Cumulative_Count_Hospital_rel(aa,end);
                elseif(Scenario_Indx==3)   
                    Y(aav,mm,pp)=Comparison.Average.Age_Cumulative_Count_Death_rel(aa,end);
                elseif(Scenario_Indx==4)   
                    Y(aav,mm,pp)=Comparison.Average.Cost_Age_rel(aa,end);
                end
            end
        end
    end

Y=100.*Y;
    for aa=1:3
        subplot('Position',[0.09+0.33.*(aa-1),0.785-0.223.*(Scenario_Indx-1),0.24,0.18]);
        b=bar([1:length(XTL)],squeeze(Y(aa,:,:)),'LineStyle','none');
        b(1).FaceColor=interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.3);
        b(2).FaceColor=interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.6);
        b(3).FaceColor=interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],1);
        box off;
        set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:length(XTL)],'XTickLabel',XTL,'Yminortick','on','YTick',[0:5],'Xminortick','off','Fontsize',16);
        ylim([0 5])
        xlim([0.4 length(XTL)+.6])

        text(0.01,0.985,'30% delay vaccination','color',interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.3),'Fontsize',12,'Units','normalized');
        text(0.01,0.9,'60% delay vaccination','color',interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.6),'Fontsize',12,'Units','normalized');
        text(0.01,0.815,'90% delay vaccination','color',CC(Scenario_Indx,:),'Fontsize',12,'Units','normalized');

        ytickformat('percentage');
        ylabel({'Increase in', lower(Outcome{Scenario_Indx})},'Fontsize',18);
        if(Scenario_Indx==1)
           title(['Ages ' Age_Text{aa}]);
        end
        if(Scenario_Indx==4)
            xlabel({'Days SARS CoV-2 vaccine','distribution delayed'},'Fontsize',18);
        end
        text(-0.32,1,char(64+aa+ 3.*(Scenario_Indx-1)),'Fontsize',24,'Units','normalized','fontweight','bold'); 

    end
%     
end
print(gcf,['Supplement_Figure_6.png'],'-dpng','-r300');
end