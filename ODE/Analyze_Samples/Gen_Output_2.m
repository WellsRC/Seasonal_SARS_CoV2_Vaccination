clear;
clc;

Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85;0 17;18 64;65 85];

 max_file_w=3;
 max_file_s=1;
 max_file_u=9;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % FDA difference in peaks
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% for t_d=1:8    
%     Time_Dose=90+30.*(t_d-1);
%     Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_S'];
%     [Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file_s);
%     save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Summer');
%     
%     Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_U'];
%     [Filtered_Output_Unimodal] = SA_Output(Scenario,Av,ACg,max_file_u);
%     save(['Output_' Scenario '.mat'],'Filtered_Output_Unimodal');
% end
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Delay
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% for tau_delay=7:7:28
%     for p_delay=0.41:0.23:0.64
%         for t_d=1:8    
%             Time_Dose=90+30.*(t_d-1);
%             Scenario=['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay) ];
%             [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
%             save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
%         end
%         Scenario=['Annual_ILC_Delay_' num2str(tau_delay) '_days_' num2str(100.*p_delay)];
%         [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
%         save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
%         
%     end
% end
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reduced vaccine rate
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% for red_vc=0.33:0.33:0.66
%     Scenario=['Annual_ILC_Reduced_Vaccination_Rate_' num2str(100.*red_vc)];
%     [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
%     save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
% 
%         for t_d=1:8    
%             Time_Dose=90+30.*(t_d-1);
%             Scenario=['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduced_Vaccination_Rate_' num2str(100.*red_vc) ];
%             [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
%             save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
%         end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reduced vaccine coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for red_vc=0.33:0.33:0.66
    Scenario=['Annual_ILC_Reduced_Coverage_' num2str(100.*red_vc) ];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    
    for t_d=1:8    
        Time_Dose=90+30.*(t_d-1);
        Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Coverage_' num2str(100.*red_vc) ];
        [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
        save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Efficacy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for eps_INC=0.33:0.33:0.66
    Scenario=['Annual_ILC_Increased_Overall_Efficacy_' num2str(100.*eps_INC) ];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

    for t_d=1:8    
        Time_Dose=90+30.*(t_d-1);
        Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Increased_Overall_Efficacy_' num2str(100.*eps_INC) ];
        [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
        save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Efficacy SD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for eps_SD=0.33:0.33:0.66
    Scenario=['Annual_ILC_Reduced_SD_Efficacy_' num2str(100.*eps_SD) ];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');

    for t_d=1:8    
        Time_Dose=90+30.*(t_d-1);
        Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_SD_Efficacy_' num2str(100.*eps_SD) ];
        [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
        save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Efficacy Inf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for eps_INF=0.33:0.33:0.66
    Scenario=['Annual_ILC_Reduced_Infection_Efficacy_' num2str(100.*eps_INF)];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    
    for t_d=1:8    
        Time_Dose=90+30.*(t_d-1);
        Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Infection_Efficacy_' num2str(100.*eps_INF) ];
        [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
        save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Probability hospitalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for eps_H=0.33:0.33:0.66
    Scenario=['Annual_ILC_Reduced_Prob_Hospital_' num2str(100.*eps_H)];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    
    for t_d=1:8    
        Time_Dose=90+30.*(t_d-1);
        Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Prob_Hospital_' num2str(100.*eps_H) ];
        [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
        save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for red_tran=0.05:0.05:0.1
    Scenario=['Annual_ILC_Reduced_Transmission_' num2str(100.*red_tran)];
    [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
    save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    
    for t_d=1:8    
        Time_Dose=90+30.*(t_d-1);
        Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_Transmission_' num2str(100.*red_tran)];
        [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
        save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
    end
end
