parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_delay=28;
pd=2;
Time_Dose=210;
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Model_Output=cell(NS,1);

Age_Dose=zeros(size(AC));
Age_Dose(AC>=50)=1;

Vac_Camp='Delay_SA_Two_Dose_Campaign';
parfor jj=1:NS
    Pt=P_All{jj};
    Pt.Prop_Delay=pd.*0.3;
    Pt.Add_dose.t0=T_Run(1);
    Pt.Add_dose.Time=Time_Dose+T_Run(1);
    Pt.Add_dose.Age=Age_Dose;
    Pt.vac_SA=Pt.vac_int_influenza;
    Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
    Pt.Delay_Time=t_delay;
    [~,Model_Output{jj}] = Run_Two_Dose_ODE_Delay(T_Run,Pt);
end
save(['Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(t_delay) '_days.mat'],'T_Run','Model_Output','R_WP');

t_delay=28;
pd=2;
Time_Dose=210;
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);

Age_Dose=zeros(size(AC));
Age_Dose(AC>=50)=1;


Model_Output=cell(NS,1);

Vac_Camp='Delay_SA_Two_Dose_Campaign';
parfor jj=1:NS
    Pt=P_All{jj};
    Pt.Prop_Delay=pd.*0.3;
    Pt.Add_dose.t0=T_Run(1);
    Pt.Add_dose.Time=Time_Dose+T_Run(1);
    Pt.Add_dose.Age=Age_Dose;
    Pt.vac_SA=Pt.vac_baseline;
    Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
    Pt.Delay_Time=t_delay;
    [~,Model_Output{jj}] = Run_Two_Dose_ODE_Delay(T_Run,Pt);
end
save(['Two_Campaign_Baseline_Coverage_180_days_50_and_older_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(t_delay) '_days.mat'],'T_Run','Model_Output','R_WP');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_delay=28;
pd=2;  
Time_Dose=210;
load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run');
NS=length(P_All);
Model_Output=cell(NS,1);

Age_Dose=zeros(size(AC));
Age_Dose(AC>=50)=1;

Vac_Camp='Delay_SA_Two_Dose_Campaign';
parfor jj=1:NS
    Pt=P_All{jj};
    Pt.Prop_Delay=pd.*0.3;
    Pt.Add_dose.t0=T_Run(1);
    Pt.Add_dose.Time=Time_Dose+T_Run(1);
    Pt.Add_dose.Age=Age_Dose;
    Pt.vac_SA=Pt.vac_int_influenza;
    Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
    Pt.Delay_Time=t_delay;
    [~,Model_Output{jj}] = Run_Two_Dose_ODE_Delay(T_Run,Pt);
end
save(['Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(t_delay) '_days_Unimodal_Winter.mat'],'T_Run','Model_Output');

t_delay=28;
pd=2;  
Time_Dose=210;
load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run');
NS=length(P_All);

Age_Dose=zeros(size(AC));
Age_Dose(AC>=50)=1;


Model_Output=cell(NS,1);

Vac_Camp='Delay_SA_Two_Dose_Campaign';
parfor jj=1:NS
    Pt=P_All{jj};
    Pt.Prop_Delay=pd.*0.3;
    Pt.Add_dose.t0=T_Run(1);
    Pt.Add_dose.Time=Time_Dose+T_Run(1);
    Pt.Add_dose.Age=Age_Dose;
    Pt.vac_SA=Pt.vac_baseline;
    Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
    Pt.Delay_Time=t_delay;
    [~,Model_Output{jj}] = Run_Two_Dose_ODE_Delay(T_Run,Pt);
end
save(['Two_Campaign_Baseline_Coverage_180_days_50_and_older_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(t_delay) '_days_Unimodal_Winter.mat'],'T_Run','Model_Output');
