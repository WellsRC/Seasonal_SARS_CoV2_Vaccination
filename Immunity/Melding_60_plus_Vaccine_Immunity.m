clear;
clc;
% parpool(48)
% Only have data that can properly inform the efficacy and not the severe
% disease efficacy for this specified age group 

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

% lt=[0 0 0 1 1 1 1 1 0 0 0];
lb=[0.61 0.8  0.7 -4.6 -1.   -3.2 -0.84 -5 0.87 0.95 0.43];
ub=[0.67 1    1   -4.2 -0.94 -2   -0.79 -1  0.91 1 0.55];

rng('shuffle');
for jj=1:500
    Log_L=zeros(50000,1);

    x=repmat(lb,50000,1)+repmat(ub-lb,50000,1).*lhsdesign(50000,length(lb));
%     x(:,lt==1)=log10(x(:,lt==1));
    x(:,3)=x(:,3).*x(:,2); % the efficacy needs to reduce over time
    parfor ii=1:50000
        Log_L(ii,:)=-Likelihood_Vaccine_Immunity_60_plus(x(ii,:),a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State);
    end
    ct=1;
    while isfile(['Vaccine_Immunity_60_plus_Sample_' num2str(ct) '.mat'])
     ct=ct+1;
    end
    save(['Vaccine_Immunity_60_plus_Sample_' num2str(ct) '.mat'],"Log_L","x");
end
