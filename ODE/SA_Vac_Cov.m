parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
NS=length(P_All);
vac_scale_influenza=sort([0.1 0.5 0.2:0.2:1]);
vac_SARSCoV2_5=[0.01 0.1:0.1:0.6];
for ss=1:7
    Model_Output_Influenza=cell(NS,1);
    Model_Output_SARSCoV2=cell(NS,1);

    parfor jj=1:NS
        Pt=Scale_Annual_Vaccination(P_All{jj},vac_scale_influenza(ss));
        [~,~,Model_Output_Influenza{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
        Pt=Under_5_Annual_Vaccination(P_All{jj},vac_SARSCoV2_5(ss));
        [~,~,Model_Output_SARSCoV2{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    end
    save(['Scale_Seasonal_Influenza_Coverage_' num2str(100.*vac_scale_influenza(ss)) '_and_SARSCoV2_Coverage_Under5_' num2str(100.*vac_SARSCoV2_5(ss)) '.mat'],'T_Run','Model_Output_Influenza','Model_Output_SARSCoV2','R_WP');
end