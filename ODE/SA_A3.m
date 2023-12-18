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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced vaccine efficacy to SD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_SD=0.15:0.2:0.55
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
% Bimodal peaks reduced vaccine efficacy to Infection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_INF=0.15:0.2:0.55
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
            Parameters.eps_V1=Parameters.eps_V1.*(1-eps_INF);
            Parameters.eps_V2=Parameters.eps_V2.*(1-eps_INF);
            Parameters.eps_V3=Parameters.eps_V3.*(1-eps_INF);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
        end            
        save(['Annual_ILC_Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks reduced probability hospitalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_H=0.15:0.3:0.75
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

