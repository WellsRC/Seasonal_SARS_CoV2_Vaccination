function [Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer] = Filter_Peaks(NG,NS,Av,ACg)

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

P_All=cell(NG*NS,1);

Pks=zeros(NG*NS,1);
Mag_Peaks=NaN.*zeros(NG*NS,2);
temp_cd=pwd;
% 
% gamma_V_All=zeros(NG*NS,1);
% omega_R_All=zeros(NG*NS,1);

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
    for ss=1:NS 
        MO=Model_Output{ss};
%         gamma_V_All(ss+NS.*(gg-1))=unique(MO.gamma_V);
%         omega_R_All(ss+NS.*(gg-1))=unique(MO.omega_R);
        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1),:)]=Hospital_Admission_Peak(MO.Continual_Booster.Low_Coverage.Hospital_Admission,T_Run);
        
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
        end
    end
    P_All([1:NS]+NS.*(gg-1))=P;
end


P_All=P_All(Pks==1);
Mag_Peaks=Mag_Peaks(Pks==1,:);

R_WP=(Mag_Peaks(:,1)-Mag_Peaks(:,2));
P_Large_Winter=P_All(R_WP>0);
P_Large_Summer=P_All(R_WP<0);
% 
% gamma_V_Large_Summer=gamma_V_All(R_WP<0);
% gamma_V_Large_Winter=gamma_V_All(R_WP>0);
%         
% omega_R_Large_Summer=omega_R_All(R_WP<0);
% omega_R_Large_Winter=omega_R_All(R_WP>0);

[Filtered_Output_All,Filtered_Output_Large_Winter,Filtered_Output_Large_Summer]=Output_Peak_Filter(Filtered_Output_All,R_WP,Pks);

save('Parameter_Filtered.mat','P_All','P_Large_Winter','P_Large_Summer','R_WP');

end

