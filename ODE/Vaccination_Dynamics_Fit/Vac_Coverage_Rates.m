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

VC=NaN.*zeros(length(Age_C),length(Season_v));
par_A=NaN.*zeros(length(Age_C),length(Season_v),3);
for jj=1:length(Age_C)
    for ii=1:length(Season_v)
        t_season_age=strcmp(T.Season,Season_v{ii}) & strcmp(T.Age_Class,Age_C{jj});
        if(sum(t_season_age)>0)
            T_temp=T(t_season_age,:);
            Vac_t=(T_temp.Coverage)./100;
            VC(jj,ii)=Vac_t(end);
            options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot','MaxFunctionEvaluations',500,'UseParallel',true);
            [par_f,fval]=surrogateopt (@(x)Fit_Vac_Timing(x,T_Run,Vac_t,T_Eval(ismember(T_Month,T_temp.Month))),[log10(0.01) -3 -1],[log10(0.06) 2 2],options);
            par_A(jj,ii,:)=par_f;
            
        end
    end
end
rmpath(temp_cd(1:end-25));
save('Influenza_Vaccination_Parameters.mat','par_A','Age_C','Season_v','VC');