clear;
clc;

NG=21;
NS=10^3;

Incidence_AC_Samp=zeros(NG*NS,365);
Hospital_Burden_AC_Samp=zeros(NG*NS,365);
Hospital_Admission_AC_Samp=zeros(NG*NS,365);
Death_AC_Samp=zeros(NG*NS,365);
Cumulative_Count_AC=zeros(NG*NS,3);

Incidence_IC_Samp=zeros(NG*NS,365);
Hospital_Burden_IC_Samp=zeros(NG*NS,365);
Hospital_Admission_IC_Samp=zeros(NG*NS,365);
Death_IC_Samp=zeros(NG*NS,365);
Cumulative_Count_IC=zeros(NG*NS,3);

P_Samp=cell(NG*NS,1);
for ss=1:NG
    load(['Sample_Gen_' num2str(ss) '.mat'],'P','T_Run','Hospital_Admission_IC','Incidence_IC','Hospital_Burden_IC','Death_IC','Hospital_IC','Hospital_Admission_AC','Incidence_AC','Hospital_Burden_AC','Death_AC','Hospital_AC');
    Incidence_AC_Samp([1:NS]+NS.*(ss-1),:)=Incidence_AC;
    Hospital_Burden_AC_Samp([1:NS]+NS.*(ss-1),:)=Hospital_Burden_AC;
    Hospital_Admission_AC_Samp([1:NS]+NS.*(ss-1),:)=Hospital_Admission_AC;
    Death_AC_Samp([1:NS]+NS.*(ss-1),:)=Death_AC;

    Cumulative_Count_AC([1:NS]+NS.*(ss-1),1)=sum(Incidence_AC,2);
    Cumulative_Count_AC([1:NS]+NS.*(ss-1),2)=sum(Hospital_AC,2);
    Cumulative_Count_AC([1:NS]+NS.*(ss-1),3)=sum(Death_AC,2);
    
    Incidence_IC_Samp([1:NS]+NS.*(ss-1),:)=Incidence_IC;
    Hospital_Burden_IC_Samp([1:NS]+NS.*(ss-1),:)=Hospital_Burden_IC;
    Hospital_Admission_IC_Samp([1:NS]+NS.*(ss-1),:)=Hospital_Admission_IC;
    Death_IC_Samp([1:NS]+NS.*(ss-1),:)=Death_IC;

    Cumulative_Count_IC([1:NS]+NS.*(ss-1),1)=sum(Incidence_IC,2);
    Cumulative_Count_IC([1:NS]+NS.*(ss-1),2)=sum(Hospital_IC,2);
    Cumulative_Count_IC([1:NS]+NS.*(ss-1),3)=sum(Death_IC,2);
    P_Samp([1:NS]+NS.*(ss-1))=P;
end

Pks=zeros(NG*NS,1);
Mag_Peaks=NaN.*zeros(NG*NS,2);
Nr=NG*NS;
for ii=1:Nr
    [m_pks,dt_pks]=findpeaks(Hospital_Admission_AC_Samp(ii,:),T_Run(1:end-1)); 
    if((length(dt_pks)>=2))
        Winter_Peak=0;
        Summer_Peak=0;
        np=length(dt_pks);
        for pp=1:np
           if(dt_pks(pp)>=datenum('December 1, 2022') && dt_pks(pp)<=datenum('January 15, 2023'))
               Winter_Peak=1;
               Mag_Peaks(ii,1)=max(m_pks(pp),Mag_Peaks(ii,1));
           end
           if(dt_pks(pp)>=datenum('July 1, 2023') && dt_pks(pp)<=datenum('August 15, 2023'))
               Summer_Peak=1;
               Mag_Peaks(ii,2)=max(m_pks(pp),Mag_Peaks(ii,2));
           end
        end
        if(Summer_Peak*Winter_Peak>0)
            Pks(ii)=1;
        end
    end

end
P_Samp=P_Samp(Pks==1);
Mag_Peaks=Mag_Peaks(Pks==1,:);
N_Samp=sum(Pks);

