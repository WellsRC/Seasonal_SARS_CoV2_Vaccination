function Red_VW=Est_Reduction_Waning_Rate(P,AC,C_Death,vac_red,baseline_s,T_Run)

Pt=Reduce_Vaccination_65(P,vac_red,baseline_s);
            
Red_VW=fminbnd(@(x)Objective_VWR(x,Pt,AC,C_Death,T_Run),0,1);            
end