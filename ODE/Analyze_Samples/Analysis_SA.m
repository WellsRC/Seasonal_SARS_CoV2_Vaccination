clear;
clc;

Av=[0:84];
ACg=[0 4;5 17;18 49;50 64;65 84;0 64];
gamma_red=[0.25 0.5 0.75 1];
SA_Scenario.Variable='Vaccine_Waning';

for ss=1:4
    SA_Scenario.value=gamma_red(ss);
    [Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
    save(['Filtered_Outputs_gamma_V_reduction=' num2str(100.*gamma_red(ss)) '.mat'],'Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
    
    Scenario_Calculations(Filtered_Output_All.Continual_Booster.Low_Coverage,['All_Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
    Scenario_Calculations(Filtered_Output_All.Annual_Booster.High_Coverage,['All_High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);

    Scenario_Calculations(Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage,['Large_Winter_Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
    Scenario_Calculations(Filtered_Output_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);

    Scenario_Calculations(Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage,['Large_Summer_Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
    Scenario_Calculations(Filtered_Output_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);


    Comparison_Calculations(Filtered_Output_All.Annual_Booster.High_Coverage,Filtered_Output_All.Continual_Booster.Low_Coverage,['All_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
   
    Comparison_Calculations(Filtered_Output_Large_Winter.Annual_Booster.High_Coverage,Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage,['Large_Winter_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
   
    Comparison_Calculations(Filtered_Output_Large_Summer.Annual_Booster.High_Coverage,Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage,['Large_Summer_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
   
end


vac_scale_influenza=flip(sort([0.1 0.5 0.2:0.2:1]));
vac_SARSCoV2_5=flip([0.01 0.1:0.1:0.6]);
SA_Scenario.Variable='Vaccination_coverage_Scaled';
load('Filtered_Outputs.mat','Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

for ss=1:7
    SA_Scenario.value=[vac_scale_influenza(ss) vac_SARSCoV2_5(ss)] ;
    if(ss==1)
        [Baseline_Output_IVC_All,Baseline_Output_IVC_Large_Winter,Baseline_Output_IVC_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
        save(['Filtered_Outputs_scaled_influenza=' num2str(100.*vac_scale_influenza(ss)) '.mat'],'Baseline_Output_IVC_All','Baseline_Output_IVC_Large_Winter','Baseline_Output_IVC_Large_Summer');
    
        Scenario_Calculations(Baseline_Output_IVC_All.Annual_Booster.High_Coverage,['All_High_Coverage_Annual_Booster_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);

        Scenario_Calculations(Baseline_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_High_Coverage_Annual_Booster_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);

        Scenario_Calculations(Baseline_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_High_Coverage_Annual_Booster_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);
    
        Comparison_Calculations(Filtered_Output_All.Annual_Booster.High_Coverage,Baseline_Output_IVC_All.Annual_Booster.High_Coverage,['All-Low_Coverage_Annual_Booster_Baseline_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);
   
        Comparison_Calculations(Filtered_Output_Large_Winter.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter-Low_Coverage_Annual_Booster_Baseline_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);
   
        Comparison_Calculations(Filtered_Output_Large_Summer.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer-Low_Coverage_Annual_Booster_Baseline_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);   
    else
        [Filtered_Output_IVC_All,Filtered_Output_IVC_Large_Winter,Filtered_Output_IVC_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
        save(['Filtered_Outputs_scaled_influenza=' num2str(100.*vac_scale_influenza(ss)) '.mat'],'Filtered_Output_IVC_All','Filtered_Output_IVC_Large_Winter','Filtered_Output_IVC_Large_Summer');
    
        Scenario_Calculations(Filtered_Output_IVC_All.Annual_Booster.High_Coverage,['All_High_Coverage_Annual_Booster_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);

        Scenario_Calculations(Filtered_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_High_Coverage_Annual_Booster_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);

        Scenario_Calculations(Filtered_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_High_Coverage_Annual_Booster_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);
    
        Comparison_Calculations(Filtered_Output_IVC_All.Annual_Booster.High_Coverage,Baseline_Output_IVC_All.Annual_Booster.High_Coverage,['All-Low_Coverage_Annual_Booster_Baseline_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);
   
        Comparison_Calculations(Filtered_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter-Low_Coverage_Annual_Booster_Baseline_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);
   
        Comparison_Calculations(Filtered_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer-Low_Coverage_Annual_Booster_Baseline_scaled_influenza=' num2str(100.*vac_scale_influenza(ss))]);   
        
    end
end

SA_Scenario.Variable='Vaccination_coverage_Under_5';
for ss=1:7
    SA_Scenario.value=[vac_scale_influenza(ss) vac_SARSCoV2_5(ss)] ;
    [Filtered_Output_VU5_All,Filtered_Output_VU5_Large_Winter,Filtered_Output_VU5_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
    save(['Filtered_Outputs_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss)) '.mat'],'Filtered_Output_VU5_All','Filtered_Output_VU5_Large_Winter','Filtered_Output_VU5_Large_Summer');
    
    Scenario_Calculations(Filtered_Output_VU5_All.Annual_Booster.High_Coverage,['All_High_Coverage_Annual_Booster_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss))]);

    Scenario_Calculations(Filtered_Output_VU5_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_High_Coverage_Annual_Booster_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss))]);

    Scenario_Calculations(Filtered_Output_VU5_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_High_Coverage_Annual_Booster_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss))]);
    
    Comparison_Calculations(Filtered_Output_VU5_All.Annual_Booster.High_Coverage,Baseline_Output_IVC_All.Annual_Booster.High_Coverage,['All-Low_Coverage_Annual_Booster_Baseline_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss))]);
   
    Comparison_Calculations(Filtered_Output_VU5_Large_Winter.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter-Low_Coverage_Annual_Booster_Baseline_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss))]);
   
    Comparison_Calculations(Filtered_Output_VU5_Large_Summer.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer-Low_Coverage_Annual_Booster_Baseline_Under_5_Coverage=' num2str(100.*vac_SARSCoV2_5(ss))]);
end