gamma_V=zeros(N_Samp,1);
omega_R=zeros(N_Samp,1);
scale_t=zeros(N_Samp,1);
phi_t=zeros(N_Samp,1);
beta_max=zeros(N_Samp,1);

for ii=1:N_Samp
    omega_R(ii)=P_Samp{ii}.omega_R(1);
    gamma_V(ii)=P_Samp{ii}.gamma_V(1);
    
    scale_t(ii)=P_Samp{ii}.beta_I.scale_t;
    phi_t(ii)=P_Samp{ii}.beta_I.phi_t;
    beta_max(ii)=P_Samp{ii}.beta_I.beta_max;
end

R_WP=(Mag_Peaks(:,1)-Mag_Peaks(:,2))./max(Mag_Peaks,[],2);
save('Parameter_Filtered.mat','P_Samp');
save('Drivers_Peak_Time.mat','gamma_V','omega_R','scale_t','phi_t','beta_max','Mag_Peaks');


Incidence_IC_Samp=Incidence_IC_Samp(Pks==1,:);
Hospital_Burden_IC_Samp=Hospital_Burden_IC_Samp(Pks==1,:);
Hospital_Admission_IC_Samp=Hospital_Admission_IC_Samp(Pks==1,:);
Death_IC_Samp=Death_IC_Samp(Pks==1,:);
Cumulative_Count_IC=Cumulative_Count_IC(Pks==1,:);

Incidence_AC_Samp=Incidence_AC_Samp(Pks==1,:);
Hospital_Burden_AC_Samp=Hospital_Burden_AC_Samp(Pks==1,:);
Hospital_Admission_AC_Samp=Hospital_Admission_AC_Samp(Pks==1,:);
Death_AC_Samp=Death_AC_Samp(Pks==1,:);
Cumulative_Count_AC=Cumulative_Count_AC(Pks==1,:);

Incidence_dT_Samp=Incidence_IC_Samp-Incidence_AC_Samp;
Hospital_Burden_dT_Samp=Hospital_Burden_IC_Samp-Hospital_Burden_AC_Samp;
Hospital_Admission_dT_Samp=Hospital_Admission_IC_Samp-Hospital_Admission_AC_Samp;
Death_dT_Samp=Death_IC_Samp-Death_AC_Samp;
Cumulative_Count_dT=Cumulative_Count_IC-Cumulative_Count_AC;

Cumulative_Count_dT_Rel=(Cumulative_Count_IC-Cumulative_Count_AC)./Cumulative_Count_AC;


bin_gamma_V=[30:30:360];
bin_gamma_V(end)=365.1;
prob_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
num_samp_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);

for ii=1:length(prob_IC_gamma_V)
    temp=Cumulative_Count_dT(bin_gamma_V(ii)<=1./gamma_V & 1./gamma_V< bin_gamma_V(ii+1),:);
    for jj=1:3
        prob_IC_gamma_V(ii,jj)=sum(temp(:,jj)<0)./length(temp(:,jj));
        num_samp_IC_gamma_V(ii,jj)=length(temp(:,jj));
    end
end

prob_IC=zeros(3,1);
num_samp=zeros(3,1);
for jj=1:3
    prob_IC(jj)=sum(Cumulative_Count_dT(:,jj)<0)./length(Cumulative_Count_dT(:,jj));
    num_samp(jj)=length(Cumulative_Count_dT(:,jj));
end

xbinedge=[-1:0.01:1];
[IC_Rel_Cases,~] = histcounts(Cumulative_Count_dT_Rel(:,1),xbinedge);
[IC_Rel_Hosp,~] = histcounts(Cumulative_Count_dT_Rel(:,2),xbinedge);
[IC_Rel_Death,~] = histcounts(Cumulative_Count_dT_Rel(:,3),xbinedge);

save('Probability_IC_Better_All.mat','prob_IC_gamma_V','bin_gamma_V','num_samp_IC_gamma_V','num_samp','prob_IC');

