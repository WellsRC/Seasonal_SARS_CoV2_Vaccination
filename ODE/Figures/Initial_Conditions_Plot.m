clear;
clc;
close all;
temp_cd=pwd;
temp_cd=temp_cd(1:end-7);

load([temp_cd 'Analyze_Samples\Parameter_Filtered.mat'])

ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
AgeC={['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+','All'};

A=length(P_All{1}.N);
Av=[0:A-1];
    

span_A=28.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;

E_n=6+span_A;
I_n=11+span_A;

R1_n=16+span_A;
R2_n=17+span_A;
R3_n=18+span_A;
R4_n=19+span_A;
R5_n=20+span_A;
R1_i=21+span_A;
R2_i=22+span_A;
R3_i=23+span_A;
R4_i=24+span_A;
R5_i=25+span_A;


S=zeros(length(P_All),size(ACg,1));
E=zeros(length(P_All),size(ACg,1));
I=zeros(length(P_All),size(ACg,1));
R1=zeros(length(P_All),size(ACg,1));
R2=zeros(length(P_All),size(ACg,1));
R3=zeros(length(P_All),size(ACg,1));
R4=zeros(length(P_All),size(ACg,1));
R5=zeros(length(P_All),size(ACg,1));

for aa=1:size(ACg,1)
    parfor nn=1:length(P_All)
        
        indx=find(Av>=ACg(aa,1) & Av<=ACg(aa,2));
        N_temp=sum(P_All{nn}.N(indx))
        S(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(S_n(indx))+P_All{nn}.X0.Baseline_Campaign(S_i(indx))))./N_temp;
        E(nn,aa)=sum(P_All{nn}.X0.Baseline_Campaign(E_n(indx)))./N_temp;
        I(nn,aa)=sum(P_All{nn}.X0.Baseline_Campaign(I_n(indx)))./N_temp;
        R1(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R1_n(indx))+P_All{nn}.X0.Baseline_Campaign(R1_i(indx))))./N_temp;
        R2(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R2_n(indx))+P_All{nn}.X0.Baseline_Campaign(R2_i(indx))))./N_temp;
        R3(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R3_n(indx))+P_All{nn}.X0.Baseline_Campaign(R3_i(indx))))./N_temp;
        R4(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R4_n(indx))+P_All{nn}.X0.Baseline_Campaign(R4_i(indx))))./N_temp;
        R5(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R5_n(indx))+P_All{nn}.X0.Baseline_Campaign(R5_i(indx))))./N_temp;
    end
end

x_s=linspace(0.035,1,8);
dx=0.8.*(x_s(2)-x_s(1));
x_s=x_s(1:end-1);
y_s=linspace(0.05,1,9);
y_s=flip(y_s(1:end-1));
dy=0.75.*(y_s(1)-y_s(2));
figure('units','normalized','outerposition',[0.02 0.02 1 1]);
yl={'Susceptible','Latent','Infectious','Recovered: 1','Recovered: 2','Recovered: 3','Recovered: 4','Recovered: 5'};
for vv=1:8
    switch vv
        case 1
            Y_temp=S;
        case 2
            Y_temp=E;
        case 3
            Y_temp=I;
        case 4
            Y_temp=R1;
        case 5
            Y_temp=R2;
        case 6
            Y_temp=R3;
        case 7
            Y_temp=R4;
        case 8
            Y_temp=R5;
    end

    for aa=1:size(ACg,1)
        subplot('Position',[x_s(aa) y_s(vv) dx dy])
        min_x=floor(10.*min(Y_temp(:,aa)))./10;
        max_x=ceil(10.*max(Y_temp(:,aa)))./10;
        histogram(Y_temp(:,aa),linspace(min_x,max_x,51),'FaceColor','k','LineStyle','none','Normalization','probability');
        if((max_x-min_x)/5>0.05)
            dxx=0.1;
        elseif((max_x-min_x)/5<0.025)
            dxx=0.02;
        else
            dxx=0.05;
        end
        set(gca,'LineWidth',2,'tickdir','out','Fontsize',10,'Xtick',min_x:dxx:max_x,'YTick',[]);
        xtickangle(0);
        box off;
        if(aa==1)
            ylabel(yl{vv},'Fontsize',12)
        end
        if(vv==1)
            title(['Ages: ' AgeC{aa}])
        end
        if(vv==8)
            xlabel('Proportion','Fontsize',12)
        end
    end
    
end

print(gcf,['Initial_Conditions_Baseline_Calibration.png'],'-dpng','-r600');

clear;
clc;
close all;
temp_cd=pwd;
temp_cd=temp_cd(1:end-7);

