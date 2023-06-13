parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
Vac_Camp='Delay_SA_Annual_Campaign';
for pd=1:3
    for dd=1:4
        Model_Output=cell(NS,1);
        parfor jj=1:NS
            Pt=P_All{jj};
            Pt.Prop_Delay=pd.*0.3;
            Pt.Delay_Time=7.*dd;
            Pt.vac_SA=Pt.vac_int_influenza;
            Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
            [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
        end
        save(['Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(7.*dd) '_days.mat'],'T_Run','Model_Output','R_WP');
    end
end

for pd=1:3
    for dd=1:4
        Model_Output=cell(NS,1);
        parfor jj=1:NS
            Pt=P_All{jj};
            Pt.Prop_Delay=pd.*0.3;
            Pt.vac_SA=Pt.vac_baseline;
            Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
            Pt.Delay_Time=7.*dd;
            [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
        end
        save(['Annual_Campaign_Baseline_Coverage_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(7.*dd) '_days.mat'],'T_Run','Model_Output','R_WP');
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run')
NS=length(P_All);

Vac_Camp='Delay_SA_Annual_Campaign';
for pd=1:3
    for dd=1:4
        Model_Output=cell(NS,1);
        parfor jj=1:NS
            Pt=P_All{jj};
            Pt.Prop_Delay=pd.*0.3;
            Pt.Delay_Time=7.*dd;
            Pt.vac_SA=Pt.vac_int_influenza;
            Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
            [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
        end
        save(['Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(7.*dd) '_days_Unimodal_Winter.mat'],'T_Run','Model_Output');
    end
end

for pd=1:3
    for dd=1:4
        Model_Output=cell(NS,1);
        parfor jj=1:NS
            Pt=P_All{jj};
            Pt.Prop_Delay=pd.*0.3;
            Pt.vac_SA=Pt.vac_baseline;
            Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
            Pt.Delay_Time=7.*dd;
            [~,Model_Output{jj}] = Run_Annual_Booster_Delay_ODE(T_Run,Pt);
        end
        save(['Annual_Campaign_Baseline_Coverage_Proportion_Delay_' num2str(pd.*30) '_Delay_' num2str(7.*dd) '_days_Unimodal_Winter.mat'],'T_Run','Model_Output');
    end
end