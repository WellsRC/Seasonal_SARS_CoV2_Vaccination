function Filter_Peaks_Baseline(NG,NS)

P_All=cell(NG*NS,1);

Pks=zeros(NG*NS,1);
Time_Peaks=NaN.*zeros(NG*NS,2);
WPks=NaN.*zeros(NG*NS,1);
temp_cd=pwd;

for gg=1:NG
    load([temp_cd(1:end-15) 'Sample_Gen_' num2str(gg) '.mat'],'P','T_Run','Model_Output');
   for ss=1:NS 
        MO=Model_Output{ss};        
        [Pks(ss+NS.*(gg-1)),Time_Peaks(ss+NS.*(gg-1),:),WPks(ss+NS.*(gg-1))]=Hospital_Admission_Peak(MO.Hospital_Admission,T_Run);  
   end
    P_All([1:NS]+NS.*(gg-1))=P;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Large Winter Peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
P_Large_Winter=P_All(Pks==1 & WPks==1);
WTime_Peaks=Time_Peaks(Pks==1 & WPks==1,:);

Indx_W=(WTime_Peaks(:,1)>=datenum('December 1, 2022') & WTime_Peaks(:,1)<datenum('March 1, 2023'));
Indx_WN=(WTime_Peaks(:,1)>=datenum('November 1, 2022') & WTime_Peaks(:,1)<datenum('December 1, 2022'));
Indx_WO=(WTime_Peaks(:,1)>=datenum('October 1, 2022') & WTime_Peaks(:,1)<datenum('November 1, 2022'));
Indx_WS=(WTime_Peaks(:,1)>=datenum('September 1, 2022') & WTime_Peaks(:,1)<datenum('October 1, 2022'));

Indx_WM=(WTime_Peaks(:,1)>=datenum('March 1, 2023') & WTime_Peaks(:,1)<datenum('April 1, 2023'));

% R_WP>0
p_N=min(0.75.*(sum(Indx_W)./3)./sum(Indx_WN),1); % need monthly average
p_O=min(0.5.*(sum(Indx_W)./3)./sum(Indx_WO),1); % need monthly average
p_S=min(0.25.*(sum(Indx_W)./3)./sum(Indx_WS),1); % need monthly average

p_M=min(0.5.*(sum(Indx_W)./3)./sum(Indx_WO),1); % need monthly average

Weighted_Winter_Peak=zeros(size(WTime_Peaks,1));
Weighted_Winter_Peak(Indx_W)=1;
Weighted_Winter_Peak(Indx_WN)=p_N;
Weighted_Winter_Peak(Indx_WO)=p_O;
Weighted_Winter_Peak(Indx_WS)=p_S;

Weighted_Winter_Peak(Indx_WM)=p_M;

Indx_S=(WTime_Peaks(:,2)>=datenum('June 1, 2023') & WTime_Peaks(:,2)<datenum('September 1, 2023'));
Indx_SM=(WTime_Peaks(:,2)>=datenum('May 1, 2023') & WTime_Peaks(:,2)<datenum('June 1, 2023'));
Indx_SA=(WTime_Peaks(:,2)>=datenum('April 1, 2023') & WTime_Peaks(:,2)<datenum('May 1, 2023'));

Weighted_Summer_Peak=zeros(size(WTime_Peaks,1));

p_M=min(0.66.*(sum(Indx_S)./3)./sum(Indx_SM),1);
p_A=min(0.33.*(sum(Indx_S)./3)./sum(Indx_SA),1);

Weighted_Summer_Peak(Indx_S)=1;
Weighted_Summer_Peak(Indx_SM)=p_M;
Weighted_Summer_Peak(Indx_SA)=p_A;

RSW=rand(size(Weighted_Winter_Peak));
RSS=rand(size(Weighted_Summer_Peak));

Weighted_Selection= (RSW<Weighted_Winter_Peak) & (RSS<Weighted_Summer_Peak);

P_Large_Winter=P_Large_Winter(Weighted_Selection);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Large Summer Peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
P_Large_Summer=P_All(Pks==1 & WPks==0);
STime_Peaks=Time_Peaks(Pks==1 & WPks==0,:);

Indx_W=(STime_Peaks(:,1)>=datenum('December 1, 2022') & STime_Peaks(:,1)<datenum('March 1, 2023'));
Indx_WN=(STime_Peaks(:,1)>=datenum('November 1, 2022') & STime_Peaks(:,1)<datenum('December 1, 2022'));
Indx_WO=(STime_Peaks(:,1)>=datenum('October 1, 2022') & STime_Peaks(:,1)<datenum('November 1, 2022'));
Indx_WS=(STime_Peaks(:,1)>=datenum('September 1, 2022') & STime_Peaks(:,1)<datenum('October 1, 2022'));

Indx_WM=(STime_Peaks(:,1)>=datenum('March 1, 2023') & STime_Peaks(:,1)<datenum('April 1, 2023'));

% R_WP>0
p_N=min(0.75.*(sum(Indx_W)./3)./sum(Indx_WN),1); % need monthly average
p_O=min(0.5.*(sum(Indx_W)./3)./sum(Indx_WO),1); % need monthly average
p_S=min(0.25.*(sum(Indx_W)./3)./sum(Indx_WS),1); % need monthly average

p_M=min(0.5.*(sum(Indx_W)./3)./sum(Indx_WO),1); % need monthly average

Weighted_Winter_Peak=zeros(size(STime_Peaks,1));
Weighted_Winter_Peak(Indx_W)=1;
Weighted_Winter_Peak(Indx_WN)=p_N;
Weighted_Winter_Peak(Indx_WO)=p_O;
Weighted_Winter_Peak(Indx_WS)=p_S;

Weighted_Winter_Peak(Indx_WM)=p_M;

Indx_S=(STime_Peaks(:,2)>=datenum('June 1, 2023') & STime_Peaks(:,2)<datenum('September 1, 2023'));
Indx_SM=(STime_Peaks(:,2)>=datenum('May 1, 2023') & STime_Peaks(:,2)<datenum('June 1, 2023'));
Indx_SA=(STime_Peaks(:,2)>=datenum('April 1, 2023') & STime_Peaks(:,2)<datenum('May 1, 2023'));

Weighted_Summer_Peak=zeros(size(STime_Peaks,1));

p_M=min(0.66.*(sum(Indx_S)./3)./sum(Indx_SM),1);
p_A=min(0.33.*(sum(Indx_S)./3)./sum(Indx_SA),1);

Weighted_Summer_Peak(Indx_S)=1;
Weighted_Summer_Peak(Indx_SM)=p_M;
Weighted_Summer_Peak(Indx_SA)=p_A;

RSW=rand(size(Weighted_Winter_Peak));
RSS=rand(size(Weighted_Summer_Peak));

Weighted_Selection= (RSW<Weighted_Winter_Peak) & (RSS<Weighted_Summer_Peak);

P_Large_Summer=P_Large_Summer(Weighted_Selection);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save(['Parameter_Filtered.mat'],'P_Large_Winter','P_Large_Summer','T_Run');

end

