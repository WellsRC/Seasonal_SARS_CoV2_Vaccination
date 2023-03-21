function Age_Dist_Baseline_Coverage_Supp(Scenario,State_V)
close all;

% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths'};

t_out=strcmp(State_V,Outcome);

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];
vac_coverage_baseline=[0.05 0.25 0.50 0.75;
                       0.10 0.20 0.40 0.60;
                       0.15 0.25 0.35 0.45;
                       0.15 0.20 0.30 0.35;
                       0.30 0.35 0.40 0.45;
                       0.50 0.55 0.60 0.75];
Age_B=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];

for aa=1:6
    load([temp_cd 'Comparison_Summary_' Scenario '_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,1)) '.mat'],'xbin_edges');
    AgeC={['Ages: 0' char(8211) '4'],['Ages: 5' char(8211) '12'],['Ages: 13' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+'};
    Per_Increase=zeros(6,4);
    Y=zeros(6,length(xbin_edges)-1,4);
    xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
    min_x=Inf;
    max_x=-Inf;

    XTL=cell(1,4);
    for mm=1:4
        XTL{mm}=[num2str(100.*vac_coverage_baseline(aa,mm)) '%'];
        load([temp_cd 'Comparison_Summary_' Scenario '_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,mm)) '.mat']);
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

    figure('units','normalized','outerposition',[0 0.025 0.8 0.9]);

    for ss=1:6
        subplot('Position',[0.06+rem((ss-1),3).*0.33,0.59-floor(ss./4).*0.49,0.27,0.375]);  
        plot([0.45 5.55],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
        for mm=1:4
            patch(mm+[-0.45.*Y(ss,:,mm) flip(0.45.*Y(ss,:,mm))], -100.*([xt flip(xt)]),CC(t_out,:),'LineStyle','none'); hold on; 
        end
        box off;
        set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:4],'XTickLabel',XTL,'Yminortick','off','YTick',[-5:10:40],'Xminortick','off','Fontsize',16);
%         ylim([-5 40])
        xlim([0.45 4.55])
        title(AgeC{ss})
        ytickformat('percentage');
        ylabel({['Reduction in ' lower(State_V)]},'Fontsize',16);
        xlabel(['Vaccination coverage for those '  num2str(Age_B(aa,1)) char(8211)   num2str(Age_B(aa,2))],'Fontsize',16);
        text(-0.204,1.046,char(64+ss),'fontweight','bold','units','normalized','Fontsize',28);  
    end
    print(gcf,['Supplement_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '_' Scenario '_' State_V '.png'],'-dpng','-r300');
end
end