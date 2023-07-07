clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Baseline: Single dose
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
Measure=cell(34,2);
Measure{1,1}='Percent reduction from status-quo';
Measure{2,2}='Incidence';
Measure{6,2}='Hospitalizations';
Measure{10,2}='Deaths';
Measure{14,2}='Direct costs';
Population=cell(34,1);
Population{2}='Total';
Population{6}='Total';
Population{10}='Total';
Population{14}='Total';

temp_cd=pwd;
temp_cd=[temp_cd(1:end-7) 'Analyze_Samples\'];

Baseline=cell(34,2);
Baseline{1,1}='Single-dose';
Baseline{1,2}='Two-doses 50+';

for dd=1:2
    if(dd==1)
        load([temp_cd 'Comparison_Summary_Large_Winter_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat']);
    else
        load([temp_cd 'Comparison_Summary_Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older-Baseline_Continual_Vaccination.mat']);
    end

    Comparison.Average.Cumulative_Count_Incidence_rel=round(Comparison.Average.Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Cumulative_Count_Hospital_rel=round(Comparison.Average.Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Cumulative_Count_Death_rel=round(Comparison.Average.Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Total_rel=round(Comparison.Average.Cost_Total_rel,3);

    Comparison.PRCT.Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Cumulative_Count_Death_rel=round(Comparison.PRCT.Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Total_rel=round(Comparison.PRCT.Cost_Total_rel,3);

    Comparison.Average.Age_Cumulative_Count_Incidence_rel=round(Comparison.Average.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Age_Cumulative_Count_Hospital_rel=round(Comparison.Average.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Age_Cumulative_Count_Death_rel=round(Comparison.Average.Age_Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Age_rel=round(Comparison.Average.Cost_Age_rel,3);

    Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Death_rel=round(Comparison.PRCT.Age_Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Age_rel=round(Comparison.PRCT.Cost_Age_rel,3);

    Baseline{2,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Incidence_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==2.5),'%3.1f') '%)'];
    Baseline{6,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==2.5),'%3.1f') '%)'];
    Baseline{10,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Death_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==2.5),'%3.1f') '%)'];
    Baseline{14,dd}=[num2str(-100.*Comparison.Average.Cost_Total_rel(end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==97.5,end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==2.5,end),'%3.1f') '%)'];
    
    aav=[7 5 6];
    agc={['0' char(8211) '49'],['50' char(8211) '64'],'65+'};
    for ii=1:3
        Population{2+ii}=agc{ii};
        Population{6+ii}=agc{ii};
        Population{10+ii}=agc{ii};
        Population{14+ii}=agc{ii};
    
        Baseline{2+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Incidence_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Baseline{6+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Hospital_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Baseline{10+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Death_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Baseline{14+ii,dd}=[num2str(-100.*Comparison.Average.Cost_Age_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        
    end
end

Delay_28_days=cell(34,2);

Delay_28_days{1,1}='Single-dose';
Delay_28_days{1,2}='Two-doses 50+';

for dd=1:2
    if(dd==1)
        load([temp_cd 'Comparison_Summary_Large_Winter_Annual_Campaign_Influenza_Like_Coverage_Proportion_Delay_60_Delay_28_days.mat']);
    else
        load([temp_cd 'Comparison_Summary_Large_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older_Proportion_Delay_60_Delay_28_days.mat']);
    end
    Comparison.Average.Cumulative_Count_Incidence_rel=round(Comparison.Average.Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Cumulative_Count_Hospital_rel=round(Comparison.Average.Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Cumulative_Count_Death_rel=round(Comparison.Average.Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Total_rel=round(Comparison.Average.Cost_Total_rel,3);

    Comparison.PRCT.Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Cumulative_Count_Death_rel=round(Comparison.PRCT.Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Total_rel=round(Comparison.PRCT.Cost_Total_rel,3);

    Comparison.Average.Age_Cumulative_Count_Incidence_rel=round(Comparison.Average.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Age_Cumulative_Count_Hospital_rel=round(Comparison.Average.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Age_Cumulative_Count_Death_rel=round(Comparison.Average.Age_Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Age_rel=round(Comparison.Average.Cost_Age_rel,3);

    Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Death_rel=round(Comparison.PRCT.Age_Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Age_rel=round(Comparison.PRCT.Cost_Age_rel,3);


    Delay_28_days{2,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Incidence_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==2.5),'%3.1f') '%)'];
    Delay_28_days{6,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==2.5),'%3.1f') '%)'];
    Delay_28_days{10,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Death_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==2.5),'%3.1f') '%)'];
    Delay_28_days{14,dd}=[num2str(-100.*Comparison.Average.Cost_Total_rel(end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==97.5,end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==2.5,end),'%3.1f') '%)'];
    
    
    aav=[7 5 6];
    for ii=1:3
        Delay_28_days{2+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Incidence_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Delay_28_days{6+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Hospital_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Delay_28_days{10+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Death_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Delay_28_days{14+ii,dd}=[num2str(-100.*Comparison.Average.Cost_Age_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        
    end
end



Large_Summer_Peak=cell(34,2);

Large_Summer_Peak{1,1}='Single-dose';
Large_Summer_Peak{1,2}='Two-doses 50+';
for dd=1:2
    if(dd==1)
        load([temp_cd 'Comparison_Summary_Large_Summer_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat']);
    else
        load([temp_cd 'Comparison_Summary_Large_Summer_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older-Baseline_Continual_Vaccination.mat']);
    end
    Comparison.Average.Cumulative_Count_Incidence_rel=round(Comparison.Average.Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Cumulative_Count_Hospital_rel=round(Comparison.Average.Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Cumulative_Count_Death_rel=round(Comparison.Average.Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Total_rel=round(Comparison.Average.Cost_Total_rel,3);

    Comparison.PRCT.Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Cumulative_Count_Death_rel=round(Comparison.PRCT.Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Total_rel=round(Comparison.PRCT.Cost_Total_rel,3);

    Comparison.Average.Age_Cumulative_Count_Incidence_rel=round(Comparison.Average.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Age_Cumulative_Count_Hospital_rel=round(Comparison.Average.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Age_Cumulative_Count_Death_rel=round(Comparison.Average.Age_Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Age_rel=round(Comparison.Average.Cost_Age_rel,3);

    Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Death_rel=round(Comparison.PRCT.Age_Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Age_rel=round(Comparison.PRCT.Cost_Age_rel,3);

    Large_Summer_Peak{2,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Incidence_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==2.5),'%3.1f') '%)'];
    Large_Summer_Peak{6,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==2.5),'%3.1f') '%)'];
    Large_Summer_Peak{10,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Death_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==2.5),'%3.1f') '%)'];
    Large_Summer_Peak{14,dd}=[num2str(-100.*Comparison.Average.Cost_Total_rel(end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==97.5,end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==2.5,end),'%3.1f') '%)'];
    
    
    aav=[7 5 6];
    for ii=1:3
        Large_Summer_Peak{2+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Incidence_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Large_Summer_Peak{6+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Hospital_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Large_Summer_Peak{10+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Death_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Large_Summer_Peak{14+ii,dd}=[num2str(-100.*Comparison.Average.Cost_Age_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        
    end
end


Single_Peak=cell(34,2);

Single_Peak{1,1}='Single-dose';
Single_Peak{1,2}='Two-doses 50+';

for dd=1:2
    if(dd==1)
        load([temp_cd 'Comparison_Summary_Unimodal_Winter_Annual_Campaign_Influenza_Like_Coverage-Baseline_Continual_Vaccination.mat']);
    else
        load([temp_cd 'Comparison_Summary_Unimodal_Winter_Two_Campaign_Influenza_Like_Coverage_180_days_50_and_older-Baseline_Continual_Vaccination.mat']);
    end

    Comparison.Average.Cumulative_Count_Incidence_rel=round(Comparison.Average.Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Cumulative_Count_Hospital_rel=round(Comparison.Average.Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Cumulative_Count_Death_rel=round(Comparison.Average.Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Total_rel=round(Comparison.Average.Cost_Total_rel,3);

    Comparison.PRCT.Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Cumulative_Count_Death_rel=round(Comparison.PRCT.Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Total_rel=round(Comparison.PRCT.Cost_Total_rel,3);

    Comparison.Average.Age_Cumulative_Count_Incidence_rel=round(Comparison.Average.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.Average.Age_Cumulative_Count_Hospital_rel=round(Comparison.Average.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.Average.Age_Cumulative_Count_Death_rel=round(Comparison.Average.Age_Cumulative_Count_Death_rel,3);
    Comparison.Average.Cost_Age_rel=round(Comparison.Average.Cost_Age_rel,3);

    Comparison.PRCT.Age_Cumulative_Count_Incidence_rel=round(Comparison.PRCT.Age_Cumulative_Count_Incidence_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Hospital_rel=round(Comparison.PRCT.Age_Cumulative_Count_Hospital_rel,3);
    Comparison.PRCT.Age_Cumulative_Count_Death_rel=round(Comparison.PRCT.Age_Cumulative_Count_Death_rel,3);
    Comparison.PRCT.Cost_Age_rel=round(Comparison.PRCT.Cost_Age_rel,3);

    Single_Peak{2,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Incidence_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Incidence_rel(PRCT==2.5),'%3.1f') '%)'];
    Single_Peak{6,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Hospital_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Hospital_rel(PRCT==2.5),'%3.1f') '%)'];
    Single_Peak{10,dd}=[num2str(-100.*Comparison.Average.Cumulative_Count_Death_rel,'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==97.5),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cumulative_Count_Death_rel(PRCT==2.5),'%3.1f') '%)'];
    Single_Peak{14,dd}=[num2str(-100.*Comparison.Average.Cost_Total_rel(end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==97.5,end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Total_rel(PRCT==2.5,end),'%3.1f') '%)'];
    
    
    aav=[7 5 6];
    for ii=1:3
        Single_Peak{2+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Incidence_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Incidence_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Single_Peak{6+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Hospital_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Hospital_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Single_Peak{10+ii,dd}=[num2str(-100.*Comparison.Average.Age_Cumulative_Count_Death_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Age_Cumulative_Count_Death_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        Single_Peak{14+ii,dd}=[num2str(-100.*Comparison.Average.Cost_Age_rel(1,aav(ii),end),'%3.1f') '% (' num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==97.5,aav(ii),end),'%3.1f') '%' char(8211) num2str(-100.*Comparison.PRCT.Cost_Age_rel(PRCT==2.5,aav(ii),end),'%3.1f') '%)'];
        
    end
end
T=table(Measure,Population,Baseline,Delay_28_days,Large_Summer_Peak,Single_Peak);

writetable(T,'Supplemental_Results.xlsx');