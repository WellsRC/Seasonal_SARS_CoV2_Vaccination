function vac_r=Vaccination_Function(t,nu_v)
    vac_r=nu_v.vac_rate.*(1-exp(-nu_v.lambda_v.*(t-nu_v.t0)));
end