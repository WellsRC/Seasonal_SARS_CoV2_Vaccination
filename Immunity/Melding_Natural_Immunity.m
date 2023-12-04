clear;
clc;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% Infection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
Data_Table=readtable("Immunity_Data.xlsx","Sheet","Omicron_BA1_Reinfection");

t_inf=Data_Table.DaysPost_infection;

Data_Table=Data_Table(ismember(t_inf,[0:max(t_inf)]),:);
t_inf=Data_Table.DaysPost_infection;
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];

b_inf=zeros(length(t_inf),1);
a_inf=zeros(length(t_inf),1);
for ii=1:length(t_inf)
    b_inf(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),sqrt(data_t(ii,1)));
    a_inf(ii)=b_inf(ii).*data_t(ii,1)./(1-data_t(ii,1));
end
[temp_poly,S]=polyfit(t_inf(t_inf>=497),data_t(t_inf>=497,1),1);
t_temp=[t_inf(end):1500];
[y_fit,delta] = polyval(temp_poly,t_temp,S);
lb_y=y_fit-2.*delta;
t_end_lb=min(t_temp(lb_y<=0));
ub_y=y_fit+2.*delta;
t_end_ub=min(t_temp(ub_y<=0));
t_end_v=t_end_lb:t_end_ub;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% Severe disease
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Omicron_BA1_Severe_Disease");

t_sd=Data_Table.DaysPost_infection;

Data_Table=Data_Table(ismember(t_sd,[0:max(t_sd)]),:);
t_sd=Data_Table.DaysPost_infection;
t_data=t_sd;
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];

b_sd=zeros(length(t_sd),1);
a_sd=zeros(length(t_sd),1);
for ii=1:length(t_sd)
    b_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),sqrt(data_t(ii,1)));
    a_sd(ii)=b_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Number of states
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
load('Natural_Immunity_Infection.mat','AICs');
N_State_Inf=find(AICs==min(AICs));
load('Natural_Immunity_Severe_Disease.mat','AICs');
N_State_SD=find(AICs==min(AICs));

% Initial
lb=[-3 -16 -8 -8 -5  0.55 0  0 -22 -16 -2.5 0.65 0];
ub=[-2  0   0  0  0  0.85 1  1 -6   0  -0   0.9 1];
rng('shuffle');
for jj=1:500
    Log_L=zeros(50000,1);

    x=repmat(lb,50000,1)+repmat(ub-lb,50000,1).*lhsdesign(50000,length(lb));
    for ii=1:50000
        Log_L(ii,:)=-Likelihood_Combined_Natural_Immunity(x(ii,:),a_inf,b_inf,t_inf,t_end_v,a_sd,b_sd,t_sd,N_State_Inf,N_State_SD); % minus as the objective function is set up to optimize wrt minimization of the negative log-likelihood
    end
    ct=1;
    while isfile(['Natural_Immunity_Sample_' num2str(ct) '.mat'])
     ct=ct+1;
    end
    save(['Natural_Immunity_Sample_' num2str(ct) '.mat'],"Log_L","x");
end