function [Pks,Time_Peaks,Winter_Peak_Ind]=Hospital_Admission_Peak(Hospital_Admission,T_Run)

Mag_Peaks=zeros(1,2);
Time_Peaks=zeros(1,2);
Pks=0;
Winter_Peak_Ind=0;

[m_pks,dt_pks]=findpeaks(Hospital_Admission,T_Run(1:end-1)); 
if((length(dt_pks)>=2))
    Winter_Peak=0;
    Summer_Peak=0;
    np=length(dt_pks);
    for pp=1:np
       if(dt_pks(pp)>=datenum('September 1, 2022') && dt_pks(pp)<datenum('April 1, 2023'))
           Winter_Peak=1;
           if(m_pks(pp)>Mag_Peaks(1))
                Mag_Peaks(1)=m_pks(pp);
                Time_Peaks(1)=dt_pks(pp);
           end
       end
       
       if(dt_pks(pp)>=datenum('May 1, 2023') && dt_pks(pp)<=datenum('August 31, 2023'))
           Summer_Peak=1;
           if(m_pks(pp)>Mag_Peaks(2))
                Mag_Peaks(2)=m_pks(pp);
                Time_Peaks(2)=dt_pks(pp);
           end
       end
    end
    % https://covid.cdc.gov/covid-data-tracker/#new-hospital-admissions
    lb=2972;
    ub=21521;
    %xo=lsqnonlin(@(x)(norminv([0.025 0.975],x(1),x(2))-log10([lb ub])),[3.89 0.21]);
    par_peak=[3.90295562633983	0.219344245436142];
    if(min(Mag_Peaks)<lb)
        prob_lb=(normcdf(log10(min(Mag_Peaks)),par_peak(1),par_peak(2)))./(normcdf(log10(lb),par_peak(1),par_peak(2)));
    else
        prob_lb=1;
    end
    if(max(Mag_Peaks)>ub)
        prob_ub=(1-normcdf(log10(max(Mag_Peaks)),par_peak(1),par_peak(2)))./(1-normcdf(log10(ub),par_peak(1),par_peak(2)));
    else
        prob_ub=1;
    end

    if(Summer_Peak*Winter_Peak>0)
        if((rand(1)<=prob_lb) && (rand(1)<=prob_ub))
            Pks=1;
        end
    end
    if(Mag_Peaks(1)>Mag_Peaks(2))
        Winter_Peak_Ind=1;
    end
end
end