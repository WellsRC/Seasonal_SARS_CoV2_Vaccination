function P_new=Adjust_Vaccination(P_old,vac_start,vac_red)

P_new=P_old;

P_new.nu_V_Influenza.vac_start=vac_start.*ones(A,1);

P_new.vac_int_influenza=P_old.vac_int_influenza.*(1-vac_red);


% Adjust initial condictions
X0=zeros(14.*A,1);

    
span_A=14.*[0:(A-1)];

S_n=1+span_A;
S_i=2+span_A;


E_n=4+span_A;

I_n=7+span_A;

R_n=10+span_A;
R_i=11+span_A;

X0(R_n)=P_new.N.*P_new.R0;

X0(I_n)=(P_new.N.*P_new.R0.*P_new.omega_R./P_new.delta_I);

X0(E_n)=P_new.delta_I.*X0(I_n)./P_new.sigma_E;

X0(S_n)=P_new.N-X0(R_n)-X0(I_n)-X0(E_n);

X0(R_i)=X0(R_n).*P_new.vac_int_influenza;
X0(R_n)=X0(R_n)-X0(R_i);

X0(S_i)=X0(S_n).*P_new.vac_int_influenza;
X0(S_n)=X0(S_n)-X0(S_i);

P_new.X0.Influenza_Campaign=X0;

end