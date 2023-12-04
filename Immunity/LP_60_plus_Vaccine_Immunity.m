clear;
clc;

% Only have data that can properly inform the efficacy and not the severe
% disease efficacy for this specified age group 

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_infection_3");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_boost=Data_Table.DaysPost_vaccination;

a_boost=zeros(size(t_boost));
b_boost=zeros(size(t_boost));
for ii=1:length(t_boost)
    b_boost(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_boost(ii)=b_boost(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_Infection_1");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_Infection_2");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_Infection");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_69_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_70_79_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

a_range=zeros(size(t_range,1),1);
b_range=zeros(size(t_range,1),1);
for ii=1:length(a_range)
    b_range(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range(ii)=b_range(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

% Will base the severe disease aspect on those under 50
Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_SD_1");

t_sd=[Data_Table.DaysPost_vaccination];
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
y_sd=[Data_Table.val];

a_sd=zeros(size(t_sd));
b_sd=NaN.*zeros(size(t_sd));
for ii=1:length(t_sd)
    if(data_t(ii,1)<1)
    b_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_sd(ii)=b_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
    end
end

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_Symptom_1");

t_lbnd_sd=[ Data_Table.Day_Start Data_Table.Day_End];
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
y_lbnd_sd=[ Data_Table.val];

b_lbnd_sd=zeros(size(t_lbnd_sd,1),1);
a_lbnd_sd=zeros(size(t_lbnd_sd,1),1);
for ii=1:size(t_lbnd_sd,1)
    b_lbnd_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_lbnd_sd(ii)=b_lbnd_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

[~,var_lbnd_sd]=betastat(a_lbnd_sd,b_lbnd_sd);

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_SD_1");

t_range_sd=[Data_Table.Day_Start Data_Table.Day_End];
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
y_range_sd=[Data_Table.val];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_SD_2");

t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
y_range_sd=[y_range_sd; Data_Table.val];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_SD_3");

t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
y_range_sd=[y_range_sd; Data_Table.val];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_SD");

t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
y_range_sd=[y_range_sd; Data_Table.val];


a_range_sd=zeros(size(t_range_sd,1),1);
b_range_sd=zeros(size(t_range_sd,1),1);
for ii=1:length(a_range_sd)
    b_range_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range_sd(ii)=b_range_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

N_State=3;

% % Initial
lb=[0 0 0 -8 -8 -10 -8 -16 0 0 0];
ub=[1 1 1  0  0  0   0  0  1 1 1];

x0=[0.699181370642693	0.429804234240497	0.0419183397023374	-3.81423526234578	-4.41126822977695	-1.19908963133293	-1.12907707318653	-4.93603472665191	0.914673587824714	0.542297260940506	0.310388954820732];
L=zeros(length(lb),1001);
pars=zeros(length(lb),1001);
for jj=1:length(lb)
    xt=x0;
    tempx=linspace(lb(jj),ub(jj),1001);
    pars(jj,:)=tempx;
    for yy=1:1001
        xt(jj)=tempx(yy);
        L(jj,yy)=-Likelihood_Vaccine_Immunity_60_plus(xt,a_boost,b_boost,t_boost,a_sd,b_sd,t_sd,a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_range_sd,b_range_sd,t_range_sd,N_State);
    end
end
