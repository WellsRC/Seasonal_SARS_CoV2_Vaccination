function [Incidence_Costs,Hospital_Costs,Death_Cost] = Outcome_Costs

% https://academic.oup.com/ofid/article/8/12/ofab561/6470753
Av=[0:84];
Incidence_Costs=zeros(size(Av));
Hospital_Costs=20674.*ones(size(Av));
Death_Cost=27017.*ones(size(Av));

Hospital_Costs(Av>=30 & Av<=39)=2044+Hospital_Costs(Av>=30 & Av<=39);
Hospital_Costs(Av>=40 & Av<=49)=5172+Hospital_Costs(Av>=40 & Av<=49);
Hospital_Costs(Av>=50 & Av<=59)=7658+Hospital_Costs(Av>=50 & Av<=59);
Hospital_Costs(Av>=60 & Av<=69)=9750+Hospital_Costs(Av>=60 & Av<=69);
Hospital_Costs(Av>=70 & Av<=79)=8566+Hospital_Costs(Av>=70 & Av<=79);
Hospital_Costs(Av>=80)=4482+Hospital_Costs(Av>=80);

Death_Cost(Av>=30 & Av<=39)=2044+Death_Cost(Av>=30 & Av<=39);
Death_Cost(Av>=40 & Av<=49)=5172+Death_Cost(Av>=40 & Av<=49);
Death_Cost(Av>=50 & Av<=59)=7658+Death_Cost(Av>=50 & Av<=59);
Death_Cost(Av>=60 & Av<=69)=9750+Death_Cost(Av>=60 & Av<=69);
Death_Cost(Av>=70 & Av<=79)=8566+Death_Cost(Av>=70 & Av<=79);
Death_Cost(Av>=80)=4482+Death_Cost(Av>=80);

% https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9923935/
% Used relative since it was different study
Incidence_Costs(Av<18)=Hospital_Costs(Av<18)./9.47;
Incidence_Costs(Av>=18)=Hospital_Costs(Av>=18)./3.18;
end

