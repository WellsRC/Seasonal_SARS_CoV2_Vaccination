parpool(48);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for t_d=4:5    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
    NS=length(P_All);
    R_WPv=R_WP;
    num_l=ceil(NS./1000);
    NSv=1000.*ones(num_l,1);
    NSv(end)=NS-sum(NSv(1:end-1));
    
    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=18 & AC<50)=1;
    
    Old_Age_Dose=zeros(size(AC));
    Old_Age_Dose(AC>=50 | AC<2)=1;
    for red_2d=0.35:0.15:0.65
        for ii=1:length(NSv)  
            Model_Output=cell(NSv(ii),1);
            if(ii==1)
                s_start=1;
            else
                s_start=sum(NSv(1:(ii-1)))+1;
            end
            s_end=sum(NSv(1:ii));
            Pt=P_All(s_start:s_end);
            R_WP=R_WPv(s_start:s_end);
            parfor jj=1:NSv(ii)
                Parameters=Pt{jj};
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose+Old_Age_Dose;
            
                Parameters.Proportion_Two_Dose=(1-red_2d).*Old_Age_Dose(:);
            
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduction_' num2str(100.*red_2d) '_FDA_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
            
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Redistributed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t_d=4:5    
    Time_Dose=90+30.*(t_d-1);
    load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
    NS=length(P_All);
    R_WPv=R_WP;
    num_l=ceil(NS./1000);
    NSv=1000.*ones(num_l,1);
    NSv(end)=NS-sum(NSv(1:end-1));
    
    Age_Dose=zeros(size(AC));
    Age_Dose(AC>=18 & AC<50)=1;
    
    Old_Age_Dose=zeros(size(AC));
    Old_Age_Dose(AC>=50 | AC<2)=1;
    for red_2d=0.35:0.15:0.65
        for ii=1:length(NSv)  
            Model_Output=cell(NSv(ii),1);
            if(ii==1)
                s_start=1;
            else
                s_start=sum(NSv(1:(ii-1)))+1;
            end
            s_end=sum(NSv(1:ii));
            Pt=P_All(s_start:s_end);
            R_WP=R_WPv(s_start:s_end);
            parfor jj=1:NSv(ii)
                Parameters=Pt{jj};
                Parameters.Add_dose.t0=T_Run(1);
                Parameters.Add_dose.Time=Time_Dose+T_Run(1);
                Parameters.Add_dose.Age=Age_Dose+Old_Age_Dose;
            
                Num_Needed=sum(Parameters.vac_int_influenza(:).*Parameters.N(:).*Old_Age_Dose(:));
                New_Vac=sum(Parameters.vac_int_influenza(:).*Parameters.N(:).*Age_Dose(:));
                Scale_F=min(New_Vac./Num_Needed,1);
                Parameters.Proportion_Two_Dose=Scale_F.*Age_Dose(:)+(1-red_2d).*Old_Age_Dose(:);
            
                [~,Model_Output{jj}] = Run_Two_Dose_ODE(T_Run,Parameters);
            end
            save(['Two_Dose_ILC_' num2str(Time_Dose) '_days_Reduction_' num2str(100.*red_2d) '_18_49_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
            
        end
    end
end