PRCT=[2.5 5:5:95 97.5];


Cumulative_Count_AC_PRCT=prctile(Cumulative_Count_AC,PRCT);
Cumulative_Count_AC_mean=mean(Cumulative_Count_AC,1);

Cumulative_Count_IC_PRCT=prctile(Cumulative_Count_IC,PRCT);
Cumulative_Count_IC_mean=mean(Cumulative_Count_IC,1);

Cumulative_Count_dT_PRCT=prctile(Cumulative_Count_dT,PRCT);
Cumulative_Count_dT_mean=mean(Cumulative_Count_dT,1);

Cumulative_Count_dT_Rel_PRCT=prctile(Cumulative_Count_dT_Rel,PRCT);
Cumulative_Count_dT_Rel_mean=mean(Cumulative_Count_dT_Rel,1);
    
Incidence_AC_PRCT=prctile(Incidence_AC_Samp,PRCT);
Hospital_Burden_AC_PRCT=prctile(Hospital_Burden_AC_Samp,PRCT);
Hospital_Admission_AC_PRCT=prctile(Hospital_Admission_AC_Samp,PRCT);
Death_AC_PRCT=prctile(Death_AC_Samp,PRCT);

Incidence_AC_mean=mean(Incidence_AC_Samp,1);
Hospital_Burden_AC_mean=mean(Hospital_Burden_AC_Samp,1);
Hospital_Admission_AC_mean=mean(Hospital_Admission_AC_Samp,1);
Death_AC_mean=mean(Death_AC_Samp,1);

Incidence_IC_PRCT=prctile(Incidence_IC_Samp,PRCT);
Hospital_Burden_IC_PRCT=prctile(Hospital_Burden_IC_Samp,PRCT);
Hospital_Admission_IC_PRCT=prctile(Hospital_Admission_IC_Samp,PRCT);
Death_IC_PRCT=prctile(Death_IC_Samp,PRCT);

Incidence_IC_mean=mean(Incidence_IC_Samp,1);
Hospital_Burden_IC_mean=mean(Hospital_Burden_IC_Samp,1);
Hospital_Admission_IC_mean=mean(Hospital_Admission_IC_Samp,1);
Death_IC_mean=mean(Death_IC_Samp,1);

Incidence_dT_PRCT=prctile(Incidence_dT_Samp,PRCT);
Hospital_Burden_dT_PRCT=prctile(Hospital_Burden_dT_Samp,PRCT);
Hospital_Admission_dT_PRCT=prctile(Hospital_Admission_dT_Samp,PRCT);
Death_dT_PRCT=prctile(Death_dT_Samp,PRCT);

Incidence_dT_mean=mean(Incidence_dT_Samp,1);
Hospital_Burden_dT_mean=mean(Hospital_Burden_dT_Samp,1);
Hospital_Admission_dT_mean=mean(Hospital_Admission_dT_Samp,1);
Death_dT_mean=mean(Death_dT_Samp,1);

    
save(['Analysis_Output_All.mat'],'IC_Rel_Cases','IC_Rel_Hosp','IC_Rel_Death','xbinedge','PRCT','T_Run','N_Samp','Cumulative_Count_dT_Rel_mean','Cumulative_Count_dT_Rel_PRCT','Cumulative_Count_dT_PRCT','Cumulative_Count_dT_mean','Cumulative_Count_AC_PRCT','Cumulative_Count_AC_mean','Cumulative_Count_IC_PRCT','Cumulative_Count_IC_mean','Incidence_AC_PRCT','Hospital_Burden_AC_PRCT','Hospital_Admission_AC_PRCT','Death_AC_PRCT','Incidence_AC_mean','Hospital_Burden_AC_mean','Hospital_Admission_AC_mean','Death_AC_mean','Incidence_IC_PRCT','Hospital_Burden_IC_PRCT','Hospital_Admission_IC_PRCT','Death_IC_PRCT','Incidence_IC_mean','Hospital_Burden_IC_mean','Hospital_Admission_IC_mean','Death_IC_mean','Incidence_dT_PRCT','Hospital_Burden_dT_PRCT','Hospital_Admission_dT_PRCT','Death_dT_PRCT','Incidence_dT_mean','Hospital_Burden_dT_mean','Hospital_Admission_dT_mean','Death_dT_mean');


