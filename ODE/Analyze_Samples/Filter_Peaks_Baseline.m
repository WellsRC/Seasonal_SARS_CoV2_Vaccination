function Filter_Peaks_Baseline(NG,NS)

P_All=cell(NG*NS,1);

Pks=zeros(NG*NS,1);
Mag_Peaks=NaN.*zeros(NG*NS,2);
Time_Peaks=NaN.*zeros(NG*NS,2);
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
   for ss=1:NS 
        MO=Model_Output{ss};        
        [Pks(ss+NS.*(gg-1)),Mag_Peaks(ss+NS.*(gg-1),:),Time_Peaks(ss+NS.*(gg-1),:)]=Hospital_Admission_Peak(MO.Hospital_Admission,T_Run);  
   end
    P_All([1:NS]+NS.*(gg-1))=P;
end

P_All=P_All(Pks==1);
Mag_Peaks=Mag_Peaks(Pks==1,:);
Time_Peaks=Time_Peaks(Pks==1,:);
R_WP=(Mag_Peaks(:,1)./Mag_Peaks(:,2))-1;

Indx_W=(Time_Peaks(:,1)>=datenum('December 1, 2022') & Time_Peaks(:,1)<datenum('March 1, 2023'));
Indx_WN=(Time_Peaks(:,1)>=datenum('November 1, 2022') & Time_Peaks(:,1)<datenum('December 1, 2022'));
Indx_WO=(Time_Peaks(:,1)>=datenum('October 1, 2022') & Time_Peaks(:,1)<datenum('November 1, 2022'));
Indx_WS=(Time_Peaks(:,1)>=datenum('September 1, 2022') & Time_Peaks(:,1)<datenum('October 1, 2022'));

Indx_WM=(Time_Peaks(:,1)>=datenum('March 1, 2023') & Time_Peaks(:,1)<datenum('April 1, 2023'));

% R_WP>0
p_N=min(0.75.*(sum(Indx_W(R_WP>0))./3)./sum(Indx_WN(R_WP>0)),1); % need monthly average
p_O=min(0.5.*(sum(Indx_W(R_WP>0))./3)./sum(Indx_WO(R_WP>0)),1); % need monthly average
p_S=min(0.25.*(sum(Indx_W(R_WP>0))./3)./sum(Indx_WS(R_WP>0)),1); % need monthly average

p_M=min(0.5.*(sum(Indx_W(R_WP>0))./3)./sum(Indx_WO(R_WP>0)),1); % need monthly average

Weighted_Winter_Peak=zeros(size(R_WP));
Weighted_Winter_Peak(Indx_W & R_WP>0)=1;
Weighted_Winter_Peak(Indx_WN & R_WP>0)=p_N;
Weighted_Winter_Peak(Indx_WO & R_WP>0)=p_O;
Weighted_Winter_Peak(Indx_WS & R_WP>0)=p_S;

Weighted_Winter_Peak(Indx_WM & R_WP>0)=p_M;

% R_WP<0
p_N=min(0.75.*(sum(Indx_W(R_WP<0))./3)./sum(Indx_WN(R_WP<0)),1); % need monthly average
p_O=min(0.5.*(sum(Indx_W(R_WP<0))./3)./sum(Indx_WO(R_WP<0)),1); % need monthly average
p_S=min(0.25.*(sum(Indx_W(R_WP<0))./3)./sum(Indx_WS(R_WP<0)),1); % need monthly average

p_M=min(0.5.*(sum(Indx_W(R_WP<0))./3)./sum(Indx_WO(R_WP<0)),1); % need monthly average

Weighted_Winter_Peak(Indx_W & R_WP<0)=1;
Weighted_Winter_Peak(Indx_WN & R_WP<0)=p_N;
Weighted_Winter_Peak(Indx_WO & R_WP<0)=p_O;
Weighted_Winter_Peak(Indx_WS & R_WP<0)=p_S;

Weighted_Winter_Peak(Indx_WM & R_WP<0)=p_M;

Indx_S=(Time_Peaks(:,2)>=datenum('June 1, 2023') & Time_Peaks(:,2)<datenum('September 1, 2023'));
Indx_SM=(Time_Peaks(:,2)>=datenum('May 1, 2023') & Time_Peaks(:,2)<datenum('June 1, 2023'));
Indx_SA=(Time_Peaks(:,2)>=datenum('April 1, 2023') & Time_Peaks(:,2)<datenum('May 1, 2023'));

Weighted_Summer_Peak=zeros(size(R_WP));

p_M=min(0.66.*(sum(Indx_S(R_WP>0))./3)./sum(Indx_SM(R_WP>0)),1);
p_A=min(0.33.*(sum(Indx_S(R_WP>0))./3)./sum(Indx_SA(R_WP>0)),1);

Weighted_Summer_Peak(Indx_S & R_WP>0)=1;
Weighted_Summer_Peak(Indx_SM & R_WP>0)=p_M;
Weighted_Summer_Peak(Indx_SA & R_WP>0)=p_A;

% R_WP<0
p_M=min(0.66.*(sum(Indx_S(R_WP<0))./3)./sum(Indx_SM(R_WP<0)),1);
p_A=min(0.33.*(sum(Indx_S(R_WP<0))./3)./sum(Indx_SA(R_WP<0)),1);

Weighted_Summer_Peak(Indx_S & R_WP<0)=1;
Weighted_Summer_Peak(Indx_SM & R_WP<0)=p_M;
Weighted_Summer_Peak(Indx_SA & R_WP<0)=p_A;

RSW=rand(size(Weighted_Winter_Peak));
RSS=rand(size(Weighted_Summer_Peak));

Weighted_Selection= (RSW<Weighted_Winter_Peak) & (RSS<Weighted_Summer_Peak);

P_Large_Winter=P_All(R_WP>0 & Weighted_Selection);
P_Large_Summer=P_All(R_WP<0 & Weighted_Selection);

P_All=P_All(Weighted_Selection);
R_WP(Weighted_Selection)=0;

save(['Parameter_Filtered.mat'],'P_All','P_Large_Winter','P_Large_Summer','R_WP','T_Run');

end

