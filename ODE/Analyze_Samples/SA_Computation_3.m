% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Influenza-like coverage 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear;
% clc;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Scenario Calcualtions and comparison of annula vs two dose
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% 
% load(['Output_Annual_ILC_S.mat'],'Filtered_Output_Large_Summer');
% Annual_Output=Filtered_Output_Large_Summer;
% Scenario_Calculations(Annual_Output,['Summer_SA_Annual']);
% 
% for t_d=1:8    
%     Time_Dose=90+30.*(t_d-1);    
%     load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_S.mat'],'Filtered_Output_Large_Summer');
%     Scenario_Calculations(Filtered_Output_Large_Summer,['Summer_SA_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days']);
%     Comparison_Calculations(Annual_Output,Filtered_Output_Large_Summer,['Summer_SA_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days' ]);
% end
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Unimodal
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% clear;
% clc;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Scenario Calcualtions and comparison of annula vs two dose
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% 
% load(['Output_Annual_ILC_U.mat'],'Filtered_Output_Unimodal');
% Annual_Output=Filtered_Output_Unimodal;
% Scenario_Calculations(Annual_Output,['UW_SA_Annual']);
% 
% for t_d=1:8    
%     Time_Dose=90+30.*(t_d-1);    
%     load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_U.mat'],'Filtered_Output_Unimodal');
%     Scenario_Calculations(Filtered_Output_Unimodal,['UW_SA_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days']);
%     Comparison_Calculations(Annual_Output,Filtered_Output_Unimodal,['UW_SA_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days' ]);
% end
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Waning vaccine: Slow
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear;
% clc;
% 
% 
% load(['Output_Annual_ILC_Slow_Waning_Vaccine_W.mat'],'Filtered_Output_Large_Winter');
% Annual_Output=Filtered_Output_Large_Winter;
% Scenario_Calculations(Annual_Output,['Slow_Waning_SA_Annual']);
% 
% for t_d=1:8    
%     Time_Dose=90+30.*(t_d-1);    
%     load(['Output_FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Slow_Waning_Vaccine_W.mat'],'Filtered_Output_Large_Winter');
%     Scenario_Calculations(Filtered_Output_Large_Winter,['Slow_Waning_SA_Two_Dose_FDA_' num2str(Time_Dose) '_days']);
%     Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Slow_Waning_SA_Two_Dose_FDA_' num2str(Time_Dose) '_days' ]);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Waning vaccine: Fast
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear;
% clc;
% 
% 
% load(['Output_Annual_ILC_Fast_Waning_Vaccine_W.mat'],'Filtered_Output_Large_Winter');
% Annual_Output=Filtered_Output_Large_Winter;
% Scenario_Calculations(Annual_Output,['Fast_Waning_SA_Annual']);
% 
% for t_d=1:8    
%     Time_Dose=90+30.*(t_d-1);    
%     load(['Output_FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Fast_Waning_Vaccine_W.mat'],'Filtered_Output_Large_Winter');
%     Scenario_Calculations(Filtered_Output_Large_Winter,['Fast_Waning_SA_Two_Dose_FDA_' num2str(Time_Dose) '_days']);
%     Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Fast_Waning_SA_Two_Dose_FDA_' num2str(Time_Dose) '_days' ]);
% end
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Waning vaccine: Other
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear;
% clc;
% 
% 
% load(['Output_Annual_ILC_Other_Waning_Vaccine_W.mat'],'Filtered_Output_Large_Winter');
% Annual_Output=Filtered_Output_Large_Winter;
% Scenario_Calculations(Annual_Output,['Other_Waning_SA_Annual']);
% 
% for t_d=1:8    
%     Time_Dose=90+30.*(t_d-1);    
%     load(['Output_FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Other_Waning_Vaccine_W.mat'],'Filtered_Output_Large_Winter');
%     Scenario_Calculations(Filtered_Output_Large_Winter,['Other_Waning_SA_Two_Dose_FDA_' num2str(Time_Dose) '_days']);
%     Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Other_Waning_SA_Two_Dose_FDA_' num2str(Time_Dose) '_days' ]);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

