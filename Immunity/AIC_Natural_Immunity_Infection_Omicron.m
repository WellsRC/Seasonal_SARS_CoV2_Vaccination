clear;
clc;
close all;

Data_Table=readtable("Immunity_Data.xlsx","Sheet","Omicron_BA1_Reinfection");

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
[temp_poly,S]=polyfit(t(t>=497),data_t(t>=497,1),1);
t_temp=[t(end):1500];
[y_fit,delta] = polyval(temp_poly,t_temp,S);
lb_y=y_fit-2.*delta;
t_end_lb=min(t_temp(lb_y<=0));
ub_y=y_fit+2.*delta;
t_end_ub=min(t_temp(ub_y<=0));
t_end_v=t_end_lb:t_end_ub;
par_est_M=cell(1,5);
L=zeros(1,5);
AICs=zeros(1,5);
BICs=zeros(1,5);
for N_State=1:5
    lb=[-16.*ones(1,N_State) -16.*ones(1,N_State-1) data_t(1,2) zeros(1,(N_State-1))];
    ub=[zeros(1,N_State) zeros(1,N_State-1) data_t(1,3) ones(1,(N_State-1))];
    options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot','MaxFunctionEvaluations',7500,'UseParallel',true);
    [est_par,f_val]=surrogateopt(@(x)Likelihood_Reinfection(x,a,b,t,t_end_v,N_State),lb,ub,[],[],[],[],[],options);
    
    options = optimoptions('patternsearch','Useparallel',true,'PlotFcn',@psplotbestf,'FunctionTolerance',10^(-8),'MaxIterations',5000);
    [est_par_temp,f_val_temp]=patternsearch(@(x)Likelihood_Reinfection(x,a,b,t,t_end_v,N_State),est_par,[],[],[],[],lb,ub,[],options);
    
    if(f_val_temp<f_val)
        f_val=f_val_temp;
        est_par=est_par_temp;
    end
    par_est_M{N_State}=est_par;
    
    L(N_State)=-f_val;
    [AICs(N_State),BICs(N_State)]=aicbic(-f_val,length(est_par),length(a));

    figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
    lambda_r=10.^est_par(1:N_State)';
    alpha_p=10.^est_par(N_State+(1:(N_State-1)))';
    if(isempty(alpha_p))
        alpha_p=0;
    end
    p=est_par(2*N_State-1+(1:N_State))';
    
    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    
    IC=zeros(N_State,1);
    
    IC(1)=p(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_r,alpha_p,p), [min(t) t_end_v(end)],IC, opts);

    plot(T,sum(Y,2),'k','LineWidth',2); hold on;
    scatter(t,data_t(:,1),10,'r','filled');
    ylim([0 1]);
end

save('Natural_Immunity_Infection.mat');
