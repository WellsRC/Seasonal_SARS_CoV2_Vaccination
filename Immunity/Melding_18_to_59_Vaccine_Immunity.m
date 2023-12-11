clear;
clc;
parpool(32);
% Only have data that can properly inform the efficacy and not the severe
% disease efficacy for this specified age group 

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_59_Booster_Infection_1");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_59_Booster_Infection");

data_t=[data_t;Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_20_29_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_30_39_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_40_49_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_50_59_Booster_Infection_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

a_range=zeros(size(t_range,1),1);
b_range=zeros(size(t_range,1),1);
for ii=1:length(a_range)
    b_range(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range(ii)=b_range(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

% Will base the severe disease aspect on those under 50


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_49_Booster_Symptom_1");

t_lbnd_sd=[Data_Table.Day_Start Data_Table.Day_End];
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
y_lbnd_sd=[Data_Table.val];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_50_64_Booster_Symptom_1");

t_lbnd_sd=[t_lbnd_sd;Data_Table.Day_Start Data_Table.Day_End];
data_t=[data_t;Data_Table.val Data_Table.lower Data_Table.upper];
y_lbnd_sd=[y_lbnd_sd;Data_Table.val];

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

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_49_Booster_SD_1");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_64_Booster_SD_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_64_Booster_SD_2");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_50_64_Booster_SD_1");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_18_59_Booster_SD");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];

a_range_sd=zeros(size(t_range_sd,1),1);
b_range_sd=zeros(size(t_range_sd,1),1);
for ii=1:length(a_range_sd)
    b_range_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range_sd(ii)=b_range_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

N_State=3;
% 0.619140625000000	1	1	-3.92187500000000	-5	-1.42968750000000	-1.19140625000000	-0.0820312500000000	0.857421875000000	0.859375000000000	0.863281250000000

% Focused
lb=[0.6   0.85  0 -3.4  -6    -1.75 -1.5 -0.2   0.825 0.75 0.35];
ub=[0.675  1    1 -2.8  -3.5  -1    -1.3  0     0.875 1    0.65];

rng('shuffle');
for jj=1:500
    Log_L=zeros(50000,1);

    x=repmat(lb,50000,1)+repmat(ub-lb,50000,1).*lhsdesign(50000,length(lb));
    x(:,3)=x(:,3).*x(:,2); % the efficacy needs to reduce over time
    parfor ii=1:50000
        Log_L(ii,:)=-Likelihood_Vaccine_Immunity_18_to_59(x(ii,:),a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State);
    end
    ct=1;
    while isfile(['Vaccine_Immunity_18_59_Sample_' num2str(ct) '.mat'])
     ct=ct+1;
    end
    save(['Vaccine_Immunity_18_59_Sample_' num2str(ct) '.mat'],"Log_L","x");
end
