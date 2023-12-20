% clear;
% clc;
% 
% % Only have data that can properly inform the efficacy and not the severe
% % disease efficacy for this specified age group 
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_Infection_1");
% 
% data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
% t_range=[Data_Table.Day_Start Data_Table.Day_End];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_Infection_2");
% 
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_Infection");
% 
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_69_Booster_Infection_1");
% 
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_70_79_Booster_Infection_1");
% 
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% t_range=[t_range;Data_Table.Day_Start Data_Table.Day_End];
% 
% a_range=zeros(size(t_range,1),1);
% b_range=zeros(size(t_range,1),1);
% for ii=1:length(a_range)
%     b_range(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
%     a_range(ii)=b_range(ii).*data_t(ii,1)./(1-data_t(ii,1));
% end
% 
% 
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_Symptom_1");
% 
% t_lbnd_sd=[ Data_Table.Day_Start Data_Table.Day_End];
% data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
% y_lbnd_sd=[ Data_Table.val];
% 
% b_lbnd_sd=zeros(size(t_lbnd_sd,1),1);
% a_lbnd_sd=zeros(size(t_lbnd_sd,1),1);
% for ii=1:size(t_lbnd_sd,1)
%     b_lbnd_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
%     a_lbnd_sd(ii)=b_lbnd_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
% end
% 
% [~,var_lbnd_sd]=betastat(a_lbnd_sd,b_lbnd_sd);
% 
% 
% a_lbnd_sd=zeros(length(var_lbnd_sd),1001);
% b_lbnd_sd=zeros(length(var_lbnd_sd),1001);
% x_ref=10.^linspace(-16,0,1001);
% 
% for ii=1:length(var_lbnd_sd)
%     parfor jj=1:1001
%         [est]=lsqnonlin(@(z)([z(1)./sum(z) (z(1).*z(2))./((sum(z)+1).*sum(z).^2) ]- [x_ref(jj) var_lbnd_sd(ii)]),[3.*x_ref(jj)./(1-x_ref(jj)) 3],[0 0],[1000 1000]);
%         a_lbnd_sd(ii,jj)=est(1);
%         b_lbnd_sd(ii,jj)=est(2);
%     end
% end
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_SD_1");
% 
% t_range_sd=[Data_Table.Day_Start Data_Table.Day_End];
% data_t=[Data_Table.val Data_Table.lower Data_Table.upper];
% y_range_sd=[Data_Table.val];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_SD_2");
% 
% t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% y_range_sd=[y_range_sd; Data_Table.val];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_65_plus_Booster_SD_3");
% 
% t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% y_range_sd=[y_range_sd; Data_Table.val];
% 
% Data_Table=readtable("Immunity_Data.xlsx","Sheet","Age_60_plus_Booster_SD");
% 
% t_range_sd=[t_range_sd; Data_Table.Day_Start Data_Table.Day_End];
% data_t=[data_t; Data_Table.val Data_Table.lower Data_Table.upper];
% y_range_sd=[y_range_sd; Data_Table.val];
% 
% 
% a_range_sd=zeros(size(t_range_sd,1),1);
% b_range_sd=zeros(size(t_range_sd,1),1);
% for ii=1:length(a_range_sd)
%     b_range_sd(ii)=lsqnonlin(@(x)100.*betainv([0.025 0.975],x.*data_t(ii,1)./(1-data_t(ii,1)),x)-100.*data_t(ii,2:3),2);
%     a_range_sd(ii)=b_range_sd(ii).*data_t(ii,1)./(1-data_t(ii,1));
% end
% 
% N_State=3;
% 
% % % Initial
% lb=[0.65   0    0   -3.1 -0.5 -2.25 -0.3 -2   0.9 0.4 0.7];
% ub=[0.8   0.7  0.8  -2.7  0   -1.25  0    0   1   0.7 1];
% 
% lb=[0 0 0 -8 -8 -8 -8 -8 0 0 0];
% ub=[1 1 1 0 0 0 0 0 1 1 1];
% 
% x0=[0.733741796940089	0.0921732565922888	0.0753898812277491	-2.87975550702380	-0.0909638719272030	-1.71141505068677	-0.114146516070519	-0.258550538419471	0.949705604603497	0.562688110125544	0.850731992033693];
% 
% 
%     A_c=[];
%     b_c=[];
%     if(N_State>2)
%         A_c=zeros(N_State-2,length(lb));
%         for jj=1:N_State-2
%             A_c(jj,jj+1)=-1;
%             A_c(jj,jj+2)=1;
%         end
%         b_c=zeros(N_State-2,1);
%     end
% 
% options = optimoptions('patternsearch','Useparallel',true,'PlotFcn',@psplotbestf,'FunctionTolerance',10^(-8),'MaxIterations',5000);
%     [est_par_temp,f_val_temp]=patternsearch(@(x)Likelihood_Vaccine_Immunity_60_plus(x,a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State),x0,[],[],A_c,b_c,lb,ub,[],options);
%     
L=zeros(length(lb),1001);
pars=zeros(length(lb),1001);
x0=est_par_temp;
r23=x0(2)./x0(3);
lb=[0.61 0.8  0.7 -4.6 -1.   -3.2 -0.95 -5 0.87 0.95 0.43];
ub=[0.67 1    1   -4.2 -0.94 -2   -0.7 -1  0.91 1 0.55];
for jj=1:length(lb)
    tempx=linspace(lb(jj),ub(jj),1001);
    pars(jj,:)=tempx;
    parfor yy=1:1001

        xt=x0;
        if(jj==2)
            xt(2)=pars(jj,yy);
            xt(3)=xt(2).*r23;
        elseif(jj==3)
            xt(jj)=x0(2).*pars(jj,yy);
        else
            xt(jj)=pars(jj,yy);
        end
        xt(jj)=tempx(yy);
        L(jj,yy)=-Likelihood_Vaccine_Immunity_60_plus(xt,a_range,b_range,t_range,t_lbnd_sd,y_lbnd_sd,var_lbnd_sd,a_lbnd_sd,b_lbnd_sd,x_ref,a_range_sd,b_range_sd,t_range_sd,N_State);
    end
end
