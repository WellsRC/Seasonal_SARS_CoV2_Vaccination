parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
for dd=1:4
    Model_Output=cell(NS,1);
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.Delay_Time=7.*dd;
        [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Influenza_Like_Coverage_Delay_' num2str(7.*dd) '_days.mat'],'T_Run','Model_Output','R_WP');
end

Vac_Camp='SA_Annual_Campaign';
for dd=1:4
    Model_Output=cell(NS,1);
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.vac_SA=Pt.vac_baseline;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        Pt.Delay_Time=7.*dd;
        [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Baseline_Coverage_Delay_' num2str(7.*dd) '_days.mat'],'T_Run','Model_Output','R_WP');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run')
NS=length(P_All);
for dd=1:4
    Model_Output=cell(NS,1);
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.Delay_Time=7.*dd;
        [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Influenza_Like_Coverage_Delay_' num2str(7.*dd) '_days_Unimodal_Winter.mat'],'T_Run','Model_Output');
end

Vac_Camp='SA_Annual_Campaign';
for dd=1:4
    Model_Output=cell(NS,1);
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.vac_SA=Pt.vac_baseline;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        Pt.Delay_Time=7.*dd;
        [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Baseline_Coverage_Delay_' num2str(7.*dd) '_days_Unimodal_Winter.mat'],'T_Run','Model_Output');
end