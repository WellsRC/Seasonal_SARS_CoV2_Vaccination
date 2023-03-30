parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
NS=length(P_All);
vac_scale_influenza=[0.1:0.1:1];
vac_wane_red=[0.1:0.1:1];
for ss=1:10
    for vv=1:10
        Model_Output_VC=cell(NS,1);
        Model_Output_VacWane=cell(NS,1);

        parfor jj=1:NS
            Pt=Scale_Vaccination_65(P_All{jj},vac_scale_influenza(ss));
            [~,~,Model_Output_VC{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
            Pt=Scale_Vaccination_65(P_All{jj},0);
            Pt.gamma_V(AC>=65)=Pt.gamma_V(AC>=65).*(1-vac_wane_red(vv));
            [~,~,Model_Output_VacWane{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
        end
        save(['Coverage_vs_Waning_Scaled_Coverage=' num2str(100.*vac_scale_influenza(ss)) '_and_Waning_Reduction=' num2str(100.*vac_wane_red(ss)) '.mat'],'T_Run','Model_Output_VC','Model_Output_VacWane','R_WP');
    end
end