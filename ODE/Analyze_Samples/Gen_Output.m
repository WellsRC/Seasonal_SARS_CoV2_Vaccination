clear;
clc;

Av=[0:84];
ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Annual campaign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

    Scenario=['Annual_ILC'];
    max_file=3;
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file);
    save(['Output_Annual_ILC.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

    Scenario=['Annual_ILC_UW'];
    max_file=6;
    [Filtered_Output_Unimodal] = SA_Output_U(Scenario,Av,ACg,max_file);
    save(['Output_Annual_ILC_UW.mat'],'Filtered_Output_Unimodal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FDA policy Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older'];
    max_file=3;
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
   
    
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_UW'];
    max_file=6;
    [Filtered_Output_Unimodal] = SA_Output_U(Scenario,Av,ACg,max_file);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older_UW.mat'],'Filtered_Output_Unimodal');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 65+ Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older'];
    max_file=3;
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');
   
    
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older_UW'];
    max_file=6;
    [Filtered_Output_Unimodal] = SA_Output_U(Scenario,Av,ACg,max_file);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older_UW.mat'],'Filtered_Output_Unimodal');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 50+ Two Doses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older'];
    max_file=3;
    [Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(Scenario,Av,ACg,max_file);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Large_Winter','Filtered_Output_Large_Summer');

    Scenario=['Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older_UW'];
    max_file=6;
    [Filtered_Output_Unimodal] = SA_Output_U(Scenario,Av,ACg,max_file);
    save(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older_UW.mat'],'Filtered_Output_Unimodal');
end

