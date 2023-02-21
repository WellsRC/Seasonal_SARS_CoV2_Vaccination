clear;
clc;

NG=150;
NS=10^4;


MMv={'August','September','October','November','December','January','February','March','April'};
YMv=[2022 2022 2022 2022 2022 2023 2023 2023 2023];

PRCT=[2.5 25 50 75 97.5];
    
mmv=2;
DI_Samp_Sept=zeros(NG*NS,365);
DH_Samp_Sept=zeros(NG*NS,365);
PH_Samp_Sept=zeros(NG*NS,365);

Peak_Time_Sept=zeros(NG*NS,3);
Peak_Mag_Sept=zeros(NG*NS,3);

Cumulative_Count_Sept=zeros(NG*NS,2);

for ss=1:NG
    load(['Sample_Gen_' num2str(ss) '_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '.mat'],'T_Run','DH','DI','PH');
    DI_Samp_Sept([1:NS]+NS.*(ss-1),:)=DI;
    DH_Samp_Sept([1:NS]+NS.*(ss-1),:)=DH;
    PH_Samp_Sept([1:NS]+NS.*(ss-1),:)=PH;

    Cumulative_Count_Sept([1:NS]+NS.*(ss-1),1)=sum(DI,2);
    Cumulative_Count_Sept([1:NS]+NS.*(ss-1),2)=sum(DH,2);

    for ii=1:NS
        Peak_Time_Sept(ii+NS.*(ss-1),1)=min(T_Run(DI(ii,:)==max(DI(ii,:))));
        Peak_Time_Sept(ii+NS.*(ss-1),2)=min(T_Run(DH(ii,:)==max(DH(ii,:))));
        Peak_Time_Sept(ii+NS.*(ss-1),3)=min(T_Run(PH(ii,:)==max(PH(ii,:))));        

        Peak_Mag_Sept(ii+NS.*(ss-1),1)=max(DI(ii,:));
        Peak_Mag_Sept(ii+NS.*(ss-1),2)=max(DH(ii,:));
        Peak_Mag_Sept(ii+NS.*(ss-1),3)=max(PH(ii,:));
    end
end

for mmv=1:9
    DI_Samp=zeros(NG*NS,365);
    DH_Samp=zeros(NG*NS,365);
    PH_Samp=zeros(NG*NS,365);

    Peak_Time=zeros(NG*NS,3);
    Peak_Mag=zeros(NG*NS,3);
    
    Cumulative_Count=zeros(NG*NS,2);
    

    for ss=1:NG
        load(['Sample_Gen_' num2str(ss) '_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '.mat'],'T_Run','DH','DI','PH');
        DI_Samp([1:NS]+NS.*(ss-1),:)=DI;
        DH_Samp([1:NS]+NS.*(ss-1),:)=DH;
        PH_Samp([1:NS]+NS.*(ss-1),:)=PH;
        
        Cumulative_Count([1:NS]+NS.*(ss-1),1)=sum(DI,2);
        Cumulative_Count([1:NS]+NS.*(ss-1),2)=sum(DH,2);
        
        for ii=1:NS
            Peak_Time(ii+NS.*(ss-1),1)=min(T_Run(DI(ii,:)==max(DI(ii,:))));
            Peak_Time(ii+NS.*(ss-1),2)=min(T_Run(DH(ii,:)==max(DH(ii,:))));
            Peak_Time(ii+NS.*(ss-1),3)=min(T_Run(PH(ii,:)==max(PH(ii,:))));        

            Peak_Mag(ii+NS.*(ss-1),1)=max(DI(ii,:));
            Peak_Mag(ii+NS.*(ss-1),2)=max(DH(ii,:));
            Peak_Mag(ii+NS.*(ss-1),3)=max(PH(ii,:));
        end
    end
    
    Peak_Time_Raw=Peak_Time;
    Cumulative_Count=Cumulative_Count-Cumulative_Count_Sept;
    DI_Samp=DI_Samp-DI_Samp_Sept;
    DH_Samp=DH_Samp-DH_Samp_Sept;
    PH_Samp=PH_Samp-PH_Samp_Sept;
    
    dt_Peak_Time=Peak_Time-Peak_Time_Sept;
    Peak_Time=Peak_Time-Peak_Time_Sept;    
    dt_Peak_Time(dt_Peak_Time>0)=1;
    dt_Peak_Time(dt_Peak_Time<=0)=0;
    
    
    dt_Peak_Mag=Peak_Mag-Peak_Mag_Sept;
    Peak_Mag=Peak_Mag-Peak_Mag_Sept;
    
    dt_Peak_Mag(dt_Peak_Mag>0)=1;
    dt_Peak_Mag(dt_Peak_Mag<=0)=0;
    
    dt_Cumulative_Count=Cumulative_Count;
    
    dt_Cumulative_Count(dt_Cumulative_Count>0)=1;
    dt_Cumulative_Count(dt_Cumulative_Count<=0)=0;
        
    Earlier_Peak_Time=mean(dt_Peak_Time,1);
    Higher_Peak_Mag=mean(dt_Peak_Mag,1);
    Higher_Cumulative_Count=mean(dt_Cumulative_Count,1);
    
    
    Cumulative_Count_PRCT=prctile(Cumulative_Count,PRCT);
    Cumulative_Count_mean=mean(Cumulative_Count,1);
    
    Cumulative_Count_High_PRCT=[prctile(Cumulative_Count(Cumulative_Count(:,1)>0,1),PRCT) prctile(Cumulative_Count(Cumulative_Count(:,2)>0,2),PRCT)];
    Cumulative_Count_Low_PRCT=[prctile(Cumulative_Count(Cumulative_Count(:,1)<=0,1),PRCT) prctile(Cumulative_Count(Cumulative_Count(:,2)<=0,2),PRCT)];
    Cumulative_Count_High_mean=[mean(Cumulative_Count(Cumulative_Count(:,1)>0,1),1) mean(Cumulative_Count(Cumulative_Count(:,2)>0,2),1)];
    Cumulative_Count_Low_mean=[mean(Cumulative_Count(Cumulative_Count(:,1)<=0,1),1) mean(Cumulative_Count(Cumulative_Count(:,2)<=0,2),1)];
        
    Peak_High_PRCT=[prctile(Peak_Mag(Peak_Mag(:,1)>0,1),PRCT) prctile(Peak_Mag(Peak_Mag(:,2)>0,2),PRCT) prctile(Peak_Mag(Peak_Mag(:,3)>0,3),PRCT)];
    Peak_Low_PRCT=[prctile(Peak_Mag(Peak_Mag(:,1)<=0,1),PRCT) prctile(Peak_Mag(Peak_Mag(:,2)<=0,2),PRCT) prctile(Peak_Mag(Peak_Mag(:,3)<=0,3),PRCT)];
    Peak_High_mean=[mean(Peak_Mag(Peak_Mag(:,1)>0,1),1) mean(Peak_Mag(Peak_Mag(:,2)>0,2),1) mean(Peak_Mag(Peak_Mag(:,3)>0,3),1)];
    Peak_Low_mean=[mean(Peak_Mag(Peak_Mag(:,1)<=0,1),1) mean(Peak_Mag(Peak_Mag(:,2)<=0,2),1) mean(Peak_Mag(Peak_Mag(:,3)<=0,3),1)];
    
    Peak_Early_PRCT=[prctile(Peak_Time(Peak_Time(:,1)>0,1),PRCT) prctile(Peak_Time(Peak_Time(:,2)>0,2),PRCT) prctile(Peak_Time(Peak_Time(:,3)>0,3),PRCT)];
    Peak_Late_PRCT=[prctile(Peak_Time(Peak_Time(:,1)<=0,1),PRCT) prctile(Peak_Time(Peak_Time(:,2)<=0,2),PRCT) prctile(Peak_Time(Peak_Time(:,3)<=0,3),PRCT)];
    Peak_Early_mean=[mean(Peak_Time(Peak_Time(:,1)>0,1),1) mean(Peak_Time(Peak_Time(:,2)>0,2),1) mean(Peak_Time(Peak_Time(:,3)>0,3),1)];
    Peak_Late_mean=[mean(Peak_Time(Peak_Time(:,1)<=0,1),1) mean(Peak_Time(Peak_Time(:,2)<=0,2),1) mean(Peak_Time(Peak_Time(:,3)<=0,3),1)];
    
    DI_PRCT=prctile(DI_Samp,PRCT);
    DH_PRCT=prctile(DH_Samp,PRCT);
    PH_PRCT=prctile(PH_Samp,PRCT);
    
    DI_mean=mean(DI_Samp,1);
    DH_mean=mean(DH_Samp,1);
    PH_mean=mean(PH_Samp,1);
        
    DI_Low_PRCT=prctile(DI_Samp,PRCT);
    DH_Low_PRCT=prctile(DH_Samp,PRCT);
    PH_Low_PRCT=prctile(PH_Samp,PRCT);
    
    DI_Low_mean=mean(DI_Samp,1);
    DH_Low_mean=mean(DH_Samp,1);
    PH_Low_mean=mean(PH_Samp,1);
    
    
    MM_Strat_Start={'July 1, 2022','September 1, 2022','December 1 2022','March 1, 2023','July 1,2023'};
    
    
    DI_PRCT_Strat=cell(4,1);
    DH_PRCT_Strat=cell(4,1);
    PH_PRCT_Strat=cell(4,1);
    Cumulative_Count_PRCT_Strat=cell(4,1);
    
    DI_mean_Strat=cell(4,1);
    DH_mean_Strat=cell(4,1);
    PH_mean_Strat=cell(4,1);
    Cumulative_Count_mean_Strat=cell(4,1);
    
    Earlier_Peak_Time_Strat=zeros(4,3);
    Higher_Peak_Mag_Strat=zeros(4,3);
    Higher_Cumulative_Count_Strat=zeros(4,2);
    
    Cumulative_Count_Low_mean_Strat=cell(4,1);
    Cumulative_Count_High_mean_Strat=cell(4,1);
    Cumulative_Count_Low_PRCT_Strat=cell(4,1);
    Cumulative_Count_High_PRCT_Strat=cell(4,1);
    Peak_Late_mean_Strat=cell(4,1);
    Peak_Early_mean_Strat=cell(4,1);
    Peak_Late_PRCT_Strat=cell(4,1);
    Peak_Early_PRCT_Strat=cell(4,1);
    Peak_High_mean_Strat=cell(4,1);
    Peak_Low_mean_Strat=cell(4,1);
    Peak_High_PRCT_Strat=cell(4,1);
    Peak_Low_PRCT_Strat=cell(4,1);
    
    for mm=1:4
        dstart=datenum(MM_Strat_Start{mm});
        dend=datenum(MM_Strat_Start{mm+1});
        tp=Peak_Time_Raw(:,1)>=dstart & Peak_Time_Raw(:,1)<dend;
        if(sum(tp)>0)
            DI_PRCT_Strat{mm}=prctile(DI_Samp(tp,:),PRCT);
            DI_mean_Strat{mm}=mean(DI_Samp(tp,:),1);
            Cumulative_Count_PRCT_Strat{mm}=prctile(Cumulative_Count(tp,:),PRCT);
            Cumulative_Count_mean_Strat{mm}=mean(Cumulative_Count(tp,:),1);
            
            Earlier_Peak_Time_Strat(mm,:)=mean(dt_Peak_Time(tp,:),1);
            Higher_Peak_Mag_Strat(mm,:)=mean(dt_Peak_Mag(tp,:),1);
            Higher_Cumulative_Count_Strat(mm,:)=mean(dt_Cumulative_Count(tp,:),1);
    
            Cumulative_Count_High_PRCT_Strat{mm}=[prctile(Cumulative_Count(Cumulative_Count(tp,1)>0,1),PRCT) prctile(Cumulative_Count(Cumulative_Count(tp,2)>0,2),PRCT)];
            Cumulative_Count_Low_PRCT_Strat{mm}=[prctile(Cumulative_Count(Cumulative_Count(tp,1)<=0,1),PRCT) prctile(Cumulative_Count(Cumulative_Count(tp,2)<=0,2),PRCT)];
            Cumulative_Count_High_mean_Strat{mm}=[mean(Cumulative_Count(Cumulative_Count(tp,1)>0,1),1) mean(Cumulative_Count(Cumulative_Count(tp,2)>0,2),1)];
            Cumulative_Count_Low_mean_Strat{mm}=[mean(Cumulative_Count(Cumulative_Count(tp,1)<=0,1),1) mean(Cumulative_Count(Cumulative_Count(tp,2)<=0,2),1)];

            Peak_High_PRCT_Strat{mm}=[prctile(Peak_Mag(Peak_Mag(tp,1)>0,1),PRCT) prctile(Peak_Mag(Peak_Mag(tp,2)>0,2),PRCT) prctile(Peak_Mag(Peak_Mag(tp,3)>0,3),PRCT)];
            Peak_Low_PRCT_Strat{mm}=[prctile(Peak_Mag(Peak_Mag(tp,1)<=0,1),PRCT) prctile(Peak_Mag(Peak_Mag(tp,2)<=0,2),PRCT) prctile(Peak_Mag(Peak_Mag(tp,3)<=0,3),PRCT)];
            Peak_High_mean_Strat{mm}=[mean(Peak_Mag(Peak_Mag(tp,1)>0,1),1) mean(Peak_Mag(Peak_Mag(tp,2)>0,2),1) mean(Peak_Mag(Peak_Mag(tp,3)>0,3),1)];
            Peak_Low_mean_Strat{mm}=[mean(Peak_Mag(Peak_Mag(tp,1)<=0,1),1) mean(Peak_Mag(Peak_Mag(tp,2)<=0,2),1) mean(Peak_Mag(Peak_Mag(tp,3)<=0,3),1)];

            Peak_Early_PRCT_Strat{mm}=[prctile(Peak_Time(Peak_Time(tp,1)>0,1),PRCT) prctile(Peak_Time(Peak_Time(tp,2)>0,2),PRCT) prctile(Peak_Time(Peak_Time(tp,3)>0,3),PRCT)];
            Peak_Late_PRCT_Strat{mm}=[prctile(Peak_Time(Peak_Time(tp,1)<=0,1),PRCT) prctile(Peak_Time(Peak_Time(tp,2)<=0,2),PRCT) prctile(Peak_Time(Peak_Time(tp,3)<=0,3),PRCT)];
            Peak_Early_mean_Strat{mm}=[mean(Peak_Time(Peak_Time(tp,1)>0,1),1) mean(Peak_Time(Peak_Time(tp,2)>0,2),1) mean(Peak_Time(Peak_Time(tp,3)>0,3),1)];
            Peak_Late_mean_Strat{mm}=[mean(Peak_Time(Peak_Time(tp,1)<=0,1),1) mean(Peak_Time(Peak_Time(tp,2)<=0,2),1) mean(Peak_Time(Peak_Time(tp,3)<=0,3),1)];
        end

        tp=Peak_Time_Raw(:,2)>=dstart & Peak_Time_Raw(:,2)<dend;
        if(sum(tp)>0)
            DH_PRCT_Strat{mm}=prctile(DH_Samp(tp,:),PRCT);
            DH_mean_Strat{mm}=mean(DH_Samp(tp,:),1);
            
        end

        tp=Peak_Time_Raw(:,3)>=dstart & Peak_Time_Raw(:,3)<dend;
        if(sum(tp)>0)
            PH_PRCT_Strat{mm}=prctile(PH_Samp(tp,:),PRCT);
            PH_mean_Strat{mm}=mean(PH_Samp(tp,:),1);
            
        end
    end
    
    
    DI_PRCT_Month=cell(12,1);
    DH_PRCT_Month=cell(12,1);
    PH_PRCT_Month=cell(12,1);
    Cumulative_Count_PRCT_Month=cell(12,1);

    DI_mean_Month=cell(12,1);
    DH_mean_Month=cell(12,1);
    PH_mean_Month=cell(12,1);
    Cumulative_Count_mean_Month=cell(12,1);
    
    
    
    Earlier_Peak_Time_Month=zeros(12,3);
    Higher_Peak_Mag_Month=zeros(12,3);
    Higher_Cumulative_Count_Month=zeros(12,2);
    
    
    Cumulative_Count_Low_mean_Month=cell(12,1);
    Cumulative_Count_High_mean_Month=cell(12,1);
    Cumulative_Count_Low_PRCT_Month=cell(12,1);
    Cumulative_Count_High_PRCT_Month=cell(12,1);
    Peak_Late_mean_Month=cell(12,1);
    Peak_Early_mean_Month=cell(12,1);
    Peak_Late_PRCT_Month=cell(12,1);
    Peak_Early_PRCT_Month=cell(12,1);
    Peak_High_mean_Month=cell(12,1);
    Peak_Low_mean_Month=cell(12,1);
    Peak_High_PRCT_Month=cell(12,1);
    Peak_Low_PRCT_Month=cell(12,1);
    
    MM={'July','August','September','October','November','December','January','February','March','April','May','June','July'};
    YM=[2022 2022 2022 2022 2022 2022 2023 2023 2023 2023 2023 2023 2023]; 
    
    for mm=1:12
        dstart=datenum([MM{mm} ' 1, ' num2str(YM(mm))]);
        dend=datenum([MM{mm+1} ' 1, ' num2str(YM(mm+1))]);
        tp=Peak_Time_Raw(:,1)>=dstart & Peak_Time_Raw(:,1)<dend;
        if(sum(tp)>0)
            DI_PRCT_Month{mm}=prctile(DI_Samp(tp,:),PRCT);
            DI_mean_Month{mm}=mean(DI_Samp(tp,:),1);
            
            Cumulative_Count_PRCT_Month{mm}=prctile(Cumulative_Count(tp,:),PRCT);
            Cumulative_Count_mean_Month{mm}=mean(Cumulative_Count(tp,:),1);
            
            
            Earlier_Peak_Time_Month(mm,:)=mean(dt_Peak_Time(tp,:),1);
            Higher_Peak_Mag_Month(mm,:)=mean(dt_Peak_Mag(tp,:),1);
            Higher_Cumulative_Count_Month(mm,:)=mean(dt_Cumulative_Count(tp,:),1);
            
            Cumulative_Count_High_PRCT_Strat{mm}=[prctile(Cumulative_Count(Cumulative_Count(tp,1)>0,1),PRCT) prctile(Cumulative_Count(Cumulative_Count(tp,2)>0,2),PRCT)];
            Cumulative_Count_Low_PRCT_Strat{mm}=[prctile(Cumulative_Count(Cumulative_Count(tp,1)<=0,1),PRCT) prctile(Cumulative_Count(Cumulative_Count(tp,2)<=0,2),PRCT)];
            Cumulative_Count_High_mean_Strat{mm}=[mean(Cumulative_Count(Cumulative_Count(tp,1)>0,1),1) mean(Cumulative_Count(Cumulative_Count(tp,2)>0,2),1)];
            Cumulative_Count_Low_mean_Strat{mm}=[mean(Cumulative_Count(Cumulative_Count(tp,1)<=0,1),1) mean(Cumulative_Count(Cumulative_Count(tp,2)<=0,2),1)];

            Peak_High_PRCT_Strat{mm}=[prctile(Peak_Mag(Peak_Mag(tp,1)>0,1),PRCT) prctile(Peak_Mag(Peak_Mag(tp,2)>0,2),PRCT) prctile(Peak_Mag(Peak_Mag(tp,3)>0,3),PRCT)];
            Peak_Low_PRCT_Strat{mm}=[prctile(Peak_Mag(Peak_Mag(tp,1)<=0,1),PRCT) prctile(Peak_Mag(Peak_Mag(tp,2)<=0,2),PRCT) prctile(Peak_Mag(Peak_Mag(tp,3)<=0,3),PRCT)];
            Peak_High_mean_Strat{mm}=[mean(Peak_Mag(Peak_Mag(tp,1)>0,1),1) mean(Peak_Mag(Peak_Mag(tp,2)>0,2),1) mean(Peak_Mag(Peak_Mag(tp,3)>0,3),1)];
            Peak_Low_mean_Strat{mm}=[mean(Peak_Mag(Peak_Mag(tp,1)<=0,1),1) mean(Peak_Mag(Peak_Mag(tp,2)<=0,2),1) mean(Peak_Mag(Peak_Mag(tp,3)<=0,3),1)];

            Peak_Early_PRCT_Strat{mm}=[prctile(Peak_Time(Peak_Time(tp,1)>0,1),PRCT) prctile(Peak_Time(Peak_Time(tp,2)>0,2),PRCT) prctile(Peak_Time(Peak_Time(tp,3)>0,3),PRCT)];
            Peak_Late_PRCT_Strat{mm}=[prctile(Peak_Time(Peak_Time(tp,1)<=0,1),PRCT) prctile(Peak_Time(Peak_Time(tp,2)<=0,2),PRCT) prctile(Peak_Time(Peak_Time(tp,3)<=0,3),PRCT)];
            Peak_Early_mean_Strat{mm}=[mean(Peak_Time(Peak_Time(tp,1)>0,1),1) mean(Peak_Time(Peak_Time(tp,2)>0,2),1) mean(Peak_Time(Peak_Time(tp,3)>0,3),1)];
            Peak_Late_mean_Strat{mm}=[mean(Peak_Time(Peak_Time(tp,1)<=0,1),1) mean(Peak_Time(Peak_Time(tp,2)<=0,2),1) mean(Peak_Time(Peak_Time(tp,3)<=0,3),1)];
        end

        tp=Peak_Time_Raw(:,2)>=dstart & Peak_Time_Raw(:,2)<dend;
        if(sum(tp)>0)
            DH_PRCT_Month{mm}=prctile(DH_Samp(tp,:),PRCT);
            DH_mean_Month{mm}=mean(DH_Samp(tp,:),1);
        end

        tp=Peak_Time_Raw(:,3)>=dstart & Peak_Time_Raw(:,3)<dend;
        if(sum(tp)>0)
            PH_PRCT_Month{mm}=prctile(PH_Samp(tp,:),PRCT);
            PH_mean_Month{mm}=mean(PH_Samp(tp,:),1);
        end
    end  
    
    save(['Output_Sample_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '_Comapred_to_September_2022.mat'],'Cumulative_Count_Low_mean','Cumulative_Count_High_mean','Cumulative_Count_Low_PRCT','Cumulative_Count_High_PRCT', 'Peak_Low_mean','Peak_High_mean','Peak_Low_PRCT','Peak_High_PRCT',    'Peak_Early_mean','Peak_Late_mean','Peak_Early_PRCT','Peak_Late_PRCT','Cumulative_Count_Low_mean_Strat','Cumulative_Count_High_mean_Strat','Cumulative_Count_Low_PRCT_Strat','Cumulative_Count_High_PRCT_Strat', 'Peak_Low_mean_Strat','Peak_High_mean_Strat','Peak_Low_PRCT_Strat','Peak_High_PRCT_Strat',    'Peak_Early_mean_Strat','Peak_Late_mean_Strat','Peak_Early_PRCT_Strat','Peak_Late_PRCT_Strat','Cumulative_Count_Low_mean_Month','Cumulative_Count_High_mean_Month','Cumulative_Count_Low_PRCT_Month','Cumulative_Count_High_PRCT_Month', 'Peak_Low_mean_Month','Peak_High_mean_Month','Peak_Low_PRCT_Month','Peak_High_PRCT_Month',    'Peak_Early_mean_Month','Peak_Late_mean_Month','Peak_Early_PRCT_Month','Peak_Late_PRCT_Month','Earlier_Peak_Time_Month','Higher_Peak_Mag_Month','Higher_Cumulative_Count_Month','Earlier_Peak_Time_Strat','Higher_Peak_Mag_Strat','Higher_Cumulative_Count_Strat','Earlier_Peak_Time','Higher_Peak_Mag','Higher_Cumulative_Count','T_Run','Cumulative_Count_PRCT_Strat','Cumulative_Count_mean_Strat','Cumulative_Count_PRCT_Month','Cumulative_Count_mean_Month','DI_PRCT','DH_PRCT','PH_PRCT','DI_mean','DH_mean','PH_mean','DI_PRCT_Strat','DH_PRCT_Strat','PH_PRCT_Strat','DI_mean_Strat','DH_mean_Strat','PH_mean_Strat','Cumulative_Count_PRCT','Cumulative_Count_mean','DI_PRCT_Month','DH_PRCT_Month','PH_PRCT_Month','DI_mean_Month','DH_mean_Month','PH_mean_Month','MM_Strat_Start');
end