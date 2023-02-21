clear;
clc;

NG=150;
NS=10^4;

MMv={'August','September','October','November','December','January','February','March','April'};
YMv=[2022 2022 2022 2022 2022 2023 2023 2023 2023];

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
    
    PRCT=[2.5 25 50 75 97.5];
    
    Cumulative_Count_PRCT=prctile(Cumulative_Count,PRCT);
    Cumulative_Count_mean=mean(Cumulative_Count,1);
    
    DI_PRCT=prctile(DI_Samp,PRCT);
    DH_PRCT=prctile(DH_Samp,PRCT);
    PH_PRCT=prctile(PH_Samp,PRCT);
    
    DI_mean=mean(DI_Samp,1);
    DH_mean=mean(DH_Samp,1);
    PH_mean=mean(PH_Samp,1);
    
    dT=T_Run;
    mp=2:0.05:7;

    [N_DI,dT,mp] = histcounts2(Peak_Time(:,1),log10(Peak_Mag(:,1)),dT,mp);
    [N_DH,dT,mp] = histcounts2(Peak_Time(:,2),log10(Peak_Mag(:,2)),dT,mp);
    [N_PH,dT,mp] = histcounts2(Peak_Time(:,3),log10(Peak_Mag(:,3)),dT,mp);
    
    MM_Strat_Start={'July 1, 2022','September 1, 2022','December 1 2022','March 1, 2023','July 1,2023'};
    
    
    DI_PRCT_Strat=cell(4,1);
    DH_PRCT_Strat=cell(4,1);
    PH_PRCT_Strat=cell(4,1);
    Cumulative_Count_PRCT_Strat=cell(4,1);
    
    DI_mean_Strat=cell(4,1);
    DH_mean_Strat=cell(4,1);
    PH_mean_Strat=cell(4,1);
    Cumulative_Count_mean_Strat=cell(4,1);
    
    for mm=1:4
        dstart=datenum(MM_Strat_Start{mm});
        dend=datenum(MM_Strat_Start{mm+1});
        tp=Peak_Time(:,1)>=dstart & Peak_Time(:,1)<dend;
        if(sum(tp)>0)
            DI_PRCT_Strat{mm}=prctile(DI_Samp(tp,:),PRCT);
            DI_mean_Strat{mm}=mean(DI_Samp(tp,:),1);
            Cumulative_Count_PRCT_Strat{mm}=prctile(Cumulative_Count(tp,:),PRCT);
            Cumulative_Count_mean_Strat{mm}=mean(Cumulative_Count(tp,:),1);
        end

        tp=Peak_Time(:,2)>=dstart & Peak_Time(:,2)<dend;
        if(sum(tp)>0)
            DH_PRCT_Strat{mm}=prctile(DH_Samp(tp,:),PRCT);
            DH_mean_Strat{mm}=mean(DH_Samp(tp,:),1);
            
        end

        tp=Peak_Time(:,3)>=dstart & Peak_Time(:,3)<dend;
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
    
    MM={'July','August','September','October','November','December','January','February','March','April','May','June','July'};
    YM=[2022 2022 2022 2022 2022 2022 2023 2023 2023 2023 2023 2023 2023]; 
    
    for mm=1:12
        dstart=datenum([MM{mm} ' 1, ' num2str(YM(mm))]);
        dend=datenum([MM{mm+1} ' 1, ' num2str(YM(mm+1))]);
        tp=Peak_Time(:,1)>=dstart & Peak_Time(:,1)<dend;
        if(sum(tp)>0)
            DI_PRCT_Month{mm}=prctile(DI_Samp(tp,:),PRCT);
            DI_mean_Month{mm}=mean(DI_Samp(tp,:),1);
            
            Cumulative_Count_PRCT_Month{mm}=prctile(Cumulative_Count(tp,:),PRCT);
            Cumulative_Count_mean_Month{mm}=mean(Cumulative_Count(tp,:),1);
        end

        tp=Peak_Time(:,2)>=dstart & Peak_Time(:,2)<dend;
        if(sum(tp)>0)
            DH_PRCT_Month{mm}=prctile(DH_Samp(tp,:),PRCT);
            DH_mean_Month{mm}=mean(DH_Samp(tp,:),1);
        end

        tp=Peak_Time(:,3)>=dstart & Peak_Time(:,3)<dend;
        if(sum(tp)>0)
            PH_PRCT_Month{mm}=prctile(PH_Samp(tp,:),PRCT);
            PH_mean_Month{mm}=mean(PH_Samp(tp,:),1);
        end
    end  
    
    
    save(['Output_Sample_Vac_Start_' MMv{mmv} '_' num2str(YMv(mmv)) '.mat'],'N_DI','N_DH','N_PH','T_Run','dT','mp','MM','YM','Cumulative_Count_PRCT_Strat','Cumulative_Count_mean_Strat','Cumulative_Count_PRCT_Month','Cumulative_Count_mean_Month','DI_PRCT','DH_PRCT','PH_PRCT','DI_mean','DH_mean','PH_mean','DI_PRCT_Strat','DH_PRCT_Strat','PH_PRCT_Strat','DI_mean_Strat','DH_mean_Strat','PH_mean_Strat','Cumulative_Count_PRCT','Cumulative_Count_mean','DI_PRCT_Month','DH_PRCT_Month','PH_PRCT_Month','DI_mean_Month','DH_mean_Month','PH_mean_Month','MM_Strat_Start');
end