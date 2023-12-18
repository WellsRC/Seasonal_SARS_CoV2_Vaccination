parpool(48);

AC=[0:84];

load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');

NS=length(P_All);
R_WPv=R_WP;
num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));
Age_Dose=zeros(size(AC));
Age_Dose(AC>=50  | AC<2)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay over time: Two Dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tau_delay=28;
p_delay=0.9;
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    if(Time_Dose~=180)
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
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose;
                Parameters.Proportion_Two_Dose=Age_Dose(:);
                Parameters.Delay_Time=tau_delay;
                Parameters.X0.Two_Dose=Adjust_Initial_Conditions('Two_Dose_Campaign',Parameters,Parameters.X0.Two_Dose,[],p_delay);
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Reduced Rate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
red_vc=0.7;
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    if(Time_Dose~=180)
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
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose;
                Parameters.nu_V_Influenza.vac_rate=(1-red_vc).*Parameters.nu_V_Influenza.vac_rate;
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduced_Vaccination_Rate_' num2str(100.*red_vc) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Reduced Rate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
red_vc=0.7;
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    if(Time_Dose~=180)
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
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose;
                Parameters.X0.Two_Dose=Adjust_Initial_Conditions('Two_Dose_Campaign',Parameters,Parameters.X0.Two_Dose,Parameters.vac_int_influenza.*(1-red_vc),[]);
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Coverage_' num2str(100.*red_vc) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
        end
    end
end
