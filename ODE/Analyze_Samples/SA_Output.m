function [Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = SA_Output(SA_Scenario,Av,ACg)

temp_cd=pwd;
if(strcmp('Vaccine_Waning',SA_Scenario.Variable))
    load([temp_cd(1:end-15) '/All_SA_Vaccine_Waning_65_plus_Reduction=' num2str(100.*SA_Scenario.value) '.mat'],'Model_Output_Influenza','Model_Output_SARSCoV2','R_WP');
    NN=length(R_WP);

    Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence=zeros(NN,365);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Burden=zeros(NN,365);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Admission=zeros(NN,365);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Death=zeros(NN,365);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));

    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Death=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));

    for ss=1:NN 
        MOS=Model_Output_SARSCoV2{ss};
        MOI=Model_Output_Influenza{ss};

        Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence(ss,:)=MOS.Continual_Booster.Low_Coverage.Incidence;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Burden(ss,:)=MOS.Continual_Booster.Low_Coverage.Hospital_Burden;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Admission(ss,:)=MOS.Continual_Booster.Low_Coverage.Hospital_Admission;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Death(ss,:)=MOS.Continual_Booster.Low_Coverage.Death;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(ss,:)=sum(MOS.Continual_Booster.Low_Coverage.Incidence);
        Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(ss,:)=sum(MOS.Continual_Booster.Low_Coverage.Hospital_Count);
        Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count(ss,:)=sum(MOS.Continual_Booster.Low_Coverage.Death);

        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence(ss,:)=MOI.Annual_Booster.High_Coverage.Incidence;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden(ss,:)=MOI.Annual_Booster.High_Coverage.Hospital_Burden;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission(ss,:)=MOI.Annual_Booster.High_Coverage.Hospital_Admission;
        Filtered_Output_All.Annual_Booster.High_Coverage.Death(ss,:)=MOI.Annual_Booster.High_Coverage.Death;
        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Incidence);
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Hospital_Count);
        Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Death);
        for aa=1:length(ACg(:,1))
            Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(ss,aa)=sum(MOS.Continual_Booster.Low_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(ss,aa)=sum(MOS.Continual_Booster.Low_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(ss,aa)=sum(MOS.Continual_Booster.Low_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));

            Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
        end
    end
elseif(strcmp('Vaccination_coverage_Scaled',SA_Scenario.Variable))
    load([temp_cd(1:end-15) '/Scale_Seasonal_Influenza_Coverage_' num2str(100.*SA_Scenario.value(1)) '_and_SARSCoV2_Coverage_Under5_' num2str(100.*SA_Scenario.value(2)) '.mat'],'Model_Output_Influenza','R_WP');  
    NN=length(R_WP);

    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Death=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));

    for ss=1:NN 
        MOI=Model_Output_Influenza{ss};

        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence(ss,:)=MOI.Annual_Booster.High_Coverage.Incidence;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden(ss,:)=MOI.Annual_Booster.High_Coverage.Hospital_Burden;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission(ss,:)=MOI.Annual_Booster.High_Coverage.Hospital_Admission;
        Filtered_Output_All.Annual_Booster.High_Coverage.Death(ss,:)=MOI.Annual_Booster.High_Coverage.Death;
        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Incidence);
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Hospital_Count);
        Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Death);
        for aa=1:length(ACg(:,1))

            Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
        end
    end
elseif(strcmp('Vaccination_coverage_Under_5',SA_Scenario.Variable))
    load([temp_cd(1:end-15) '/Scale_Seasonal_Influenza_Coverage_' num2str(100.*SA_Scenario.value(1)) '_and_SARSCoV2_Coverage_Under5_' num2str(100.*SA_Scenario.value(2)) '.mat'],'Model_Output_SARSCoV2','R_WP');
    NN=length(R_WP);

    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Death=zeros(NN,365);
    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count=zeros(NN,1);
    Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));
    Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=zeros(NN,length(ACg(:,1)));

    for ss=1:NN 
        MOI=Model_Output_SARSCoV2{ss};

        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence(ss,:)=MOI.Annual_Booster.High_Coverage.Incidence;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden(ss,:)=MOI.Annual_Booster.High_Coverage.Hospital_Burden;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission(ss,:)=MOI.Annual_Booster.High_Coverage.Hospital_Admission;
        Filtered_Output_All.Annual_Booster.High_Coverage.Death(ss,:)=MOI.Annual_Booster.High_Coverage.Death;
        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Incidence);
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Hospital_Count);
        Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count(ss,:)=sum(MOI.Annual_Booster.High_Coverage.Death);
        for aa=1:length(ACg(:,1))

            Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(ss,aa)=sum(MOI.Annual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
        end
    end
end
[Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer]=SA_Output_Peak_Filter(SA_Scenario.Variable,Filtered_Output_All,R_WP);

end

