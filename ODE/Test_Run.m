clear;
clc;
close all;

NS=10^4;

DI=cell(NS,1);
DH=cell(NS,1);
CH=cell(NS,1);

[T_Run,P] = Parameter_Sample(NS);

parfor jj=1:NS
    [~,Cumulative_Incidence,Daily_Incidence,Cumulative_Hospital,Daily_Hospital] = Run_ODE(T_Run,P{jj});
    DH{jj}=Daily_Hospital;
    DI{jj}=Daily_Incidence;
    CH{jj}=Cumulative_Hospital;
end

R=zeros(NS,365);
PT=zeros(NS,2);
for jj=1:NS
    temp=DH{jj};
    R(jj,:)=sum(temp.Total,1);
    temp=DI{jj};
    temp=sum(temp.Total,1);
    PT(jj,:)=[max(T_Run(temp==max(temp))) max(temp(:))]; 
end

patch([1:365 365:-1:1], [prctile(R,2.5) flip(prctile(R,97.5))],'k','LineStyle','none','facealpha',0.3);
hold on
plot([1:365],mean(R),'k','LineWidth',2);
plot([1:365],median(R),'r','LineWidth',2);