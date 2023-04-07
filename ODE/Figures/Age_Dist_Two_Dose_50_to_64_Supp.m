function Age_Dist_Two_Dose_50_to_64_Supp(Scenario,State_V)
close all;

% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Death'};

t_out=strcmp(State_V,Outcome);

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];

load([temp_cd 'Comparison_Summary_' Scenario '_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat'],'xbin_edges');
AgeC={['Ages: 0' char(8211) '4'],['Ages: 5' char(8211) '12'],['Ages: 13' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+'};


xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
min_x=Inf;
max_x=-Inf;

t_day=[90:30:180];
XTL={'90','120','150','180'};
Per_Increase=zeros(6,length(XTL));
Y=zeros(6,length(xbin_edges)-1,length(XTL));
for mm=1:length(XTL)
        load([temp_cd 'Comparison_Summary_' Scenario '_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(mm)) '_days_50_to_64.mat']);
    
    for ss=1:6
        if(t_out(1))
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            Y(ss,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
            Per_Increase(ss,mm)=sum(Y(ss,xt>=0,mm))./sum(Y(ss,:,mm));
        elseif(t_out(2))   
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            Y(ss,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
            Per_Increase(ss,mm)=sum(Y(ss,xt>=0,mm))./sum(Y(ss,:,mm));
        elseif(t_out(3))   
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            Y(ss,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
            Per_Increase(ss,mm)=sum(Y(ss,xt>=0,mm))./sum(Y(ss,:,mm));
        end
        min_x=min(min_x,min(xbin_edges(Y(ss,:,mm)>0)));
        max_x=max(max_x,max(xbin_edges(Y(ss,:,mm)>0)));
    end
end

% Need to take the negative as we computed based on increase and y-axis is
% represented in reduction
xt=-xt;

figure('units','normalized','outerposition',[0 0.025 0.8 0.9]);

for ss=1:6
    subplot('Position',[0.06+rem((ss-1),3).*0.33,0.59-floor(ss./4).*0.49,0.27,0.375]);  
    plot([0.45 length(XTL)+.55],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for mm=1:length(XTL)
        patch(mm+[-0.45.*Y(ss,:,mm) flip(0.45.*Y(ss,:,mm))], 100.*([xt flip(xt)]),CC(t_out,:),'LineStyle','none'); hold on; 
        text(mm,-3,['(' num2str(100.*Per_Increase(ss,mm),'%3.1f') '%)'],'HorizontalAlignment','center','fontsize',16);
    end
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:length(XTL)],'XTickLabel',XTL,'Yminortick','off','YTick',[-5:5:25],'Xminortick','off','Fontsize',16);
    ylim([-5 25])
    xlim([0.45 length(XTL)+.55])
    title(AgeC{ss})
    ytickformat('percentage');
    ylabel({['Reduction in ' lower(State_V)]},'Fontsize',18);
    xlabel('Days to second dose for 50 to 64','Fontsize',18);
    text(-0.204,1.046,char(64+ss),'fontweight','bold','units','normalized','Fontsize',24);  
end
print(gcf,['Supplement_Days_to_second_dose_50_to_64_' Scenario '_' State_V '.png'],'-dpng','-r300');
end