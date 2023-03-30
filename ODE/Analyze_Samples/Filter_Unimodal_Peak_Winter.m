function [Filtered_Output_All] = Filter_Unimodal_Peak_Winter(NG,NS,Av,ACg)

Filtered_Output_All.Incidence=zeros(NG*NS,365);
Filtered_Output_All.Hospital_Burden=zeros(NG*NS,365);
Filtered_Output_All.Hospital_Admission=zeros(NG*NS,365);
Filtered_Output_All.Death=zeros(NG*NS,365);
Filtered_Output_All.Incidence_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Hospital_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Death_Cumulative_Count=zeros(NG*NS,1);
Filtered_Output_All.Incidence_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Death_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Hospital_Cumulative_Count_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Death_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age=zeros(NG*NS,length(ACg(:,1)));
Filtered_Output_All.Cost=zeros(NG*NS,1);

P_All=cell(NG*NS,1);

Pks=zeros(NG*NS,1);
Mag_Peaks=NaN.*zeros(NG*NS,2);
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
    for ss=1:NS 
        MO=Model_Output{ss};
        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1),:)]=Hospital_Admission_Unimodal_Winter_Peak(MO.Hospital_Admission,T_Run);
        
        Filtered_Output_All.Cost(ss+NS.*(gg-1))=Calculate_Cost(MO.Age_Incidence(:,end),MO.Age_Hospital(:,end),MO.Age_Death(:,end));
        Filtered_Output_All.Incidence(ss+NS.*(gg-1),:)=MO.Incidence;
        Filtered_Output_All.Hospital_Burden(ss+NS.*(gg-1),:)=MO.Hospital_Burden;
        Filtered_Output_All.Hospital_Admission(ss+NS.*(gg-1),:)=MO.Hospital_Admission;
        Filtered_Output_All.Death(ss+NS.*(gg-1),:)=MO.Death;
        Filtered_Output_All.Incidence_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Incidence);
        Filtered_Output_All.Hospital_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Hospital_Count);
        Filtered_Output_All.Death_Cumulative_Count(ss+NS.*(gg-1),:)=sum(MO.Death);
        
        for aa=1:length(ACg(:,1))                       
            Filtered_Output_All.Incidence_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Age_Incidence(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Death_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Age_Death(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
            Filtered_Output_All.Hospital_Cumulative_Count_Age(ss+NS.*(gg-1),aa)=sum(MO.Age_Hospital(ACg(aa,1)<=Av & Av<=ACg(aa,2),end));
                       
            Filtered_Output_All.Incidence_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Age_Incidence(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Death_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Age_Death(ACg(aa,1)>Av | Av>ACg(aa,2),end));
            Filtered_Output_All.Hospital_Cumulative_Count_Compliment_Age(ss+NS.*(gg-1),aa)=sum(MO.Age_Hospital(ACg(aa,1)>Av | Av>ACg(aa,2),end));
        end
    end
    P_All([1:NS]+NS.*(gg-1))=P;
end

[Filtered_Output_All]=Output_Peak_Filter_Unimodal_Winter(Filtered_Output_All,Pks);

P_All=P_All(Pks==1);

save('Parameter_Filtered_Unimodal_Winter.mat','P_All');

end

