parpool(48);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_Large_Winter','T_Run');
    NS=length(P_Large_Winter);
    R_WPv=R_WP;
    num_l=ceil(NS./1000);
    NSv=1000.*ones(num_l,1);
    NSv(end)=NS-sum(NSv(1:end-1));
    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=65)=1;
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_Large_Winter(s_start:s_end);
        R_WP=R_WPv(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.Add_dose.t0=T_Run(1);
            Parameters.Add_dose.Time=Time_Dose+T_Run(1);
            Parameters.Add_dose.Age=Age_Dose;
            Parameters.Proportion_Two_Dose=Age_Dose(:);
            [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
        end
        save(['Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end
