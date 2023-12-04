clear;
clc;
close all;

load('Natural_Immunity_Infection.mat');
for N_State=1:5
    lb=[-16.*ones(1,N_State) -16.*ones(1,N_State-1) data_t(1,2) zeros(1,(N_State-1))];
    ub=[zeros(1,N_State) zeros(1,N_State-1) data_t(1,3) ones(1,(N_State-1))];
    x0=par_est_M{N_State};
    if(N_State>1)
        x_last=par_est_M{N_State-1};
        lambda_r=[x_last(1:(N_State-1)) x_last(N_State-1)];
        
        if(N_State==2)
            alpha_r=-16;
        else
            alpha_r=[x_last(N_State-1+[1:(N_State-2)]) -16];
        end

        p_r=[x_last(2.*N_State-2:end) 1];
        
        x0=[x0; lambda_r alpha_r p_r];
    end
    options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot','MaxFunctionEvaluations',500,'UseParallel',true,'InitialPoints',x0);
    [est_par,f_val]=surrogateopt(@(x)Likelihood_Reinfection(x,a,b,t,t_end_v,N_State),lb,ub,[],[],[],[],[],options);
    
    options = optimoptions('patternsearch','Useparallel',true,'PlotFcn',@psplotbestf,'FunctionTolerance',10^(-8),'MaxIterations',1000);
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
