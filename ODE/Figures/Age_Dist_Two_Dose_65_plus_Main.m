function Age_Dist_Two_Dose_65_plus_Main(State_V)
close all;
Scenario='All';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths'};

t_out=strcmp(State_V,Outcome);

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];

load([temp_cd 'Comparison_Summary_' Scenario '_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat'],'xbin_edges');
AgeC={['Ages 0' char(8211) '64 vs Ages 65+'],'All ages'};
Per_Increase=zeros(6,5);
Y=zeros(6,length(xbin_edges)-1,5);

xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
min_x=Inf;
max_x=-Inf;

t_day=[90:30:180];
XTL={'One dose','90','120','150','180'};
Age_Indx=6; 
for mm=1:5
    if(mm==1)
        load([temp_cd 'Comparison_Summary_' Scenario '_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat']);
    else
        load([temp_cd 'Comparison_Summary_' Scenario '_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(mm-1)) '_days_65_and_older-Baseline_Continual_Vaccination.mat']);
    end
    gg=1;
    if(t_out(1))
        MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(Age_Indx,:));
        Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(Age_Indx,:)./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    elseif(t_out(2))   
        MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(Age_Indx,:));
        Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(Age_Indx,:)./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    elseif(t_out(3))   
        MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(Age_Indx,:));
        Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(Age_Indx,:)./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    end
    
    gg=2;
    if(t_out(1))
        MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(Age_Indx,:));
        Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(Age_Indx,:)./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    elseif(t_out(2))   
        MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(Age_Indx,:));
        Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(Age_Indx,:)./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    elseif(t_out(3))   
        MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(Age_Indx,:));
        Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(Age_Indx,:)./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    end
    
    gg=3;
    if(t_out(1))
        MM=max(Comparison.Histogram.Cumulative_Count_Incidence_rel);
        Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Incidence_rel./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    elseif(t_out(2))   
        MM=max(Comparison.Histogram.Cumulative_Count_Hospital_rel);
        Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Hospital_rel./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    elseif(t_out(3))   
        MM=max(Comparison.Histogram.Cumulative_Count_Death_rel);
        Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Death_rel./MM;
        Per_Increase(gg,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
    end
    min_x=min(min_x,min(xbin_edges(Y(gg,:,mm)>0)));
    max_x=max(max_x,max(xbin_edges(Y(gg,:,mm)>0)));
end

% Need to take the negative as we computed based on increase and y-axis is
% represented in reduction
xt=-xt;
figure('units','normalized','outerposition',[0.1 0.25 0.55 0.45]);

for Age_Indx=1:2
    subplot('Position',[0.09+rem((Age_Indx-1),3).*0.5,0.175,0.4,0.725]);  
    plot([0.45 5.55],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    if(Age_Indx==1)
        for mm=1:5
            patch(mm+[-0.45.*Y(Age_Indx,:,mm) flip(0.*Y(Age_Indx,:,mm))], 100.*([xt flip(xt)]),CC(t_out,:),'LineStyle','none'); hold on; 
            patch(mm+[-0.*Y(Age_Indx+1,:,mm) flip(0.45.*Y(Age_Indx+1,:,mm))], 100.*([xt flip(xt)]),interp1([0 1],[1 1 1; CC(t_out,:)],0.45),'LineStyle','none'); hold on; 
        end
        text(0.5,-26,['Ages 0' char(8211) '64'],'Fontsize',14,'color',CC(t_out,:));
        text(1.75,-26,['Ages 65+'],'Fontsize',14,'color',interp1([0 1],[1 1 1; CC(t_out,:)],0.45));
    else
        for mm=1:5
            patch(mm+[-0.45.*Y(Age_Indx+1,:,mm) flip(0.45.*Y(Age_Indx+1,:,mm))], 100.*([xt flip(xt)]),CC(t_out,:),'LineStyle','none'); hold on; 
            text(mm,-25,['(' num2str(100.*Per_Increase(Age_Indx,mm),'%3.1f') '%)'],'HorizontalAlignment','center','fontsize',16);
        end
    end
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:5],'XTickLabel',XTL,'Yminortick','off','YTick',[-30:10:30],'Xminortick','off','Fontsize',16);
    ylim([-30 30])
    xlim([0.45 5.55])
%     title(AgeC{Age_Indx})
    ytickformat('percentage');
    ylabel({['Reduction in ' lower(State_V)]},'Fontsize',18);
    xlabel('Days to second dose for 65+','Fontsize',18);
text(-0.204,1.08,char(64+Age_Indx),'units','normalized','Fontsize',24,'Fontweight','bold');    
end
print(gcf,['Days_to_second_dose_65_' Scenario '_' State_V '.png'],'-dpng','-r300');
end