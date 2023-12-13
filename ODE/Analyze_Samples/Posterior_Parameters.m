clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Large Winter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
AC=[0:84];
load([pwd '\Parameter_Filtered.mat'])
sigma_E=zeros(length(P_Large_Winter),1);
day_delta_I=zeros(length(P_Large_Winter),3);
day_delta_V=zeros(length(P_Large_Winter),3);
eps_V1=zeros(length(P_Large_Winter),3);
eps_V2=zeros(length(P_Large_Winter),3);
eps_V3=zeros(length(P_Large_Winter),3);
q1_sd=zeros(length(P_Large_Winter),3);
q2_sd=zeros(length(P_Large_Winter),3);
q3_sd=zeros(length(P_Large_Winter),3);
gammaV_1=zeros(length(P_Large_Winter),3);
gammaV_2=zeros(length(P_Large_Winter),3);
gammaV_3=zeros(length(P_Large_Winter),3);
kappaV_1=zeros(length(P_Large_Winter),3);
kappaV_2=zeros(length(P_Large_Winter),3);
psi_V=zeros(length(P_Large_Winter),1);
beta_max=zeros(length(P_Large_Winter),1);
beta_min=zeros(length(P_Large_Winter),1);
phi_t=zeros(length(P_Large_Winter),1);
scale_t=zeros(length(P_Large_Winter),1);
S_Inf=zeros(length(P_Large_Winter),8);
Influenza_vac_rate=zeros(length(P_Large_Winter),6);
Influenza_vac_delay=zeros(length(P_Large_Winter),6);
Influenza_vac_HC=zeros(length(P_Large_Winter),6);
SARSCoV2_vac_rate=zeros(length(P_Large_Winter),11);
prob_H=zeros(length(P_Large_Winter),9);
prob_death_H=zeros(length(P_Large_Winter),6);
R0=zeros(length(P_Large_Winter),5);
Influenza_vac_coverage=zeros(length(P_Large_Winter),6);
SARSCoV2_vac_coverage=zeros(length(P_Large_Winter),11);



