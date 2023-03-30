function Averted_Additional_Doses()
close all;

State_V='Deaths';

CCv=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];


Outcome={'Incidence','Hospitalizations','Deaths'};
t_out=strcmp(State_V,Outcome);
CC=CCv(t_out,:);

rr=zeros(1000,6);
for ii=1:6
   rr(:,ii)=normrnd(10+7.*rand(1),8.*rand(1),1000,1).^2; 
end
lb1=prctile(rr,2.5);
lb2=prctile(rr,25);
m=prctile(rr,50);
ub2=prctile(rr,75);
ub1=prctile(rr,97.5);


lb_Age=[0 5 13 18 50 65];
ub_Age=[5 13 18 50 65 85];
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
figure('units','normalized','outerposition',[0.2 0.2 0.3 0.45]);
subplot('Position',[0.19,0.265,0.785,0.695]);
for ii=1:6
   patch(ii+[-0.45 -0.45 0.45 0.45],[lb1(ii) ub1(ii) ub1(ii) lb1(ii)],CC,'LineStyle','none','FaceAlpha',0.25); hold on
   patch(ii+[-0.45 -0.45 0.45 0.45],[lb2(ii) ub2(ii) ub2(ii) lb2(ii)],CC,'LineStyle','none','FaceAlpha',0.5);
   plot(ii+[-0.45 0.45],[m(ii) m(ii)],'color',CC,'LineWidth',2.5);
end
grid on
xlim([0.5 6.5]);
box off;
set(gca,'LineWidth',2,'tickdir','out','XTick',[1:6],'XTickLabel',AgeC,'Fontsize',16)
xtickangle(90);
xlabel('Age class receiving additional doses','Fontsize',18);
ylabel({[State_V],'averted per vaccine'},'Fontsize',18);
end

