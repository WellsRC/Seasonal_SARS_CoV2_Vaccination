parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
NS=length(P_All);
Model_Output_Two_Doses=cell(NS,1);
parfor jj=1:NS
    Pt=Two_Dose_Vaccination(P_All{jj},true);
    [~,~,Model_Output_Two_Doses{jj}] = Run_Annual_65Booster_ODE(T_Run,Pt);
end
save(['Two_Doses_65_plus_Baseline.mat'],'T_Run','Model_Output_Two_Doses','R_WP');

NS=length(P_All);
Model_Output_Two_Doses=cell(NS,1);
parfor jj=1:NS
    Pt=Two_Dose_Vaccination(P_All{jj},false);
    [~,~,Model_Output_Two_Doses{jj}] = Run_Annual_65Booster_ODE(T_Run,Pt);
end
save(['Two_Doses_65_plus_Seasonal.mat'],'T_Run','Model_Output_Two_Doses','R_WP');