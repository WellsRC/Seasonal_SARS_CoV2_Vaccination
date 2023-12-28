parpool(48);

AC=[0:84];
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_Large_Winter','T_Run');
NS=length(P_Large_Winter);

num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));
Age_Dose=zeros(size(AC));
Age_Dose(AC>=50  | AC<2)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced vaccine efficacy to SD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    for eps_SD=0.33:0.33:0.66
        for ii=1:length(NSv)  
            Model_Output=cell(NSv(ii),1);
            if(ii==1)
                s_start=1;
            else
                s_start=sum(NSv(1:(ii-1)))+1;
            end
            s_end=sum(NSv(1:ii));
            Pt=P_Large_Winter(s_start:s_end);
            
            parfor jj=1:NSv(ii)
                Parameters=Pt{jj};
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose;
                Parameters.Proportion_Two_Dose=Age_Dose(:);
                Parameters.q1_sd=Parameters.q1_sd.*(1-eps_SD);
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_SD_Efficacy_' num2str(100.*eps_SD) '_' num2str(ii) '.mat'],'T_Run','Model_Output');
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced vaccine efficacy to Infection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_INF=0.33:0.33:0.66
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_Large_Winter(s_start:s_end);
        
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.Add_dose.t0=T_Run(1);
            Parameters.Add_dose.Time=Time_Dose+T_Run(1);
            Parameters.Add_dose.Age=Age_Dose;
            Parameters.eps_V1=Parameters.eps_V1.*(1-eps_INF);
            Parameters.eps_V2=Parameters.eps_V2.*(1-eps_INF);
            Parameters.eps_V3=Parameters.eps_V3.*(1-eps_INF);
            [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
        end
        save(['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced probability hospitalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    for eps_H=0.33:0.33:0.66
        for ii=1:length(NSv)  
            Model_Output=cell(NSv(ii),1);
            if(ii==1)
                s_start=1;
            else
                s_start=sum(NSv(1:(ii-1)))+1;
            end
            s_end=sum(NSv(1:ii));
            Pt=P_Large_Winter(s_start:s_end);
            
            parfor jj=1:NSv(ii)
                Parameters=Pt{jj};
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose;
                Parameters.Proportion_Two_Dose=Age_Dose(:);
                Parameters.prob_H=Parameters.prob_H.*(1-eps_H);
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Prob_Hospital_' num2str(100.*eps_H) '_' num2str(ii) '.mat'],'T_Run','Model_Output');
        end
    end
end