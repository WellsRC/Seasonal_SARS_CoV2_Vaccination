clear;
clc;

Av=[0:84];
ACg=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Waning immunity among 65+
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
gamma_red=[0.25 0.5 0.75 1];
SA_Scenario.Variable='Vaccine_Waning';

load('Filtered_Outputs.mat','Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
for ss=1:4
    SA_Scenario.value=gamma_red(ss);
    [Filtered_Output_VW_All,Filtered_Output_VW_Large_Winter,Filtered_Output_VW_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
    save(['Filtered_Outputs_gamma_V_reduction=' num2str(100.*gamma_red(ss)) '.mat'],'Filtered_Output_VW_All','Filtered_Output_VW_Large_Winter','Filtered_Output_VW_Large_Summer');
    
    Scenario_Calculations(Filtered_Output_VW_All.Continual_Booster.Low_Coverage,['All_Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
    Scenario_Calculations(Filtered_Output_VW_All.Annual_Booster.High_Coverage,['All_High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);

    Scenario_Calculations(Filtered_Output_VW_Large_Winter.Continual_Booster.Low_Coverage,['Large_Winter_Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
    Scenario_Calculations(Filtered_Output_VW_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);

    Scenario_Calculations(Filtered_Output_VW_Large_Summer.Continual_Booster.Low_Coverage,['Large_Summer_Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
    Scenario_Calculations(Filtered_Output_VW_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);


    Comparison_Calculations(Filtered_Output_VW_All.Annual_Booster.High_Coverage,Filtered_Output_VW_All.Continual_Booster.Low_Coverage,['All_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
   
    Comparison_Calculations(Filtered_Output_VW_Large_Winter.Annual_Booster.High_Coverage,Filtered_Output_VW_Large_Winter.Continual_Booster.Low_Coverage,['Large_Winter_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
   
    Comparison_Calculations(Filtered_Output_VW_Large_Summer.Annual_Booster.High_Coverage,Filtered_Output_VW_Large_Summer.Continual_Booster.Low_Coverage,['Large_Summer_Alt-High_Coverage_Annual_Booster_Baseline-Low_Coverage_Continual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) ]);
   
    % Comapre to no reduction in the baseline model
    Comparison_Calculations(Filtered_Output_VW_All.Annual_Booster.High_Coverage,Filtered_Output_All.Continual_Booster.Low_Coverage,['All_Alt-High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) '_Baseline-Low_Coverage_Continual_Booster-No_reduction']);
   
    Comparison_Calculations(Filtered_Output_VW_Large_Winter.Annual_Booster.High_Coverage,Filtered_Output_Large_Winter.Continual_Booster.Low_Coverage,['Large_Winter_Alt-High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) '_Baseline-Low_Coverage_Continual_Booster-No_reduction']);
   
    Comparison_Calculations(Filtered_Output_VW_Large_Summer.Annual_Booster.High_Coverage,Filtered_Output_Large_Summer.Continual_Booster.Low_Coverage,['Large_Summer_Alt-High_Coverage_Annual_Booster_Gamma_Reduction=' num2str(100.*gamma_red(ss)) '_Baseline-Low_Coverage_Continual_Booster-No_reduction']);
   
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Scale coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

vac_scale_influenza=flip(sort([0.1 0.5 0.2:0.2:1]));
SA_Scenario.Variable='Vaccination_coverage_Scaled';

for ss=1:7
    SA_Scenario.value=vac_scale_influenza(ss) ;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Age specific coverage: Low baseline coverages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

SA_Scenario.Variable='Baseline_Coverages_Ages';
vac_coverage_baseline=[0.05 0.25 0.50 0.75;
                       0.10 0.20 0.40 0.60;
                       0.15 0.25 0.35 0.45;
                       0.15 0.20 0.30 0.35;
                       0.30 0.35 0.40 0.45;
                       0.50 0.55 0.60 0.75];
                       
    
Age_B=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
for aa=1:6
    for ss=1:4
        SA_Scenario.value=[Age_B(aa,1) Age_B(aa,2) vac_coverage_baseline(aa,ss)] ;
        [Filtered_Output_Age_All,Filtered_Output_Age_Large_Winter,Filtered_Output_Age_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
        save(['Filtered_Outputs_Baseline_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss)) '.mat'],'Filtered_Output_Age_All','Filtered_Output_Age_Large_Winter','Filtered_Output_Age_Large_Summer');

        Scenario_Calculations(Filtered_Output_Age_All.Annual_Booster.High_Coverage,['All_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss))]);

        Scenario_Calculations(Filtered_Output_Age_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss))]);

        Scenario_Calculations(Filtered_Output_Age_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss))]);

        Comparison_Calculations(Filtered_Output_Age_All.Annual_Booster.High_Coverage,Baseline_Output_IVC_All.Annual_Booster.High_Coverage,['All_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss))]);

        Comparison_Calculations(Filtered_Output_Age_Large_Winter.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss))]);

        Comparison_Calculations(Filtered_Output_Age_Large_Summer.Annual_Booster.High_Coverage,Baseline_Output_IVC_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_Baseline_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss))]);
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Age specific coverage: High seasonal influenza-like coverages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

SA_Scenario.Variable='Seasonal_Influenza_Coverages_Age';
vac_coverage_influenza=[0.5 0.6 0.8 0.9; 
                        0.4 0.5 0.7 0.8;
                        0.25 0.35 0.55 0.65;
                        0.15 0.25 0.45 0.55;
                        0.25 0.35 0.55 0.65;
                        0.45 0.55 0.75 0.85;];
                       

load('Filtered_Outputs.mat','Filtered_Output_All','Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');    
Age_B=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
for aa=1:6
    for ss=1:4
        SA_Scenario.value=[Age_B(aa,1) Age_B(aa,2) vac_coverage_influenza(aa,ss)] ;
        [Filtered_Output_Age_All,Filtered_Output_Age_Large_Winter,Filtered_Output_Age_Large_Summer] = SA_Output(SA_Scenario,Av,ACg);
        save(['Filtered_Outputs_Seasonal_Influenza_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss)) '.mat'],'Filtered_Output_Age_All','Filtered_Output_Age_Large_Winter','Filtered_Output_Age_Large_Summer');

        Scenario_Calculations(Filtered_Output_Age_All.Annual_Booster.High_Coverage,['All_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss))]);

        Scenario_Calculations(Filtered_Output_Age_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss))]);

        Scenario_Calculations(Filtered_Output_Age_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss))]);

        Comparison_Calculations(Filtered_Output_Age_All.Annual_Booster.High_Coverage,Filtered_Output_All.Annual_Booster.High_Coverage,['All_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss))]);

        Comparison_Calculations(Filtered_Output_Age_Large_Winter.Annual_Booster.High_Coverage,Filtered_Output_Large_Winter.Annual_Booster.High_Coverage,['Large_Winter_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss))]);

        Comparison_Calculations(Filtered_Output_Age_Large_Summer.Annual_Booster.High_Coverage,Filtered_Output_Large_Summer.Annual_Booster.High_Coverage,['Large_Summer_Seasonal_Influenza_Coverage_Annual_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss))]);
    end
end