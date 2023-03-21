function Age_Dist_Outcomes_Compare_Summer_vs_Winter(Scenario)
close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_Large_Winter_Alt-' Scenario '.mat']);

CCS=[hex2rgb('#fddbc7'); hex2rgb('#ef8a62'); hex2rgb('#b2182b')];
CCW=[hex2rgb('#d1e5f0'); hex2rgb('#67a9cf'); hex2rgb('#2166ac')];

figure('units','normalized','outerposition',[0.2 0.025 0.25 0.9]);
subplot('Position',[0.226293103448276,0.089874857792946,0.737992610837439,0.902161547212741]);
AgeC={['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+',['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+',['0' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
C_indx=[ones(1,6) 2.*ones(1,6) 3.*ones(1,6)];
Per_Increase=zeros(1,18);

YW=zeros(18,length(xbin_edges)-1);

xt=(xbin_edges(1:end-1)+xbin_edges(2:end))./2;
min_x=Inf;
max_x=-Inf;
for jj=1:3    
    for ss=1:6
        if(jj==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            YW(ss+6.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
        elseif(jj==2)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            YW(ss+6.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
        elseif(jj==3)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            YW(ss+6.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
        end
        min_x=min(min_x,min(xbin_edges(YW(ss+6.*(jj-1),:)>0)));
        max_x=max(max_x,max(xbin_edges(YW(ss+6.*(jj-1),:)>0)));
    end
    
end


load([temp_cd 'Comparison_Summary_Large_Summer_Alt-' Scenario '.mat']);
YS=zeros(18,length(xbin_edges)-1);
for jj=1:3    
    for ss=1:6
        if(jj==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            YS(ss+6.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
            Per_Increase(ss+6.*(jj-1))=sum(YS(ss+6.*(jj-1),xt>=0))./sum(YS(ss+6.*(jj-1),:));
        elseif(jj==2)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            YS(ss+6.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
            Per_Increase(ss+6.*(jj-1))=sum(YS(ss+6.*(jj-1),xt>=0))./sum(YS(ss+6.*(jj-1),:));
        elseif(jj==3)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            YS(ss+6.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
            Per_Increase(ss+6.*(jj-1))=sum(YS(ss+6.*(jj-1),xt>=0))./sum(YS(ss+6.*(jj-1),:));
        end
        min_x=min(min_x,min(xbin_edges(YS(ss+6.*(jj-1),:)>0)));
        max_x=max(max_x,max(xbin_edges(YS(ss+6.*(jj-1),:)>0)));
    end
    
end
[~,S_indx]=sort(Per_Increase);
AgeC=AgeC(S_indx);
C_indx=C_indx(S_indx);
YS=YS(S_indx,:);
YW=YW(S_indx,:);
plot([0 0],[0.5 18.5],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
for ii=1:18
    patch(100.*([xt flip(xt)]),ii+[0.*YS(ii,:) flip(0.45.*YS(ii,:))], CCS(C_indx(ii),:),'LineStyle','none'); hold on; 
    patch(100.*([xt flip(xt)]),ii+[-0.45.*YW(ii,:) flip(0.*YW(ii,:))], CCW(C_indx(ii),:),'LineStyle','none'); hold on; 
end

ylim([0.5 18.5]);
xlim(100.*[-0.8 0.2]);
xtickformat('percentage');
set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:18],'YTickLabel',AgeC,'Yminortick','off','XTick',[-100:25:150],'Xminortick','off','Fontsize',16);
xlabel('Relative to baseline','Fontsize',20);
ylabel('Age class','Fontsize',20);

text(0.02,0.99,'Larger summer peak','Fontsize',16,'color','k','Units','normalized');
text(0.02,0.99,'__________________','Fontsize',16,'Units','normalized');
text(0.02,0.96,'Incidence','Fontsize',16,'color',CCS(1,:),'Units','normalized');
text(0.02,0.93,'Hospitalizations','Fontsize',16,'color',CCS(2,:),'Units','normalized');
text(0.02,0.90,'Death','Fontsize',16,'color',CCS(3,:),'Units','normalized');
text(0.02,0.87,'Larger winter peak','Fontsize',16,'color','k','Units','normalized');
text(0.02,0.87,'__________________','Fontsize',16,'Units','normalized');
text(0.02,0.84,'Incidence','Fontsize',16,'color',CCW(1,:),'Units','normalized');
text(0.02,0.81,'Hospitalizations','Fontsize',16,'color',CCW(2,:),'Units','normalized');
text(0.02,0.78,'Death','Fontsize',16,'color',CCW(3,:),'Units','normalized');
box off;

print(gcf,['Comparison_Summer_vs_Winter_Ranked_Age_Distributed_Outcomes_' Scenario '.png'],'-dpng','-r300');
end