for tau_delay=14:14:28
    for p_delay=0.41:0.23:0.64
        load(['Output_Annual_ILC_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '.mat'],'Filtered_Output_Large_Winter');
        Annual_Output=Filtered_Output_Large_Winter;
        Scenario_Calculations(Annual_Output,['SA_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '_Annual']);
        
        for t_d=1:8    
            Time_Dose=90+30.*(t_d-1);    
            load(['Output_FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '.mat'],'Filtered_Output_Large_Winter');
            Scenario_Calculations(Filtered_Output_Large_Winter,['SA_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '_Two_Dose_FDA_' num2str(Time_Dose) '_days']);
            Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['SA_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) '_Two_Dose_FDA_' num2str(Time_Dose) '_days']);
        end

    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Reduced vaccination rate
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for red_vc=0.33:0.33:0.66
%     load(['Output_Annual_ILC_Reduced_Vaccination_Rate_' num2str(100.*red_vc) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Reduced_Vaccination_Rate_' num2str(100.*red_vc) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduced_Vaccination_Rate_' num2str(100.*red_vc) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Reduced_Vaccination_Rate_' num2str(100.*red_vc) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Reduced_Vaccination_Rate_' num2str(100.*red_vc) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Reduced vaccination coverage
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for red_vc=0.33:0.33:0.66
%     load(['Output_Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Reduced_Coverage_' num2str(100.*red_vc) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Coverage_' num2str(100.*red_vc) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Reduced_Coverage_' num2str(100.*red_vc) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Reduced_Coverage_' num2str(100.*red_vc) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Increased Efficacy
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for eps_INC=0.33:0.33:0.66
%     load(['Output_Annual_ILC_Increased_Overall_Efficacy_' num2str(100.*eps_INC) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Increased_Overall_Efficacy_' num2str(100.*eps_INC) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Increased_Overall_Efficacy_' num2str(100.*eps_INC) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Increased_Overall_Efficacy_' num2str(100.*eps_INC) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Increased_Overall_Efficacy_' num2str(100.*eps_INC) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Decreased Efficacy in infection
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for eps_INF=0.33:0.33:0.66
%     load(['Output_Annual_ILC_Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Reduced_Infection_Efficacy_' num2str(100.*eps_INF) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Probability hospitalization
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for eps_H=0.33:0.33:0.66
%     load(['Output_Annual_ILC_Reduced_Prob_Hospital_' num2str(100.*eps_H) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Reduced_Prob_Hospital_' num2str(100.*eps_H) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Prob_Hospital_' num2str(100.*eps_H) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Reduced_Prob_Hospital_' num2str(100.*eps_H) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Reduced_Prob_Hospital_' num2str(100.*eps_H) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Transmission
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for red_tran=0.05:0.05:0.1
%     load(['Output_Annual_ILC_Reduced_Transmission_' num2str(100.*red_tran) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Reduced_Transmission_' num2str(100.*red_tran) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Transmission_' num2str(100.*red_tran) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Reduced_Transmission_' num2str(100.*red_tran) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Reduced_Transmission_' num2str(100.*red_tran) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Transmission
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% for red_tran=0.05:0.05:0.1
%     load(['Output_Annual_ILC_Increased_Transmission_' num2str(100.*red_tran) '.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
%     Scenario_Calculations(Annual_Output,['Increased_Transmission_' num2str(100.*red_tran) '_SA_Annual']);
%     
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Increased_Transmission_' num2str(100.*red_tran) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Increased_Transmission_' num2str(100.*red_tran) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Increased_Transmission_' num2str(100.*red_tran) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% % Second Dose
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% clear;
% clc;
% 
%     load(['Output_Annual_ILC_W.mat'],'Filtered_Output_Large_Winter');
%     Annual_Output=Filtered_Output_Large_Winter;
% for red_vc=0.33:0.33:0.66
%     for t_d=1:8    
%         Time_Dose=90+30.*(t_d-1);    
%         load(['Output_FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_2_Dose_' num2str(100.*red_vc) '.mat'],'Filtered_Output_Large_Winter');
%         Scenario_Calculations(Filtered_Output_Large_Winter,['Reduced_2_Dose_' num2str(100.*red_vc) '_SA_FDA_' num2str(Time_Dose) '_days']);
%         Comparison_Calculations(Annual_Output,Filtered_Output_Large_Winter,['Reduced_2_Dose_' num2str(100.*red_vc) '_SA_FDA_' num2str(Time_Dose) '_days' ]);
%     end
% end

