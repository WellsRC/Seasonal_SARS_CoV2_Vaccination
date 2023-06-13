function Supplement_Figures_1_to_3
State_V='Hospital Admission';
Scenario='Large_Winter_Continual_Vaccination_Baseline_Coverage';
Figure_Temporal(State_V,Scenario)
print(gcf,['Supplement_Figure_1.png'],'-dpng','-r300');   

Scenario='Large_Summer_Continual_Vaccination_Baseline_Coverage';
Figure_Temporal(State_V,Scenario)
print(gcf,['Supplement_Figure_2.png'],'-dpng','-r300');   

Scenario='Unimodal_WinterContinual_Vaccination_Influenza_Baseline_Coverage';
Figure_Temporal(State_V,Scenario)
print(gcf,['Supplement_Figure_3.png'],'-dpng','-r300');   

end