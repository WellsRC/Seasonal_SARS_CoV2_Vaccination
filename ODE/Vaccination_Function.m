function vac_r=Vaccination_Function(t,nu_v)
    vac_r=nu_v.vac_rate.*(t-nu_v.t0).^50./((t-nu_v.t0).^50+(nu_v.vac_start-nu_v.t0).^50);
end