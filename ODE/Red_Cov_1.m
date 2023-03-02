clear;
clc;
close all;
parpool(32)

load('Parameter_Filtered.mat','P_Samp');
NS=length(P_Samp);

T_Run=[datenum('September 1, 2022'):datenum('September 1, 2023')];

for rr=1:10
    
    Red_Cov=rr./10;
    
    Incidence_IC=zeros(NS,length(T_Run)-1);
    Death_IC=zeros(NS,length(T_Run)-1);
    Hospital_Admission_IC=zeros(NS,length(T_Run)-1);
    Hospital_Burden_IC=zeros(NS,length(T_Run)-1); 
    
    parfor jj=1:NS
        Pt=Adjust_Vaccination(P_Samp{jj},datenum('September 1, 2022'),Red_Cov);
        [~,Daily_Incidence_Influenza_Campaign,Hospital_Admission_Influenza_Campaign,Hospital_Death_Count_Influenza_Campaign,Hospital_Prevalence_Influenza_Campaign] = Run_Influenza(T_Run,Pt);
        Hospital_Admission_IC(jj,:)=Hospital_Admission_Influenza_Campaign;
        Incidence_IC(jj,:)=Daily_Incidence_Influenza_Campaign;
        Hospital_Burden_IC(jj,:)=Hospital_Prevalence_Influenza_Campaign;
        Death_IC(jj,:)=Hospital_Death_Count_Influenza_Campaign;
    end
    save(['Reduce_Coverage_' num2str(100.*Red_Cov) '.mat'],'T_Run','Hospital_Admission_IC','Incidence_IC','Hospital_Burden_IC','Death_IC');
    
end
