parpool(48);

AC=[0:84];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks (Slow Waning vaccine)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_Large_Winter','T_Run');

NS=length(P_Large_Winter);
num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));

Age_Dose=zeros(size(AC));
Age_Dose(AC>=50 | AC<2)=1;
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_Large_Winter(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.Add_dose.t0=T_Run(1);
            Parameters.Add_dose.Time=Time_Dose+T_Run(1);
            Parameters.Add_dose.Age=Age_Dose;
            Parameters.eps_V1=Parameters.eps_V1(end).*ones(size(Parameters.eps_V1));
            Parameters.eps_V2=Parameters.eps_V2(end).*ones(size(Parameters.eps_V2));
            Parameters.eps_V3=Parameters.eps_V3(end).*ones(size(Parameters.eps_V3));
            Parameters.q1_sd=Parameters.q1_sd(end).*ones(size(Parameters.q1_sd));
            Parameters.q2_sd=Parameters.q2_sd(end).*ones(size(Parameters.q2_sd));
            Parameters.q3_sd=Parameters.q3_sd(end).*ones(size(Parameters.q3_sd));
            Parameters.gammaV_1=Parameters.gammaV_1(end).*ones(size(Parameters.gammaV_1));
            Parameters.gammaV_2=Parameters.gammaV_2(end).*ones(size(Parameters.gammaV_2));
            Parameters.gammaV_3=Parameters.gammaV_3(end).*ones(size(Parameters.gammaV_3));
            Parameters.kappaV_1=Parameters.kappaV_1(end).*ones(size(Parameters.kappaV_1));
            Parameters.kappaV_2=Parameters.kappaV_2(end).*ones(size(Parameters.kappaV_2));
            [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
        end
        save(['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Slow_Waning_Vaccine_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end


for ii=1:length(NSv)  
    Model_Output=cell(NSv(ii),1);
    if(ii==1)
        s_start=1;
    else
        s_start=sum(NSv(1:(ii-1)))+1;
    end
    s_end=sum(NSv(1:ii));
    Pt=P_Large_Winter(s_start:s_end);
    parfor jj=1:NSv(ii)
        Parameters=Pt{jj};
        Parameters.eps_V1=Parameters.eps_V1(end).*ones(size(Parameters.eps_V1));
        Parameters.eps_V2=Parameters.eps_V2(end).*ones(size(Parameters.eps_V2));
        Parameters.eps_V3=Parameters.eps_V3(end).*ones(size(Parameters.eps_V3));
        Parameters.q1_sd=Parameters.q1_sd(end).*ones(size(Parameters.q1_sd));
        Parameters.q2_sd=Parameters.q2_sd(end).*ones(size(Parameters.q2_sd));
        Parameters.q3_sd=Parameters.q3_sd(end).*ones(size(Parameters.q3_sd));
        Parameters.gammaV_1=Parameters.gammaV_1(end).*ones(size(Parameters.gammaV_1));
        Parameters.gammaV_2=Parameters.gammaV_2(end).*ones(size(Parameters.gammaV_2));
        Parameters.gammaV_3=Parameters.gammaV_3(end).*ones(size(Parameters.gammaV_3));
        Parameters.kappaV_1=Parameters.kappaV_1(end).*ones(size(Parameters.kappaV_1));
        Parameters.kappaV_2=Parameters.kappaV_2(end).*ones(size(Parameters.kappaV_2));
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
    end
    save(['Annual_ILC_Slow_Waning_Vaccine_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fast Waning vaccine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_Large_Winter(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.Add_dose.t0=T_Run(1);
            Parameters.Add_dose.Time=Time_Dose+T_Run(1);
            Parameters.Add_dose.Age=Age_Dose;
            Parameters.eps_V1=Parameters.eps_V1(1).*ones(size(Parameters.eps_V1));
            Parameters.eps_V2=Parameters.eps_V2(1).*ones(size(Parameters.eps_V2));
            Parameters.eps_V3=Parameters.eps_V3(1).*ones(size(Parameters.eps_V3));
            Parameters.q1_sd=Parameters.q1_sd(1).*ones(size(Parameters.q1_sd));
            Parameters.q2_sd=Parameters.q2_sd(1).*ones(size(Parameters.q2_sd));
            Parameters.q3_sd=Parameters.q3_sd(1).*ones(size(Parameters.q3_sd));
            Parameters.gammaV_1=Parameters.gammaV_1(1).*ones(size(Parameters.gammaV_1));
            Parameters.gammaV_2=Parameters.gammaV_2(1).*ones(size(Parameters.gammaV_2));
            Parameters.gammaV_3=Parameters.gammaV_3(1).*ones(size(Parameters.gammaV_3));
            Parameters.kappaV_1=Parameters.kappaV_1(1).*ones(size(Parameters.kappaV_1));
            Parameters.kappaV_2=Parameters.kappaV_2(1).*ones(size(Parameters.kappaV_2));
            [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
        end
        save(['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Fast_Waning_Vaccine_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end


for ii=1:length(NSv)  
    Model_Output=cell(NSv(ii),1);
    if(ii==1)
        s_start=1;
    else
        s_start=sum(NSv(1:(ii-1)))+1;
    end
    s_end=sum(NSv(1:ii));
    Pt=P_Large_Winter(s_start:s_end);
    parfor jj=1:NSv(ii)
        Parameters=Pt{jj};
        Parameters.eps_V1=Parameters.eps_V1(1).*ones(size(Parameters.eps_V1));
        Parameters.eps_V2=Parameters.eps_V2(1).*ones(size(Parameters.eps_V2));
        Parameters.eps_V3=Parameters.eps_V3(1).*ones(size(Parameters.eps_V3));
        Parameters.q1_sd=Parameters.q1_sd(1).*ones(size(Parameters.q1_sd));
        Parameters.q2_sd=Parameters.q2_sd(1).*ones(size(Parameters.q2_sd));
        Parameters.q3_sd=Parameters.q3_sd(1).*ones(size(Parameters.q3_sd));
        Parameters.gammaV_1=Parameters.gammaV_1(1).*ones(size(Parameters.gammaV_1));
        Parameters.gammaV_2=Parameters.gammaV_2(1).*ones(size(Parameters.gammaV_2));
        Parameters.gammaV_3=Parameters.gammaV_3(1).*ones(size(Parameters.gammaV_3));
        Parameters.kappaV_1=Parameters.kappaV_1(1).*ones(size(Parameters.kappaV_1));
        Parameters.kappaV_2=Parameters.kappaV_2(1).*ones(size(Parameters.kappaV_2));
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
    end
    save(['Annual_ILC_Fast_Waning_Vaccine_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other Waning vaccine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t_d=1:8    
    Time_Dose=90+30.*(t_d-1);
    for ii=1:length(NSv)  
        Model_Output=cell(NSv(ii),1);
        if(ii==1)
            s_start=1;
        else
            s_start=sum(NSv(1:(ii-1)))+1;
        end
        s_end=sum(NSv(1:ii));
        Pt=P_Large_Winter(s_start:s_end);
        parfor jj=1:NSv(ii)
            Parameters=Pt{jj};
            Parameters.Add_dose.t0=T_Run(1);
            Parameters.Add_dose.Time=Time_Dose+T_Run(1);
            Parameters.Add_dose.Age=Age_Dose;
            Parameters.eps_V1=Parameters.eps_V1(31).*ones(size(Parameters.eps_V1));
            Parameters.eps_V2=Parameters.eps_V2(31).*ones(size(Parameters.eps_V2));
            Parameters.eps_V3=Parameters.eps_V3(31).*ones(size(Parameters.eps_V3));
            Parameters.q1_sd=Parameters.q1_sd(31).*ones(size(Parameters.q1_sd));
            Parameters.q2_sd=Parameters.q2_sd(31).*ones(size(Parameters.q2_sd));
            Parameters.q3_sd=Parameters.q3_sd(31).*ones(size(Parameters.q3_sd));
            Parameters.gammaV_1=Parameters.gammaV_1(31).*ones(size(Parameters.gammaV_1));
            Parameters.gammaV_2=Parameters.gammaV_2(31).*ones(size(Parameters.gammaV_2));
            Parameters.gammaV_3=Parameters.gammaV_3(31).*ones(size(Parameters.gammaV_3));
            Parameters.kappaV_1=Parameters.kappaV_1(31).*ones(size(Parameters.kappaV_1));
            Parameters.kappaV_2=Parameters.kappaV_2(31).*ones(size(Parameters.kappaV_2));
            [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
        end
        save(['FDA_Two_Dose_ILC_' num2str(Time_Dose) '_days_Other_Waning_Vaccine_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
    end
end


for ii=1:length(NSv)  
    Model_Output=cell(NSv(ii),1);
    if(ii==1)
        s_start=1;
    else
        s_start=sum(NSv(1:(ii-1)))+1;
    end
    s_end=sum(NSv(1:ii));
    Pt=P_Large_Winter(s_start:s_end);
    parfor jj=1:NSv(ii)
        Parameters=Pt{jj};
        Parameters.eps_V1=Parameters.eps_V1(31).*ones(size(Parameters.eps_V1));
        Parameters.eps_V2=Parameters.eps_V2(31).*ones(size(Parameters.eps_V2));
        Parameters.eps_V3=Parameters.eps_V3(31).*ones(size(Parameters.eps_V3));
        Parameters.q1_sd=Parameters.q1_sd(31).*ones(size(Parameters.q1_sd));
        Parameters.q2_sd=Parameters.q2_sd(31).*ones(size(Parameters.q2_sd));
        Parameters.q3_sd=Parameters.q3_sd(31).*ones(size(Parameters.q3_sd));
        Parameters.gammaV_1=Parameters.gammaV_1(31).*ones(size(Parameters.gammaV_1));
        Parameters.gammaV_2=Parameters.gammaV_2(31).*ones(size(Parameters.gammaV_2));
        Parameters.gammaV_3=Parameters.gammaV_3(31).*ones(size(Parameters.gammaV_3));
        Parameters.kappaV_1=Parameters.kappaV_1(31).*ones(size(Parameters.kappaV_1));
        Parameters.kappaV_2=Parameters.kappaV_2(31).*ones(size(Parameters.kappaV_2));
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Parameters);
    end
    save(['Annual_ILC_Other_Waning_Vaccine_W_' num2str(ii) '.mat'],'T_Run','Model_Output');
end