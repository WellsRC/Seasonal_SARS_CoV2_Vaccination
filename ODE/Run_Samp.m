clear;
clc;
close all;
parpool(32)
rng('shuffle');
for ss=1:50
    NS=10^3;  

    [T_Run,P] = Parameter_Sample(NS);
    count_f=1;
    while isfile(['Sample_Gen_' num2str(count_f) '.mat'])
        count_f=count_f+1;
    end
    % Save Here so do not have to wait for the simualtion to complete
    % before another pool of runs can be run
    save(['Sample_Gen_' num2str(count_f) '.mat'],'P','T_Run');
    Model_Output=cell(NS,1);
    
    parfor jj=1:NS
        Pt=P{jj};
        [~,~,Model_Output{jj}] = Run_ODE(T_Run,Pt);
    end
    save(['Sample_Gen_' num2str(count_f) '.mat'],'P','T_Run','Model_Output');
    
end
