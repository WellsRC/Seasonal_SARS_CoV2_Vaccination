function vac_r=Vaccination_Function(t,nu_v)
    vac_r=nu_v.vac_rate.*(t-nu_v.t0).^nu_v.n./((t-nu_v.t0).^nu_v.n+(nu_v.vac_delay_start+nu_v.vac_start-nu_v.t0).^nu_v.n);
end