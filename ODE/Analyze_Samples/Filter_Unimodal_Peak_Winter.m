function [Filtered_Output_All] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg)

Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Burden=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Admission=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.Low_Coverage.Death=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));


Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Burden=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Admission=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.Low_Coverage.Death=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));

Filtered_Output_All.Annual_Booster.High_Coverage.Incidence=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.High_Coverage.Death=zeros(NG*NS,365);
Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));

Filtered_Output_All.Continual_Booster.High_Coverage.Incidence=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Burden=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Admission=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.High_Coverage.Death=zeros(NG*NS,365);
Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));

P_All=cell(NG*NS,1);

Pks=zeros(NG*NS,1);
Mag_Peaks=NaN.*zeros(NG*NS,2);
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
    for ss=1:NS 
        MO=Model_Output{ss};
        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1),:)]=Hospital_Admission_Unimodal_Winter_Peak(MO.Continual_Booster.Low_Coverage.Hospital_Admission,T_Run);
        
        Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence(ss+NS.*(gg-1),:)=MO.Annual_Booster.Low_Coverage.Incidence;
        Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Annual_Booster.Low_Coverage.Hospital_Burden;
        Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Admission(ss+NS.*(gg-1),:)=MO.Annual_Booster.Low_Coverage.Hospital_Admission;
        Filtered_Output_All.Annual_Booster.Low_Coverage.Death(ss+NS.*(gg-1),:)=MO.Annual_Booster.Low_Coverage.Death;
        Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Annual_Booster.Low_Coverage.Incidence);
        Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Annual_Booster.Low_Coverage.Hospital_Count);
        Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Annual_Booster.Low_Coverage.Death);
        
        Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence(ss+NS.*(gg-1),:)=MO.Continual_Booster.Low_Coverage.Incidence;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Continual_Booster.Low_Coverage.Hospital_Burden;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Admission(ss+NS.*(gg-1),:)=MO.Continual_Booster.Low_Coverage.Hospital_Admission;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Death(ss+NS.*(gg-1),:)=MO.Continual_Booster.Low_Coverage.Death;
        Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Continual_Booster.Low_Coverage.Incidence);
        Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Continual_Booster.Low_Coverage.Hospital_Count);
        Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Continual_Booster.Low_Coverage.Death);
        
        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence(ss+NS.*(gg-1),:)=MO.Annual_Booster.High_Coverage.Incidence;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Annual_Booster.High_Coverage.Hospital_Burden;
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Admission(ss+NS.*(gg-1),:)=MO.Annual_Booster.High_Coverage.Hospital_Admission;
        Filtered_Output_All.Annual_Booster.High_Coverage.Death(ss+NS.*(gg-1),:)=MO.Annual_Booster.High_Coverage.Death;
        Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Annual_Booster.High_Coverage.Incidence);
        Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Annual_Booster.High_Coverage.Hospital_Count);
        Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Annual_Booster.High_Coverage.Death);
        
        Filtered_Output_All.Continual_Booster.High_Coverage.Incidence(ss+NS.*(gg-1),:)=MO.Continual_Booster.High_Coverage.Incidence;
        Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Continual_Booster.High_Coverage.Hospital_Burden;
        Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Admission(ss+NS.*(gg-1),:)=MO.Continual_Booster.High_Coverage.Hospital_Admission;
        Filtered_Output_All.Continual_Booster.High_Coverage.Death(ss+NS.*(gg-1),:)=MO.Continual_Booster.High_Coverage.Death;
        Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Continual_Booster.High_Coverage.Incidence);
        Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Continual_Booster.High_Coverage.Hospital_Count);
        Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Continual_Booster.High_Coverage.Death);
        for aa=1:length(ACg(:,1))
            Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.Low_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.Low_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.Low_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
                       
            Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.Low_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.Low_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.Low_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));

            Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.High_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
                       
            Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.High_Coverage.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            
            Filtered_Output_All.Annual_Booster.Low_Coverage.Incidence_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.Low_Coverage.Age_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.Low_Coverage.Death_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.Low_Coverage.Age_Death(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.Low_Coverage.Hospital_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.Low_Coverage.Age_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),end));
                       
            Filtered_Output_All.Continual_Booster.Low_Coverage.Incidence_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.Low_Coverage.Age_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.Low_Coverage.Death_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.Low_Coverage.Age_Death(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.Low_Coverage.Hospital_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.Low_Coverage.Age_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),end));

            Filtered_Output_All.Annual_Booster.High_Coverage.Incidence_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.High_Coverage.Age_Death(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Annual_Booster.High_Coverage.Hospital_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Annual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),end));
                       
            Filtered_Output_All.Continual_Booster.High_Coverage.Incidence_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.High_Coverage.Age_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.High_Coverage.Death_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.High_Coverage.Age_Death(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Continual_Booster.High_Coverage.Hospital_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Continual_Booster.High_Coverage.Age_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),end));
        end
    end
    P_All([1:NS]+NS.*(gg-1))=P;
end


[Filtered_Output_All]=Output_Peak_Filter_Unimodal_Winter(Filtered_Output_All,Pks);

P_All=P_All(Pks==1);

save('Parameter_Filtered_Unimodal_Winter.mat','P_All');

end

