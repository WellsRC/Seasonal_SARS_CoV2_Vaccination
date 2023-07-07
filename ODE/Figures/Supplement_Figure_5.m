function Supplement_Figure_5
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

State_V='Cost';

Outcome={'Incidence','Hospitalizations','Death','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];

AgeC={['Ages: 0' char(8211) '4'],['Ages: 5' char(8211) '12'],['Ages: 13' char(8211) '17'],['Ages: 18' char(8211) '49'],['Ages: 50' char(8211) '64'],'Ages: 65+'};

t_day=[90:30:300];
XTL={'90','120','150','180','210','240','270','300'};
Y_Red=zeros(6,length(XTL),8);
for oo=1:4
    
    t_out=strcmp(Outcome{oo},Outcome);
    for vv=1:2
        for mm=1:length(XTL)
                load([temp_cd 'Comparison_Summary_Large_Winter_Two_Campaign_Influenza_Like_Coverage_' num2str(t_day(mm)) '_days_' num2str(65-15.*(vv-1)) '_and_older.mat']);
                Comparison.Average.Age_Cumulative_Count_Incidence_rel=reshape(Comparison.Average.Age_Cumulative_Count_Incidence_rel,7,9);
                Comparison.Average.Age_Cumulative_Count_Hospital_rel=reshape(Comparison.Average.Age_Cumulative_Count_Hospital_rel,7,9);
                Comparison.Average.Age_Cumulative_Count_Death_rel=reshape(Comparison.Average.Age_Cumulative_Count_Death_rel,7,9);
                Comparison.Average.Cost_Age_rel=reshape(Comparison.Average.Cost_Age_rel,7,9);
            for ss=1:6
                if(t_out(1))
                    Y_Red(ss,mm,oo+4.*(vv-1))=Comparison.Average.Age_Cumulative_Count_Incidence_rel(ss,end);
                elseif(t_out(2))   
                    Y_Red(ss,mm,oo+4.*(vv-1))=Comparison.Average.Age_Cumulative_Count_Hospital_rel(ss,end);
                elseif(t_out(3))   
                    Y_Red(ss,mm,oo+4.*(vv-1))=Comparison.Average.Age_Cumulative_Count_Death_rel(ss,end);
                elseif(t_out(4))   
                    Y_Red(ss,mm,oo+4.*(vv-1))=Comparison.Average.Cost_Age_rel(ss,end);
                end
            end
        end
    end
end
Y_Red=-100.*Y_Red;
% Need to take the negative as we computed based on increase and y-axis is
% represented in reduction


figure('units','normalized','outerposition',[0 0.025 0.8 0.9]);

for ss=1:6
    subplot('Position',[0.06+rem((ss-1),3).*0.33,0.59-floor(ss./4).*0.49,0.27,0.375]);  
    b=bar([1:8],squeeze(Y_Red(ss,:,:)),'LineStyle','none');
    for oo=1:4
        b(oo).FaceColor=CC(oo,:);
        b(oo+4).FaceColor=interp1([0 1],[1 1 1;CC(oo,:)],0.5);
    end
    box off;
    set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:length(XTL)],'XTickLabel',XTL,'Yminortick','on','YTick',[0:7],'Xminortick','off','Fontsize',16);
    ylim([0 6])
    xlim([0.45 length(XTL)+.55])
    title(AgeC{ss})
    ytickformat('percentage');
    text(0.87,0.97,'65+','color','k','units','normalized','Fontsize',16);  
    text(0.87,0.9,'50+','color',interp1([0 1],[1 1 1;0 0 0],0.5),'units','normalized','Fontsize',16);  
    for oo=1:4
        text(0.01,0.97-0.07.*(oo-1),Outcome{oo},'color',CC(oo,:),'units','normalized','Fontsize',16);  
    end

    ylabel({['Reduction in ' lower(State_V)]},'Fontsize',18);
    xlabel('Days to second dose','Fontsize',18);
    text(-0.204,1.046,char(64+ss),'fontweight','bold','units','normalized','Fontsize',24);  
end
print(gcf,['Supplement_Figure_5.png'],'-dpng','-r300');
end