N_Samp=sum(R_WP<-0.05);
Cumulative_Count_AC_PRCT=prctile(Cumulative_Count_AC(R_WP<-0.05,:),PRCT);
Cumulative_Count_AC_mean=mean(Cumulative_Count_AC(R_WP<-0.05,:),1);

Cumulative_Count_IC_PRCT=prctile(Cumulative_Count_IC(R_WP<-0.05,:),PRCT);
Cumulative_Count_IC_mean=mean(Cumulative_Count_IC(R_WP<-0.05,:),1);

Cumulative_Count_dT_PRCT=prctile(Cumulative_Count_dT(R_WP<-0.05,:),PRCT);
Cumulative_Count_dT_mean=mean(Cumulative_Count_dT(R_WP<-0.05,:),1);

Cumulative_Count_dT_Rel_PRCT=prctile(Cumulative_Count_dT_Rel(R_WP<-0.05,:),PRCT);
Cumulative_Count_dT_Rel_mean=mean(Cumulative_Count_dT_Rel(R_WP<-0.05,:),1);
    
Incidence_AC_PRCT=prctile(Incidence_AC_Samp(R_WP<-0.05,:),PRCT);
Hospital_Burden_AC_PRCT=prctile(Hospital_Burden_AC_Samp(R_WP<-0.05,:),PRCT);
Hospital_Admission_AC_PRCT=prctile(Hospital_Admission_AC_Samp(R_WP<-0.05,:),PRCT);
Death_AC_PRCT=prctile(Death_AC_Samp(R_WP<-0.05,:),PRCT);

Incidence_AC_mean=mean(Incidence_AC_Samp(R_WP<-0.05,:),1);
Hospital_Burden_AC_mean=mean(Hospital_Burden_AC_Samp(R_WP<-0.05,:),1);
Hospital_Admission_AC_mean=mean(Hospital_Admission_AC_Samp(R_WP<-0.05,:),1);
Death_AC_mean=mean(Death_AC_Samp(R_WP<-0.05,:),1);

Incidence_IC_PRCT=prctile(Incidence_IC_Samp(R_WP<-0.05,:),PRCT);
Hospital_Burden_IC_PRCT=prctile(Hospital_Burden_IC_Samp(R_WP<-0.05,:),PRCT);
Hospital_Admission_IC_PRCT=prctile(Hospital_Admission_IC_Samp(R_WP<-0.05,:),PRCT);
Death_IC_PRCT=prctile(Death_IC_Samp(R_WP<-0.05,:),PRCT);

Incidence_IC_mean=mean(Incidence_IC_Samp(R_WP<-0.05,:),1);
Hospital_Burden_IC_mean=mean(Hospital_Burden_IC_Samp(R_WP<-0.05,:),1);
Hospital_Admission_IC_mean=mean(Hospital_Admission_IC_Samp(R_WP<-0.05,:),1);
Death_IC_mean=mean(Death_IC_Samp(R_WP<-0.05,:),1);

Incidence_dT_PRCT=prctile(Incidence_dT_Samp(R_WP<-0.05,:),PRCT);
Hospital_Burden_dT_PRCT=prctile(Hospital_Burden_dT_Samp(R_WP<-0.05,:),PRCT);
Hospital_Admission_dT_PRCT=prctile(Hospital_Admission_dT_Samp(R_WP<-0.05,:),PRCT);
Death_dT_PRCT=prctile(Death_dT_Samp,PRCT);

