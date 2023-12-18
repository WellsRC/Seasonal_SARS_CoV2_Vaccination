%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Influenza-like coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Scenario Calcualtions and comparison of annula vs two dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load(['Output_Annual_ILC.mat'],'Filtered_Output_Large_Summer');
Annual_Output=Filtered_Output_Large_Summer;
Scenario_Calculations(Annual_Output,['Summer_SA_Annual']);

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);    
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Large_Summer');
    Scenario_Calculations(Filtered_Output_Large_Summer,['Summer_SA_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Large_Summer,Annual_Output,['Summer_SA_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days' ]);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Large_Summer');
    Scenario_Calculations(Filtered_Output_Large_Summer,['Summer_SA_Two_Dose_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Large_Summer,Annual_Output,['Summer_SA_Annual_vs_Two_Dose_50_and_older_' num2str(Time_Dose) '_days' ]);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Large_Summer');
    Scenario_Calculations(Filtered_Output_Large_Summer,['Summer_SA_Two_Dose_65_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Large_Summer,Annual_Output,['Summer_SA_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose) '_days' ]);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit for vaccinating additional age groups
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear;
clc;


load(['Output_Annual_ILC.mat'],'Filtered_Output_Large_Summer');
Annual_Output=Filtered_Output_Large_Summer;

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Large_Summer');
    Two_Dose_65_Output=Filtered_Output_Large_Summer;
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Large_Summer');
    Two_Dose_50_Output=Filtered_Output_Large_Summer;
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Large_Summer');
    Two_Dose_child_and_50_Output=Filtered_Output_Large_Summer;    

    Marginal_Benefit_Second_Doses(Two_Dose_65_Output,Two_Dose_50_Output,Annual_Output, ['Summer_SA_65_vs_50_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Second_Doses(Two_Dose_50_Output,Two_Dose_child_and_50_Output,Annual_Output, ['Summer_SA_50_vs_young_50_Second_dose_' num2str(Time_Dose) '_days']);

    Marginal_Benefit_Direct(Two_Dose_65_Output,Annual_Output,Time_Dose,['Summer_SA_65_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Direct(Two_Dose_50_Output,Annual_Output,Time_Dose,['Summer_SA_50_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Direct(Two_Dose_child_and_50_Output,Annual_Output,Time_Dose,['Summer_SA_under_2_50_Second_dose_' num2str(Time_Dose) '_days']);

end

clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Unimodal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Scenario Calcualtions and comparison of annula vs two dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load(['Output_Annual_ILC.mat'],'Filtered_Output_Unimodal');
Annual_Output=Filtered_Output_Unimodal;
Scenario_Calculations(Annual_Output,['UW_SA_Annual']);

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);    
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Unimodal');
    Scenario_Calculations(Filtered_Output_Unimodal,['UW_SA_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Unimodal,Annual_Output,['UW_SA_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days' ]);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Unimodal');
    Scenario_Calculations(Filtered_Output_Unimodal,['UW_SA_Two_Dose_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Unimodal,Annual_Output,['UW_SA_Annual_vs_Two_Dose_50_and_older_' num2str(Time_Dose) '_days' ]);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Unimodal');
    Scenario_Calculations(Filtered_Output_Unimodal,['UW_SA_Two_Dose_65_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Unimodal,Annual_Output,['UW_SA_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose) '_days' ]);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit for vaccinating additional age groups
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear;
clc;


load(['Output_Annual_ILC.mat'],'Filtered_Output_Unimodal');
Annual_Output=Filtered_Output_Unimodal;

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Unimodal');
    Two_Dose_65_Output=Filtered_Output_Unimodal;
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Unimodal');
    Two_Dose_50_Output=Filtered_Output_Unimodal;
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Unimodal');
    Two_Dose_child_and_50_Output=Filtered_Output_Unimodal;    

    Marginal_Benefit_Second_Doses(Two_Dose_65_Output,Two_Dose_50_Output,Annual_Output, ['UW_SA_65_vs_50_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Second_Doses(Two_Dose_50_Output,Two_Dose_child_and_50_Output,Annual_Output, ['UW_SA_50_vs_young_50_Second_dose_' num2str(Time_Dose) '_days']);

    Marginal_Benefit_Direct(Two_Dose_65_Output,Annual_Output,Time_Dose,['UW_SA_65_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Direct(Two_Dose_50_Output,Annual_Output,Time_Dose,['UW_SA_50_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Direct(Two_Dose_child_and_50_Output,Annual_Output,Time_Dose,['UW_SA_under_2_50_Second_dose_' num2str(Time_Dose) '_days']);

end

clear;
clc;

