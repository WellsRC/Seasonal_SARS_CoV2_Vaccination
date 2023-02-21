clear;
clc;
close all;
parpool(32)

for ss=1:1000
    NS=10^4;  

    [T_Run,P] = Parameter_Sample(NS);
    
    
    MM={'August','September','October','November','December','January','February','March','April'};
    YM=[2022 2022 2022 2022 2022 2023 2023 2023 2023];
    
    count_f=1;
    while isfile(['Sample_Gen_' num2str(count_f) '_Vac_Start_' MM{1} '_' num2str(YM(1)) '.mat'])
        count_f=count_f+1;
    end
    % Save Here so do not have to wait for the simualtion to complete
    % before another pool of runs can be run
    save(['Sample_Gen_' num2str(count_f) '_Vac_Start_' MM{1} '_' num2str(YM(1)) '.mat'],'P','T_Run');
    for mm=1:9
        DI=zeros(NS,length(T_Run)-1);
        DH=zeros(NS,length(T_Run)-1);
        PH=zeros(NS,length(T_Run)-1); 
        parfor jj=1:NS
            Pt=P{jj};
            Pt.nu_V.vac_start=datenum([MM{mm} ' 1, ' num2str(YM(mm))]);
            [~,Daily_Incidence,Hospital_Admission,Hospital_Prevalence] = Run_ODE(T_Run,Pt);
            DH(jj,:)=Hospital_Admission;
            DI(jj,:)=Daily_Incidence;
            PH(jj,:)=Hospital_Prevalence;
        end
        save(['Sample_Gen_' num2str(count_f) '_Vac_Start_' MM{mm} '_' num2str(YM(mm)) '.mat'],'P','T_Run','DH','DI','PH');
    end
end
