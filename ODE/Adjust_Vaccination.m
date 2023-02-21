function Parameters_Adj = Adjust_Vaccination(Parameters,Reduction_Vac)

Parameters_Adj=Parameters;
Parameters_Adj.vac_int=(1-Reduction_Vac).*Parameters_Adj.vac_int;

% Adjust the initial conditions

X0=zeros(11.*A,1);

span_A=11.*[0:(A-1)];
S_n=1+span_A;
S_v=2+span_A;

E=4+span_A;
I=6+span_A;

R_n=8+span_A;
R_v=9+span_A;


X0(R_n)=Parameters_Adj.N.*Parameters_Adj.R0.*(1-Parameters_Adj.vac_int);
X0(R_v)=Parameters_Adj.N.*Parameters_Adj.R0.*Parameters_Adj.vac_int;

X0(I)=Parameters.X0(I);

X0(E)=Parameters.X0(E);

S_Tot=Parameters_Adj.N-Parameters_Adj.N.*Parameters_Adj.R0-X0(I)-X0(E);

X0(S_n)=S_Tot.*(1-Parameters_Adj.vac_int);
X0(S_v)=S_Tot.*Parameters_Adj.vac_int;

Parameters_Adj.X0=X0;

end