Var={'Incubation_Period';
    'Infectious_Period_under_30';
    'Infectious_Period_30_to_49';
    'Infectious_Period_50_and_older';
    'Infectious_Period_under_30_Vaccinated';
    'Infectious_Period_30_to_49_Vaccinated';
    'Infectious_Period_50_and_older_Vaccinated';
    'Stage_1_Efficacy_Infection_under_18';
    'Stage_1_Efficacy_Infection_18_to_59';
    'Stage_1_Efficacy_Infection_60_and_older';
    'Stage_2_Efficacy_Infection_under_18';
    'Stage_2_Efficacy_Infection_18_to_59';
    'Stage_2_Efficacy_Infection_60_and_older';
    'Stage_3_Efficacy_Infection_under_18';
    'Stage_3_Efficacy_Infection_18_to_59';
    'Stage_3_Efficacy_Infection_60_and_older';
    'Stage_1_Vaccine_Probability_under_18';
    'Stage_1_Vaccine_Probability_18_to_59';
    'Stage_1_Vaccine_Probability_60_and_older';
    'Stage_2_Vaccine_Probability_under_18';
    'Stage_2_Vaccine_Probability_18_to_59';
    'Stage_2_Vaccine_Probability_60_and_older';
    'Stage_3_Vaccine_Probability_under_18';
    'Stage_3_Vaccine_Probability_18_to_59';
    'Stage_3_Vaccine_Probability_60_and_older';
    'Efficacy_Hospitalization';
    'Efficacy_Death_Hospital_under_65';
    'Efficacy_Death_Hospital_65_and_older';
    'Vaccine_reduction_in_transmission';
    'Maximum_transmission';
    'Minimum_transmission';
    'Phase_shift';
    'Seasonal_scalar';
    'Relative_susceptiblity_under_10';
    'Relative_susceptiblity_10_to_19';
    'Relative_susceptiblity_20_to_29';
    'Relative_susceptiblity_30_to_39';
    'Relative_susceptiblity_40_to_49';
    'Relative_susceptiblity_50_to_59';
    'Relative_susceptiblity_60_to_69';
    'Relative_susceptiblity_70_to_79';
    'Relative_susceptiblity_80_and_older';
    'Influenza_vaccination_rate_under_5';
    'Influenza_vaccination_rate_5_to_12';
    'Influenza_vaccination_rate_13_to_17';
    'Influenza_vaccination_rate_18_to_49';
    'Influenza_vaccination_rate_50_to_64';
    'Influenza_vaccination_rate_65_and_older';
    'Influenza_vaccination_delay_under_5';
    'Influenza_vaccination_delay_5_to_12';
    'Influenza_vaccination_delay_13_to_17';
    'Influenza_vaccination_delay_18_to_49';
    'Influenza_vaccination_delay_50_to_64';
    'Influenza_vaccination_delay_65_and_older';
    'Influenza_vaccination_Hill_Coefficient_under_5';
    'Influenza_vaccination_Hill_Coefficient_5_to_12';
    'Influenza_vaccination_Hill_Coefficient_13_to_17';
    'Influenza_vaccination_Hill_Coefficient_18_to_49';
    'Influenza_vaccination_Hill_Coefficient_50_to_64';
    'Influenza_vaccination_Hill_Coefficient_65_and_older';
    'SARS_CoV2_vaccination_rate_under_2';
    'SARS_CoV2_vaccination_rate_2_to_4';
    'SARS_CoV2_vaccination_rate_5_to_11';
    'SARS_CoV2_vaccination_rate_12_to_17';
    'SARS_CoV2_vaccination_rate_18_to_24';
    'SARS_CoV2_vaccination_rate_25_to_39';
    'SARS_CoV2_vaccination_rate_40_to_49';
    'SARS_CoV2_vaccination_rate_50_to_64';
    'SARS_CoV2_vaccination_rate_65_to_74';
    'SARS_CoV2_vaccination_rate_75_and_older';
    'Probability_Hospitalization_under_10';
    'Probability_Hospitalization_10_to_19';
    'Probability_Hospitalization_20_to_29';
    'Probability_Hospitalization_30_to_39';
    'Probability_Hospitalization_40_to_49';
    'Probability_Hospitalization_50_to_59';
    'Probability_Hospitalization_60_to_69';
    'Probability_Hospitalization_70_to_79';
    'Probability_Hospitalization_80_and_older';
    'Probability_Death_under_18';
    'Probability_Death_18_to_34';
    'Probability_Death_35_to_49';
    'Probability_Death_50_to_64';
    'Probability_Death_65_to_79';
    'Probability_Death_80_and_older';
    'Prior_immunity_under_12';
    'Prior_immunity_12_to_17';
    'Prior_immunity_18_to_49';
    'Prior_immunity_50_to_64';
    'Prior_immunity_65_and_older';
    'Influenza_coverage_under_5';
    'Influenza_coverage_5_to_12';
    'Influenza_coverage_13_to_17';
    'Influenza_coverage_18_to_49';
    'Influenza_coverage_50_to_64';
    'Influenza_coverage_65_and_older';
    'SARS_CoV2_coverage_under_2';
    'SARS_CoV2_coverage_2_to_4';
    'SARS_CoV2_coverage_5_to_11';
    'SARS_CoV2_coverage_12_to_15';
    'SARS_CoV2_coverage_16_to_17';
    'SARS_CoV2_coverage_18_to_24';
    'SARS_CoV2_coverage_25_to_39';
    'SARS_CoV2_coverage_40_to_49';
    'SARS_CoV2_coverage_50_to_64';
    'SARS_CoV2_coverage_65_to_74';
    'SARS_CoV2_coverage_75_and_older'};

