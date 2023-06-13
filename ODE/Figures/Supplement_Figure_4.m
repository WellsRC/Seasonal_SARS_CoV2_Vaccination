function  Supplement_Figure_4
close all;

temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
state_out={'incidence','hospitalizations','deaths','cost'};
xtl=cell(8,1);
for ii=1:8
   xtl{ii}=num2str(90+30.*(ii-1)); 
end
CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E'); hex2rgb('#002C54')];
figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);

for Scenario_Indx=1:4
    M=zeros(1,8);
    Pr=zeros(2,8);
    xt=linspace(-1,1,5001);
    
    subplot('Position',[0.135+0.5.*(rem(Scenario_Indx-1,2)),0.635-0.49.*(floor((Scenario_Indx-1)./2)),0.36,0.315]);
    for ss=1:8         
        load([temp_cd 'Marginal_Benefit_65_and_older_Large_Winter_Two_Campaign_Baseline_Coverage_' num2str(90+30.*(ss-1)) '_days.mat'])
        
        if(Scenario_Indx==1)
            out_measure=Marginal_Benefit.Incidence;
        elseif(Scenario_Indx==2)    
            out_measure=Marginal_Benefit.Hospital;
        elseif(Scenario_Indx==3)    
            out_measure=Marginal_Benefit.Death;
        elseif(Scenario_Indx==4)  
            out_measure=Marginal_Benefit.Cost;
        end
        
        pdf_e  = fitdist(out_measure,'Kernel','Kernel','epanechnikov');
        MM=max(pdf(pdf_e,xt));
        M(ss)=median(out_measure);
        Pr(:,ss)=prctile(out_measure,[2.5 97.5]);
        Y=pdf(pdf_e,xt)./MM;
        
        plot([0.5 8.5],[0 0],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
        patch(ss+[-0.45.*Y flip(0.45.*Y)], 100.*([xt flip(xt)]),CCv(Scenario_Indx,:),'LineStyle','none'); hold on; 
    end
    ylim([-0.5 8]);
    xlim([0.5 8.5]);
    box off
    set(gca,'LineWidth',2,'Tickdir','out','XTick',[1:8],'XTickLabel',xtl,'Yminortick','on','YTick',[0:2:10],'Xminortick','off','Fontsize',16);
    ytickformat('percentage');
    xlabel('Days to second doses','Fontsize',18,'Units','normalized','position',[0.5 -0.27 0]);
    ylabel([{'Marginal benefit', state_out{Scenario_Indx}}],'Fontsize',18);
    
    text(-0.35,1.08,char(65+(Scenario_Indx-1)),'Fontsize',24,'FontWeight','bold','Units','normalized');
end
print(gcf,['Supplement_Figure_4.png'],'-dpng','-r300');    
end

