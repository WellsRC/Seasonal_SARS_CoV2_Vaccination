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
lb=[0 0 0 -4 -4 -4 -2 -2  0 0 0];
ub=[1 1 1  0  0  0  0  0  1 1 1];
rng('shuffle');
for jj=1:1
    Log_L=zeros(50000,1);

    x=repmat(lb,50000,1)+repmat(ub-lb,50000,1).*lhsdesign(50000,length(lb));
    x(:,3)=x(:,3).*x(:,2); % the efficacy needs to reduce over time
    parfor ii=1:50000
        Log_L(ii,:)=-Likelihood_Vaccine_Immunity_Under_18(x(ii,:),a_boost,b_boost,t_boost,a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_range_sd,b_range_sd,t_range_sd,N_State);
    end
    ct=1;
    while isfile(['Vaccine_Immunity_Under_18_Sample_' num2str(ct) '.mat'])
     ct=ct+1;
    end
    save(['Vaccine_Immunity_Under_18_Sample_' num2str(ct) '.mat'],"Log_L","x");
end