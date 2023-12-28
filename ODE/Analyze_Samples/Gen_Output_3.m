clear;
clc;

Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85;0 17;18 64;65 85];

 max_file_w=3;
 max_file_s=1;
 max_file_u=9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reduced vaccine uptake second dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for red_vc=0.33:0.33:0.66
        for t_d=1:8    
            Time_Dose=90+30.*(t_d-1);
            Scenario=['FDA_Two_Dose_' num2str(Time_Dose) '_days_ILC_Reduced_2_Dose_' num2str(100.*red_vc) ];
            [Filtered_Output_Large_Winter] = SA_Output(Scenario,Av,ACg,max_file_s);
            save(['Output_' Scenario '.mat'],'Filtered_Output_Large_Winter');
        end
end
