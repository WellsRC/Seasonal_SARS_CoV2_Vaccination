function [Cost_Total,Cost_Age,Cost_Compliment_Age]=Calculate_Cost(Incidence,Hospitalization,Deaths,ACg,Av)

[Incidence_Costs,Hospital_Costs,Death_Cost] = Outcome_Costs;
%https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0263813
pp=zeros(size(Av));
pp(Av<=30)=35607./(35607+295112);
pp(31<=Av & Av<=50)=101753./(101753+464876);
pp(51<=Av & Av<=64)=141501./(141501+325762);
pp(65<=Av & Av<=74)=116393./(116393+156462);
pp(Av>=75)=150381./(150381+117866);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine the number of outpatients plus inpatients from the incidence
% pp=H/(K.*I)
% The number of outpatients would then be K.*I-H
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K=Hospitalization(:)./(pp(:).*Incidence(:));
Cost_All=(K(:).*Incidence(:)-Hospitalization(:)).*Incidence_Costs(:)+(Hospitalization(:)-Deaths(:)).*Hospital_Costs(:)+Deaths(:).*Death_Cost(:);
Cost_Total=sum(Cost_All);
Cost_Age=zeros(1,length(ACg(:,1)));
Cost_Compliment_Age=zeros(1,length(ACg(:,1)));
for aa=1:length(ACg(:,1))
    % Age classes
    Cost_Age(aa)=sum(Cost_All(ACg(aa,1)<=Av & Av<=ACg(aa,2)));

    % Compliment of age classes
    Cost_Compliment_Age(aa)=sum(Cost_All(ACg(aa,1)>Av | Av>ACg(aa,2)));
end
end