function Comp_Vaccine_Coverage_vs_Waning(State_V)
close all;
State_V='Deaths';
Outcome={'Incidence','Hospitalizations','Deaths'};

t_out=strcmp(State_V,Outcome);

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];

vac_scale_influenza=[0.1:0.1:1];
vac_wane_red=[0.1:0.1:1];

figure('units','normalized','outerposition',[0.05 0.2 0.42 0.5]);

subplot('Position',[0.165,0.175,0.65,0.8]);

for ss=1:length(vac_scale_influenza)
    for vv=1:length(vac_wane_red)
        patch(100.*(vac_wane_red(vv)+[-0.05 -0.05 0.05 0.05]),100.*(vac_scale_influenza(ss)+[-0.05 0.05 0.05 -0.05]),CC(t_out,:),'facealpha',rand(1),'LineStyle','none');
    end
end
xtickformat('percentage');
ytickformat('percentage');
xlim([5 105]);
ylim([5 105]);
box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',100.*vac_wane_red,'YTick',100.*vac_scale_influenza,'fontsize',16);

xlabel('Reduction in vaccine waning rate for 65+','Fontsize',18)
ylabel({'Proportional increase in','vaccination coverage for 65+'},'Fontsize',18)

subplot('Position',[0.85,0.175,0.05,0.8]);
for ii=0:100
    patch([0 0 1 1],ii+[-0.5 0.5 0.5 -0.5],CC(t_out,:),'facealpha',ii./100,'LineStyle','none');
end
ylim([-0.5 100.5])
box on;
set(gca,'LineWidth',1.5,'XTick',[],'YTick',[]);
text(1.25,-0.5,'0','VerticalAlignment','middle','Fontsize',16);
text(1.25,100.5,'1','VerticalAlignment','middle','Fontsize',16);
text(2.25,50,{'Probability an increase in coverage','outperforms prolonging immunity'},'Rotation',270,'HorizontalAlignment','center','Fontsize',16);
end

