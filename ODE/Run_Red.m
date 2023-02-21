function Run_Red(mm)

    MM={'August','September','October','November','December','January','February','March','April'};
    YM=[2022 2022 2022 2022 2022 2023 2023 2023 2023];
    Reduction_Vac=0:0.05:0.3;

    for ss=1:6

        load(['Sample_Gen_' num2str(ss) '_Vac_Start_' MM{mm} '_' num2str(YM(mm)) '.mat'],'P','T_Run');
        NS=length(P);
        for mm=1:7
            DI_Adj=zeros(NS,length(T_Run)-1);
            DH_Adj=zeros(NS,length(T_Run)-1);
            PH_Adj=zeros(NS,length(T_Run)-1); 
            parfor jj=1:NS
                Pt=P{jj};
                Pt.nu_V.vac_start=datenum([MM{mm} ' 1, ' num2str(YM(mm))]);
                Parameters_Adj = Adjust_Vaccination(Pt,Reduction_Vac(mm));
                [~,Daily_Incidence,Hospital_Admission,Hospital_Prevalence] = Run_ODE(T_Run,Parameters_Adj);
                DH_Adj(jj,:)=Hospital_Admission;
                DI_Adj(jj,:)=Daily_Incidence;
                PH_Adj(jj,:)=Hospital_Prevalence;
            end
            save(['Sample_Gen_' num2str(count_f) '_Vac_Start_' MM{mm} '_' num2str(YM(mm)) '_Reduction_' num2str(Reduction_Vac(mm)) '.mat'],'Parameters_Adj','DH_Adj','DI_Adj','PH_Adj');   
        end
    end
end