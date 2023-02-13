function [T_Run,P] = Parameter_Sample(NS)

P=cell(NS,1);
lhs_samp=lhsdesign(NS,26);
T_Run=[datenum('July 1, 2022'):datenum('July 1, 2023')];

parfor jj=1:NS
    temp_cd=pwd;
    temp_cd=temp_cd(1:end-3);
    Parameters=load([temp_cd 'Contact_Matrix\Contact_USA_85.mat'],'N','C');

    A=length(Parameters.N);
    AC=[0:84];
    % Latent period
    Parameters.sigma_E=ones(A,1)./(1.48+(2.76-1.48).*rand(1));
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
    Parameters.beta_I=ones(A,1).*(0.02+(0.04-0.02).*lhs_samp(jj,12));

    % Vaccination parameters
    Parameters.nu_V.vac_rate=ones(A,1).*(0.01+(0.05-0.01).*lhs_samp(jj,13));
    Parameters.nu_V.t0=ones(A,1).*T_Run(1);

    dT=datenum('September 1, 2022')-T_Run(1);
    lambda_V=-log(0.05)./dT;

    Parameters.nu_V.lambda_v=ones(A,1).*lambda_V;

    % Vaccine waning rate
    day_gamma_V=30.*(3+(18-3).*lhs_samp(jj,14)).*ones(A,1);
    Parameters.gamma_V=1./day_gamma_V;


    % Natural immunity waning rate
    day_omega_R=30.*(6+(24-6).*lhs_samp(jj,15)).*ones(A,1);
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

    Parameters.R0(AC<=11)=0.735+(0.768-0.735).*lhs_samp(jj,16);
    Parameters.R0(AC>=12 & AC<=17)=0.728+(0.755-0.728).*lhs_samp(jj,17);
    Parameters.R0(AC>=18 & AC<=49)=0.625+(0.648-0.625).*lhs_samp(jj,18);
    Parameters.R0(AC>=50 & AC<=64)=0.485+(0.513-0.485).*lhs_samp(jj,19);
    Parameters.R0(AC>=65)=0.322+(0.343-0.322).*lhs_samp(jj,20);

    Parameters.vac_int=zeros(A,1);

    Parameters.vac_int(AC<=4)=0.636+(0.752-0.636).*lhs_samp(jj,21);
    Parameters.vac_int(AC>=5 & AC<=12)=0.542+(0.645-0.542).*lhs_samp(jj,22);
    Parameters.vac_int(AC>=13 & AC<=17)=0.337+(0.533-0.337).*lhs_samp(jj,23);
    Parameters.vac_int(AC>=18 & AC<=49)=0.269+(0.384-0.269).*lhs_samp(jj,24);
    Parameters.vac_int(AC>=50 & AC<=64)=0.397+(0.542-0.397).*lhs_samp(jj,25);
    Parameters.vac_int(AC>=65)=0.596+(0.752-0.596).*lhs_samp(jj,26);

    X0(R_n)=Parameters.N.*Parameters.R0.*(1-Parameters.vac_int);
    X0(R_v)=Parameters.N.*Parameters.R0.*Parameters.vac_int;

    X0(I)=(Parameters.N.*Parameters.R0.*Parameters.omega_R./Parameters.delta_I)./10;

    X0(E)=(Parameters.delta_I.*X0(I)./Parameters.sigma_E)./10;

    S_Tot=Parameters.N-Parameters.N.*Parameters.R0-X0(I)-X0(E);

    X0(S_n)=S_Tot.*(1-Parameters.vac_int);
    X0(S_v)=S_Tot.*Parameters.vac_int;

    Parameters.X0=X0;
    
    P{jj}=Parameters;
end
end

