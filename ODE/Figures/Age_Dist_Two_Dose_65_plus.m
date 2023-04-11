function Age_Dist_Two_Dose_65_plus()
close all;
Scenario='All';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];

xt=linspace(-1,1,5001);
xt2=-xt;
t_day=[90:30:300];
XTL={'90','120','150','180','210','240','270','300'};



figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
for Scenario_Indx=1:4    

    Per_Increase=zeros(1,length(XTL));
    Y=zeros(2,length(xt),length(XTL));

    min_x=Inf;
    max_x=-Inf;

    for mm=1:length(XTL)
        load([temp_cd 'Comparison_Summary_' Scenario '_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(mm)) '_days_65_and_older.mat']);
        if(Scenario_Indx==1)
            MM=max(pdf(Comparison.Histogram.Cumulative_Count_Incidence_rel,xt));
            Y(1,:,mm)=pdf(Comparison.Histogram.Cumulative_Count_Incidence_rel,xt)./MM;
        elseif(Scenario_Indx==2)   
            MM=max(pdf(Comparison.Histogram.Cumulative_Count_Hospital_rel,xt));
            Y(1,:,mm)=pdf(Comparison.Histogram.Cumulative_Count_Hospital_rel,xt)./MM;
        elseif(Scenario_Indx==3)   
            MM=max(pdf(Comparison.Histogram.Cumulative_Count_Death_rel,xt));
            Y(1,:,mm)=pdf(Comparison.Histogram.Cumulative_Count_Death_rel,xt)./MM;
        elseif(Scenario_Indx==4)   
            MM=max(pdf(Comparison.Histogram.Cost_rel,xt));
            Y(1,:,mm)=pdf(Comparison.Histogram.Cost_rel,xt)./MM;
        end
        min_x=min(min_x,min(xt(Y(1,:,mm)>0)));
        max_x=max(max_x,max(xt(Y(1,:,mm)>0)));
        
        load([temp_cd 'Comparison_Summary_' Scenario '_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(mm)) '_days_50_and_older.mat']);
        if(Scenario_Indx==1)
            MM=max(pdf(Comparison.Histogram.Cumulative_Count_Incidence_rel,xt));
            Y(2,:,mm)=pdf(Comparison.Histogram.Cumulative_Count_Incidence_rel,xt)./MM;
        elseif(Scenario_Indx==2)   
            MM=max(pdf(Comparison.Histogram.Cumulative_Count_Hospital_rel,xt));
            Y(2,:,mm)=pdf(Comparison.Histogram.Cumulative_Count_Hospital_rel,xt)./MM;
        elseif(Scenario_Indx==3)   
            MM=max(pdf(Comparison.Histogram.Cumulative_Count_Death_rel,xt));
            Y(2,:,mm)=pdf(Comparison.Histogram.Cumulative_Count_Death_rel,xt)./MM;
        elseif(Scenario_Indx==4)   
            MM=max(pdf(Comparison.Histogram.Cost_rel,xt));
            Y(2,:,mm)=pdf(Comparison.Histogram.Cost_rel,xt)./MM;
        end
        min_x=min(min_x,min(xt(Y(2,:,mm)>0)));
        max_x=max(max_x,max(xt(Y(2,:,mm)>0)));
    end

    
    subplot('Position',[0.115+0.5.*(rem(Scenario_Indx-1,2)),0.625-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.3525]);    

    
    plot([0 0],[0.45 length(XTL)+0.55],'color',[0.7 0.7 0.7],'LineWidth',2); hold on; 
    for mm=1:length(XTL)
        patch(100.*([xt2 flip(xt2)]),mm+[-0.*Y(1,:,mm) flip(0.45.*Y(1,:,mm))], CC(Scenario_Indx,:),'LineStyle','none'); hold on; 
        patch(100.*([xt2 flip(xt2)]),mm+[-0.45.*Y(2,:,mm) flip(0.*Y(2,:,mm))], interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.5),'LineStyle','none'); hold on; 
    end
    text(0.866,0.944,'65+','color',CC(Scenario_Indx,:),'Fontsize',16,'Units','normalize');
    text(0.866,0.8367,'50+','color',interp1([0 1],[1 1 1;CC(Scenario_Indx,:)],0.5),'Fontsize',16,'Units','normalize');
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:length(XTL)],'YTickLabel',XTL,'Yminortick','off','XTick',[-6:1:10],'Xminortick','off','Fontsize',16);
    xlim([-0.5 8])
    ylim([0.4 length(XTL)+.6])
    xtickformat('percentage');
    xlabel({['Reduction in ' lower(Outcome{Scenario_Indx})]},'Fontsize',18);
    ylabel({'Days to','second dose'},'Fontsize',18);
    text(-0.3,1,char(64+Scenario_Indx),'Fontsize',24,'Units','normalized','fontweight','bold');
    
end
print(gcf,['Days_to_second_dose_65_' Scenario '.png'],'-dpng','-r300');
end