
clear;
clc;
close all;
temp_cd=pwd;
addpath(temp_cd(1:end-25));
T_Eval=[datenum('August 1, 2022');datenum('September 1, 2022');datenum('October 1, 2022');datenum('November 1, 2022');datenum('December 1, 2022');datenum('January 1, 2023');datenum('February 1, 2023');datenum('March 1, 2023');datenum('April 1, 2023');datenum('May 1, 2023');datenum('June 1, 2023')];
T_Month=[7 8 9 10 11 12 1 2 3 4 5];
Age_C={'6 Months - 4 Years','5-12 Years','13-17 Years','18-49 Years','50-64 Years','65+ Years'};

T=readtable('National_Influenza_Coverage.xlsx');
T=T(T.Month~=7 & T.Month~=8,:);    
Season_v={'2010-11','2011-12','2012-13','2013-14','2014-15','2015-16','2016-17','2017-18','2018-19','2019-20','2020-21','2021-22'};
    
T_Run=[datenum('September 1, 2022'):datenum('September 1, 2023')];
XT=[datenum('September 1, 2022') datenum('October 1, 2022') datenum('November 1, 2022') datenum('December 1, 2022') datenum('January 1, 2023') datenum('February 1, 2023') datenum('March 1, 2023') datenum('April 1, 2023') datenum('May 1, 2023') datenum('June 1, 2023') datenum('July 1, 2023') datenum('August 1, 2023')];
load('Influenza_Vaccination_Parameters.mat')

C=[hex2rgb('#1b9e77');
hex2rgb('#d95f02');
hex2rgb('#7570b3');
hex2rgb('#e7298a');
hex2rgb('#66a61e');
hex2rgb('#e6ab02');];
X0_r=[0.636 0.752;0.542 0.645; 0.337 0.533; 0.269 0.384; 0.397 0.542; 0.596 0.752];
VC=zeros(1000,6,length(T_Run));
for ss=1:1000
    for jj=1:length(Age_C)
        x=squeeze(par_A(jj,:,:));            
        x=10.^x;
        nu_V.vac_rate=min(x(:,1))+(max(x(:,1))-min(x(:,1))).*rand(1);
        nu_V.t0=T_Run(1);
        nu_V.n=min(x(:,3))+(max(x(:,3))-min(x(:,3))).*rand(1);
        
        nu_V.vac_start=datenum('September 1, 2022');
        nu_V.vac_delay_start=min(x(:,2))+(max(x(:,2))-min(x(:,2))).*rand(1);
        X0=X0_r(jj,1)+(X0_r(jj,2)-X0_r(jj,1)).*rand(1);
        
        opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1);
        
        [TM,Y] = ode15s(@(t,x)ODE_Vac(t,x,nu_V), [min(T_Run) max(T_Run)], X0, opts);
        test=(sum(X0).*ones(length(TM),1)-sum(Y,2));
        VC(ss,jj,:)=100.*pchip(TM,test,T_Run);
    end
end
Age_C={'6 Months - 4 Years','5-12 Years','13-17 Years','18-49 Years','50-64 Years','65+ Years'};

XT=[datenum('September 1, 2022') datenum('October 1, 2022') datenum('November 1, 2022') datenum('December 1, 2022') datenum('January 1, 2023') datenum('February 1, 2023') datenum('March 1, 2023') datenum('April 1, 2023') datenum('May 1, 2023') datenum('June 1, 2023') datenum('July 1, 2023') datenum('August 1, 2023')];
figure('units','normalized','outerposition',[0 0.05 1 1]);
for jj=1:6
subplot('Position',[0.06+0.49.*rem(jj-1,2) 0.74-0.325.*floor((jj-1)./2) 0.44 0.22])
patch([T_Run flip(T_Run)],[prctile(squeeze(VC(:,jj,:)),2.5) flip(prctile(squeeze(VC(:,jj,:)),97.5))],'k','LineStyle','none','FaceAlpha',0.3); hold on
plot(T_Run,median(squeeze(VC(:,jj,:)),1),'k','LineWidth',2); 
plot(T_Run,mean(squeeze(VC(:,jj,:)),1),'k-.','LineWidth',2); 
set(gca,'LineWidth',2,'TickDir','out','FontSize',14,'XTick',XT)
datetick('x','mmm','keepticks');
xlabel('Month','FontSize',16);
title(Age_C{jj})
ylim([0 80]);
ytickformat('percentage')
ylabel('Vaccine uptake','FontSize',16)
text(-0.095,1.09,char(64+jj),'Fontsize',28,'Units','normalized')
end

    
print(gcf,['Uncertainty_Influenza_Coverage.png'],'-dpng','-r600');