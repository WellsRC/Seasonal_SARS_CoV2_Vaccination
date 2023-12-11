clear;
clc;


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


npar_inf=3*N_State_Inf-1;
load('Sample_Natural_Immunity.mat','par_samp_ni');
par_samp_ni=unique(par_samp_ni,'rows');

par_samp_ni(:,1:(2*N_State_Inf-1))=log10(par_samp_ni(:,1:(2*N_State_Inf-1)));
par_samp_ni(:,(npar_inf+1):(npar_inf+2*N_State_SD-1))=log10(par_samp_ni(:,(npar_inf+1):(npar_inf+2*N_State_SD-1)));

lb=[-3 -16 -8 -8 -5  0.55 0  0 -22 -16 -2.5 0.65 0];
ub=[-2  0   0  0  0  0.85 1  1 -6   0  -0   0.9 1];


L_old=zeros(size(par_samp_ni,1),1);
parfor ii=1:size(par_samp_ni,1)
    L_old(ii)=-Likelihood_Combined_Natural_Immunity(par_samp_ni(ii,:),a_inf,b_inf,t_inf,t_end_v,a_sd,b_sd,t_sd,N_State_Inf,N_State_SD); % minus as the objective function is set up to optimize wrt minimization of the negative log-likelihood
end

NS=10^6;

new_samp=zeros(NS,length(lb));
L_new=zeros(NS,1);
for jj=1:(NS/1000)
    par_samp_ni_trim=par_samp_ni(randi(size(par_samp_ni,1),1000,1),:);
    new_samp([(1+1000.*(jj-1)):1000.*jj],:)=par_samp_ni_trim.*(1+0.02.*(0.5-rand(size(par_samp_ni_trim))));
end

for jj=1:5
    f=find(new_samp(:,jj)>0);
    new_samp(f,jj)=lb(jj)+(ub(jj)-lb(jj)).*rand(size(f));
end
for jj=6:8
    f=find(new_samp(:,jj)>1 | new_samp(:,jj)<0 );
    new_samp(f,jj)=rand(size(f));
end
for jj=9:11
    f=find(new_samp(:,jj)>0);
    new_samp(f,jj)=lb(jj)+(ub(jj)-lb(jj)).*rand(size(f));
end
for jj=12:13
    f=find(new_samp(:,jj)>1 | new_samp(:,jj)<0 );
    new_samp(f,jj)=rand(size(f));
end

       
parfor jj=1:NS
   L_new(jj)=-Likelihood_Combined_Natural_Immunity(new_samp(jj,:),a_inf,b_inf,t_inf,t_end_v,a_sd,b_sd,t_sd,N_State_Inf,N_State_SD); % minus as the objective function is set up to optimize wrt minimization of the negative log-likelihood
end 

L=[L_new;L_old];
par_samp=[new_samp;par_samp_ni];


save('Natural_Immunity_Filler.mat','par_samp','L');