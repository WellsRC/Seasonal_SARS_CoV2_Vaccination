%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Influenza-like coverage 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Scenario Calcualtions and comparison of annula vs two dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

load(['Output_Calibration.mat'],'Filtered_Output_Large_Winter');
Calibration_Output=Filtered_Output_Large_Winter;
Scenario_Calculations(Calibration_Output,['Calibration']);

load(['Output_Calibration.mat'],'Filtered_Output_Large_Summer');
Calibration_Output=Filtered_Output_Large_Winter;
Scenario_Calculations(Calibration_Output,['Calibration_Summer']);

load(['Output_Calibration_UW.mat'],'Filtered_Output_Unimodal');
Calibration_Output=Filtered_Output_Unimodal;
Scenario_Calculations(Calibration_Output,['Calibration_UW']);


load(['Output_Annual_ILC.mat'],'Filtered_Output_Large_Winter');
Annual_Output=Filtered_Output_Large_Winter;
Scenario_Calculations(Annual_Output,['Main_Text_Annual']);

load(['Output_Annual_ILC_Slow_Waning_Vaccine.mat'],'Filtered_Output_Large_Winter');
Annual_Output_Slow=Filtered_Output_Large_Winter;
Scenario_Calculations(Annual_Output_Slow,['Main_Text_Annual_Slow_Waning_Vaccine']);
Comparison_Calculations(Annual_Output_Slow,Annual_Output,['Main_Text_Annual_vs_Annual_Slow_Waning_Vaccine' ]);

load(['Output_Annual_ILC_Fast_Waning_Vaccine.mat'],'Filtered_Output_Large_Winter');
Annual_Output_Fast=Filtered_Output_Large_Winter;
Scenario_Calculations(Annual_Output_Fast,['Main_Text_Annual_Fast_Waning_Vaccine']);
Comparison_Calculations(Annual_Output_Fast,Annual_Output,['Main_Text_Annual_vs_Annual_Fast_Waning_Vaccine' ]);

load(['Output_FDA_Two_Dose_ILC_Slow_Waning_Vaccine.mat'],'Filtered_Output_Large_Winter');
TwoDose_Output_Slow=Filtered_Output_Large_Winter;
Scenario_Calculations(TwoDose_Output_Slow,['Main_Text_FDA_Two_Dose_ILC_Slow_Waning_Vaccine']);
Comparison_Calculations(TwoDose_Output_Slow,Annual_Output_Slow,['Main_Text_Two_Dose_vs_Annual_Slow_Waning_Vaccine' ]);

load(['Output_FDA_Two_Dose_ILC_Fast_Waning_Vaccine.mat'],'Filtered_Output_Large_Winter');
TwoDose_Output_Fast=Filtered_Output_Large_Winter;
Scenario_Calculations(TwoDose_Output_Fast,['Main_Text_FDA_Two_Dose_ILC_Fast_Waning_Vaccine']);
Comparison_Calculations(TwoDose_Output_Fast,Annual_Output_Fast,['Main_Text_Two_Dose_vs_Annual_Fast_Waning_Vaccine' ]);

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);    
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Large_Winter,Annual_Output,['Main_Text_Annual_vs_Two_Dose_under_2_and_50_and_older_' num2str(Time_Dose) '_days' ]);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_50_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Large_Winter,Annual_Output,['Main_Text_Annual_vs_Two_Dose_50_and_older_' num2str(Time_Dose) '_days' ]);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_Two_Dose_65_and_older_' num2str(Time_Dose) '_days']);
    Comparison_Calculations(Filtered_Output_Large_Winter,Annual_Output,['Main_Text_Annual_vs_Two_Dose_65_and_older_' num2str(Time_Dose) '_days' ]);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Marginal benefit for vaccinating additional age groups
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
clear;
clc;


load(['Output_Annual_ILC.mat'],'Filtered_Output_Large_Winter');
Annual_Output=Filtered_Output_Large_Winter;

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_65_and_older.mat'],'Filtered_Output_Large_Winter');
    Two_Dose_65_Output=Filtered_Output_Large_Winter;
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_50_and_older.mat'],'Filtered_Output_Large_Winter');
    Two_Dose_50_Output=Filtered_Output_Large_Winter;
    load(['Output_Two_Dose_ILC_' num2str(Time_Dose) '_days_under_2_and_50_and_older.mat'],'Filtered_Output_Large_Winter');
    Two_Dose_child_and_50_Output=Filtered_Output_Large_Winter;    

    Marginal_Benefit_Second_Doses(Two_Dose_65_Output,Two_Dose_50_Output,Annual_Output, ['Main_Text_65_vs_50_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Second_Doses(Two_Dose_50_Output,Two_Dose_child_and_50_Output,Annual_Output, ['Main_Text_50_vs_young_50_Second_dose_' num2str(Time_Dose) '_days']);

    Marginal_Benefit_Direct(Two_Dose_65_Output,Annual_Output,Time_Dose,['Main_Text_65_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Direct(Two_Dose_50_Output,Annual_Output,Time_Dose,['Main_Text_50_Second_dose_' num2str(Time_Dose) '_days']);
    Marginal_Benefit_Direct(Two_Dose_child_and_50_Output,Annual_Output,Time_Dose,['Main_Text_under_2_50_Second_dose_' num2str(Time_Dose) '_days']);

end

clear;
clc;


load(['Output_Annual_ILC.mat'],'Filtered_Output_Large_Winter');
Annual_Output=Filtered_Output_Large_Winter;



for red_2d=0.35:0.15:0.65  
    load(['Output_Two_Dose_ILC_180_days_Reduction_' num2str(100.*red_2d) '_FDA.mat'],'Filtered_Output_Large_Winter');
    Two_Dose_FDA=Filtered_Output_Large_Winter;  
    load(['Output_Two_Dose_ILC_180_days_Reduction_' num2str(100.*red_2d) '_18_49.mat'],'Filtered_Output_Large_Winter');
    Scenario_Calculations(Filtered_Output_Large_Winter,['Main_Text_18_49_vs_FDA_Reduction' num2str(100.*red_2d)]);
     Comparison_Calculations(Filtered_Output_Large_Winter,Annual_Output,['Main_Text_Annual_vs_Two_Dose_under_18_49_vs_FDA_Reduction' num2str(100.*red_2d) ]);
    Marginal_Benefit_Second_Doses(Two_Dose_FDA,Filtered_Output_Large_Winter,Annual_Output, ['Main_Text_18_49_vs_FDA_Reduction' num2str(100.*red_2d)]);
    Marginal_Benefit_Direct(Filtered_Output_Large_Winter,Annual_Output,180,['Main_Text_18_49_180_days_FDA_Reduction' num2str(100.*red_2d)]);
end

