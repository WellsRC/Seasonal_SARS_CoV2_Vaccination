clear;
clc;


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Pfiezer_Booster_SD");

t_sd=Data_Table.DaysPost_vaccination;

Data_Table=Data_Table(ismember(t_sd,[0:max(t_sd)]),:);
t_sd=Data_Table.DaysPost_vaccination;
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
data_sd=Data_Table.val;

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_SD_1");
t_sd=[t_sd; Data_Table.DaysPost_vaccination];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
data_sd=[data_sd; Data_Table.val];


b_sd=zeros(length(t_sd),1);
a_sd=zeros(length(t_sd),1);
for ii=1:length(t_sd)
    b_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_sd(ii)=b_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_SD_2");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_sd_range=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_SD_3");

data_t=[data_t;Data_Table.val Data_Table.lower Data_Table.upper];
t_sd_range=[t_sd_range; Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_SD_4");

data_t=[data_t;Data_Table.val Data_Table.lower Data_Table.upper];
t_sd_range=[t_sd_range; Data_Table.Day_Start Data_Table.Day_End];

a_sd_range=zeros(size(t_sd_range,1),1);
b_sd_range=zeros(size(t_sd_range,1),1);
for ii=1:length(a_sd_range)
    b_sd_range(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_sd_range(ii)=b_sd_range(ii).*data_t(ii,1)./(1-data_t(ii,1));
end


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Pfiezer_Booster_Symptom");

t_ubnd=Data_Table.DaysPost_vaccination;

Data_Table=Data_Table(ismember(t_ubnd,[0:max(t_ubnd)]),:);
t_ubnd=Data_Table.DaysPost_vaccination;
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
y_ubnd=Data_Table.val;

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Symptom_1");

t_ubnd=[t_ubnd;Data_Table.DaysPost_vaccination];
data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
y_ubnd=[y_ubnd; Data_Table.val];


b_ubnd=zeros(length(t_ubnd),1);
a_ubnd=zeros(length(t_ubnd),1);
bnd=zeros(length(t_ubnd),2);
for ii=1:length(t_ubnd)
    b_ubnd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_ubnd(ii)=b_ubnd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

[~,var_ubnd]=betastat(a_ubnd,b_ubnd);

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Symptom_2");

t_range_ubnd=[ Data_Table.Day_Start Data_Table.Day_End];
data_t=[ Data_Table.val Data_Table.lower Data_Table.upper];
y_range_ubnd=[ Data_Table.val];


b_range_ubnd=zeros(length(t_range_ubnd),1);
a_range_ubnd=zeros(length(t_range_ubnd),1);
for ii=1:length(t_range_ubnd)
    b_range_ubnd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range_ubnd(ii)=b_range_ubnd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

[~,var_range_ubnd]=betastat(a_range_ubnd,b_range_ubnd);


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Infection_1");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_boost=Data_Table.DaysPost_vaccination;


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Infection_2");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_boost=[t_boost; Data_Table.DaysPost_vaccination];

a_boost=zeros(size(t_boost));
b_boost=zeros(size(t_boost));
for ii=1:length(t_boost)
    b_boost(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_boost(ii)=b_boost(ii).*data_t(ii,1)./(1-data_t(ii,1));
end


Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Infection_3");

data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Infection_4");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Booster_Infection_5");

data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
t_range=[t_range; Data_Table.Day_Start Data_Table.Day_End];

a_range=zeros(size(t_range,1),1);
b_range=zeros(size(t_range,1),1);
for ii=1:length(a_range)
    b_range(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
    a_range(ii)=b_range(ii).*data_t(ii,1)./(1-data_t(ii,1));
end



load('Vaccine_Immunity_Population.mat','par_est_M','AICs');
x0=par_est_M{AICs==min(AICs)};    
N_State=find(AICs==min(AICs));
lb=[zeros(1,N_State) -10.*ones(1,N_State) -2.*ones(1,N_State-1) zeros(1,N_State)];
ub=[ones(1,N_State) zeros(1,N_State) zeros(1,N_State-1) ones(1,N_State)];
LP=zeros(length(x0),1001);
par_v=zeros(length(x0),1001);

for jj=1:length(x0)
    
    r23=x0(3)./x0(2);
    par_v(jj,:)=linspace(lb(jj),ub(jj),1001);
    parfor ii=1:1001
        xt=x0;
        if(jj==2)
            xt(2)=par_v(jj,ii);
            xt(3)=xt(2).*r23;
        elseif(jj==3)
            xt(jj)=x0(2).*par_v(jj,ii);
        else
            xt(jj)=par_v(jj,ii);
        end
        LP(jj,ii)=-Likelihood_Vaccine_Immunity(xt,a_sd,b_sd,t_sd,a_sd_range,b_sd_range,t_sd_range,y_ubnd,var_ubnd,t_ubnd,y_range_ubnd,var_range_ubnd,t_range_ubnd,a_boost,b_boost,t_boost,a_range,b_range,t_range,N_State);
    end
end
    


