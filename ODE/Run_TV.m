clear;
clc;
parpool(32)

for ss=1:1000
    load(['Sample_Gen_' num2str(ss) '.mat'],'P','T_Run');
    
    NS=length(P);
    
    TV=[datenum('July 1, 2022') datenum('August 1, 2022') datenum('October 1, 2022') datenum('November 1, 2022') datenum('December 1, 2022') datenum('January 1, 2023') datenum('February 1, 2023') datenum('March 1, 2023')];
    Red_V=[0:0.1:0.4];
    
    [TV,Red_V]=meshgrid(TV,Red_V);
    
    TV=TV(:);
    Red_V=Red_V(:);
    
    DI_Adj=cell(NS,length(TV));
    DH_Adj=cell(NS,length(TV));
    
    for pp=1:length(TV)
        parfor jj=1:NS
           Parameters_Adj = Adjust_Vaccination(T_Run,P{jj},TV(pp),Red_V(pp));
            [~,~,Daily_Incidence,~,Daily_Hospital] = Run_ODE(T_Run,P{jj});
            DH_Adj{jj,pp}=Daily_Hospital;
            DI_Adj{jj,pp}=Daily_Incidence;
        end
    end
    save(['Adjust_Vaccination_' num2str(ss) '.mat'],'TV','Red_V','T_Run','DI_Adj','DH_Adj','CI_Adj','CH_Adj');
end