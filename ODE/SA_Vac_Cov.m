parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
NS=length(P_All);
vac_scale_influenza=sort([0.1 0.5 0.2:0.2:1]);
for ss=1:7
    Model_Output_Influenza=cell(NS,1);
    parfor jj=1:NS
        Pt=Scale_Annual_Vaccination(P_All{jj},vac_scale_influenza(ss));
        [~,~,Model_Output_Influenza{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    end
    save(['Scale_Seasonal_Influenza_Coverage_' num2str(100.*vac_scale_influenza(ss)) '.mat'],'T_Run','Model_Output_Influenza','R_WP');
end