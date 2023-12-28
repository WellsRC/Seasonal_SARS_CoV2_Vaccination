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
% Bimodal peaks reduced coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for red_vc=0.33:0.33:0.66
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
            Parameters.X0.Annual=Adjust_Initial_Conditions('Annual_Campaign',Parameters,Parameters.X0.Annual,Parameters.vac_int_influenza.*(1-red_vc),[]);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
        end   
        save(['Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) '_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks Increase overall efficacy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for eps_INC=0.33:0.33:0.66
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
            Parameters.q1_sd=Parameters.q1_sd+eps_INC.*(1-Parameters.q1_sd);

            Parameters.eps_V1=Parameters.eps_V1+eps_INC.*(1-Parameters.q1_sd);
            Parameters.eps_V2=Parameters.eps_V2+eps_INC.*(1-Parameters.q1_sd);
            Parameters.eps_V3=Parameters.eps_V3+eps_INC.*(1-Parameters.q1_sd);
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
        end            
        save(['Annual_ILC_Increased_Overall_Efficacy_' num2str(100.*eps_INC) '_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reduced transmission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for red_tran=0.05:0.05:0.1
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
                Parameters.beta_I.beta_max=(1-red_tran).*Parameters.beta_I.beta_max;
                Parameters.beta_I.beta_min=(1-red_tran).*Parameters.beta_I.beta_min;
            [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
            end
            save(['Annual_ILC_Reduced_Transmission_' num2str(100.*red_tran) '_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end
