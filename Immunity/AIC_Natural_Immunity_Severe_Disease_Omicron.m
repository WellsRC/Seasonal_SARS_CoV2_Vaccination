clear;
clc;
close all;
load('Natural_Immunity_Infection.mat','par_est_M','AICs','t_data','data_t');
nat_inf_dat=data_t(:,1);
t_data_nat=t_data;
est_par=par_est_M{AICs==min(AICs)};
N_State=find(AICs==min(AICs));
lambda_r_nat=10.^est_par(1:N_State)';
alpha_p_nat=10.^est_par(N_State+(1:(N_State-1)))';
if(isempty(alpha_p_nat))
    alpha_p_nat=0;
end
p_nat=est_par(2*N_State-1+(1:N_State))';

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Omicron_BA1_Severe_Disease");

t=Data_Table.DaysPost_infection;

Data_Table=Data_Table(ismember(t,[0:max(t)]),:);
t=Data_Table.DaysPost_infection;
t_data=t;
data_t=[Data_Table.val Data_Table.lower Data_Table.upper];

b=zeros(length(t),1);
a=zeros(length(t),1);
for ii=1:length(t)
    b(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),sqrt(data_t(ii,1)));
    a(ii)=b(ii).*data_t(ii,1)./(1-data_t(ii,1));
end

par_est_M=cell(1,5);
L=zeros(1,5);
AICs=zeros(1,5);
BICs=zeros(1,5);
lb1=(data_t(1,2)-p_nat(1))./(1-p_nat(1));
ub1=(data_t(1,3)-p_nat(1))./(1-p_nat(1));
for N_State=1:5
    lb=[-16.*ones(1,N_State) -16.*ones(1,N_State-1) lb1 zeros(1,(N_State-1))];
    ub=[zeros(1,N_State) zeros(1,N_State-1) ub1 ones(1,(N_State-1))];
    options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot','MaxFunctionEvaluations',7500,'UseParallel',true);
    [est_par,f_val]=surrogateopt(@(x)Likelihood_Severe_Disease(x,a,b,t,N_State,lambda_r_nat,alpha_p_nat,p_nat),lb,ub,[],[],[],[],[],options);
    
    options = optimoptions('patternsearch','Useparallel',true,'PlotFcn',@psplotbestf,'FunctionTolerance',10^(-8),'MaxIterations',5000);
    [est_par_temp,f_val_temp]=patternsearch(@(x)Likelihood_Severe_Disease(x,a,b,t,N_State,lambda_r_nat,alpha_p_nat,p_nat),est_par,[],[],[],[],lb,ub,[],options);
    
    if(f_val_temp<f_val)
        f_val=f_val_temp;
        est_par=est_par_temp;
    end
    par_est_M{N_State}=est_par;
    
    L(N_State)=-f_val;
    [AICs(N_State),BICs(N_State)]=aicbic(-f_val,length(est_par),length(a));

    figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
    lambda_r_sd=10.^est_par(1:N_State)';
    alpha_p_sd=10.^est_par(N_State+(1:(N_State-1)))';
    if(isempty(alpha_p_sd))
        alpha_p_sd=0;
    end
    p_sd=est_par(2*N_State-1+(1:N_State))';
    
    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    
    IC=zeros(length(lambda_r_nat)+N_State,1);
    
    IC(1)=p_nat(1);
    IC(length(lambda_r_nat)+1)=(1-p_nat(1)).*p_sd(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_Severe_Disease_ODE(t,y,lambda_r_nat,alpha_p_nat,p_nat,lambda_r_sd,alpha_p_sd,p_sd), [min(t) 1000],IC, opts);
    subplot(1,2,1)
    plot(T,sum(Y(:,1:length(lambda_r_nat)),2),'k','LineWidth',2); hold on;
    scatter(t_data_nat,nat_inf_dat,10,'r','filled');
    ylim([0 1]);
    title('Infection')

    subplot(1,2,2)
    plot(T,sum(Y,2),'k','LineWidth',2); hold on;
    scatter(t,data_t(:,1),10,'r','filled');
    ylim([0 1]);
    title('Severe disease')
end

save('Natural_Immunity_Severe_Disease.mat');
