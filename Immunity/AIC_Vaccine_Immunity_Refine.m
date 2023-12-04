clear;
clc;
load('Vaccine_Immunity_Population.mat');
for N_State=1:5
    lb=[0 zeros(1,N_State-1) -16.*ones(1,N_State) -16.*ones(1,N_State-1) zeros(1,N_State)];
    ub=[1 ones(1,N_State-1) zeros(1,N_State) zeros(1,N_State-1) ones(1,N_State)];
    
    A_c=[];
    b_c=[];
    if(N_State>2)
        A_c=zeros(N_State-2,length(lb));
        for jj=1:N_State-2
            A_c(jj,jj+1)=-1;
            A_c(jj,jj+2)=1;
        end
        b_c=zeros(N_State-2,1);
    end

    x0=par_est_M{N_State};
    if(N_State>1)
        N_State_t=N_State-1;
        xt=par_est_M{N_State_t};
        eps_0=xt(1);
        if(N_State_t>1)
            p_red=[xt(2:(N_State_t))];
            if(N_State_t>2)
                p_red=[p_red(1:end-1) p_red(end-1) p_red(end)];
            else
                p_red=[p_red p_red];
            end
        else
            p_red=0;
        end
        
        lambda_sd=[xt((N_State_t)+(1:N_State_t))] ;
        if(N_State_t>1)
            lambda_sd=[lambda_sd(1:end-1) lambda_sd(end-1) lambda_sd(end)];
        else
            lambda_sd=[lambda_sd lambda_sd];
        end
        if(N_State_t>1)
            alpha_sd=[xt(2.*N_State_t+(1:(N_State_t-1)))];
            alpha_sd=[alpha_sd alpha_sd(end)];
        else
            alpha_sd=-16;
        end
        p_sd=[xt(3*N_State_t-1+(1:N_State_t))];
        p_sd=[p_sd(1:end-1) 1 p_sd(end)];
       
        x0=[x0; eps_0 p_red lambda_sd alpha_sd p_sd];
    end

    options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot','MaxFunctionEvaluations',750,'UseParallel',true,'InitialPoints',par_est_M{N_State});
    [est_par,f_val]=surrogateopt(@(x)Likelihood_Vaccine_Immunity(x,a_sd,b_sd,t_sd,a_sd_range,b_sd_range,t_sd_range,y_ubnd,var_ubnd,t_ubnd,y_range_ubnd,var_range_ubnd,t_range_ubnd,a_boost,b_boost,t_boost,a_range,b_range,t_range,N_State),lb,ub,[],[],[],A_c,b_c,options);
    
    options = optimoptions('patternsearch','Useparallel',true,'PlotFcn',@psplotbestf,'FunctionTolerance',10^(-8),'MaxIterations',5000);
    [est_par_temp,f_val_temp]=patternsearch(@(x)Likelihood_Vaccine_Immunity(x,a_sd,b_sd,t_sd,a_sd_range,b_sd_range,t_sd_range,y_ubnd,var_ubnd,t_ubnd,y_range_ubnd,var_range_ubnd,t_range_ubnd,a_boost,b_boost,t_boost,a_range,b_range,t_range,N_State),est_par,[],[],A_c,b_c,lb,ub,[],options);
    
    if(f_val_temp<f_val)
        f_val=f_val_temp;
        est_par=est_par_temp;
    end
    par_est_M{N_State}=est_par;
    
    L(N_State)=-f_val;
    [AICs(N_State),BICs(N_State)]=aicbic(-f_val,length(est_par),length(a_sd)+length(var_ubnd));

    figure('units','normalized','outerposition',[0.2 0.2 0.5 0.6]);
    eps_0=est_par(1);
    if(N_State>1)
        p_red=est_par(1+(1:(N_State-1)));
        eps_inf=eps_0.*[1;(p_red(:))];
    else
        eps_inf=eps_0;
    end
    
    lambda_sd=10.^est_par((N_State)+(1:N_State))';
    alpha_sd=10.^est_par(2.*N_State+(1:(N_State-1)))';
    if(isempty(alpha_sd))
        alpha_sd=0;
    end
    p_sd=est_par(3*N_State-1+(1:N_State))';
    
    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    IC=zeros(N_State,1);
    
    IC(1)=p_sd(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 365],IC, opts);
    
    
    y_raw=zeros(size(T));
    for ii=1:N_State
        y_raw=y_raw+eps_inf(ii).*Y(:,ii);
    end
    subplot(2,1,1);
    plot(T,y_raw,'k','LineWidth',2)
    ylim([0 1]);
    box off;
    title('Infection')
    subplot(2,1,2);
    plot(T,sum(Y,2),'k','LineWidth',2); hold on
    scatter(t_sd,data_sd,5,'r','filled')
    ylim([0 1]);
    box off;
    title('Severe disease')

end

save('Vaccine_Immunity_Population.mat');


