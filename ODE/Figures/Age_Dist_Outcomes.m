function Age_Dist_Outcomes(Scenario)
% close all;
temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];
load([temp_cd 'Comparison_Summary_' Scenario '.mat']);

CC=[hex2rgb('#EDAE01'); hex2rgb('#E94F08'); hex2rgb('#7F152E')];
figure('units','normalized','outerposition',[0.2 0.025 0.25 0.9]);
subplot('Position',[0.226293103448276,0.089874857792946,0.737992610837439,0.902161547212741]);
AgeC={['0' char(8211) '4'],['5' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+',['0' char(8211) '4'],['5' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+',['0' char(8211) '4'],['5' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+'};
C_indx=[ones(1,5) 2.*ones(1,5) 3.*ones(1,5)];
Per_Increase=zeros(1,15);
Y=zeros(15,length(xbin_edges)-1);
xt=xbin_edges(1:end-1);
min_x=Inf;
max_x=-Inf;
for jj=1:3    
    for ss=1:5
        if(jj==1)
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:));
            Y(ss+5.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Incidence_rel(ss,:)./MM;
            Per_Increase(ss+5.*(jj-1))=sum(Y(ss+5.*(jj-1),xt>=0))./sum(Y(ss+5.*(jj-1),:));
        elseif(jj==2)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:));
            Y(ss+5.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Hospital_rel(ss,:)./MM;
            Per_Increase(ss+5.*(jj-1))=sum(Y(ss+5.*(jj-1),xt>=0))./sum(Y(ss+5.*(jj-1),:));
        elseif(jj==3)    
            MM=max(Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:));
            Y(ss+5.*(jj-1),:)=Comparison.Histogram.Age_Cumulative_Count_Death_rel(ss,:)./MM;
            Per_Increase(ss+5.*(jj-1))=sum(Y(ss+5.*(jj-1),xt>=0))./sum(Y(ss+5.*(jj-1),:));
        end
        min_x=min(min_x,min(xbin_edges(Y(ss+5.*(jj-1),:)>0)));
        max_x=max(max_x,max(xbin_edges(Y(ss+5.*(jj-1),:)>0)));
    end
    
end
[~,S_indx]=sort(Per_Increase);
Per_Increase=Per_Increase(S_indx);
AgeC=AgeC(S_indx);
C_indx=C_indx(S_indx);
Y=Y(S_indx,:);
plot([0 0],[0.5 15.5],'color',[0.7 0.7 0.7],'LineWidth',2); hold on;
for ii=1:15
    patch(100.*([xbin_edges(1:end-1) flip(xbin_edges(1:end-1))]),ii+[-0.45.*Y(ii,:) flip(0.45.*Y(ii,:))], CC(C_indx(ii),:),'LineStyle','none'); hold on; 
end

ylim([0.5 15.5]);
xlim(100.*[min_x max_x+0.2]);
xtickformat('percentage');
set(gca,'LineWidth',2,'Tickdir','out','YTick',[1:15],'YTickLabel',AgeC,'Yminortick','off','XTick',[-100:25:150],'Xminortick','off','Fontsize',16);
xlabel('Relative to baseline','Fontsize',20);
ylabel('Age class','Fontsize',20);
text(0.02,0.97,'Incidence','Fontsize',16,'color',CC(1,:),'Units','normalized');
text(0.02,0.94,'Hospitalizations','Fontsize',16,'color',CC(2,:),'Units','normalized');
text(0.02,0.91,'Death','Fontsize',16,'color',CC(3,:),'Units','normalized');
box off;
for ii=1:15
   text(100.*(max_x+0.1),ii,['(' num2str(round(100.*Per_Increase(ii),1)) '%)'],'color',CC(C_indx(ii),:),'Fontsize',12,'HorizontalAlignment','center') 
end
print(gcf,['Ranked_Age_Distributed_Outcomes_' Scenario '.png'],'-dpng','-r300');
end
