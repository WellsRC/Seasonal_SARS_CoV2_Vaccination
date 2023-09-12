function Supplement_Figures_1_to_3
State_V='Hospital Admission';
Scenario='Larger_Winter_Baseline_Continual_Vaccination_Raw';
Figure_Temporal(State_V,Scenario)
print(gcf,['Supplement_Figure_1.png'],'-dpng','-r300');   

Scenario='Larger_Summer_Baseline_Continual_Vaccination_Raw';
Figure_Temporal(State_V,Scenario)
print(gcf,['Supplement_Figure_2.png'],'-dpng','-r300');   

Scenario='Unimodal_Baseline_Continual_Vaccination_Raw';
Figure_Temporal(State_V,Scenario)
print(gcf,['Supplement_Figure_3.png'],'-dpng','-r300');   

end