Incidence_dT_mean=mean(Incidence_dT_Samp(R_WP<-0.05,:),1);
Hospital_Burden_dT_mean=mean(Hospital_Burden_dT_Samp(R_WP<-0.05,:),1);
Hospital_Admission_dT_mean=mean(Hospital_Admission_dT_Samp(R_WP<-0.05,:),1);
Death_dT_mean=mean(Death_dT_Samp(R_WP<-0.05,:),1);

bin_gamma_V=[30:30:360];
bin_gamma_V(end)=365.1;
prob_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
num_samp_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
temp_CC=Cumulative_Count_dT(R_WP<-0.05,:);
temp_gamma=gamma_V(R_WP<-0.05);
for ii=1:length(prob_IC_gamma_V)
    temp=temp_CC(bin_gamma_V(ii)<=1./temp_gamma & 1./temp_gamma< bin_gamma_V(ii+1),:);
    for jj=1:3
        prob_IC_gamma_V(ii,jj)=sum(temp(:,jj)<0)./length(temp(:,jj));
        num_samp_IC_gamma_V(ii,jj)=length(temp(:,jj));
    end
end

prob_IC=zeros(3,1);
num_samp=zeros(3,1);
for jj=1:3
    prob_IC(jj)=sum(temp_CC(:,jj)<0)./length(temp_CC(:,jj));
    num_samp(jj)=length(temp_CC(:,jj));
end

xbinedge=[-1:0.01:1];
[IC_Rel_Cases,~] = histcounts(Cumulative_Count_dT_Rel(R_WP<-0.05,1),xbinedge);
[IC_Rel_Hosp,~] = histcounts(Cumulative_Count_dT_Rel(R_WP<-0.05,2),xbinedge);
[IC_Rel_Death,~] = histcounts(Cumulative_Count_dT_Rel(R_WP<-0.05,3),xbinedge);

save('Probability_IC_Better_Large_Summer.mat','prob_IC_gamma_V','bin_gamma_V','num_samp_IC_gamma_V','num_samp','prob_IC');
save(['Analysis_Output_Large_Summer.mat'],'IC_Rel_Cases','IC_Rel_Hosp','IC_Rel_Death','xbinedge','PRCT','T_Run','N_Samp','Cumulative_Count_dT_Rel_mean','Cumulative_Count_dT_Rel_PRCT','Cumulative_Count_dT_PRCT','Cumulative_Count_dT_mean','Cumulative_Count_AC_PRCT','Cumulative_Count_AC_mean','Cumulative_Count_IC_PRCT','Cumulative_Count_IC_mean','Incidence_AC_PRCT','Hospital_Burden_AC_PRCT','Hospital_Admission_AC_PRCT','Death_AC_PRCT','Incidence_AC_mean','Hospital_Burden_AC_mean','Hospital_Admission_AC_mean','Death_AC_mean','Incidence_IC_PRCT','Hospital_Burden_IC_PRCT','Hospital_Admission_IC_PRCT','Death_IC_PRCT','Incidence_IC_mean','Hospital_Burden_IC_mean','Hospital_Admission_IC_mean','Death_IC_mean','Incidence_dT_PRCT','Hospital_Burden_dT_PRCT','Hospital_Admission_dT_PRCT','Death_dT_PRCT','Incidence_dT_mean','Hospital_Burden_dT_mean','Hospital_Admission_dT_mean','Death_dT_mean');

N_Samp=sum(R_WP>0.05);

Cumulative_Count_AC_PRCT=prctile(Cumulative_Count_AC(R_WP>0.05,:),PRCT);
Cumulative_Count_AC_mean=mean(Cumulative_Count_AC(R_WP>0.05,:),1);

Cumulative_Count_IC_PRCT=prctile(Cumulative_Count_IC(R_WP>0.05,:),PRCT);
Cumulative_Count_IC_mean=mean(Cumulative_Count_IC(R_WP>0.05,:),1);

Cumulative_Count_dT_PRCT=prctile(Cumulative_Count_dT(R_WP>0.05,:),PRCT);
Cumulative_Count_dT_mean=mean(Cumulative_Count_dT(R_WP>0.05,:),1);

