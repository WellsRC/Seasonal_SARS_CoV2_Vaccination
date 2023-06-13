function Supplement_Figure_7
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
    Y_90=zeros(3,length(xt),length(XTL));

    min_x=Inf;
    max_x=-Inf;

    for mm=1:length(XTL)
        load([temp_cd 'Comparison_Summary_' Scenario '_Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_90_Delay_' num2str(t_day(mm)) '_days.mat']);
        for aav=1:3 
            aa=aa_indx(aav);
            if(Scenario_Indx==1)
                MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{aa},xt));
                Y_90(aav,:,mm)=pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{aa},xt)./MM;
            elseif(Scenario_Indx==2)   
                MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{aa},xt));
                Y_90(aav,:,mm)=pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{aa},xt)./MM;
            elseif(Scenario_Indx==3)   
                MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{aa},xt));
                Y_90(aav,:,mm)=pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{aa},xt)./MM;
            elseif(Scenario_Indx==4)   
                MM=max(pdf(Comparison.Histogram.Cost_Age_rel{aa},xt));
                Y_90(aav,:,mm)=pdf(Comparison.Histogram.Cost_Age_rel{aa},xt)./MM;
            end
            min_x=min(min_x,min(xt(Y_90(aav,:,mm)>0)));
            max_x=max(max_x,max(xt(Y_90(aav,:,mm)>0)));
        end

    end

    for aa=1:3
        subplot('Position',[0.09+0.33.*(aa-1),0.785-0.223.*(Scenario_Indx-1),0.24,0.18]);

%     
        plot([0.45 length(XTL)+0.55],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on; 
        for mm=1:length(XTL)
            t1=squeeze(Y_90(aa,:,mm));
            patch(mm+[-0.45.*t1 0.45.*flip(t1)], 100.*([xt flip(xt)]),CC(Scenario_Indx,:),'LineStyle','none'); hold on;   
        end
        box off;
        set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:length(XTL)],'XTickLabel',XTL,'Yminortick','on','YTick',[-5:5:20],'Xminortick','off','Fontsize',16);
        ylim([-5 20])
        xlim([0.4 length(XTL)+.6])

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
print(gcf,['Supplement_Figure_7.png'],'-dpng','-r300');
end