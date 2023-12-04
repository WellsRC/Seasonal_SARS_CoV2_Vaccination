function [X0,X0_Summary]=Calc_Initial_Conditions(Vac_Camp,Parameters,vac_c,stratify_recovered)
A=length(Parameters.N);
Av=[0:A-1];
if(strcmp('Continual',Vac_Camp))
    X0=zeros(28.*A,1);

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
elseif(strcmp('Annual_Campaign',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=9+span_A;
    I_n=14+span_A;

    R1_n=19+span_A;
    R1_i=20+span_A;
elseif(strcmp('Two_Dose_Campaign',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=9+span_A;
    I_n=14+span_A;

    R1_n=19+span_A;
    R1_i=20+span_A;
elseif(strcmp('Delay_Annual_Campaign',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=9+span_A;
    I_n=14+span_A;

    R1_n=19+span_A;
    R1_i=20+span_A;
elseif(strcmp('Delay_Two_Dose_Campaign',Vac_Camp))
    X0=zeros(26.*A,1);

    span_A=26.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;

    E_n=9+span_A;
    I_n=14+span_A;

    R1_n=19+span_A;
    R1_i=20+span_A;
end
    

X0(R1_n)=Parameters.N.*Parameters.R0.*stratify_recovered(1);
X0(R2_n)=Parameters.N.*Parameters.R0.*stratify_recovered(2);
X0(R3_n)=Parameters.N.*Parameters.R0.*stratify_recovered(3);
X0(R4_n)=Parameters.N.*Parameters.R0.*stratify_recovered(4);
X0(R5_n)=Parameters.N.*Parameters.R0.*stratify_recovered(5);

NI_Inf=X0(R1_n)+X0(R2_n)+X0(R3_n);
pd=Parameters.prob_H.*Parameters.prob_death_H;
X0(I_n)=X0(R1_n).*(Parameters.omega_R1+Parameters.alpha_R1.*X0(R2_n)./NI_Inf)./(Parameters.p1_inf.*(1-pd).*Parameters.delta_I);

X0(E_n)=Parameters.delta_I.*X0(I_n)./Parameters.sigma_E;

X0(S_n)=Parameters.N-X0(R1_n)-X0(R2_n)-X0(R3_n)-X0(R4_n)-X0(R5_n)-X0(I_n)-X0(E_n);


if(strcmp('Delay',Vac_Camp(1:5)))
    X0(R1_i)=X0(R1_n).*vac_c.*(1-Parameters.Prop_Delay);
    X0(dR1_i)=X0(R1_n).*vac_c.*Parameters.Prop_Delay;
    X0(R1_n)=X0(R1_n)-X0(R1_i)-X0(dR1_i);
    
    X0(S_i)=X0(S_n).*vac_c.*(1-Parameters.Prop_Delay);
    X0(dS_i)=X0(S_n).*vac_c.*Parameters.Prop_Delay;
    X0(S_n)=X0(S_n)-X0(S_i)-X0(dS_i);

    S_temp=X0(S_n)+X0(S_i)+X0(dS_i);
    E_temp=X0(E_n);
    I_temp=X0(I_n);
    R1_temp=X0(R1_n)+X0(R1_i)+X0(dR1_i);

    Non_Vac=X0(S_n)+X0(E_n)+X0(I_n)+X0(R1_n);
    Vac=X0(S_i)+X0(dS_i)+X0(R1_i)+X0(dR1_i);
else
    X0(R1_i)=X0(R1_n).*vac_c;
    X0(R2_i)=X0(R2_n).*vac_c;
    X0(R3_i)=X0(R3_n).*vac_c;
    X0(R4_i)=X0(R4_n).*vac_c;
    X0(R5_i)=X0(R5_n).*vac_c;

    X0(R1_n)=X0(R1_n)-X0(R1_i);
    X0(R2_n)=X0(R2_n)-X0(R2_i);
    X0(R3_n)=X0(R3_n)-X0(R3_i);
    X0(R4_n)=X0(R4_n)-X0(R4_i);
    X0(R5_n)=X0(R5_n)-X0(R5_i);
    
    X0(S_i)=X0(S_n).*vac_c;
    X0(S_n)=X0(S_n)-X0(S_i);
    
    S_temp=X0(S_n)+X0(S_i);
    E_temp=X0(E_n);
    I_temp=X0(I_n);
    R1_temp=X0(R1_n)+X0(R2_n)+X0(R3_n)+X0(R4_n)+X0(R5_n)+X0(R1_i)+X0(R2_i)+X0(R3_i)+X0(R4_i)+X0(R5_i);

    Non_Vac=X0(S_n)+X0(E_n)+X0(I_n)+X0(R1_n)+X0(R2_n)+X0(R3_n)+X0(R4_n)+X0(R5_n);
    Vac=X0(S_i)+X0(R1_i)+X0(R2_i)+X0(R3_i)+X0(R4_i)+X0(R5_i);
end

X0_Summary.Non_Vaccinating.Age_0_to_2=sum(Non_Vac(Av<=2))./sum(Vac(Av<=2));
X0_Summary.Non_Vaccinating.Age_3_to_11=sum(Non_Vac(Av<=11 & Av>=3))./sum(Vac(Av<=11 & Av>=3));
X0_Summary.Non_Vaccinating.Age_12_to_17=sum(Non_Vac(Av<=17 & Av>=12))./sum(Vac(Av<=17 & Av>=12));
X0_Summary.Non_Vaccinating.Age_18_to_49=sum(Non_Vac(Av<=49 & Av>=18))./sum(Vac(Av<=49 & Av>=18));
X0_Summary.Non_Vaccinating.Age_50_to_64=sum(Non_Vac(Av<=64 & Av>=50))./sum(Vac(Av<=64 & Av>=50));
X0_Summary.Non_Vaccinating.Age_65_plus=sum(Non_Vac(Av>=65))./sum(Vac(Av>=65));

X0_Summary.Susceptible.Age_0_to_2=sum(S_temp(Av<=2));
X0_Summary.Susceptible.Age_3_to_11=sum(S_temp(Av<=11 & Av>=3));
X0_Summary.Susceptible.Age_12_to_17=sum(S_temp(Av<=17 & Av>=12));
X0_Summary.Susceptible.Age_18_to_49=sum(S_temp(Av<=49 & Av>=18));
X0_Summary.Susceptible.Age_50_to_64=sum(S_temp(Av<=64 & Av>=50));
X0_Summary.Susceptible.Age_65_plus=sum(S_temp(Av>=65));

X0_Summary.Latent.Age_0_to_2=sum(E_temp(Av<=2));
X0_Summary.Latent.Age_3_to_11=sum(E_temp(Av<=11 & Av>=3));
X0_Summary.Latent.Age_12_to_17=sum(E_temp(Av<=17 & Av>=12));
X0_Summary.Latent.Age_18_to_49=sum(E_temp(Av<=49 & Av>=18));
X0_Summary.Latent.Age_50_to_64=sum(E_temp(Av<=64 & Av>=50));
X0_Summary.Latent.Age_65_plus=sum(E_temp(Av>=65));

X0_Summary.Infectious.Age_0_to_2=sum(I_temp(Av<=2));
X0_Summary.Infectious.Age_3_to_11=sum(I_temp(Av<=11 & Av>=3));
X0_Summary.Infectious.Age_12_to_17=sum(I_temp(Av<=17 & Av>=12));
X0_Summary.Infectious.Age_18_to_49=sum(I_temp(Av<=49 & Av>=18));
X0_Summary.Infectious.Age_50_to_64=sum(I_temp(Av<=64 & Av>=50));
X0_Summary.Infectious.Age_65_plus=sum(I_temp(Av>=65));

X0_Summary.Recovered.Age_0_to_2=sum(R1_temp(Av<=2));
X0_Summary.Recovered.Age_3_to_11=sum(R1_temp(Av<=11 & Av>=3));
X0_Summary.Recovered.Age_12_to_17=sum(R1_temp(Av<=17 & Av>=12));
X0_Summary.Recovered.Age_18_to_49=sum(R1_temp(Av<=49 & Av>=18));
X0_Summary.Recovered.Age_50_to_64=sum(R1_temp(Av<=64 & Av>=50));
X0_Summary.Recovered.Age_65_plus=sum(R1_temp(Av>=65));

end
    