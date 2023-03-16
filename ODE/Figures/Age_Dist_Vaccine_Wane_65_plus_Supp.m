function Age_Dist_Vaccine_Wane_65_plus_Supp(Scenario,State_V)
close all;

% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths'};

t_out=strcmp(State_V,Outcome);

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];

load([temp_cd 'Comparison_Summary_' Scenario '_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster.mat'],'xbin_edges');
AgeC={['Ages: 0' char(8211) '4'],['Ages: 5' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+','All ages'};
Per_Increase=zeros(6,5);
Y=zeros(6,length(xbin_edges)-1,5);
xt=xbin_edges(1:end-1);
min_x=Inf;
max_x=-Inf;

Red_gamma_V=[0 25 50 75 100];
XTL={'0%','25%' ,'50%','75%','100%'};
for mm=1:5
    if(mm==1)
        load([temp_cd 'Comparison_Summary_' Scenario '_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster.mat']);
    else
        load([temp_cd 'Comparison_Summary_' Scenario '_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(Red_gamma_V(mm)) '.mat']);
    end
    for ss=1:6
        if(ss<6)
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
        else
             if(t_out(1))
                MM=max(Comparison.Histogram.Cumulative_Count_Incidence_rel);
                Y(ss,:,mm)=Comparison.Histogram.Cumulative_Count_Incidence_rel./MM;
                Per_Increase(ss,mm)=sum(Y(ss,xt>=0,mm))./sum(Y(ss,:,mm));
            elseif(t_out(2))   
                MM=max(Comparison.Histogram.Cumulative_Count_Hospital_rel);
                Y(ss,:,mm)=Comparison.Histogram.Cumulative_Count_Hospital_rel./MM;
                Per_Increase(ss,mm)=sum(Y(ss,xt>=0,mm))./sum(Y(ss,:,mm));
            elseif(t_out(3))   
                MM=max(Comparison.Histogram.Cumulative_Count_Death_rel);
                Y(ss,:,mm)=Comparison.Histogram.Cumulative_Count_Death_rel./MM;
                Per_Increase(ss,mm)=sum(Y(ss,xt>=0,mm))./sum(Y(ss,:,mm));
            end

        end
        min_x=min(min_x,min(xbin_edges(Y(ss,:,mm)>0)));
        max_x=max(max_x,max(xbin_edges(Y(ss,:,mm)>0)));
    end
end

figure('units','normalized','outerposition',[0 0.025 0.8 0.9]);

for ss=1:6
    subplot('Position',[0.06+rem((ss-1),3).*0.33,0.59-floor(ss./4).*0.49,0.27,0.375]);  
    plot([0.5 5.5],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
    for mm=1:5
        patch(mm+[-0.45.*Y(ss,:,mm) flip(0.45.*Y(ss,:,mm))], 100.*([xbin_edges(1:end-1) flip(xbin_edges(1:end-1))]),CC(t_out,:),'LineStyle','none'); hold on; 
        text(mm,25,['(' num2str(100.*Per_Increase(ss,mm),'%3.1f') '%)'],'HorizontalAlignment','center','fontsize',16);
    end
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:5],'XTickLabel',XTL,'Yminortick','off','YTick',[-100:25:150],'Xminortick','off','Fontsize',16);
    ylim([-75 30])
    xlim([0.45 5.55])
    title(AgeC{ss})
    ytickformat('percentage');
    ylabel('Relative to baseline','Fontsize',18);
    xlabel('Reduction in vaccine waning rate for 65+','Fontsize',16);
    text(-0.204,1.046,char(64+ss),'fontweight','bold','units','normalized','Fontsize',28);  
end
print(gcf,['Supplement_Reduce_Vaccine_Waning_Rate_65_' Scenario '_' State_V '.png'],'-dpng','-r300');
end