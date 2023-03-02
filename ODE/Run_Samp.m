clear;
clc;
close all;
parpool(32)
rng('shuffle');
for ss=1:100
    NS=10^3;  

    [T_Run,P] = Parameter_Sample(NS);
    count_f=1;
    while isfile(['Sample_Gen_' num2str(count_f) '.mat'])
        count_f=count_f+1;
    end
    % Save Here so do not have to wait for the simualtion to complete
    % before another pool of runs can be run
    save(['Sample_Gen_' num2str(count_f) '.mat'],'P','T_Run');
    Incidence_IC=zeros(NS,length(T_Run)-1);
    Death_IC=zeros(NS,length(T_Run)-1);
    Hospital_Admission_IC=zeros(NS,length(T_Run)-1);
    Hospital_Burden_IC=zeros(NS,length(T_Run)-1); 
    Hospital_IC=zeros(NS,length(T_Run)-1); 
    
    Incidence_AC=zeros(NS,length(T_Run)-1);
    Death_AC=zeros(NS,length(T_Run)-1);
    Hospital_Admission_AC=zeros(NS,length(T_Run)-1);
    Hospital_Burden_AC=zeros(NS,length(T_Run)-1); 
    Hospital_AC=zeros(NS,length(T_Run)-1); 
    parfor jj=1:NS
        Pt=P{jj};
        [~,Daily_Incidence_Influenza_Campaign,Hospital_Admission_Influenza_Campaign,Death_Count_Influenza_Campaign,Hospital_Prevalence_Influenza_Campaign,Hospital_Count_Influenza_Campaign,Daily_Incidence_Annual_Campaign,Hospital_Admission_Annual_Campaign,Death_Count_Annual_Campaign,Hospital_Prevalence_Annual_Campaign,Hospital_Count_Annual_Campaign] = Run_ODE(T_Run,Pt);
        Hospital_Admission_IC(jj,:)=Hospital_Admission_Influenza_Campaign;
        Incidence_IC(jj,:)=Daily_Incidence_Influenza_Campaign;
        Hospital_Burden_IC(jj,:)=Hospital_Prevalence_Influenza_Campaign;
        Death_IC(jj,:)=Death_Count_Influenza_Campaign;
        Hospital_IC(jj,:)=Hospital_Count_Influenza_Campaign;
        
        Hospital_Admission_AC(jj,:)=Hospital_Admission_Annual_Campaign;
        Incidence_AC(jj,:)=Daily_Incidence_Annual_Campaign;
        Hospital_Burden_AC(jj,:)=Hospital_Prevalence_Annual_Campaign;
        Death_AC(jj,:)=Death_Count_Annual_Campaign;
        Hospital_AC(jj,:)=Hospital_Count_Annual_Campaign;
    end
    save(['Sample_Gen_' num2str(count_f) '.mat'],'P','T_Run','Hospital_Admission_IC','Incidence_IC','Hospital_Burden_IC','Death_IC','Hospital_IC','Hospital_Admission_AC','Incidence_AC','Hospital_Burden_AC','Death_AC','Hospital_AC');
    
end
