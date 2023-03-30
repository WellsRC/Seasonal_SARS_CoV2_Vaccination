function F=Objective_VWR(x,Pt,AC,C_Death,T_Run)
    Pt.gamma_V(AC>=65)=Pt.gamma_V(AC>=65).*(1-x);
    [~,~,Model_Output] = Run_Annual_Booster_ODE(T_Run,Pt);
    ME=sum(Model_Output.Annual_Booster.High_Coverage.Age_Death(AC>=65,end));
    
    F=(ME-C_Death).^2;
end