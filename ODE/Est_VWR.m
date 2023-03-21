clear;
clc;

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
load([pwd '/Analyze_Samples/Filtered_Outputs.mat'],'Filtered_Output_All');


NS=length(P_All);

C_Death=Filtered_Output_All.Annual_Booster.High_Coverage.Death_Cumulative_Count_Age(:,end);

clear Filtered_Output_All;

for rr=1:40
    vac_red=rr./100;
    Red_VWR=zeros(length(P_All),1);
    parfor jj=1:NS
        Red_VWR(jj)=Est_Reduction_Waning_Rate(P_All{jj},AC,C_Death,vac_red);
    end
    save(['Reduce_Waning_Immunity_65_plus_Vac_reduction=' num2str(100.*vac_red) '.mat'],'Red_VWR');
end