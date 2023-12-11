function [Pk,Mag_Peak]=Hospital_Admission_Unimodal_Winter_Peak(Hospital_Admission,T_Run)

Mag_Peak=0;
Pk=0;
Winter_Peak=0;


wp_1=1./(datenum('December 1, 2022')-datenum('October 1, 2022'));
wp_2=1./(datenum('March 1, 2023')-datenum('May 1, 2023'));

if(Hospital_Admission(end-1)>Hospital_Admission(end))    
    [m_pks,dt_pks]=findpeaks(Hospital_Admission,T_Run(1:end-1)); 
    if((length(dt_pks)>=1))
        np=length(dt_pks);
        for pp=1:np
           if(dt_pks(pp)>=datenum('December 1, 2022') && dt_pks(pp)<datenum('March 1, 2023'))
               Winter_Peak=1;
               Mag_Peak=max(m_pks(pp),Mag_Peak);
           elseif(dt_pks(pp)<datenum('December 1, 2022')) && (rand(1)<=wp_1*(dt_pks(pp)-datenum('September 1, 2022')))
                Winter_Peak=1;
               Mag_Peak=max(m_pks(pp),Mag_Peak);
           elseif(dt_pks(pp)<datenum('May 1, 2023')) && (rand(1)<=1+wp_2*(dt_pks(pp)-datenum('March 1, 2023')))
               Winter_Peak=1;
               Mag_Peak=max(m_pks(pp),Mag_Peak);
           end
        end
    end

    if(Winter_Peak==1)
        LP=sum(m_pks>Mag_Peak);
        if(LP==0)
            rel_p=max(m_pks(m_pks<Mag_Peak)./Mag_Peak);
            if(rel_p<=0.05)
               Pk=1; 
            end
        end
    end
end

end