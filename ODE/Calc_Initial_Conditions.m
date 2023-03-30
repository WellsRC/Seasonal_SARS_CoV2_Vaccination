function X0=Calc_Initial_Conditions(Vac_Camp,Parameters)
A=length(Parameters.N);

if(strcmp('Influenza_Campaign',Vac_Camp))
    X0=zeros(17.*A,1);

    span_A=17.*[0:(A-1)];

    S_n=1+span_A;
    S_i=2+span_A;

    E_n=5+span_A;
    I_n=8+span_A;

    R_n=11+span_A;
    R_i=12+span_A;

    vac_c=Parameters.vac_int_influenza;
elseif(strcmp('Baseline_Campaign',Vac_Camp))
    X0=zeros(19.*A,1);

    span_A=19.*[0:(A-1)];

    S_n=1+span_A;
    S_i=2+span_A;

    E_n=5+span_A;
    I_n=9+span_A;

    R_n=13+span_A;
    R_i=14+span_A;

    vac_c=Parameters.vac_baseline;
elseif(strcmp('Two_Dose_Campaign_Influenza',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=8+span_A;
    I_n=13+span_A;

    R_n=18+span_A;
    R_i=19+span_A;
    
    vac_c=Parameters.vac_int_influenza;
elseif(strcmp('Two_Dose_Campaign_Baseline',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=8+span_A;
    I_n=13+span_A;

    R_n=18+span_A;
    R_i=19+span_A;
    
    vac_c=Parameters.vac_baseline;
elseif(strcmp('SA_Annual_Campaign',Vac_Camp))
    X0=zeros(17.*A,1);

    span_A=17.*[0:(A-1)];

    S_n=1+span_A;
    S_i=2+span_A;

    E_n=5+span_A;
    I_n=8+span_A;

    R_n=11+span_A;
    R_i=12+span_A;

    vac_c=Parameters.vac_SA;
elseif(strcmp('SA_Continual_Campaign',Vac_Camp))
    X0=zeros(19.*A,1);

    span_A=19.*[0:(A-1)];

    S_n=1+span_A;
    S_i=2+span_A;

    E_n=5+span_A;
    I_n=9+span_A;

    R_n=13+span_A;
    R_i=14+span_A;

    vac_c=Parameters.vac_SA;
elseif(strcmp('SA_Two_Dose_Campaign',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=8+span_A;
    I_n=13+span_A;

    R_n=18+span_A;
    R_i=19+span_A;
end

X0(R_n)=Parameters.N.*Parameters.R0;

X0(I_n)=(Parameters.N.*Parameters.R0.*Parameters.omega_R./Parameters.delta_I);

X0(E_n)=Parameters.delta_I.*X0(I_n)./Parameters.sigma_E;

X0(S_n)=Parameters.N-X0(R_n)-X0(I_n)-X0(E_n);


X0(R_i)=X0(R_n).*vac_c;
X0(R_n)=X0(R_n)-X0(R_i);

X0(S_i)=X0(S_n).*vac_c;
X0(S_n)=X0(S_n)-X0(S_i);

end
    