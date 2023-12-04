
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
figure('units','normalized','outerposition',[0 0 1 1]);
C=[hex2rgb('#1b9e77');
hex2rgb('#d95f02');
hex2rgb('#7570b3');
hex2rgb('#e7298a');
hex2rgb('#66a61e');
hex2rgb('#e6ab02');];
for ii=1:length(Season_v)
    subplot('Position',[0.05+0.24.*rem(ii-1,4) 0.74-0.28.*floor((ii-1)./4) 0.21 0.23])
    for jj=1:length(Age_C)
        t_season_age=strcmp(T.Season,Season_v{ii}) & strcmp(T.Age_Class,Age_C{jj});
        if(sum(t_season_age)>0)
            T_temp=T(t_season_age,:);
            Vac_t=(T_temp.Coverage)./100;
            x=par_A(jj,ii,:);            
            x=10.^x;
            nu_V.vac_rate=x(1);
            nu_V.t0=T_Run(1);
            nu_V.n=x(3);
            
            nu_V.vac_start=datenum('September 1, 2022');
            nu_V.vac_delay_start=x(2);
            X0=max(Vac_t);
            
            opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1);
            
            [TM,Y] = ode15s(@(t,x)ODE_Vac(t,x,nu_V), [min(T_Run) max(T_Run)], X0, opts);
            test=(sum(X0).*ones(length(TM),1)-sum(Y,2));
            
            t_plot=T_Eval(ismember(T_Month,T_temp.Month));

            pl(jj)=plot(TM,test,'-.','LineWidth',1.5,'Color',C(jj,:)); hold on
            scatter(t_plot,Vac_t,25,C(jj,:),'filled');
        end
    end
    title(['Season: ' Season_v{ii}])
    if(ii==12)
        legend(pl,Age_C,'NumColumns',6,'Fontsize',16,'Position',[0.238970588235294,0.053741188643859,0.560924369747898,0.037401108021298])
    end
    ylim([0 1])
    xlim([datenum('September 1, 2022') datenum('September 1, 2023')])
    box off;
    
    if(ii>8)
        set(gca,'LineWidth',2,'tickdir','out','Fontsize',14,'XTick',XT)
        datetick('x','mmm','keepticks');
        xlabel('Month','Fontsize',16);
    else
        set(gca,'LineWidth',2,'tickdir','out','Fontsize',14,'XTick',XT,'XTickLabel',[])
    end

    if(rem(ii-1,4)==0)
        ylabel('Vaccination uptake','Fontsize',16)
    end
    text(-0.13,1.04,char(64+ii),'Fontsize',24,'Units','normalized')
end
    
print(gcf,['Fit_Influenza_Coverage.png'],'-dpng','-r600');