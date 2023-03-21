function Age_Dist_Seasonal_Influenza_Coverage_Main(State_V)
close all;
Scenario='All';
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths'};

t_out=strcmp(State_V,Outcome);

vac_coverage_influenza=[0.5 0.6 0.8 0.9; 
                        0.4 0.5 0.7 0.8;
                        0.25 0.35 0.55 0.65;
                        0.15 0.25 0.45 0.55;
                        0.25 0.35 0.55 0.65;
                        0.45 0.55 0.75 0.85;];
Age_B=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];

for Age_Indx=1:6
    load([temp_cd 'Comparison_Summary_' Scenario '_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(Age_Indx,1)) '_to_' num2str(Age_B(Age_Indx,2)) '=' num2str(100.*vac_coverage_influenza(Age_Indx,1)) '.mat'],'xbin_edges');


    Per_Increase=zeros(2,4);
    Y=zeros(4,length(xbin_edges)-1,4);
    xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
    min_x=Inf;
    max_x=-Inf;

    XTL=cell(1,4);
    for mm=1:4
        XTL{mm}=[num2str(100.*vac_coverage_influenza(Age_Indx,mm)) '%'];
        load([temp_cd 'Comparison_Summary_' Scenario '_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(Age_Indx,1)) '_to_' num2str(Age_B(Age_Indx,2)) '=' num2str(100.*vac_coverage_influenza(Age_Indx,mm)) '.mat']);
        
            gg=1;
            if(t_out(1))
                MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(Age_Indx,:));
                Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(Age_Indx,:)./MM;
            elseif(t_out(2))   
                MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(Age_Indx,:));
                Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(Age_Indx,:)./MM;
            elseif(t_out(3))   
                MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(Age_Indx,:));
                Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(Age_Indx,:)./MM;
            end                
            min_x=min(min_x,min(xbin_edges(Y(gg,:,mm)>0)));
            max_x=max(max_x,max(xbin_edges(Y(gg,:,mm)>0)));
            
            gg=2;
            if(t_out(1))
                MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(Age_Indx,:));
                Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Incidence_rel(Age_Indx,:)./MM;
            elseif(t_out(2))   
                MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(Age_Indx,:));
                Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Hospital_rel(Age_Indx,:)./MM;
            elseif(t_out(3))   
                MM=max(Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(Age_Indx,:));
                Y(gg,:,mm)=Comparison.Histogram.Compliment_Age_Cumulative_Count_Death_rel(Age_Indx,:)./MM;
            end                
            min_x=min(min_x,min(xbin_edges(Y(gg,:,mm)>0)));
            max_x=max(max_x,max(xbin_edges(Y(gg,:,mm)>0)));
            
            gg=3;
             if(t_out(1))
                MM=max(Comparison.Histogram.Cumulative_Count_Incidence_rel);
                Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Incidence_rel./MM;
                Per_Increase(1,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
            elseif(t_out(2))   
                MM=max(Comparison.Histogram.Cumulative_Count_Hospital_rel);
                Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Hospital_rel./MM;
                Per_Increase(1,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
            elseif(t_out(3))   
                MM=max(Comparison.Histogram.Cumulative_Count_Death_rel);
                Y(gg,:,mm)=Comparison.Histogram.Cumulative_Count_Death_rel./MM;
                Per_Increase(1,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
             end
            min_x=min(min_x,min(xbin_edges(Y(gg,:,mm)>0)));
            max_x=max(max_x,max(xbin_edges(Y(gg,:,mm)>0)));
            
            
            gg=4;
            if(t_out(1))
                MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(end,:));
                Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(end,:)./MM;
                Per_Increase(2,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
            elseif(t_out(2))   
                MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(end,:));
                Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(end,:)./MM;
                Per_Increase(2,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
            elseif(t_out(3))   
                MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(end,:));
                Y(gg,:,mm)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(end,:)./MM;
                Per_Increase(2,mm)=sum(Y(gg,xt>=0,mm))./sum(Y(gg,:,mm));
            end     
            min_x=min(min_x,min(xbin_edges(Y(gg,:,mm)>0)));
            max_x=max(max_x,max(xbin_edges(Y(gg,:,mm)>0)));
    end

    % Need to take the negative as we computed based on increase and y-axis is
% represented in reduction
xt=-xt;
    figure('units','normalized','outerposition',[0.1 0.25 0.55 0.45]);

    for jj=1:2
        subplot('Position',[0.09+rem((jj-1),3).*0.5,0.175,0.4,0.725]);  
        plot([0.45 5.55],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
        if(jj==1)
            for mm=1:4
                patch(mm+[-0.45.*Y(jj,:,mm) flip(0.*Y(jj,:,mm))], 100.*([xt flip(xt)]),CC(t_out,:),'LineStyle','none'); hold on; 
                patch(mm+[-0.*Y(jj+1,:,mm) flip(0.45.*Y(jj+1,:,mm))], 100.*([xt flip(xt)]),interp1([0 1],[1 1 1; CC(t_out,:)],0.45),'LineStyle','none'); hold on; 
            end
            text(0.5,27.5,['Ages ' AgeC{Age_Indx}],'Fontsize',14,'color',CC(t_out,:));
            text(0.5,21.5,['Those not ' AgeC{Age_Indx}],'Fontsize',14,'color',interp1([0 1],[1 1 1; CC(t_out,:)],0.45));
        else
            for mm=1:4
                patch(mm+[-0.45.*Y(jj+1,:,mm) flip(0.*Y(jj+1,:,mm))], 100.*([xt flip(xt)]),CC(t_out,:),'LineStyle','none'); hold on; 
                patch(mm+[0.*Y(jj+1,:,mm) flip(0.45.*Y(jj+2,:,mm))], 100.*([xt flip(xt)]),interp1([0 1],[1 1 1; CC(t_out,:)],0.45),'LineStyle','none'); hold on; 
                text(mm,-35,['(' num2str(100.*Per_Increase(1,mm),'%3.1f') '%)'],'HorizontalAlignment','center','fontsize',16,'color',CC(t_out,:));
                text(mm,-41,['(' num2str(100.*Per_Increase(2,mm),'%3.1f') '%)'],'HorizontalAlignment','center','fontsize',16,'color',interp1([0 1],[1 1 1; CC(t_out,:)],0.45));
                
                text(0.5,27.5,['All ages'],'Fontsize',14,'color',CC(t_out,:));
                text(0.5,21.5,['Ages 65+'],'Fontsize',14,'color',interp1([0 1],[1 1 1; CC(t_out,:)],0.45));
            end
        end
        box off;
        set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:4],'XTickLabel',XTL,'Yminortick','off','YTick',[-40:10:40],'Xminortick','off','Fontsize',16);
        ylim([-45 30])
        xlim([0.45 4.55])
        ytickformat('percentage');
        ylabel({['Reduction in ' lower(State_V)]},'Fontsize',16);
        xlabel(['Vaccination coverage for those '  AgeC{Age_Indx}],'Fontsize',16);
        text(-0.204,1.08,char(64+jj),'fontweight','bold','units','normalized','Fontsize',28);    
    end
    print(gcf,['Main_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(Age_Indx,1)) '_to_' num2str(Age_B(Age_Indx,2)) '.png'],'-dpng','-r300');
end
end