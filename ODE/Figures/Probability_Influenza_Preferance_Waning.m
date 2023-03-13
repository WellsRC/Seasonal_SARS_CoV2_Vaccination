function Probability_Influenza_Preferance_Waning(State_V)
close all;

if(strcmp(State_V,'Incidence'))
    jj=1;
elseif(strcmp(State_V,'Hospitalization'))
    jj=2;
elseif(strcmp(State_V,'Deaths'))
    jj=3;
end
Scenarios={'All','Large_Summer','Large_Winter'};

Title_Name={'All scenarios','Large summer peak','Large winter peak'};

CC=[hex2rgb('#000B29');hex2rgb('#E1B80D');hex2rgb('#2988BC')];

X=zeros(length(Scenarios),11);
for ss=1:length(Scenarios)
    load(['Probability_IC_Better_' Scenarios{ss} '.mat']);
    X(ss,:)=prob_IC_gamma_V(:,jj);
end

figure('units','normalized','outerposition',[0.2 0.2 0.5 0.5]);
subplot('Position',[0.103,0.153,0.87,0.782123042505593]);
hb=bar([1:11],100.*X,'LineStyle','none');
box off;
set(gca,'tickdir','out','LineWidth',2,'Fontsize',14,'YminorTick','on','XTick',[0.5:11.5],'XTickLabel',{num2str(round(bin_gamma_V)')});
xlim([0.5 11.5])
ytickformat('percentage')
ylabel('Probability annual booster preferable','Fontsize',16);
xlabel('Duration of vaccine immunity (days)','Fontsize',16);

for ss=1:length(Scenarios)
    hb(ss).FaceColor=CC(ss,:);
end
legend(Title_Name,'Fontsize',12,'Location','NorthWest');
legend boxoff;
title(State_V)

end
