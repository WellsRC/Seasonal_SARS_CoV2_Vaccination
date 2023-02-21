function dxdt = ODE_Vac(t,x,nu_v)

vac_r=Vaccination_Function(t,nu_v);
dxdt=-vac_r.*x;
end

