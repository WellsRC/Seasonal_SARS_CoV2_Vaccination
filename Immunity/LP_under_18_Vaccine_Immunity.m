clear;
clc;
% parpool(32);
% Only have data that can properly inform the efficacy and not the severe
% disease efficacy for this specified age group 

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_to_11_Booster_Infection_1");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_boost=Data_Table.DaysPost_vaccination;

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_to_11_Booster_Infection_3");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_boost=[t_boost; Data_Table.DaysPost_vaccination];

a_boost=zeros(size(t_boost));
b_boost=zeros(size(t_boost));
for ii=1:length(t_boost)
    b_boost(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_boost(ii)=b_boost(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_to_11_Booster_Infection_2");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_to_11_Booster_Infection_4");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_to_11_Booster_Infection_5");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_10_19_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

a_range=zeros(size(t_range,1),1);
b_range=zeros(size(t_range,1),1);
for ii=1:length(a_range)
    b_range(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range(ii)=b_range(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

% Will base the severe disease aspect on those under 50

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_11_Booster_Symptom_1");

t_lbnd_sd=[Data_Table.Day_Start Data_Table.Day_End];
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
y_lbnd_sd=[Data_Table.val];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_5_11_Booster_Symptom_2");

t_lbnd_sd=[t_lbnd_sd; Data_Table.Day_Start Data_Table.Day_End];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
y_lbnd_sd=[y_lbnd_sd; Data_Table.val];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_12_17_Booster_Symptom_1");

t_lbnd_sd=[t_lbnd_sd; Data_Table.Day_Start Data_Table.Day_End];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
y_lbnd_sd=[y_lbnd_sd; Data_Table.val];

b_lbnd_sd=zeros(size(t_lbnd_sd,1),1);
a_lbnd_sd=zeros(size(t_lbnd_sd,1),1);
for ii=1:size(t_lbnd_sd,1)
    b_lbnd_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_lbnd_sd(ii)=b_lbnd_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

[~,var_lbnd_sd]=betastat(a_lbnd_sd,b_lbnd_sd);

a_lbnd_sd=zeros(length(var_lbnd_sd),1001);
b_lbnd_sd=zeros(length(var_lbnd_sd),1001);
x_ref=10.^linspace(-16,0,1001);

for ii=1:length(var_lbnd_sd)
    parfor jj=1:1001
        [est]=lsqnonlin(@(z)([z(1)./sum(z) (z(1).*z(2))./((sum(z)+1).*sum(z).^2) ]- [x_ref(jj) var_lbnd_sd(ii)]),[3.*x_ref(jj)./(1-x_ref(jj)) 3],[0 0],[1000 1000]);
        a_lbnd_sd(ii,jj)=est(1);
        b_lbnd_sd(ii,jj)=est(2);
    end
end


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_12_15_Booster_SD_1");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_12_18_Vaccine_SD_2");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];


a_range_sd=zeros(size(t_range_sd,1),1);
b_range_sd=zeros(size(t_range_sd,1),1);
for ii=1:length(a_range_sd)
    b_range_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range_sd(ii)=b_range_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

N_State=3;

% % Initial
lb=[0.65   0.75  0 -5.5 -7 -5 -0.6 -2   0.7 0.9 0];
ub=[0.75   0.9   1 -2.8 -2  0 -0.2 -0.5 0.8 1   1];

x0=[0.700976562500000	0.818164062500000	0.818164062500000	-4.09277343750000	-3.96875000000000	-5	-0.363281250000000	-1.04824218750000	0.753710937500000	0.999218750000000	0.439257812500000];
L=zeros(length(lb),1001);
pars=zeros(length(lb),1001);
r23=x0(2)./x0(3);
for jj=1:length(lb)
    
    tempx=linspace(lb(jj),ub(jj),1001);
    pars(jj,:)=tempx;
    parfor yy=1:1001
        xt=x0;
        if(jj==2)
            xt(2)=pars(jj,yy);
            xt(3)=xt(2).*r23;
        elseif(jj==3)
            xt(jj)=x0(2).*pars(jj,yy);
        else
            xt(jj)=pars(jj,yy);
        end
        L(jj,yy)=-Likelihood_Vaccine_Immunity_Under_18(xt,a_boost,b_boost,t_boost,a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State);
    end
end

