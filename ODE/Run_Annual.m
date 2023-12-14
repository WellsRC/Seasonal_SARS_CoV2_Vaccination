parpool(32);

AC=[0:84];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bimodal peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','T_Run','R_WP');
NS=length(P_All);
R_WPv=R_WP;
num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));
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
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt{jj});
    end
    save(['Annual_ILC_' num2str(ii) '.mat'],'T_Run','Model_Output','R_WP');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([pwd '/Analyze_Samples/Parameter_Filtered_Unimodal_Winter.mat'],'P_All','T_Run')
NS=length(P_All);
num_l=ceil(NS./1000);
NSv=1000.*ones(num_l,1);
NSv(end)=NS-sum(NSv(1:end-1));
for ii=1:length(NSv)  
    Model_Output=cell(NSv(ii),1);
    if(ii==1)
        s_start=1;
    else
        s_start=sum(NSv(1:(ii-1)))+1;
    end
    s_end=sum(NSv(1:ii));
    Pt=P_All(s_start:s_end);
    parfor jj=1:NSv(ii)
        Parameters=Pt{jj};
        [~,Model_Output{jj}] = Run_Annual_Booster_ODE(T_Run,Pt{jj});
    end
    save(['Annual_ILC_UW_' num2str(ii) '.mat'],'T_Run','Model_Output');
end