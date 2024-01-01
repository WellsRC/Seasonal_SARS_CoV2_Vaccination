function [X0]=Adjust_Initial_Conditions(Vac_Camp,Parameters,X0,vac_c,Proportion_Delay)
A=length(Parameters.N);
Av=[0:A-1];
if(strcmp('Continual',Vac_Camp))
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
    span_A=30.*[0:(A-1)];
    % Susceptyible
    S_n=1+span_A;
    S_i=2+span_A;
    dS_i=3+span_A;

    E_n=7+span_A;
    I_n=10+span_A;

    %Recovered
    R1_n=13+span_A;
    R2_n=14+span_A;
    R3_n=15+span_A;
    R4_n=16+span_A;
    R5_n=17+span_A;
    R1_i=18+span_A;
    R2_i=19+span_A;
    R3_i=20+span_A;
    R4_i=21+span_A;
    R5_i=22+span_A;
    dR1_i=23+span_A;
    dR2_i=24+span_A;
    dR3_i=25+span_A;
    dR4_i=26+span_A;
    dR5_i=27+span_A;
elseif(strcmp('Two_Dose_Campaign',Vac_Camp))
    span_A=38.*[0:(A-1)];
        
    S_n=1+span_A;
    S_i=2+span_A;
    dS_i=3+span_A;

    E_n=15+span_A;
    I_n=18+span_A;

    R1_n=21+span_A;
    R2_n=22+span_A;
    R3_n=23+span_A;
    R4_n=24+span_A;
    R5_n=25+span_A;
    R1_i=26+span_A;
    R2_i=27+span_A;
    R3_i=28+span_A;
    R4_i=29+span_A;
    R5_i=30+span_A;
    dR1_i=31+span_A;
    dR2_i=32+span_A;
    dR3_i=33+span_A;
    dR4_i=34+span_A;
    dR5_i=35+span_A;

end

if(~isempty(vac_c))
    % Re-initialize non-vaccinating class to be full population
    X0(S_n)=X0(S_n)+X0(S_i);
    X0(R1_n)=X0(R1_n)+X0(R1_i);
    X0(R2_n)=X0(R2_n)+X0(R2_i);
    X0(R3_n)=X0(R3_n)+X0(R3_i);
    X0(R4_n)=X0(R4_n)+X0(R4_i);
    X0(R5_n)=X0(R5_n)+X0(R5_i);

    % Redistribute classes
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
end
if(~isempty(Proportion_Delay))
    X0(dR1_i)=X0(R1_i).*Proportion_Delay;
    X0(dR2_i)=X0(R2_i).*Proportion_Delay;
    X0(dR3_i)=X0(R3_i).*Proportion_Delay;
    X0(dR4_i)=X0(R4_i).*Proportion_Delay;
    X0(dR5_i)=X0(R5_i).*Proportion_Delay;
    X0(dS_i)=X0(S_i).*Proportion_Delay;

    X0(R1_i)=X0(R1_i)-X0(dR1_i);
    X0(R2_i)=X0(R2_i)-X0(dR2_i);
    X0(R3_i)=X0(R3_i)-X0(dR3_i);
    X0(R4_i)=X0(R4_i)-X0(dR4_i);
    X0(R5_i)=X0(R5_i)-X0(dR5_i);
    X0(S_i)=X0(S_i)-X0(dS_i);
end

end
    