load([temp_cd 'Analyze_Samples\Parameter_Filtered_Unimodal_Winter.mat'])

ACg=[0 1;2 4;5 12;13 17; 18 49; 50 64; 65 85];
AgeC={['0' char(8211) '1'],['2' char(8211) '4'],['5' char(8211) '12'],['13' char(8211) '17'],['18' char(8211) '49'],['50' char(8211) '64'],'65+','All'};

A=length(P_All{1}.N);
Av=[0:A-1];
    

span_A=28.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;

E_n=6+span_A;
I_n=11+span_A;

R1_n=16+span_A;
R2_n=17+span_A;
R3_n=18+span_A;
R4_n=19+span_A;
R5_n=20+span_A;
R1_i=21+span_A;
R2_i=22+span_A;
R3_i=23+span_A;
R4_i=24+span_A;
R5_i=25+span_A;


S=zeros(length(P_All),size(ACg,1));
E=zeros(length(P_All),size(ACg,1));
I=zeros(length(P_All),size(ACg,1));
R1=zeros(length(P_All),size(ACg,1));
R2=zeros(length(P_All),size(ACg,1));
R3=zeros(length(P_All),size(ACg,1));
R4=zeros(length(P_All),size(ACg,1));
R5=zeros(length(P_All),size(ACg,1));

for aa=1:size(ACg,1)
    parfor nn=1:length(P_All)
        
        indx=find(Av>=ACg(aa,1) & Av<=ACg(aa,2));
        N_temp=sum(P_All{nn}.N(indx))
        S(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(S_n(indx))+P_All{nn}.X0.Baseline_Campaign(S_i(indx))))./N_temp;
        E(nn,aa)=sum(P_All{nn}.X0.Baseline_Campaign(E_n(indx)))./N_temp;
        I(nn,aa)=sum(P_All{nn}.X0.Baseline_Campaign(I_n(indx)))./N_temp;
        R1(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R1_n(indx))+P_All{nn}.X0.Baseline_Campaign(R1_i(indx))))./N_temp;
        R2(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R2_n(indx))+P_All{nn}.X0.Baseline_Campaign(R2_i(indx))))./N_temp;
        R3(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R3_n(indx))+P_All{nn}.X0.Baseline_Campaign(R3_i(indx))))./N_temp;
        R4(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R4_n(indx))+P_All{nn}.X0.Baseline_Campaign(R4_i(indx))))./N_temp;
        R5(nn,aa)=(sum(P_All{nn}.X0.Baseline_Campaign(R5_n(indx))+P_All{nn}.X0.Baseline_Campaign(R5_i(indx))))./N_temp;
    end
end

x_s=linspace(0.035,1,8);
dx=0.8.*(x_s(2)-x_s(1));
x_s=x_s(1:end-1);
y_s=linspace(0.05,1,9);
y_s=flip(y_s(1:end-1));
dy=0.75.*(y_s(1)-y_s(2));
figure('units','normalized','outerposition',[0.02 0.02 1 1]);
yl={'Susceptible','Latent','Infectious','Recovered: 1','Recovered: 2','Recovered: 3','Recovered: 4','Recovered: 5'};
for vv=1:8
    switch vv
        case 1
            Y_temp=S;
        case 2
            Y_temp=E;
        case 3
            Y_temp=I;
        case 4
            Y_temp=R1;
        case 5
            Y_temp=R2;
        case 6
            Y_temp=R3;
        case 7
            Y_temp=R4;
        case 8
            Y_temp=R5;
    end

    for aa=1:size(ACg,1)
        subplot('Position',[x_s(aa) y_s(vv) dx dy])
        min_x=floor(10.*min(Y_temp(:,aa)))./10;
        max_x=ceil(10.*max(Y_temp(:,aa)))./10;
        histogram(Y_temp(:,aa),linspace(min_x,max_x,51),'FaceColor','k','LineStyle','none','Normalization','probability');
        if((max_x-min_x)/5>0.05)
            dxx=0.1;
        elseif((max_x-min_x)/5<0.025)
            dxx=0.02;
        else
            dxx=0.05;
        end
        set(gca,'LineWidth',2,'tickdir','out','Fontsize',10,'Xtick',min_x:dxx:max_x,'YTick',[]);
        xtickangle(0);
        box off;
        if(aa==1)
            ylabel(yl{vv},'Fontsize',12)
        end
        if(vv==1)
            title(['Ages: ' AgeC{aa}])
        end
        if(vv==8)
            xlabel('Proportion','Fontsize',12)
        end
    end
    
end

print(gcf,['Initial_Conditions_Unimodal_Calibration.png'],'-dpng','-r600');