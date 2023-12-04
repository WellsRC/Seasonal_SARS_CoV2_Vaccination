function [T_Run,P] = Parameter_Sample(NS)

temp_cd=pwd;
temp_cd=temp_cd(1:end-3);

P=cell(NS,1);
lhs_samp=lhsdesign(NS,86);
T_Run=[datenum('September 1, 2022'):datenum('September 1, 2023')];
load([temp_cd 'Immunity/Sample_Under_18_Vaccine_Immunity.mat'],'par_samp_vi_U18');
load([temp_cd 'Immunity/Sample_18_to_59_Vaccine_Immunity.mat'],'par_samp_vi_18_59');
load([temp_cd 'Immunity/Sample_60_plus_Vaccine_Immunity.mat'],'par_samp_vi_60p');
load([temp_cd 'Immunity/Sample_Natural_Immunity.mat'],'par_samp_ni','stratify_recovered');
rs_vi_U18=randi([1 size(par_samp_vi_U18,1)],NS,1);
rs_vi_18_59=randi([1 size(par_samp_vi_18_59,1)],NS,1);
rs_vi_60p=randi([1 size(par_samp_vi_60p,1)],NS,1);
rs_ni=randi([1 size(par_samp_ni,1)],NS,1);

parfor jj=1:NS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Load population and contact matrix
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Parameters=load([temp_cd 'Contact_Matrix/Contact_USA_85.mat'],'N','C');

    A=length(Parameters.N);
    AC=[0:84];
    count=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Latent period
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Parameters.sigma_E=ones(A,1)./(1.48+(2.76-1.48).*lhs_samp(jj,count));
    count=count+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Infectious period (no vaccine)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    day_delta_I=zeros(A,1);
    day_delta_I(AC<30)=9.0+(10.6-9.0).*lhs_samp(jj,count);
    count=count+1;
    day_delta_I(AC>=30 & AC<=50)=8.7+(11.6-8.7).*lhs_samp(jj,count);
    count=count+1;
    day_delta_I(AC>50)=9.6+(17.5-9.6).*lhs_samp(jj,count);
    count=count+1;
    Parameters.delta_I=1./day_delta_I;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Infectious period (vaccine)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    day_delta_V=zeros(A,1);
    day_delta_V(AC<30)=10.5+(12.4-10.5).*lhs_samp(jj,count);
    count=count+1;
    day_delta_V(AC>=30 & AC<=50)=11.7+(13.4-11.7).*lhs_samp(jj,count);
    count=count+1;
    day_delta_V(AC>50)=12.2+(15.0-12.2).*lhs_samp(jj,count);
    count=count+1;
    Parameters.delta_V=1./day_delta_V;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Vaccine waning immunity compartmental
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    eps_V1=zeros(A,1);    
    eps_V2=zeros(A,1);  
    eps_V3=zeros(A,1); 
    q1_sd=zeros(A,1); 
    q2_sd=zeros(A,1); 
    q3_sd=zeros(A,1); 
    gammaV_1=zeros(A,1); 
    gammaV_2=zeros(A,1); 
    gammaV_3=zeros(A,1);
    kappaV_1=zeros(A,1); 
    kappaV_2=zeros(A,1); 

    eps_V1(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),1);    
    eps_V2(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),2);  
    eps_V3(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),3); 
    gammaV_1(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),4); 
    gammaV_2(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),5); 
    gammaV_3(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),6);
    kappaV_1(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),7);
    kappaV_2(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),8);
    q1_sd(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),9); 
    q2_sd(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),10); 
    q3_sd(AC<18)=par_samp_vi_U18(rs_vi_U18(jj),11); 

    eps_V1(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),1);    
    eps_V2(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),2);  
    eps_V3(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),3); 
    gammaV_1(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),4); 
    gammaV_2(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),5); 
    gammaV_3(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),6);
    kappaV_1(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),7);
    kappaV_2(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),8);
    q1_sd(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),9); 
    q2_sd(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),10); 
    q3_sd(AC>=18 & AC<60)=par_samp_vi_18_59(rs_vi_18_59(jj),11); 

    eps_V1(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),1);    
    eps_V2(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),2);  
    eps_V3(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),3); 
    gammaV_1(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),4); 
    gammaV_2(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),5); 
    gammaV_3(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),6);
    kappaV_1(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),7);
    kappaV_2(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),8);
    q1_sd(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),9); 
    q2_sd(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),10); 
    q3_sd(AC>=60)=par_samp_vi_60p(rs_vi_60p(jj),11); 

    Parameters.eps_V1=eps_V1;
    Parameters.eps_V2=eps_V2;
    Parameters.eps_V3=eps_V3;
    Parameters.q1_sd=q1_sd;
    Parameters.q2_sd=q2_sd;
    Parameters.q3_sd=q3_sd;
    Parameters.gammaV_1=gammaV_1;
    Parameters.gammaV_2=gammaV_2;
    Parameters.gammaV_3=gammaV_3;
    Parameters.kappaV_1=kappaV_1;
    Parameters.kappaV_2=kappaV_2;
    
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % natural waning immunity compartmental
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    p1_inf=zeros(A,1); 
    p2_inf=zeros(A,1);     
    p3_inf=zeros(A,1); 
    p1_sd=zeros(A,1);     
    p2_sd=zeros(A,1);     
    omega_R1=zeros(A,1); 
    omega_R2=zeros(A,1); 
    omega_R3=zeros(A,1);
    omega_R4=zeros(A,1); 
    omega_R5=zeros(A,1); 
    alpha_R1=zeros(A,1); 
    alpha_R2=zeros(A,1); 
    alpha_R4=zeros(A,1);
    
    omega_R1(:)=par_samp_ni(rs_ni(jj),1);
    omega_R2(:)=par_samp_ni(rs_ni(jj),2);
    omega_R3(:)=par_samp_ni(rs_ni(jj),3);
    alpha_R1(:)=par_samp_ni(rs_ni(jj),4);
    alpha_R2(:)=par_samp_ni(rs_ni(jj),5);
    p1_inf(:)=par_samp_ni(rs_ni(jj),6);
    p2_inf(:)=par_samp_ni(rs_ni(jj),7);
    p3_inf(:)=par_samp_ni(rs_ni(jj),8);

    omega_R4(:)=par_samp_ni(rs_ni(jj),9);
    omega_R5(:)=par_samp_ni(rs_ni(jj),10);
    alpha_R4(:)=par_samp_ni(rs_ni(jj),11);
    p1_sd(:)=par_samp_ni(rs_ni(jj),12);
    p2_sd(:)=par_samp_ni(rs_ni(jj),13);
    
    Parameters.p1_inf=p1_inf;
    Parameters.p2_inf=p2_inf;
    Parameters.p3_inf=p3_inf;
    Parameters.p1_sd=p1_sd;
    Parameters.p2_sd=p2_sd;
    Parameters.q3_sd=q3_sd;
    Parameters.omega_R1=omega_R1;
    Parameters.omega_R2=omega_R2;
    Parameters.omega_R3=omega_R3;
    Parameters.omega_R4=omega_R4;
    Parameters.omega_R5=omega_R5;
    Parameters.alpha_R1=alpha_R1;
    Parameters.alpha_R2=alpha_R2;
    Parameters.alpha_R4=alpha_R4;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reduction transmission    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Parameters.psi_V=ones(A,1).*(0.2713+(0.3125-0.2713).*lhs_samp(jj,count));
    count=count+1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Transmission
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Parameters.beta_I.beta_max=(0.03+(0.05-0.03).*lhs_samp(jj,count));
    count=count+1;
    Parameters.beta_I.beta_min=(0.015+(0.025-0.015).*lhs_samp(jj,count));
    count=count+1;
    Parameters.beta_I.phi_t=0.25+(0.75+0.25).*lhs_samp(jj,count);
    count=count+1;
    Parameters.beta_I.scale_t=365.*(0.4+(1-0.4).*lhs_samp(jj,count));
    count=count+1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Susceptilibty
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    S_Inf=zeros(A,1);
    S_Inf(AC<10)=0.25+(0.57-0.25).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=10 & AC<20)=0.27+(0.53-0.27).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=20 & AC<30)=0.59+(0.96-0.59).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=30 & AC<40)=0.69+(0.98-0.69).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=40 & AC<50)=0.61+(0.96-0.61).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=50 & AC<60)=0.63+(0.97-0.63).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=60 & AC<70)=0.7+(0.99-0.7).*lhs_samp(jj,count);
    count=count+1;
    S_Inf(AC>=70)=0.56+(0.90-0.56).*lhs_samp(jj,count);
    count=count+1;
    
    Parameters.beta_I.S_Inf=S_Inf;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Influenza seaosonal coverage
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Vaccination rate
    vac_rate=zeros(A,1);
    
    vac_rate(AC<=4)=0.0171+(0.0445-0.0171).*lhs_samp(jj,count);
    count=count+1;
    vac_rate(AC>=5 & AC<=12)=0.0191+(0.0252-0.0191).*lhs_samp(jj,count);
    count=count+1;
    vac_rate(AC>=13 & AC<=17)=0.0199+(0.0303-0.0199).*lhs_samp(jj,count);
    count=count+1;
    vac_rate(AC>=18 & AC<=49)=0.0166+(0.0231-0.0166).*lhs_samp(jj,count);
    count=count+1;
    vac_rate(AC>=50 & AC<=64)=0.0181+(0.0263-0.0181).*lhs_samp(jj,count);
    count=count+1;
    vac_rate(AC>=65)=0.0178+(0.0304-0.0178).*lhs_samp(jj,count);
    count=count+1;
    Parameters.nu_V_Influenza.vac_rate=vac_rate;
    Parameters.nu_V_Influenza.t0=T_Run(1).*ones(A,1);
    
    
    % Delay in vaccination for saturation
    vac_delay_start=zeros(A,1);
    
    vac_delay_start(AC<=4)=7.4987+(83.8131-7.4987).*lhs_samp(jj,count);
    count=count+1;
    vac_delay_start(AC>=5 & AC<=12)=11.4628+(20.1999-11.4628).*lhs_samp(jj,count);
    count=count+1;
    vac_delay_start(AC>=13 & AC<=17)=13.4019+(30.3156-13.4019).*lhs_samp(jj,count);
    count=count+1;
    vac_delay_start(AC>=18 & AC<=49)=15.8267+(23.0024-15.8267).*lhs_samp(jj,count);
    count=count+1;
    vac_delay_start(AC>=50 & AC<=64)=15.4328+(24.2047-15.4328).*lhs_samp(jj,count);
    count=count+1;
    vac_delay_start(AC>=65)=11.2138+(23.4614-11.2138).*lhs_samp(jj,count);
    count=count+1;
    Parameters.nu_V_Influenza.vac_delay_start=vac_delay_start;
        
    % Hill coefficient for function
    vac_n=zeros(A,1);
    
    vac_n(AC<=4)=0.6421+(29.4843-0.6421).*lhs_samp(jj,count);
    count=count+1;
    vac_n(AC>=5 & AC<=12)=1.4778+(72.7098-1.4778).*lhs_samp(jj,count);
    count=count+1;
    vac_n(AC>=13 & AC<=17)=0.8398+(69.3464-0.8398).*lhs_samp(jj,count);
    count=count+1;
    vac_n(AC>=18 & AC<=49)=1.7758+(95.4960-1.7758).*lhs_samp(jj,count);
    count=count+1;
    vac_n(AC>=50 & AC<=64)=3.6271+(96.9207-3.6271).*lhs_samp(jj,count);
    count=count+1;
    vac_n(AC>=65)=2.4438+(30.6773-2.4438).*lhs_samp(jj,count);
    count=count+1;
    Parameters.nu_V_Influenza.n=vac_n;
    
    Parameters.nu_V_Influenza.vac_start=datenum('September 1, 2022').*ones(A,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SARS CoV-2 Boosters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Vaccination rate
    vac_rate=zeros(A,1);
    
    vac_rate(AC<=1)=0.0507.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=12 & AC<=15)=0.0057.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=16 & AC<=17)=0.0052.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=18 & AC<=24)=0.0043.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=2 & AC<=4)=0.0236.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=25 & AC<=39)=0.0096.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=40 & AC<=49)=0.0093.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=5 & AC<=11)=0.0138.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=50 & AC<=64)=0.0089.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=65 & AC<=74)=0.0114.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    vac_rate(AC>=75)=0.0130.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.nu_V_SARSCoV2.vac_rate=vac_rate;
    
    
    % Assume for the seasonal campaign under low coverage the functional
    % form is similar to keep things as consistent as possible
    Parameters.nu_V_SARSCoV2.n=Parameters.nu_V_Influenza.n;
    Parameters.nu_V_SARSCoV2.vac_start=Parameters.nu_V_Influenza.vac_start;
    Parameters.nu_V_SARSCoV2.vac_delay_start=Parameters.nu_V_Influenza.vac_delay_start;
    Parameters.nu_V_SARSCoV2.t0=Parameters.nu_V_Influenza.t0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Probability of hospital admission
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    prob_H=zeros(A,1);
    
    NI=43147;
    NH=475;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC<10)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=119261;
    NH=456;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=10 & AC<=19)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=265199;
    NH=1593;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=20 & AC<=29)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=228915;
    NH=1500;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=30 & AC<=39)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=167045;
    NH=987;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=40 & AC<=49)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=134186;
    NH=1031;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=50 & AC<=59)=md+(Md-md).*lhs_samp(jj,count); count=count+1;

    NI=64875;
    NH=900;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=60 & AC<=69)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=31066;
    NH=1108;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=70 & AC<=79)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    NI=14165;
    NH=1574;
    md=binoinv(0.025,NI,NH/NI)/NI;
    Md=binoinv(0.975,NI,NH/NI)/NI;
    prob_H(AC>=80)=md+(Md-md).*lhs_samp(jj,count); count=count+1;

    Parameters.prob_H=prob_H;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Probability of death given hospitalization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    prob_death_H=zeros(A,1);
    Hp=690;
    Hd=6;
    md=binoinv(0.025,Hp,Hd/Hp)/Hp;
    Md=binoinv(0.975,Hp,Hd/Hp)/Hp;
    prob_death_H(AC<18)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
        
    Hp=875;
    Hd=8;
    md=binoinv(0.025,Hp,Hd/Hp)/Hp;
    Md=binoinv(0.975,Hp,Hd/Hp)/Hp;  
    prob_death_H(AC>=18 & AC<=34)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    Hp=1415;
    Hd=29;
    md=binoinv(0.025,Hp,Hd/Hp)/Hp;
    Md=binoinv(0.975,Hp,Hd/Hp)/Hp;
    prob_death_H(AC>=35 & AC<=49)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    Hp=3691;
    Hd=139;
    md=binoinv(0.025,Hp,Hd/Hp)/Hp;
    Md=binoinv(0.975,Hp,Hd/Hp)/Hp;
    prob_death_H(AC>=50 & AC<=64)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    Hp=7063;
    Hd=371;
    md=binoinv(0.025,Hp,Hd/Hp)/Hp;
    Md=binoinv(0.975,Hp,Hd/Hp)/Hp;
    prob_death_H(AC>=65 & AC<=79)=md+(Md-md).*lhs_samp(jj,count); count=count+1;
    
    Hp=6921;
    Hd=451;
    md=binoinv(0.025,Hp,Hd/Hp)/Hp;
    Md=binoinv(0.975,Hp,Hd/Hp)/Hp;
    prob_death_H(AC>=80)=md+(Md-md).*lhs_samp(jj,count); 
    count=count+1;

    Parameters.prob_death_H=prob_death_H;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Prior immunity
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

    Parameters.R0=zeros(A,1);

    Parameters.R0(AC<=11)=0.735+(0.768-0.735).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.R0(AC>=12 & AC<=17)=0.728+(0.755-0.728).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.R0(AC>=18 & AC<=49)=0.625+(0.648-0.625).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.R0(AC>=50 & AC<=64)=0.485+(0.513-0.485).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.R0(AC>=65)=0.322+(0.343-0.322).*lhs_samp(jj,count); 
    count=count+1;
    
       
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    % Influenza seasonal coverage
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    Parameters.vac_int_influenza=zeros(A,1);

    Parameters.vac_int_influenza(AC<=4)=0.636+(0.752-0.636).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.vac_int_influenza(AC>=5 & AC<=12)=0.542+(0.645-0.542).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.vac_int_influenza(AC>=13 & AC<=17)=0.337+(0.533-0.337).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.vac_int_influenza(AC>=18 & AC<=49)=0.269+(0.384-0.269).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.vac_int_influenza(AC>=50 & AC<=64)=0.397+(0.542-0.397).*lhs_samp(jj,count); 
    count=count+1;
    Parameters.vac_int_influenza(AC>=65)=0.596+(0.752-0.596).*lhs_samp(jj,count); 
    count=count+1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    % SARS CoV-2 coverage
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    
    Parameters.vac_baseline=zeros(A,1);
    
    Parameters.vac_baseline(AC<=1)=0.0023.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=2 & AC<=4)=0.0043.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=5 & AC<=11)=0.0523.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=12 & AC<=15)=0.1253.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=16 & AC<=17)=0.1362.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=18 & AC<=24)=0.1453.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=25 & AC<=39)=0.1325.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=40 & AC<=49)=0.1827.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=50 & AC<=64)=0.2843.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=65 & AC<=74)=0.4943.*(1+0.05.*(0.5-lhs_samp(jj,count)));
    count=count+1;
    Parameters.vac_baseline(AC>=75)=0.5127.*(1+0.05.*(0.5-lhs_samp(jj,count)));    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    % Initial Conditions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Parameters.X0.Baseline_Campaign=Calc_Initial_Conditions('Continual',Parameters,Parameters.vac_baseline,stratify_recovered(rs_ni(jj),:));
        
    P{jj}=Parameters;
end
end

