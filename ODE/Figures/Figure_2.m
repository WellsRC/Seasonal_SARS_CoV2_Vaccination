function Figure_2()
close all;
Scenario='Large_Winter';
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Outcome={'Incidence','Hospitalizations','Deaths','Cost'};


CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];

xt=linspace(-0.05,0.05,5001);
xt2=-xt;
t_day=[90:30:300];
XTL={'90','120','150','180','210','240','270','300'};
AgeV=[65 50];
Age_Text={['0' char(8211) '49'],['50' char(8211) '64'],'65+'};
aa_indx=[7 5 6];

Age_50_64=cell(length(t_day),1);
Age_65_Older=cell(length(t_day),1);
Age_Under_50=cell(length(t_day),1);

figure('units','normalized','outerposition',[0.1 0.05 0.75 1]);
for Scenario_Indx=1:4    
    Y=zeros(1,length(XTL));

    min_x=Inf;
    max_x=-Inf;

    for mm=1:length(XTL)
        load([temp_cd 'Comparison_Summary_Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(t_day(mm)) '_days.mat']);
    
%         for aav=1:3
%             aa=aa_indx(aav);
            if(Scenario_Indx==1)
                Y(mm)=Comparison.Average.Cumulative_Count_Incidence_rel;
            elseif(Scenario_Indx==2)   
                Y(mm)=Comparison.Average.Cumulative_Count_Hospital_rel;
            elseif(Scenario_Indx==3)   
                Y(mm)=Comparison.Average.Cumulative_Count_Death_rel;
            elseif(Scenario_Indx==4)   
                Y(mm)=Comparison.Average.Cost_Total_rel(end);
            end
%         end
    end
    Y=-100.*Y;
    subplot(2,2,Scenario_Indx)
    bar(Y)
%     for aa=1:3
%         subplot('Position',[0.08+0.33.*(aa-1),0.785-0.235.*(Scenario_Indx-1),0.24,0.18]);
%         bar([1:length(XTL)],Y(aa,:),'LineStyle','none','FaceColor',CC(Scenario_Indx,:))
%         box off;
%         set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:length(XTL)],'XTickLabel',XTL,'Yminortick','on','YTick',[0:5:25],'Xminortick','off','Fontsize',16);
%         ylim([0 25])
%         xlim([0.4 length(XTL)+.6])
%         ytickformat('percentage');
%         ylabel({'Reduction in', lower(Outcome{Scenario_Indx})},'Fontsize',18);
%         if(Scenario_Indx==1)
%            title(['Ages ' Age_Text{aa}]);
%         end
%         if(Scenario_Indx==4)
%             xlabel({'Days to second dose'},'Fontsize',18,'Units','Normalized','Position',[0.500000476837158,-0.27,0]);
%         end
%         text(-0.32,1,char(64+aa+ 3.*(Scenario_Indx-1)),'Fontsize',24,'Units','normalized','fontweight','bold'); 
%     end
%     
end
print(gcf,['Figure_2.png'],'-dpng','-r300');
delay_v=XTL';
table(delay_v,Age_Under_50,Age_50_64,Age_65_Older)
end