Cumulative_Count_dT_Rel_PRCT=prctile(Cumulative_Count_dT_Rel(R_WP>0.05,:),PRCT);
Cumulative_Count_dT_Rel_mean=mean(Cumulative_Count_dT_Rel(R_WP>0.05,:),1);
    
Incidence_AC_PRCT=prctile(Incidence_AC_Samp(R_WP>0.05,:),PRCT);
Hospital_Burden_AC_PRCT=prctile(Hospital_Burden_AC_Samp(R_WP>0.05,:),PRCT);
Hospital_Admission_AC_PRCT=prctile(Hospital_Admission_AC_Samp(R_WP>0.05,:),PRCT);
Death_AC_PRCT=prctile(Death_AC_Samp(R_WP>0.05,:),PRCT);

Incidence_AC_mean=mean(Incidence_AC_Samp(R_WP>0.05,:),1);
Hospital_Burden_AC_mean=mean(Hospital_Burden_AC_Samp(R_WP>0.05,:),1);
Hospital_Admission_AC_mean=mean(Hospital_Admission_AC_Samp(R_WP>0.05,:),1);
Death_AC_mean=mean(Death_AC_Samp(R_WP>0.05,:),1);

Incidence_IC_PRCT=prctile(Incidence_IC_Samp(R_WP>0.05,:),PRCT);
Hospital_Burden_IC_PRCT=prctile(Hospital_Burden_IC_Samp(R_WP>0.05,:),PRCT);
Hospital_Admission_IC_PRCT=prctile(Hospital_Admission_IC_Samp(R_WP>0.05,:),PRCT);
Death_IC_PRCT=prctile(Death_IC_Samp(R_WP>0.05,:),PRCT);

Incidence_IC_mean=mean(Incidence_IC_Samp(R_WP>0.05,:),1);
Hospital_Burden_IC_mean=mean(Hospital_Burden_IC_Samp(R_WP>0.05,:),1);
Hospital_Admission_IC_mean=mean(Hospital_Admission_IC_Samp(R_WP>0.05,:),1);
Death_IC_mean=mean(Death_IC_Samp(R_WP>0.05,:),1);

Incidence_dT_PRCT=prctile(Incidence_dT_Samp(R_WP>0.05,:),PRCT);
Hospital_Burden_dT_PRCT=prctile(Hospital_Burden_dT_Samp(R_WP>0.05,:),PRCT);
Hospital_Admission_dT_PRCT=prctile(Hospital_Admission_dT_Samp(R_WP>0.05,:),PRCT);
Death_dT_PRCT=prctile(Death_dT_Samp,PRCT);

Incidence_dT_mean=mean(Incidence_dT_Samp(R_WP>0.05,:),1);
Hospital_Burden_dT_mean=mean(Hospital_Burden_dT_Samp(R_WP>0.05,:),1);
Hospital_Admission_dT_mean=mean(Hospital_Admission_dT_Samp(R_WP>0.05,:),1);
Death_dT_mean=mean(Death_dT_Samp(R_WP>0.05,:),1);


bin_gamma_V=[30:30:360];
bin_gamma_V(end)=365.1;
prob_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
num_samp_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
temp_CC=Cumulative_Count_dT(R_WP>0.05,:);
temp_gamma=gamma_V(R_WP>0.05);
for ii=1:length(prob_IC_gamma_V)
    temp=temp_CC(bin_gamma_V(ii)<=1./temp_gamma & 1./temp_gamma< bin_gamma_V(ii+1),:);
    for jj=1:3
        prob_IC_gamma_V(ii,jj)=sum(temp(:,jj)<0)./length(temp(:,jj));
        num_samp_IC_gamma_V(ii,jj)=length(temp(:,jj));
    end
end


prob_IC=zeros(3,1);
num_samp=zeros(3,1);
for jj=1:3
    prob_IC(jj)=sum(temp_CC(:,jj)<0)./length(temp_CC(:,jj));
    num_samp(jj)=length(temp_CC(:,jj));
