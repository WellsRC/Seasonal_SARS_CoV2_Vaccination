parpool(32);

AC=[0:84];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Model_Output=cell(NS,1);

for tau_delay=7:7:28
    for p_delay=0.1:0.2:0.9
        parfor jj=1:NS
            Parameters=P_All{jj};
            Parameters.Delay_Time=tau_delay;
            Parameters.X0.Annual=Adjust_Initial_Conditions(Vac_Camp,Parameters,Parameters.X0.Annual,[],p_delay);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,P_All{jj});
        end
        save(['Annual_ILC_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '.mat'],'T_Run','Model_Output','R_WP');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Model_Output=cell(NS,1);

for red_vc=0.1:0.1:0.5
    parfor jj=1:NS
        Parameters=P_All{jj};
        Parameters.Delay_Time=tau_delay;
        Parameters.X0.Annual=Adjust_Initial_Conditions(Vac_Camp,Parameters,Parameters.X0.Annual,Parameters.vac_int_influenza.*(1-red_vc),[]);
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,P_All{jj});
    end
    save(['Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) '.mat'],'T_Run','Model_Output','R_WP');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Model_Output=cell(NS,1);

for eps_SD=0.05:0.1:0.5
    parfor jj=1:NS
        Parameters=P_All{jj};
        Parameters.Delay_Time=tau_delay;
        Parameters.X0.Annual=Adjust_Initial_Conditions(Vac_Camp,Parameters,Parameters.X0.Annual,Parameters.vac_int_influenza.*(1-red_vc),[]);
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,P_All{jj});
    end
    save(['Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) '.mat'],'T_Run','Model_Output','R_WP');
end
