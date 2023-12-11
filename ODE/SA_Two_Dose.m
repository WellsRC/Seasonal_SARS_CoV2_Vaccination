parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Time_Dose=180;
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Model_Output=cell(NS,1);

Age_Dose=zeros(size(AC));
Age_Dose(AC>=50 | AC<2)=1;

Vac_Camp='Two_Dose_Campaign';

for tau_delay=7:7:28
    for p_delay=0.1:0.2:0.9
        parfor jj=1:NS
            Parameters=P_All{jj};
            Parameters.Add_dose.t0=T_Run(1);
            Parameters.Add_dose.Time=Time_Dose+T_Run(1);
            Parameters.Add_dose.Age=Age_Dose;

            Parameters.Delay_Time=tau_delay;
            Parameters.X0.Annual=Adjust_Initial_Conditions(Vac_Camp,Parameters,Parameters.X0.Two_Dose,[],p_delay);
            [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
        end
        save(['Two_Dose_ILC_' num2str(Time_Dose) 'Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '.mat'],'T_Run','Model_Output','R_WP');
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
        Parameters.Add_dose.t0=T_Run(1);
        Parameters.Add_dose.Time=Time_Dose+T_Run(1);
        Parameters.Add_dose.Age=Age_Dose;

        Parameters.Delay_Time=tau_delay;
        Parameters.X0.Annual=Adjust_Initial_Conditions(Vac_Camp,Parameters,Parameters.X0.Two_Dose,Parameters.vac_int_influenza.*(1-red_vc),[]);
        [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
    end
    save(['Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) '.mat'],'T_Run','Model_Output','R_WP');
end
