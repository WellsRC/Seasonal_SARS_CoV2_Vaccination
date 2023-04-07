function Age_Dist_Two_Dose_50_plus_Supp
close all;
Scenario='All';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];

load([temp_cd 'Comparison_Summary_' Scenario '_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat'],'xbin_edges');
xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
xt2=-xt; % took the negative as we are examining the reduction
t_day=[90:30:300];
XTL={'90','120','150','180','210','240','270','300'};



figure('units','normalized','outerposition',[0.1 0.06 0.45 1]);
for State_Indx=1:4    

    Per_Increase=zeros(3,length(XTL));
    Y=zeros(3,length(xbin_edges)-1,length(XTL));

    min_x=Inf;
    max_x=-Inf;

    Age_Indx=6; 
    for mm=1:length(XTL)
        load([temp_cd 'Comparison_Summary_' Scenario '_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(mm)) '_days_50_and_older.mat']);
        gg=1;
        if(State_Indx==1)
            MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==2)   
            MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==3)   
            MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==4)   
            MM=max(Comparison.Histogram.Cost_Compliment_Age_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Cost_Compliment_Age_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        end

        gg=2;
        if(State_Indx==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==2)   
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==3)   
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==4)   
            MM=max(Comparison.Histogram.Cost_Age_rel(Age_Indx,:));
            Y(gg,:,mm)=Comparison.Histogram.Cost_Age_rel(Age_Indx,:)./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        end

        gg=3;
        if(State_Indx==1)
            MM=max(Comparison.Histogram.Cumulative_Count_Incidence_rel);
            Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Incidence_rel./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==2)   
            MM=max(Comparison.Histogram.Cumulative_Count_Hospital_rel);
            Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Hospital_rel./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        elseif(State_Indx==3)   
            MM=max(Comparison.Histogram.Cumulative_Count_Death_rel);
            Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Death_rel./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));    
        elseif(State_Indx==4)   
            MM=max(Comparison.Histogram.Cost_rel);
            Y(gg,:,mm)=Comparison.Histogram.Cost_rel./MM;
            Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
        end
        min_x=min(min_x,min(xbin_edges(Y(gg,:,mm)>0)));
        max_x=max(max_x,max(xbin_edges(Y(gg,:,mm)>0)));
    end

    % Need to take the negative as we computed based on increase and y-axis is
    % represented in reduction
    
    subplot('Position',[0.605,0.8-0.245.*(State_Indx-1),0.365,0.18]);
    plot([0 0],[0.45 length(XTL)+0.55],'color',[0.7 0.7 0.7],'LineWidth',2); hold on; 
    Age_Indx=1;
    for mm=1:length(XTL)
        patch(100.*([xt2 flip(xt2)]),mm+[0.45.*Y(Age_Indx,:,mm) flip(-0.*Y(Age_Indx,:,mm))], CC(State_Indx,:),'LineStyle','none'); hold on; 
        patch( 100.*([xt2 flip(xt2)]),mm+[0.*Y(Age_Indx+1,:,mm) flip(-0.45.*Y(Age_Indx+1,:,mm))],interp1([0 1],[1 1 1; CC(State_Indx,:)],0.45),'LineStyle','none'); hold on; 
    end
    text(-5.67,8.335,['Ages 0' char(8211) '64'],'Fontsize',12,'color',CC(State_Indx,:));
    text(-5.67,7.52,['Ages 65+'],'Fontsize',12,'color',interp1([0 1],[1 1 1; CC(State_Indx,:)],0.45));
    
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:length(XTL)],'YTickLabel',XTL,'Yminortick','off','XTick',[-5:5:15],'Xminortick','off','Fontsize',12);
    xlim([-5 15])
    ylim([0.45 length(XTL)+.55])
    xtickformat('percentage');
    xlabel({['Reduction in ' lower(Outcome{State_Indx})]},'Fontsize',14);
    text(-0.3,1.04,char(64+2.*(State_Indx)),'Fontsize',22,'FontWeight','bold','Units','normalized');
    ylabel({'Days to second','dose for 50+'},'Fontsize',14);
        
    subplot('Position',[0.1165,0.8-0.245.*(State_Indx-1),0.365,0.18]);

    
    plot([0 0],[0.45 length(XTL)+0.55],'color',[0.7 0.7 0.7],'LineWidth',2); hold on; 
    Age_Indx=2;
    for mm=1:length(XTL)
        patch(100.*([xt2 flip(xt2)]),mm+[-0.45.*Y(Age_Indx+1,:,mm) flip(0.45.*Y(Age_Indx+1,:,mm))], CC(State_Indx,:),'LineStyle','none'); hold on; 
        text(-5.67,mm,['(' num2str(100.*Per_Increase(Age_Indx+1,mm),'%3.1f') '%)'],'fontsize',10);
    end
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:length(XTL)],'YTickLabel',XTL,'Yminortick','off','XTick',[-5:5:15],'Xminortick','off','Fontsize',12);
    xlim([-5 15])
    ylim([0.45 length(XTL)+.55])
    xtickformat('percentage');
    xlabel({['Reduction in ' lower(Outcome{State_Indx})]},'Fontsize',14);
    ylabel({'Days to second','dose for 50+'},'Fontsize',14);
    text(-0.3,1.04,char(65+2.*(State_Indx-1)),'Fontsize',22,'FontWeight','bold','Units','normalized');
    
end
print(gcf,['Days_to_second_dose_50_' Scenario '.png'],'-dpng','-r300');
end