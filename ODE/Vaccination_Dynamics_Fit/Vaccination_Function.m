function vac_r=Vaccination_Function(t,nu_V)
    vac_r=nu_V.vac_rate.*(t-nu_V.t0).^nu_V.n./((t-nu_V.t0).^nu_V.n+(nu_V.vac_delay_start+nu_V.vac_start-nu_V.t0).^nu_V.n);
end