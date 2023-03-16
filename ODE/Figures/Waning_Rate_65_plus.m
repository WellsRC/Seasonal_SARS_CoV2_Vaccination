clear;
clc;

Scenario={'All','Large_Winter','Large_Summer'};
State_V={'Incidence','Hospitalizations','Deaths'};

for oo=1:3
    Age_Dist_Vaccine_Wane_65_plus_Main(State_V{oo})
    for ss=1:3
        Age_Dist_Vaccine_Wane_65_plus_Supp(Scenario{ss},State_V{oo})
    end
end