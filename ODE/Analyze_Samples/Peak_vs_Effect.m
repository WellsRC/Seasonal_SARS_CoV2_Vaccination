function Peak_vs_Effect(Alt_Model,Base_Model,Scenario_Name)


T_Run=[datenum('September 1, 2022'):datenum('September 1, 2023')];
% T_Run=T_Run(1:end-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conduct calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Cumulative_Count_Incidence_dt=Alt_Model.Incidence_Cumulative_Count-Base_Model.Incidence_Cumulative_Count;
Cumulative_Count_Hospital_dt=Alt_Model.Hospital_Cumulative_Count-Base_Model.Hospital_Cumulative_Count;
Cumulative_Count_Death_dt=Alt_Model.Death_Cumulative_Count-Base_Model.Death_Cumulative_Count;
Cost_Total_dt=Alt_Model.Cost_Total-Base_Model.Cost_Total;

Peak_Comp.Cumulative_Count_Incidence_rel=Cumulative_Count_Incidence_dt./Base_Model.Incidence_Cumulative_Count;
Peak_Comp.Cumulative_Count_Hospital_rel=Cumulative_Count_Hospital_dt./Base_Model.Hospital_Cumulative_Count;
Peak_Comp.Cumulative_Count_Death_rel=Cumulative_Count_Death_dt./Base_Model.Death_Cumulative_Count;
Peak_Comp.Cost_Total_rel=Cost_Total_dt./Base_Model.Cost_Total;

Mag_Peaks=zeros(length(Cost_Total_dt),2);
Peak_Comp.Baseline.Incidence_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Baseline.Hospital_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Baseline.Death_Burden=zeros(length(Cost_Total_dt),2);

Peak_Comp.Baseline.Incidence_Avg_Daily_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Baseline.Hospital_Avg_Daily_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Baseline.Death_Avg_Daily_Burden=zeros(length(Cost_Total_dt),2);

Peak_Comp.Alternative.Incidence_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Alternative.Hospital_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Alternative.Death_Burden=zeros(length(Cost_Total_dt),2);

Peak_Comp.Alternative.Incidence_Avg_Daily_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Alternative.Hospital_Avg_Daily_Burden=zeros(length(Cost_Total_dt),2);
Peak_Comp.Alternative.Death_Avg_Daily_Burden=zeros(length(Cost_Total_dt),2);

NP_T=length(Cost_Total_dt);
for ii=1:NP_T
    Peak_Comp.Baseline.Incidence_Burden(ii,:)=[sum(Base_Model.Incidence(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) sum(Base_Model.Incidence(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    Peak_Comp.Baseline.Hospital_Burden(ii,:)=[sum(Base_Model.Hospital_Admission(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) sum(Base_Model.Hospital_Admission(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];    
    Peak_Comp.Baseline.Death_Burden(ii,:)=[sum(Base_Model.Death(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) sum(Base_Model.Death(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    
    Peak_Comp.Baseline.Incidence_Avg_Daily_Burden(ii,:)=[mean(Base_Model.Incidence(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) mean(Base_Model.Incidence(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    Peak_Comp.Baseline.Hospital_Avg_Daily_Burden(ii,:)=[mean(Base_Model.Hospital_Admission(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) mean(Base_Model.Hospital_Admission(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];    
    Peak_Comp.Baseline.Death_Avg_Daily_Burden(ii,:)=[mean(Base_Model.Death(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) mean(Base_Model.Death(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    
    
    Peak_Comp.Alternative.Incidence_Burden(ii,:)=[sum(Alt_Model.Incidence(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) sum(Alt_Model.Incidence(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    Peak_Comp.Alternative.Hospital_Burden(ii,:)=[sum(Alt_Model.Hospital_Admission(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) sum(Alt_Model.Hospital_Admission(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];    
    Peak_Comp.Alternative.Death_Burden(ii,:)=[sum(Alt_Model.Death(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) sum(Alt_Model.Death(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    
    Peak_Comp.Alternative.Incidence_Avg_Daily_Burden(ii,:)=[mean(Alt_Model.Incidence(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) mean(Alt_Model.Incidence(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    Peak_Comp.Alternative.Hospital_Avg_Daily_Burden(ii,:)=[mean(Alt_Model.Hospital_Admission(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) mean(Alt_Model.Hospital_Admission(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];    
    Peak_Comp.Alternative.Death_Avg_Daily_Burden(ii,:)=[mean(Alt_Model.Death(ii,T_Run(1:end-1)<datenum('March 3, 2023'))) mean(Alt_Model.Death(ii,T_Run(1:end-1)>=datenum('March 3, 2023')))];
    
    
    [m_pks,dt_pks]=findpeaks(Base_Model.Hospital_Admission(ii,:),T_Run(1:end-1)); 
    if((length(dt_pks)>=2))
        np=length(dt_pks);
        for pp=1:np
           if(dt_pks(pp)>=datenum('December 1, 2022') && dt_pks(pp)<=datenum('January 15, 2023'))
               Mag_Peaks(ii,1)=max(m_pks(pp),Mag_Peaks(ii,1));
           end
           if(dt_pks(pp)>=datenum('July 1, 2023') && dt_pks(pp)<=datenum('August 15, 2023'))
               Mag_Peaks(ii,2)=max(m_pks(pp),Mag_Peaks(ii,2));
           end
        end
    end
end

Peak_Comp.Rel_Peak=Mag_Peaks(:,2)./Mag_Peaks(:,1);

save(['Peak_Mag_Comparison_' Scenario_Name '.mat'],'Peak_Comp');

end