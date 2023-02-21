function beta_t = Transmission_Rate(t,beta_I)

beta_t=beta_I.S_Inf.*(beta_I.beta_min+(beta_I.beta_max-beta_I.beta_min).*(1+cos(2.*pi.*t./beta_I.scale_t+2.*pi.*beta_I.phi_t))./2);

end