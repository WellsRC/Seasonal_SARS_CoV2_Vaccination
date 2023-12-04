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

par_est_M=cell(1,5);

L=zeros(1,5);
AICs=zeros(1,5);
BICs=zeros(1,5);
for N_State=5:5
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
    options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot','MaxFunctionEvaluations',10000,'UseParallel',true,'InitialPoints',par_est_M{N_State});
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


