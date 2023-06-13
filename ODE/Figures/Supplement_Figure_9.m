function Supplement_Figure_9
close all;
Scenario='Large_Winter';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];

xt=linspace(-1,1,5001);
xt2=-xt;
t_day=[90:30:300];
XTL={'90','120','150','180','210','240','270','300'};
AgeV=[65 50];
Age_Text={['0' char(8211) '49'],['50' char(8211) '64'],'65+'};
aa_indx=[7 5 6];

figure('units','normalized','outerposition',[0.1 0.05 0.75 1]);
for Scenario_Indx=1:4    
    Y=zeros(3,2,length(xt),length(XTL));

    min_x=Inf;
    max_x=-Inf;

    for mm=1:length(XTL)
        for vv=1:2
            load([temp_cd 'Comparison_Summary_' Scenario '_Two_Campaign_Baseline_Coverage_' num2str(t_day(mm)) '_days_' num2str(AgeV(vv)) '_and_older.mat']);
            for aav=1:3
                aa=aa_indx(aav);
                if(Scenario_Indx==1)
                    MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{aa},xt));
                    Y(aav,vv,:,mm)=pdf(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel{aa},xt)./MM;
                elseif(Scenario_Indx==2)   
                    MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{aa},xt));
                    Y(aav,vv,:,mm)=pdf(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel{aa},xt)./MM;
                elseif(Scenario_Indx==3)   
                    MM=max(pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{aa},xt));
                    Y(aav,vv,:,mm)=pdf(Comparison.Histogram.Age_Cumulative_Count_Death_rel{aa},xt)./MM;
                elseif(Scenario_Indx==4)   
                    MM=max(pdf(Comparison.Histogram.Cost_Age_rel{aa},xt));
                    Y(aav,vv,:,mm)=pdf(Comparison.Histogram.Cost_Age_rel{aa},xt)./MM;
                end
                min_x=min(min_x,min(xt(Y(aav,vv,:,mm)>0)));
                max_x=max(max_x,max(xt(Y(aav,vv,:,mm)>0)));
            end
        end
    end

    for aa=1:3
        subplot('Position',[0.08+0.33.*(aa-1),0.785-0.235.*(Scenario_Indx-1),0.24,0.18]);

%     
        plot([0.45 length(XTL)+0.55],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on; 
        for mm=1:length(XTL)
            t1=squeeze(Y(aa,1,:,mm))';
            t2=squeeze(Y(aa,2,:,mm))';
            patch(mm+[-0.45.*t1 flip(0.*t1)], 100.*([xt2 flip(xt2)]),CC(Scenario_Indx,:),'LineStyle','none'); hold on; 
            patch(mm+[-0.*t2 flip(0.45.*t2)], 100.*([xt2 flip(xt2)]),interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.5),'LineStyle','none'); hold on; 
        end
        text(0.866,0.944,'65+','color',CC(Scenario_Indx,:),'Fontsize',16,'Units','normalize');
        text(0.866,0.8367,'50+','color',interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.5),'Fontsize',16,'Units','normalize');
        box off;
        set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:length(XTL)],'XTickLabel',XTL,'Yminortick','on','YTick',[-0:1:6],'Xminortick','off','Fontsize',16);
        ylim([-0.5 6])
        xlim([0.4 length(XTL)+.6])
        ytickformat('percentage');
        ylabel({'Reduction in', lower(Outcome{Scenario_Indx})},'Fontsize',18);
        if(Scenario_Indx==1)
           title(['Ages ' Age_Text{aa}]);
        end
        if(Scenario_Indx==4)
            xlabel({'Days to second dose'},'Fontsize',18,'Units','Normalized','Position',[0.500000476837158,-0.27,0]);
        end
        text(-0.32,1,char(64+aa+ 3.*(Scenario_Indx-1)),'Fontsize',24,'Units','normalized','fontweight','bold'); 
    end
%     
end
print(gcf,['Supplement_Figure_9.png'],'-dpng','-r300');
end