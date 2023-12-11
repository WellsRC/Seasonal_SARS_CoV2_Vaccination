clear;
load('Sample_Under_18_Vaccine_Immunity.mat','par_samp_vi_U18');
T_P=[0:0.1:365];
NS=size(par_samp_vi_U18,1);
Y_Inf=zeros(NS,length(T_P));
Y_SD=zeros(NS,length(T_P));
N_State=3;

for ii=1:size(par_samp_vi_U18,1)
    

    eps_inf=par_samp_vi_U18(ii,1:3)';
    lambda_sd=par_samp_vi_U18(ii,4:6)';
    alpha_sd=par_samp_vi_U18(ii,7:8)';
    p_sd=par_samp_vi_U18(ii,9:11)';

    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    IC=zeros(N_State,1);
    
    IC(1)=p_sd(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 365],IC, opts);
    
    Y_SD(ii,:)=pchip(T,sum(Y,2),T_P);
    Y_Inf(ii,:)=pchip(T,Y(:,1).*eps_inf(1)+Y(:,2).*eps_inf(2)+Y(:,3).*eps_inf(3),T_P);
end

save('Plot_Data_Waning_Vaccine_Immunity_Under_18.mat','Y_Inf','Y_SD','T_P');

clear;
load('Sample_18_to_59_Vaccine_Immunity.mat','par_samp_vi_18_59');
T_P=[0:0.1:365];
NS=size(par_samp_vi_18_59,1);
N_State=3;

Y_Inf=zeros(NS,length(T_P));
Y_SD=zeros(NS,length(T_P));

for ii=1:size(par_samp_vi_18_59,1)
    

    eps_inf=par_samp_vi_18_59(ii,1:3)';
    lambda_sd=par_samp_vi_18_59(ii,4:6)';
    alpha_sd=par_samp_vi_18_59(ii,7:8)';
    p_sd=par_samp_vi_18_59(ii,9:11)';

    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    IC=zeros(N_State,1);
    
    IC(1)=p_sd(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 365],IC, opts);
    
    Y_SD(ii,:)=pchip(T,sum(Y,2),T_P);
    Y_Inf(ii,:)=pchip(T,Y(:,1).*eps_inf(1)+Y(:,2).*eps_inf(2)+Y(:,3).*eps_inf(3),T_P);
end

save('Plot_Data_Waning_Vaccine_Immunity_18_59.mat','Y_Inf','Y_SD','T_P');

clear;
load('Sample_60_plus_Vaccine_Immunity.mat','par_samp_vi_60p');
T_P=[0:0.1:365];
N_State=3;
NS=size(par_samp_vi_60p,1);
Y_Inf=zeros(NS,length(T_P));
Y_SD=zeros(NS,length(T_P));

for ii=1:size(par_samp_vi_60p,1)
    

    eps_inf=par_samp_vi_60p(ii,1:3)';
    lambda_sd=par_samp_vi_60p(ii,4:6)';
    alpha_sd=par_samp_vi_60p(ii,7:8)';
    p_sd=par_samp_vi_60p(ii,9:11)';

    opts = odeset('RelTol',1e-10,'AbsTol',1e-10,'NonNegative',1:N_State);
    IC=zeros(N_State,1);
    
    IC(1)=p_sd(1);
    
    [T,Y] = ode15s(@(t,y)Immunity_Wane_ODE(t,y,lambda_sd,alpha_sd,p_sd), [0 365],IC, opts);
    
    Y_SD(ii,:)=pchip(T,sum(Y,2),T_P);
    Y_Inf(ii,:)=pchip(T,Y(:,1).*eps_inf(1)+Y(:,2).*eps_inf(2)+Y(:,3).*eps_inf(3),T_P);
end

save('Plot_Data_Waning_Vaccine_Immunity_60_plus.mat','Y_Inf','Y_SD','T_P');