function P_new=Two_Dose_Vaccination(P_old,vac_scenario)

P_new=P_old;

A=length(P_old.N);

% Adjust initial condictions
 X0=zeros(20.*A,1);    
span_A=20.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;


E_n=6+span_A;

I_n=10+span_A;

R_n=14+span_A;
R_0i=15+span_A;

X0(R_n)=P_new.N.*P_new.R0;

X0(I_n)=(P_new.N.*P_new.R0.*P_new.omega_R./P_new.delta_I);

X0(E_n)=P_new.delta_I.*X0(I_n)./P_new.sigma_E;

X0(S_n)=P_new.N-X0(R_n)-X0(I_n)-X0(E_n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% Influenza seasonal coverage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
if(vac_scenario)
    P_new.vac_int_influenza=P_old.vac_int_annual;
end

X0(R_0i)=X0(R_n).*P_new.vac_int_influenza;
X0(R_n)=X0(R_n)-X0(R_0i);

X0(S_i)=X0(S_n).*P_new.vac_int_influenza;
X0(S_n)=X0(S_n)-X0(S_i);

P_new.X0.Influenza_Campaign=X0;

end