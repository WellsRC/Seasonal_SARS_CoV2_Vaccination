clear;
clc;
close all;
load('Bivalent_Vaccination_Parameters.mat','par_A','Age_C','VC','fval');

Age_C_P={'Ages 0-2yrs';'Ages 12-15 yrs';'Ages 16-17 yrs';'Ages 18-24 yrs';'Ages 2-4 yrs';'Ages 25-39 yrs';'Ages 40-49 yrs';'Ages 5-11 yrs';'Ages 50-64 yrs';'Ages 65-74 yrs';'Ages 75+ yrs'};

Indx=[1 5 8 2 3 4 6 7 9 10 11];
T=readtable('National_Bivalent_Coverage.xlsx');
T=sortrows(T,1);

XT=[datenum('October 1, 2022') datenum('November 1, 2022') datenum('December 1, 2022') datenum('January 1, 2023') datenum('February 1, 2023') datenum('March 1, 2023') datenum('April 1, 2023') datenum('May 1, 2023') datenum('June 1, 2023') datenum('July 1, 2023') datenum('August 1, 2023')];
figure('units','normalized','outerposition',[0 0 1 1]);
for iix=1:length(Age_C)
    ii=Indx(iix);
    subplot('Position',[0.05+0.245.*rem(iix-1,4) 0.74-0.32.*floor((iix-1)./4) 0.20 0.23])
    t_season_age= strcmp(T.Demographic_category,Age_C{ii});
    if(sum(t_season_age)>0)
        T_temp=T(t_season_age,:);
        Vac_t=(T_temp.Coverage);
        f=find(Vac_t>0);
        if(min(f)>1)
           f=[min(f)-1;f]; 
        end
        T_Eval=unique(datenum(T_temp.Date));
        Vac_t=Vac_t(f);
        T_Eval=T_Eval(f);
        T_Run=[T_Eval(1):datenum('September 1, 2023')];
        VC(ii)=max(Vac_t);
        
        x=par_A(ii,:);
        x=10.^x;
        nu_V.vac_rate=x(1);
        X0=x(2);
        
        opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1);
        
        [TM,Y] = ode15s(@(t,x)ODE_Vac_Alt(t,x,nu_V.vac_rate), [min(T_Run) max(T_Run)], X0, opts);
        test=(sum(X0).*ones(length(TM),1)-sum(Y,2));
        
            t_plot=T_Eval;

        plot(TM,test,'k-.','LineWidth',1.5); hold on
        scatter(t_plot,Vac_t,25,'r','filled');

        title([Age_C_P{ii}])
         ylim([0 0.6])
        xlim([min(T_Run) max(T_Run)])
        box off;
        
            set(gca,'LineWidth',2,'tickdir','out','Fontsize',14)
            datetick('x','mmm','keepticks');
            
            xlabel('Month','Fontsize',16);
        
        if(rem(ii-1,4)==0)
            ylabel('Vaccination uptake','Fontsize',16)
        end
        text(-0.18,1.04,char(64+ii),'Fontsize',24,'Units','normalized')

    end
end
print(gcf,['Fit_Bivalent_Coverage.png'],'-dpng','-r600');