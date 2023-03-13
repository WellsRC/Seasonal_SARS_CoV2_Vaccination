parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P');
NS=length(P);
Model_Output=cell(NS,1);

parfor jj=1:NS
    Pt=P{jj};
    Pt.gamma_V(AC>=65)=Pt.gamma_V(AC>=65).*(1-0.25);
    [~,~,Model_Output{jj}] = Run_ODE(T_Run,Pt);
end
save(['All_SA_Vaccine_Waning_65_plus_Reduction=25.mat'],'T_Run','Model_Output');

load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_Large_Winter');
NS=length(P_Large_Winter);
Model_Output=cell(NS,1);

parfor jj=1:NS
    Pt=P_Large_Winter{jj};
    Pt.gamma_V(AC>=65)=Pt.gamma_V(AC>=65).*(1-0.25);
    [~,~,Model_Output{jj}] = Run_ODE(T_Run,Pt);
end
save(['Large_Winter_SA_Vaccine_Waning_65_plus_Reduction=25.mat'],'T_Run','Model_Output');

load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_Large_Summer');
NS=length(P_Large_Summer);
Model_Output=cell(NS,1);

parfor jj=1:NS
    Pt=P_Large_Summer{jj};
    Pt.gamma_V(AC>=65)=Pt.gamma_V(AC>=65).*(1-0.25);
    [~,~,Model_Output{jj}] = Run_ODE(T_Run,Pt);
end
save(['Large_Summer_SA_Vaccine_Waning_65_plus_Reduction=25.mat'],'T_Run','Model_Output');
