function [Pk,Mag_Peak,Time_Peak]=Hospital_Admission_Unimodal_Winter_Peak(Hospital_Admission,T_Run)

Mag_Peak=0;
Pk=0;
Winter_Peak=0;
Time_Peak=0;

if(Hospital_Admission(end-1)>Hospital_Admission(end))    
    [m_pks,dt_pks]=findpeaks(Hospital_Admission,T_Run(1:end-1)); 
    if((length(dt_pks)>=1))
        np=length(dt_pks);
        for pp=1:np
           if(dt_pks(pp)>=datenum('October 1, 2022') && dt_pks(pp)<datenum('May 1, 2023'))
               Winter_Peak=1;
               if(m_pks(pp)>Mag_Peak)
                    Mag_Peak=m_pks(pp);
                    Time_Peak=dt_pks(pp);
               end
           end
        end
    end
    
    % https://covid.cdc.gov/covid-data-tracker/#new-hospital-admissions
    lb=2972;
    ub=21521;
    %xo=lsqnonlin(@(x)(norminv([0.025 0.975],x(1),x(2))-log10([lb ub])),[3.89 0.21]);
    par_peak=[3.90295562633983	0.219344245436142];
    if(Mag_Peak<lb)
        prob_ov=(normcdf(log10(Mag_Peak),par_peak(1),par_peak(2)))./(normcdf(log10(lb),par_peak(1),par_peak(2)));
    elseif(Mag_Peak>ub)
        prob_ov=(1-normcdf(log10(Mag_Peak),par_peak(1),par_peak(2)))./(1-normcdf(log10(ub),par_peak(1),par_peak(2)));
    else
        prob_ov=1;
    end

    if(Winter_Peak==1)
        if(rand(1)<=prob_ov)
            LP=sum(m_pks>Mag_Peak);
            if((LP==0))
                rel_p=max(m_pks(m_pks<Mag_Peak)./Mag_Peak);
                if(rel_p<=0.05)
                   Pk=1; 
                end
            end
        end
    end
end

end