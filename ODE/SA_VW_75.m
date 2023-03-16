parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
NS=length(P_All);
Model_Output_Influenza=cell(NS,1);
Model_Output_SARSCoV2=cell(NS,1);

parfor jj=1:NS
    Pt=P_All{jj};
    Pt.gamma_V(AC>=65)=Pt.gamma_V(AC>=65).*(1-0.75);
    [~,~,Model_Output_Influenza{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    [~,~,Model_Output_SARSCoV2{jj}] = Run_Cont_Booster_ODE(T_Run,Pt);
end
save(['All_SA_Vaccine_Waning_65_plus_Reduction=75.mat'],'T_Run','Model_Output_SARSCoV2','Model_Output_Influenza','R_WP');