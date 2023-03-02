clear;
clc;
close all;

Age_C={'Ages_0-2yrs';'Ages_12-15_yrs';'Ages_16-17_yrs';'Ages_18-24_yrs';'Ages_2-4_yrs';'Ages_25-39_yrs';'Ages_40-49_yrs';'Ages_5-11_yrs';'Ages_50-64_yrs';'Ages_65-74_yrs';'Ages_75+_yrs'};

T=readtable('National_Bivalent_Coverage.xlsx');
T=sortrows(T,1);

VC=NaN.*zeros(length(Age_C),1);
par_A=NaN.*zeros(length(Age_C),2);
fval=NaN.*zeros(1,length(Age_C));
for jj=1:length(Age_C)
    t_season_age= strcmp(T.Demographic_category,Age_C{jj});
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
        VC(jj)=max(Vac_t);
        
        options = optimoptions('fmincon','OptimalityTolerance',10^(-12),'StepTolerance',10^(-12));
        vv=max(Vac_t).*1.01;
        x0=[-log((vv-max(Vac_t))./vv)./(T_Eval(end)-T_Eval(1)) vv];
        [par_f,fval(jj)]=fmincon (@(x)Fit_Vac_Timing_Alt(x,T_Run,Vac_t,T_Eval),x0,[],[],[],[],[log10(0.0001) log10(max(Vac_t))],[log10(0.2) log10(0.8)],[],options);
        par_A(jj,:)=par_f;

    end
end
save('Bivalent_Vaccination_Parameters.mat','par_A','Age_C','VC','fval');