for ss=1:length(P_Large_Winter)
    Parameters=P_Large_Winter{ss};
    sigma_E(ss)=1./unique(Parameters.sigma_E);

    day_delta_I(ss,1)=1./unique(Parameters.delta_I(AC<30));
    day_delta_I(ss,2)=1./unique(Parameters.delta_I(AC>=30 & AC<50));
    day_delta_I(ss,3)=1./unique(Parameters.delta_I(AC>=50));

    day_delta_V(ss,1)=1./unique(Parameters.delta_V(AC<30));
    day_delta_V(ss,2)=1./unique(Parameters.delta_V(AC>=30 & AC<50));
    day_delta_V(ss,3)=1./unique(Parameters.delta_V(AC>=50));

    eps_V1(ss,1)=unique(Parameters.eps_V1(AC<=17));
    eps_V1(ss,2)=unique(Parameters.eps_V1(AC>=18 & AC<=59));
    eps_V1(ss,3)=unique(Parameters.eps_V1(AC>=60));

    eps_V2(ss,1)=unique(Parameters.eps_V2(AC<=17));
    eps_V2(ss,2)=unique(Parameters.eps_V2(AC>=18 & AC<=59));
    eps_V2(ss,3)=unique(Parameters.eps_V2(AC>=60));

    eps_V3(ss,1)=unique(Parameters.eps_V3(AC<=17));
    eps_V3(ss,2)=unique(Parameters.eps_V3(AC>=18 & AC<=59));
    eps_V3(ss,3)=unique(Parameters.eps_V3(AC>=60));
    
    eps_H(ss)=unique(Parameters.eps_H);

    eps_DH(ss,1)=unique(Parameters.eps_DH(AC<65));
    eps_DH(ss,2)=unique(Parameters.eps_DH(AC>=65));

    psi_V(ss)=unique(Parameters.psi_V);

    beta_max=unique(Parameters.beta_I.beta_max);
    beta_min=unique(Parameters.beta_I.beta_min);
    phi_t=unique(Parameters.beta_I.phi_t);
    scale_t=unique(Parameters.beta_I.scale_t);
    
    S_Inf(ss,1)=unique(Parameters.beta_I.S_Inf(AC<10));
    S_Inf(ss,2)=unique(Parameters.beta_I.S_Inf(AC>=10 & AC<20));
    S_Inf(ss,3)=unique(Parameters.beta_I.S_Inf(AC>=20 & AC<30));
    S_Inf(ss,4)=unique(Parameters.beta_I.S_Inf(AC>=30 & AC<40));
    S_Inf(ss,5)=unique(Parameters.beta_I.S_Inf(AC>=40 & AC<50));
    S_Inf(ss,6)=unique(Parameters.beta_I.S_Inf(AC>=50 & AC<60));
    S_Inf(ss,7)=unique(Parameters.beta_I.S_Inf(AC>=60 & AC<70));
    S_Inf(ss,8)=unique(Parameters.beta_I.S_Inf(AC>=70));

    Influenza_vac_rate(ss,1)=unique(Parameters.nu_V_Influenza.vac_rate(AC<=4));
    Influenza_vac_rate(ss,2)=unique(Parameters.nu_V_Influenza.vac_rate(AC>=5 & AC<=12));
    Influenza_vac_rate(ss,3)=unique(Parameters.nu_V_Influenza.vac_rate(AC>=13 & AC<=17));
    Influenza_vac_rate(ss,4)=unique(Parameters.nu_V_Influenza.vac_rate(AC>=18 & AC<=49));
    Influenza_vac_rate(ss,5)=unique(Parameters.nu_V_Influenza.vac_rate(AC>=50 & AC<=64));
    Influenza_vac_rate(ss,6)=unique(Parameters.nu_V_Influenza.vac_rate(AC>=65));

    Influenza_vac_delay(ss,1)=unique(Parameters.nu_V_Influenza.vac_delay_start(AC<=4));
    Influenza_vac_delay(ss,2)=unique(Parameters.nu_V_Influenza.vac_delay_start(AC>=5 & AC<=12));
    Influenza_vac_delay(ss,3)=unique(Parameters.nu_V_Influenza.vac_delay_start(AC>=13 & AC<=17));
    Influenza_vac_delay(ss,4)=unique(Parameters.nu_V_Influenza.vac_delay_start(AC>=18 & AC<=49));
    Influenza_vac_delay(ss,5)=unique(Parameters.nu_V_Influenza.vac_delay_start(AC>=50 & AC<=64));
    Influenza_vac_delay(ss,6)=unique(Parameters.nu_V_Influenza.vac_delay_start(AC>=65));

    Influenza_vac_HC(ss,1)=unique(Parameters.nu_V_Influenza.n(AC<=4));
    Influenza_vac_HC(ss,2)=unique(Parameters.nu_V_Influenza.n(AC>=5 & AC<=12));
    Influenza_vac_HC(ss,3)=unique(Parameters.nu_V_Influenza.n(AC>=13 & AC<=17));
    Influenza_vac_HC(ss,4)=unique(Parameters.nu_V_Influenza.n(AC>=18 & AC<=49));
    Influenza_vac_HC(ss,5)=unique(Parameters.nu_V_Influenza.n(AC>=50 & AC<=64));
    Influenza_vac_HC(ss,6)=unique(Parameters.nu_V_Influenza.n(AC>=65));

    SARSCoV2_vac_rate(ss,1)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC<=1));
    SARSCoV2_vac_rate(ss,2)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=2 & AC<=4));
    SARSCoV2_vac_rate(ss,3)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=5 & AC<=11));
    SARSCoV2_vac_rate(ss,4)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=12 & AC<=15));
    SARSCoV2_vac_rate(ss,5)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=16 & AC<=17));
    SARSCoV2_vac_rate(ss,6)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=18 & AC<=24));
    SARSCoV2_vac_rate(ss,7)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=25 & AC<=39));
    SARSCoV2_vac_rate(ss,8)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=40 & AC<=49));
    SARSCoV2_vac_rate(ss,9)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=50 & AC<=64));
    SARSCoV2_vac_rate(ss,10)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=65 & AC<=74));
    SARSCoV2_vac_rate(ss,11)=unique(Parameters.nu_V_SARSCoV2.vac_rate(AC>=75));

    prob_H(ss,1)=unique(Parameters.prob_H(AC<10));
    prob_H(ss,2)=unique(Parameters.prob_H(AC>=10 & AC<=19));
    prob_H(ss,3)=unique(Parameters.prob_H(AC>=20 & AC<=29));
    prob_H(ss,4)=unique(Parameters.prob_H(AC>=30 & AC<=39));
    prob_H(ss,5)=unique(Parameters.prob_H(AC>=40 & AC<=49));
    prob_H(ss,6)=unique(Parameters.prob_H(AC>=50 & AC<=59));
    prob_H(ss,7)=unique(Parameters.prob_H(AC>=60 & AC<=69));
    prob_H(ss,8)=unique(Parameters.prob_H(AC>=70 & AC<=79));
    prob_H(ss,9)=unique(Parameters.prob_H(AC>=80));

    prob_death_H(ss,1)=unique(Parameters.prob_death_H(AC<18));
    prob_death_H(ss,2)=unique(Parameters.prob_death_H(AC>=18 & AC<=34));
    prob_death_H(ss,3)=unique(Parameters.prob_death_H(AC>=35 & AC<=49));
    prob_death_H(ss,4)=unique(Parameters.prob_death_H(AC>=50 & AC<=64));
    prob_death_H(ss,5)=unique(Parameters.prob_death_H(AC>=65 & AC<=79));
    prob_death_H(ss,6)=unique(Parameters.prob_death_H(AC>=80));
    
    R0(ss,1)=unique(Parameters.R0(AC<=11));
    R0(ss,2)=unique(Parameters.R0(AC>=12 & AC<=17));
    R0(ss,3)=unique(Parameters.R0(AC>=18 & AC<=49));
    R0(ss,4)=unique(Parameters.R0(AC>=50 & AC<=64));
    R0(ss,5)=unique(Parameters.R0(AC>=65));
    
    Influenza_vac_coverage(ss,1)=unique(Parameters.vac_int_influenza(AC<=4));
    Influenza_vac_coverage(ss,2)=unique(Parameters.vac_int_influenza(AC>=5 & AC<=12));
    Influenza_vac_coverage(ss,3)=unique(Parameters.vac_int_influenza(AC>=13 & AC<=17));
    Influenza_vac_coverage(ss,4)=unique(Parameters.vac_int_influenza(AC>=18 & AC<=49));
    Influenza_vac_coverage(ss,5)=unique(Parameters.vac_int_influenza(AC>=50 & AC<=64));
    Influenza_vac_coverage(ss,6)=unique(Parameters.vac_int_influenza(AC>=65));

    SARSCoV2_vac_coverage(ss,1)=unique(Parameters.vac_baseline(AC<=1));
    SARSCoV2_vac_coverage(ss,2)=unique(Parameters.vac_baseline(AC>=2 & AC<=4));
    SARSCoV2_vac_coverage(ss,3)=unique(Parameters.vac_baseline(AC>=5 & AC<=11));
    SARSCoV2_vac_coverage(ss,4)=unique(Parameters.vac_baseline(AC>=12 & AC<=15));
    SARSCoV2_vac_coverage(ss,5)=unique(Parameters.vac_baseline(AC>=16 & AC<=17));
    SARSCoV2_vac_coverage(ss,6)=unique(Parameters.vac_baseline(AC>=18 & AC<=24));
    SARSCoV2_vac_coverage(ss,7)=unique(Parameters.vac_baseline(AC>=25 & AC<=39));
    SARSCoV2_vac_coverage(ss,8)=unique(Parameters.vac_baseline(AC>=40 & AC<=49));
    SARSCoV2_vac_coverage(ss,9)=unique(Parameters.vac_baseline(AC>=50 & AC<=64));
    SARSCoV2_vac_coverage(ss,10)=unique(Parameters.vac_baseline(AC>=65 & AC<=74));
    SARSCoV2_vac_coverage(ss,11)=unique(Parameters.vac_baseline(AC>=75));

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Compute the correlation of posterior 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
X=[sigma_E day_delta_I day_delta_V eps_V1 eps_H eps_DH psi_V beta_max beta_min phi_t scale_t S_Inf Influenza_vac_rate Influenza_vac_delay Influenza_vac_HC SARSCoV2_vac_rate prob_H prob_death_H R0 Influenza_vac_coverage SARSCoV2_vac_coverage];
[Corr_Post,P_post]=corr(X);
T_Corr=[table(Var) array2table(Corr_Post)];
T_Corr.VariableNames=[{'Variable'} Var'];
T_p_value=[table(Var) array2table(P_post)];
T_p_value.VariableNames=[{'Variable'} Var'];

save('Correlation_Tables_Larger_Winter_Peak.mat','T_p_value','T_Corr');

Posterior_Dist.Fitted_Dist=cell(length(Var),1);
Posterior_Dist.Raw_Dist=cell(length(Var),2);
Posterior_Dist.Name=Var;

for ii=1:length(Var)
    %% NEEDS TO INTEGRATE THE BOUNDS
    Posterior_Dist.Fitted_Dist{ii} = fitdist(X(:,ii),'Kernel','Kernel','epanechnikov');
    [n,nx]=histcounts(X(:,ii),35,'Normalization','pdf');
    Posterior_Dist.Raw_Dist{ii,1}=n;
    Posterior_Dist.Raw_Dist{ii,2}=nx;
end

