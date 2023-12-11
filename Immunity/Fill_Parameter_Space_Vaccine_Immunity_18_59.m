clear;
clc;
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

load('Sample_18_to_59_Vaccine_Immunity.mat','par_samp_vi_18_59');
par_samp_vi_18_59=unique(par_samp_vi_18_59,'rows');

par_samp_vi_18_59(:,(N_State+1):(3*N_State-1))=log10(par_samp_vi_18_59(:,(N_State+1):(3*N_State-1)));

lb=[0.6   0.85  0 -5 -6    -4    -4  -0.5    0.825 0.75 0.1];
ub=[0.675  1    1 -2.8  0  -1    -1.1  0     1     1    1];


L_old=zeros(size(par_samp_vi_18_59,1),1);
parfor ii=1:size(par_samp_vi_18_59,1)
    L_old(ii)=-Likelihood_Vaccine_Immunity_18_to_59(par_samp_vi_18_59(ii,:),a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State);
end
[~,s_indx]=sort(L_old,'descend');
par_samp_vi_18_59=par_samp_vi_18_59(s_indx,:);
L_old=L_old(s_indx,:);

% Filter out as many as possilbe
% par_samp_vi_18_59=par_samp_vi_18_59(1:9:9001,:);
% L_old=L_old(1:9:9001,:);

NS=10^6;

new_samp=zeros(NS,length(lb));
L_new=zeros(NS,1);
for jj=1:(NS/100)
    par_samp_vi_18_59_trim=par_samp_vi_18_59(randi(size(par_samp_vi_18_59,1),100,1),:);
    new_samp([(1+100.*(jj-1)):100.*jj],:)=par_samp_vi_18_59_trim.*(1+0.02.*(0.5-rand(size(par_samp_vi_18_59_trim)))); % Take a little broader to expand the space
end

for jj=4:8
    f=find(new_samp(:,jj)>0);
    new_samp(f,jj)=lb(jj)+(ub(jj)-lb(jj)).*rand(size(f));
end
for jj=1:3
    f=find(new_samp(:,jj)>1 | new_samp(:,jj)<0 );
    new_samp(f,jj)=rand(size(f));
end
for jj=9:11
    f=find(new_samp(:,jj)>1 | new_samp(:,jj)<0 );
    new_samp(f,jj)=rand(size(f));
end

       
parfor jj=1:NS
   L_new(jj)=-Likelihood_Vaccine_Immunity_18_to_59(new_samp(jj,:),a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State);
end 

L=[L_new;L_old];
par_samp=[new_samp;par_samp_vi_18_59];


save('Vaccine_Immunity_18_59_Filler.mat','par_samp','L');