end

xbinedge=[-1:0.01:1];
[IC_Rel_Cases,~] = histcounts(Cumulative_Count_dT_Rel(R_WP>0.05,1),xbinedge);
[IC_Rel_Hosp,~] = histcounts(Cumulative_Count_dT_Rel(R_WP>0.05,2),xbinedge);
[IC_Rel_Death,~] = histcounts(Cumulative_Count_dT_Rel(R_WP>0.05,3),xbinedge);

save('Probability_IC_Better_Large_Winter.mat','prob_IC_gamma_V','bin_gamma_V','num_samp_IC_gamma_V','num_samp','prob_IC');

save(['Analysis_Output_Large_Winter.mat'],'IC_Rel_Cases','IC_Rel_Hosp','IC_Rel_Death','xbinedge','PRCT','T_Run','N_Samp','Cumulative_Count_dT_Rel_mean','Cumulative_Count_dT_Rel_PRCT','Cumulative_Count_dT_PRCT','Cumulative_Count_dT_mean','Cumulative_Count_AC_PRCT','Cumulative_Count_AC_mean','Cumulative_Count_IC_PRCT','Cumulative_Count_IC_mean','Incidence_AC_PRCT','Hospital_Burden_AC_PRCT','Hospital_Admission_AC_PRCT','Death_AC_PRCT','Incidence_AC_mean','Hospital_Burden_AC_mean','Hospital_Admission_AC_mean','Death_AC_mean','Incidence_IC_PRCT','Hospital_Burden_IC_PRCT','Hospital_Admission_IC_PRCT','Death_IC_PRCT','Incidence_IC_mean','Hospital_Burden_IC_mean','Hospital_Admission_IC_mean','Death_IC_mean','Incidence_dT_PRCT','Hospital_Burden_dT_PRCT','Hospital_Admission_dT_PRCT','Death_dT_PRCT','Incidence_dT_mean','Hospital_Burden_dT_mean','Hospital_Admission_dT_mean','Death_dT_mean');

