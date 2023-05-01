parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Model_Output=cell(NS,1);

parfor jj=1:NS
    [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,P_All{jj});
end
save(['Annual_Campaign_Influenza_Like_Coverage.mat'],'T_Run','Model_Output','R_WP');


Model_Output=cell(NS,1);
Vac_Camp='SA_Annual_Campaign';
parfor jj=1:NS
    Pt=P_All{jj};
    Pt.vac_SA=Pt.vac_baseline;
    Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
    [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
end
save(['Annual_Campaign_Baseline_Coverage.mat'],'T_Run','Model_Output','R_WP');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run')
NS=length(P_All);
Model_Output=cell(NS,1);

parfor jj=1:NS
    [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,P_All{jj});
end
save(['Annual_Campaign_Influenza_Like_Coverage_Unimodal_Winter.mat'],'T_Run','Model_Output');


Model_Output=cell(NS,1);
Vac_Camp='SA_Annual_Campaign';
parfor jj=1:NS
    Pt=P_All{jj};
    Pt.vac_SA=Pt.vac_baseline;
    Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
    [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
end
save(['Annual_Campaign_Baseline_Coverage_Unimodal_Winter.mat'],'T_Run','Model_Output');