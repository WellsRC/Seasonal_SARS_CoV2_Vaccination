parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb_Age=[0 5 13 18 50 0];
ub_Age=[5 13 18 50 65 65];

for aa=1:6
    load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
    NS=length(P_All);
    Model_Output=cell(NS,1);

    Vac_Camp='SA_Annual_Campaign';
    parfor jj=1:NS
        Pt=P_All{jj};    
        Total_Additional_Doses=sum(Pt.N(50<=AC & AC<65).*Pt.vac_int_influenza(50<=AC & AC<65));
        N_A=Pt.N;
        N_A=N_A(AC>=lb_Age(aa) & AC<ub_Age(aa))./sum(N_A(AC>=lb_Age(aa) & AC<ub_Age(aa)));    
        Num_Add_Vac=zeros(size(Pt.N));
        Num_Add_Vac(AC>=lb_Age(aa) & AC<ub_Age(aa))=Total_Additional_Doses.*N_A;    
        Inc_Cov=Num_Add_Vac./Pt.N;    
        Pt.vac_SA=Pt.vac_int_influenza+Inc_Cov;
        Pt.vac_SA(Pt.vac_SA>1)=1;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '.mat'],'T_Run','Model_Output','R_WP');

    Model_Output=cell(NS,1);
    parfor jj=1:NS
        Pt=P_All{jj};    
        Total_Additional_Doses=sum(Pt.N(50<=AC & AC<65).*Pt.vac_int_influenza(50<=AC & AC<65));
        N_A=Pt.N;
        N_A=N_A(AC>=lb_Age(aa) & AC<ub_Age(aa))./sum(N_A(AC>=lb_Age(aa) & AC<ub_Age(aa)));    
        Num_Add_Vac=zeros(size(Pt.N));
        Num_Add_Vac(AC>=lb_Age(aa) & AC<ub_Age(aa))=Total_Additional_Doses.*N_A;    
        Inc_Cov=Num_Add_Vac./Pt.N;    
        Pt.vac_SA=Pt.vac_baseline+Inc_Cov;
        Pt.vac_SA(Pt.vac_SA>1)=1;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '.mat'],'T_Run','Model_Output','R_WP');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % One peak
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run')
    NS=length(P_All);
    Model_Output=cell(NS,1);

    Vac_Camp='SA_Annual_Campaign';
    parfor jj=1:NS
        Pt=P_All{jj};    
        Total_Additional_Doses=sum(Pt.N(50<=AC & AC<65).*Pt.vac_int_influenza(50<=AC & AC<65));
        N_A=Pt.N;
        N_A=N_A(AC>=lb_Age(aa) & AC<ub_Age(aa))./sum(N_A(AC>=lb_Age(aa) & AC<ub_Age(aa)));    
        Num_Add_Vac=zeros(size(Pt.N));
        Num_Add_Vac(AC>=lb_Age(aa) & AC<ub_Age(aa))=Total_Additional_Doses.*N_A;    
        Inc_Cov=Num_Add_Vac./Pt.N;    
        Pt.vac_SA=Pt.vac_int_influenza+Inc_Cov;
        Pt.vac_SA(Pt.vac_SA>1)=1;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Influenza_Like_Coverage_50_to_64_Variable_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '_Unimodal_Winter.mat'],'T_Run','Model_Output');


    Model_Output=cell(NS,1);
    parfor jj=1:NS
        Pt=P_All{jj};    
        Total_Additional_Doses=sum(Pt.N(50<=AC & AC<65).*Pt.vac_int_influenza(50<=AC & AC<65));
        N_A=Pt.N;
        N_A=N_A(AC>=lb_Age(aa) & AC<ub_Age(aa))./sum(N_A(AC>=lb_Age(aa) & AC<ub_Age(aa)));    
        Num_Add_Vac=zeros(size(Pt.N));
        Num_Add_Vac(AC>=lb_Age(aa) & AC<ub_Age(aa))=Total_Additional_Doses.*N_A;    
        Inc_Cov=Num_Add_Vac./Pt.N;    
        Pt.vac_SA=Pt.vac_baseline+Inc_Cov;
        Pt.vac_SA(Pt.vac_SA>1)=1;
        Pt.X0.Influenza_Campaign=Calc_Initial_Conditions(Vac_Camp,Pt);
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
    end
    save(['Annual_Campaign_Baseline_Coverage_50_to_64_Variable_Additional_Doses_Ages_' num2str(lb_Age(aa)) '_to_' num2str(ub_Age(aa)-1) '_Unimodal_Winter.mat'],'T_Run','Model_Output');
end