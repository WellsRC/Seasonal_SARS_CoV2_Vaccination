parpool(32);

AC=[0:84];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks slow waning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');

NS=length(P_All);
R_WPv=R_WP;
num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));

for ii=1:length(NSv)  
    Model_Output=cell(NSv(ii),1);
    if(ii==1)
        s_start=1;
    else
        s_start=sum(NSv(1:(ii-1)))+1;
    end
    s_end=sum(NSv(1:ii));
    Pt=P_All(s_start:s_end);
    R_WP=R_WPv(s_start:s_end);
    parfor jj=1:NSv(ii)
        Parameters=Pt{jj};
        Parameters.eps_V1=Parameters.eps_V1(end).*ones(size(Parameters.eps_V1));
        Parameters.eps_V2=Parameters.eps_V2(end).*ones(size(Parameters.eps_V2));
        Parameters.eps_V3=Parameters.eps_V3(end).*ones(size(Parameters.eps_V3));
        Parameters.q1_sd=Parameters.q1_sd(end).*ones(size(Parameters.q1_sd));
        Parameters.q2_sd=Parameters.q2_sd(end).*ones(size(Parameters.q2_sd));
        Parameters.q3_sd=Parameters.q3_sd(end).*ones(size(Parameters.q3_sd));
        Parameters.gammaV_1=Parameters.gammaV_1(end).*ones(size(Parameters.gammaV_1));
        Parameters.gammaV_2=Parameters.gammaV_2(end).*ones(size(Parameters.gammaV_2));
        Parameters.gammaV_3=Parameters.gammaV_3(end).*ones(size(Parameters.gammaV_3));
        Parameters.kappaV_1=Parameters.kappaV_1(end).*ones(size(Parameters.kappaV_1));
        Parameters.kappaV_2=Parameters.kappaV_2(end).*ones(size(Parameters.kappaV_2));
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
    end
    save(['Annual_ILC_Delay_Slow_Vaccine_Waning_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks Fast waning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');

NS=length(P_All);
R_WPv=R_WP;
num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));

for ii=1:length(NSv)  
    Model_Output=cell(NSv(ii),1);
    if(ii==1)
        s_start=1;
    else
        s_start=sum(NSv(1:(ii-1)))+1;
    end
    s_end=sum(NSv(1:ii));
    Pt=P_All(s_start:s_end);
    R_WP=R_WPv(s_start:s_end);
    parfor jj=1:NSv(ii)
        Parameters=Pt{jj};
        Parameters.eps_V1=Parameters.eps_V1(1).*ones(size(Parameters.eps_V1));
        Parameters.eps_V2=Parameters.eps_V2(1).*ones(size(Parameters.eps_V2));
        Parameters.eps_V3=Parameters.eps_V3(1).*ones(size(Parameters.eps_V3));
        Parameters.q1_sd=Parameters.q1_sd(1).*ones(size(Parameters.q1_sd));
        Parameters.q2_sd=Parameters.q2_sd(1).*ones(size(Parameters.q2_sd));
        Parameters.q3_sd=Parameters.q3_sd(1).*ones(size(Parameters.q3_sd));
        Parameters.gammaV_1=Parameters.gammaV_1(1).*ones(size(Parameters.gammaV_1));
        Parameters.gammaV_2=Parameters.gammaV_2(1).*ones(size(Parameters.gammaV_2));
        Parameters.gammaV_3=Parameters.gammaV_3(1).*ones(size(Parameters.gammaV_3));
        Parameters.kappaV_1=Parameters.kappaV_1(1).*ones(size(Parameters.kappaV_1));
        Parameters.kappaV_2=Parameters.kappaV_2(1).*ones(size(Parameters.kappaV_2));
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
    end
    save(['Annual_ILC_Delay_Fast_Vaccine_Waning_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for tau_delay=7:7:28
    for p_delay=0.3:0.3:0.9
        for ii=1:length(NSv)  
            Model_Output=cell(NSv(ii),1);
            if(ii==1)
                s_start=1;
            else
                s_start=sum(NSv(1:(ii-1)))+1;
            end
            s_end=sum(NSv(1:ii));
            Pt=P_All(s_start:s_end);
            R_WP=R_WPv(s_start:s_end);
            parfor jj=1:NSv(ii)
                Parameters=Pt{jj};
                Parameters.Delay_Time=tau_delay;
                Parameters.X0.Annual=Adjust_Initial_Conditions('Annual_Campaign',Parameters,Parameters.X0.Annual,[],p_delay);
                [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
            end
            save(['Annual_ILC_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for red_vc=0.1:0.1:0.7
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_All(s_start:s_end);
        R_WP=R_WPv(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.X0.Annual=Adjust_Initial_Conditions(Annual_Campaign,Parameters,Parameters.X0.Annual,Parameters.vac_int_influenza.*(1-red_vc),[]);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
        end   
        save(['Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced vaccine efficacy to SD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_SD=0.05:0.1:0.55
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_All(s_start:s_end);
        R_WP=R_WPv(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.q1_sd=Parameters.q1_sd.*(1-eps_SD);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
        end            
        save(['Annual_ILC_Reduced_SD_Efficacy_' num2str(100.*eps_SD) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced probability hospitalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_H=0.1:0.2:0.7
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_All(s_start:s_end);
        R_WP=R_WPv(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.prob_H=Parameters.prob_H.*(1-eps_H);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
        end            
        save(['Annual_ILC_Reduced_Prob_Hospital_' num2str(100.*eps_H) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
    end
end

