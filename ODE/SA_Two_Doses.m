parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
    NS=length(P_All);
    Model_Output=cell(NS,1);

    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=65)=1;

    Vac_Camp='Two_Dose_Campaign_Influenza';
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.Add_dose.t0=T_Run(1);
        Pt.Add_dose.Time=Time_Dose+T_Run(1);
        Pt.Add_dose.Age=Age_Dose;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Pt);
    end
    save(['Two_Campaign_Influenza_Like_Coverage_' num2str(Time_Dose) '_days_65_and_older.mat'],'T_Run','Model_Output','R_WP');
end


for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
    NS=length(P_All);

    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=65)=1;


    Model_Output=cell(NS,1);

    Vac_Camp='Two_Dose_Campaign_Baseline';
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.Add_dose.t0=T_Run(1);
        Pt.Add_dose.Time=Time_Dose+T_Run(1);
        Pt.Add_dose.Age=Age_Dose;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Pt);
    end
    save(['Two_Campaign_Baseline_Coverage_' num2str(Time_Dose) '_days_65_and_older.mat'],'T_Run','Model_Output','R_WP');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run');
    NS=length(P_All);
    Model_Output=cell(NS,1);

    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=65)=1;

    Vac_Camp='Two_Dose_Campaign_Influenza';
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.Add_dose.t0=T_Run(1);
        Pt.Add_dose.Time=Time_Dose+T_Run(1);
        Pt.Add_dose.Age=Age_Dose;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Pt);
    end
    save(['Two_Campaign_Influenza_Like_Coverage_' num2str(Time_Dose) '_days_65_and_older_Unimodal_Winter.mat'],'T_Run','Model_Output');
end


for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run');
    NS=length(P_All);

    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=65)=1;


    Model_Output=cell(NS,1);

    Vac_Camp='Two_Dose_Campaign_Baseline';
    parfor jj=1:NS
        Pt=P_All{jj};
        Pt.Add_dose.t0=T_Run(1);
        Pt.Add_dose.Time=Time_Dose+T_Run(1);
        Pt.Add_dose.Age=Age_Dose;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Pt);
    end
    save(['Two_Campaign_Baseline_Coverage_' num2str(Time_Dose) '_days_65_and_older_Unimodal_Winter.mat'],'T_Run','Model_Output');
end
