clear;
clc;

Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
gamma_red=[0.25 0.5 0.75 1];


vac_scale_influenza=[0.1:0.1:1];
vac_wane_red=[0.1:0.1:1];
for ss=1:10
    for vv=1:10        
        SA_Scenario.value=[vac_scale_influenza(ss) vac_wane_red(ss)] ;
        SA_Scenario.Variable='Vaccination_coverage_vs_Waning-Coverage';
        [Filtered_Output_Coverage_All,Filtered_Output_Coverage_Large_Winter,Filtered_Output_Coverage_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
        SA_Scenario.Variable='Vaccination_coverage_vs_Waning-Immunity';
        [Filtered_Output_Immunity_All,Filtered_Output_Immunity_Large_Winter,Filtered_Output_Immunity_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
        
        Comparison_Calculations(Filtered_Output_Immunity_All.Annual_Booster.High_Coverage,Filtered_Output_Coverage_All.Continual_Booster.Low_Coverage,['All_Baseline_65_plus_Coverage_Scaled=' num2str(100.*vac_scale_influenza(ss)) '_vs_Reduced_waning_65_plus=' num2str(100.*vac_wane_red(ss))]);

        Comparison_Calculations(Filtered_Output_Immunity_Large_Winter.Annual_Booster.High_Coverage,Filtered_Output_Coverage_Large_Winter.Continual_Booster.Low_Coverage,['Large_Winter_Baseline_65_plus_Coverage_Scaled=' num2str(100.*vac_scale_influenza(ss)) '_vs_Reduced_waning_65_plus=' num2str(100.*vac_wane_red(ss))]);

        Comparison_Calculations(Filtered_Output_Immunity_Large_Summer.Annual_Booster.High_Coverage,Filtered_Output_Coverage_Large_Summer.Continual_Booster.Low_Coverage,['Large_Summer_Baseline_65_plus_Coverage_Scaled=' num2str(100.*vac_scale_influenza(ss)) '_vs_Reduced_waning_65_plus=' num2str(100.*vac_wane_red(ss))]);
    end   
end