N_Samp=sum(R_WP<=0.05 &  R_WP>=-0.05);
Cumulative_Count_AC_PRCT=prctile(Cumulative_Count_AC(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Cumulative_Count_AC_mean=mean(Cumulative_Count_AC(R_WP<=0.05 &  R_WP>=-0.05,:),1);

Cumulative_Count_IC_PRCT=prctile(Cumulative_Count_IC(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Cumulative_Count_IC_mean=mean(Cumulative_Count_IC(R_WP<=0.05 &  R_WP>=-0.05,:),1);

Cumulative_Count_dT_PRCT=prctile(Cumulative_Count_dT(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Cumulative_Count_dT_mean=mean(Cumulative_Count_dT(R_WP<=0.05 &  R_WP>=-0.05,:),1);

Cumulative_Count_dT_Rel_PRCT=prctile(Cumulative_Count_dT_Rel(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Cumulative_Count_dT_Rel_mean=mean(Cumulative_Count_dT_Rel(R_WP<=0.05 &  R_WP>=-0.05,:),1);
    
Incidence_AC_PRCT=prctile(Incidence_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Hospital_Burden_AC_PRCT=prctile(Hospital_Burden_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Hospital_Admission_AC_PRCT=prctile(Hospital_Admission_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Death_AC_PRCT=prctile(Death_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);

Incidence_AC_mean=mean(Incidence_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Hospital_Burden_AC_mean=mean(Hospital_Burden_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Hospital_Admission_AC_mean=mean(Hospital_Admission_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Death_AC_mean=mean(Death_AC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);

Incidence_IC_PRCT=prctile(Incidence_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Hospital_Burden_IC_PRCT=prctile(Hospital_Burden_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Hospital_Admission_IC_PRCT=prctile(Hospital_Admission_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Death_IC_PRCT=prctile(Death_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);

Incidence_IC_mean=mean(Incidence_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Hospital_Burden_IC_mean=mean(Hospital_Burden_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Hospital_Admission_IC_mean=mean(Hospital_Admission_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Death_IC_mean=mean(Death_IC_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);

Incidence_dT_PRCT=prctile(Incidence_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Hospital_Burden_dT_PRCT=prctile(Hospital_Burden_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Hospital_Admission_dT_PRCT=prctile(Hospital_Admission_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),PRCT);
Death_dT_PRCT=prctile(Death_dT_Samp,PRCT);

Incidence_dT_mean=mean(Incidence_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Hospital_Burden_dT_mean=mean(Hospital_Burden_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Hospital_Admission_dT_mean=mean(Hospital_Admission_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);
Death_dT_mean=mean(Death_dT_Samp(R_WP<=0.05 &  R_WP>=-0.05,:),1);


bin_gamma_V=[30:30:360];
bin_gamma_V(end)=365.1;
prob_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
num_samp_IC_gamma_V=zeros(length(bin_gamma_V)-1,3);
temp_CC=Cumulative_Count_dT(-0.05<=R_WP & R_WP<=0.05,:);
temp_gamma=gamma_V(-0.05<=R_WP & R_WP<=0.05);
for ii=1:length(prob_IC_gamma_V)
    temp=temp_CC(bin_gamma_V(ii)<=1./temp_gamma & 1./temp_gamma< bin_gamma_V(ii+1),:);
    for jj=1:3
        prob_IC_gamma_V(ii,jj)=sum(temp(:,jj)<0)./length(temp(:,jj));
        num_samp_IC_gamma_V(ii,jj)=length(temp(:,jj));
    end
end

prob_IC=zeros(3,1);
num_samp=zeros(3,1);
for jj=1:3
    prob_IC(jj)=sum(temp_CC(:,jj)<0)./length(temp_CC(:,jj));
    num_samp(jj)=length(temp_CC(:,jj));
end

xbinedge=[-1:0.01:1];
[IC_Rel_Cases,~] = histcounts(Cumulative_Count_dT_Rel(R_WP<=0.05 &  R_WP>=-0.05,1),xbinedge);
[IC_Rel_Hosp,~] = histcounts(Cumulative_Count_dT_Rel(R_WP<=0.05 &  R_WP>=-0.05,2),xbinedge);
[IC_Rel_Death,~] = histcounts(Cumulative_Count_dT_Rel(R_WP<=0.05 &  R_WP>=-0.05,3),xbinedge);

save('Probability_IC_Better_Similar_Winter_Summer.mat','prob_IC_gamma_V','bin_gamma_V','num_samp_IC_gamma_V','num_samp','prob_IC');

save(['Analysis_Output_Similar_Winter_Summer.mat'],'IC_Rel_Cases','IC_Rel_Hosp','IC_Rel_Death','xbinedge','PRCT','T_Run','N_Samp','Cumulative_Count_dT_Rel_mean','Cumulative_Count_dT_Rel_PRCT','Cumulative_Count_dT_PRCT','Cumulative_Count_dT_mean','Cumulative_Count_AC_PRCT','Cumulative_Count_AC_mean','Cumulative_Count_IC_PRCT','Cumulative_Count_IC_mean','Incidence_AC_PRCT','Hospital_Burden_AC_PRCT','Hospital_Admission_AC_PRCT','Death_AC_PRCT','Incidence_AC_mean','Hospital_Burden_AC_mean','Hospital_Admission_AC_mean','Death_AC_mean','Incidence_IC_PRCT','Hospital_Burden_IC_PRCT','Hospital_Admission_IC_PRCT','Death_IC_PRCT','Incidence_IC_mean','Hospital_Burden_IC_mean','Hospital_Admission_IC_mean','Death_IC_mean','Incidence_dT_PRCT','Hospital_Burden_dT_PRCT','Hospital_Admission_dT_PRCT','Death_dT_PRCT','Incidence_dT_mean','Hospital_Burden_dT_mean','Hospital_Admission_dT_mean','Death_dT_mean');