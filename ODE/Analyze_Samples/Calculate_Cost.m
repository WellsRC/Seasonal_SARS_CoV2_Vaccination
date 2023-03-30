function Cost_Total=Calculate_Cost(Incidence,Hospitalization,Deaths)

[Incidence_Costs,Hospital_Costs,Death_Cost] = Outcome_Costs;

Cost_Total=sum(Death_Cost(:).*Deaths(:)+Hospital_Costs(:).*(Hospitalization(:)-Deaths(:))+Incidence_Costs(:).*(Incidence(:)-Hospitalization(:)));
end