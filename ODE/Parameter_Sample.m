function [T_Run,P] = Parameter_Sample(NS)

P=cell(NS,1);
lhs_samp=lhsdesign(NS,40);
T_Run=[datenum('July 1, 2022'):datenum('July 1, 2023')];

parfor jj=1:NS
    temp_cd=pwd;
    temp_cd=temp_cd(1:end-3);
    Parameters=load([temp_cd 'Contact_Matrix/Contact_USA_85.mat'],'N','C');

    A=length(Parameters.N);
    AC=[0:84];
    % Latent period
    Parameters.sigma_E=ones(A,1)./(1.48+(2.76-1.48).*lhs_samp(jj,32));
    % Infectious period (no vaccine)
    day_delta_I=zeros(A,1);
    day_delta_I(AC<30)=9.0+(10.6-9.0).*lhs_samp(jj,1);
    day_delta_I(AC>=30 & AC<50)=8.7+(11.6-8.7).*lhs_samp(jj,2);
    day_delta_I(AC>=50)=9.6+(17.5-9.6).*lhs_samp(jj,3);
    Parameters.delta_I=1./day_delta_I;

    % Infectious period (vaccine)
    day_delta_V=zeros(A,1);
    day_delta_V(AC<30)=10.5+(12.4-10.5).*lhs_samp(jj,4);
    day_delta_V(AC>=30 & AC<50)=11.7+(13.4-11.7).*lhs_samp(jj,5);
    day_delta_V(AC>=50)=12.2+(15.0-12.2).*lhs_samp(jj,6);
    Parameters.delta_V=1./day_delta_V;

    % Vaccine effectiveness
    eps_V=zeros(A,1);
    eps_V(AC<=17)=0.45+(0.59-0.45).*lhs_samp(jj,7);
    eps_V(AC>=18 & AC<=49)=0.49+(0.52-0.49).*lhs_samp(jj,8);
    eps_V(AC>=50 & AC<=64)=0.40+(0.43-0.40).*lhs_samp(jj,9);
    eps_V(AC>=65)=0.37+(0.43-0.37).*lhs_samp(jj,10);
    Parameters.eps_V=eps_V;

    % Vaccine effectiveness Hospitalization
    eps_H=ones(A,1).*0.2961;
    Parameters.eps_H=eps_H;

    % Reduction transmission
    Parameters.psi_V=ones(A,1).*(0.2713+(0.3125-0.2713).*lhs_samp(jj,11));

    % Transmission
    Parameters.beta_I.beta_max=(0.025+(0.075-0.025).*lhs_samp(jj,12));
    Parameters.beta_I.beta_min=(0.01+(0.025-0.01).*lhs_samp(jj,13));
    Parameters.beta_I.phi_t=0.2+(0.8-0.2).*lhs_samp(jj,14);
    Parameters.beta_I.scale_t=365;
    
    S_Inf=zeros(A,1);
    S_Inf(AC<10)=0.25+(0.57-0.25).*lhs_samp(jj,33);
    S_Inf(AC>=10 & AC<20)=0.27+(0.53-0.27).*lhs_samp(jj,34);
    S_Inf(AC>=20 & AC<30)=0.59+(0.96-0.59).*lhs_samp(jj,35);
    S_Inf(AC>=30 & AC<40)=0.69+(0.98-0.69).*lhs_samp(jj,36);
    S_Inf(AC>=40 & AC<50)=0.61+(0.96-0.61).*lhs_samp(jj,37);
    S_Inf(AC>=50 & AC<60)=0.63+(0.97-0.63).*lhs_samp(jj,38);
    S_Inf(AC>=60 & AC<70)=0.7+(0.99-0.7).*lhs_samp(jj,39);
    S_Inf(AC>=70)=0.56+(0.90-0.56).*lhs_samp(jj,40);
    
    Parameters.beta_I.S_Inf=S_Inf;
    
    % Vaccination parameters
    Parameters.nu_V.vac_rate=ones(A,1).*(0.01+(0.05-0.01).*lhs_samp(jj,15));
    Parameters.nu_V.t0=T_Run(1);

    Parameters.nu_V.vac_start=datenum('September 1, 2022');

    % Vaccine waning rate
    day_gamma_V=30.*(3+(18-3).*lhs_samp(jj,16)).*ones(A,1);
    Parameters.gamma_V=1./day_gamma_V;


    % Natural immunity waning rate
    day_omega_R=30.*(6+(24-6).*lhs_samp(jj,17)).*ones(A,1);
    Parameters.omega_R=1./day_omega_R;

    % Probability of hospital admission

    prob_H=zeros(A,1);

    prob_H(AC<10)=0.011;
    prob_H(AC>=10 & AC<=19)=0.0038;
    prob_H(AC>=20 & AC<=29)=0.006;
    prob_H(AC>=30 & AC<=39)=0.0066;
    prob_H(AC>=40 & AC<=49)=0.0059;
    prob_H(AC>=50 & AC<=59)=0.0077;
    prob_H(AC>=60 & AC<=69)=0.0139;
    prob_H(AC>=70 & AC<=79)=0.0357;
    prob_H(AC>=80)=0.111;

    Parameters.prob_H=prob_H;
    
    % Duration of stay in Hospital

    DOS_Hosp=zeros(A,1);

    DOS_Hosp(AC<=17)=3+round(lhs_samp(jj,18));
    DOS_Hosp(AC>=18 & AC<=50)=4+ceil(lhs_samp(jj,19)-0.7);
    DOS_Hosp(AC>50)=6+ceil(lhs_samp(jj,20)-0.8);
    Parameters.DOS_Hosp=DOS_Hosp;

    % Initial conditions

    X0=zeros(11.*A,1);

    span_A=11.*[0:(A-1)];
    S_n=1+span_A;
    S_v=2+span_A;

    E=4+span_A;
    I=6+span_A;

    R_n=8+span_A;
    R_v=9+span_A;


    Parameters.R0=zeros(A,1);

    Parameters.R0(AC<=11)=0.735+(0.768-0.735).*lhs_samp(jj,21);
    Parameters.R0(AC>=12 & AC<=17)=0.728+(0.755-0.728).*lhs_samp(jj,22);
    Parameters.R0(AC>=18 & AC<=49)=0.625+(0.648-0.625).*lhs_samp(jj,23);
    Parameters.R0(AC>=50 & AC<=64)=0.485+(0.513-0.485).*lhs_samp(jj,24);
    Parameters.R0(AC>=65)=0.322+(0.343-0.322).*lhs_samp(jj,25);


    X0(R_n)=Parameters.N.*Parameters.R0;

    X0(I)=(Parameters.N.*Parameters.R0.*Parameters.omega_R./Parameters.delta_I).*0.1;

    X0(E)=Parameters.delta_I.*X0(I)./Parameters.sigma_E;

    X0(S_n)=Parameters.N-X0(R_n)-X0(I)-X0(E);
       
    Parameters.vac_int=zeros(A,1);

    Parameters.vac_int(AC<=4)=0.636+(0.752-0.636).*lhs_samp(jj,26);
    Parameters.vac_int(AC>=5 & AC<=12)=0.542+(0.645-0.542).*lhs_samp(jj,27);
    Parameters.vac_int(AC>=13 & AC<=17)=0.337+(0.533-0.337).*lhs_samp(jj,28);
    Parameters.vac_int(AC>=18 & AC<=49)=0.269+(0.384-0.269).*lhs_samp(jj,29);
    Parameters.vac_int(AC>=50 & AC<=64)=0.397+(0.542-0.397).*lhs_samp(jj,30);
    Parameters.vac_int(AC>=65)=0.596+(0.752-0.596).*lhs_samp(jj,31);

    X0(R_v)=X0(R_n).*Parameters.vac_int;
    X0(R_n)=X0(R_n)-X0(R_v);
    
    X0(S_v)=X0(S_n).*Parameters.vac_int;
    X0(S_n)=X0(S_n)-X0(S_v);
    
    Parameters.X0=X0;
    
    
    
    P{jj}=Parameters;
end
end

