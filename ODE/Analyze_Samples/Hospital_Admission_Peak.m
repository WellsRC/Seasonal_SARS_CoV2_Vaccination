function [Pks,Mag_Peaks]=Hospital_Admission_Peak(Hospital_Admission,T_Run)

Mag_Peaks=zeros(1,2);
Pks=0;

[m_pks,dt_pks]=findpeaks(Hospital_Admission,T_Run(1:end-1)); 
if((length(dt_pks)>=2))
    Winter_Peak=0;
    Summer_Peak=0;
    np=length(dt_pks);
    for pp=1:np
       if(dt_pks(pp)>=datenum('December 1, 2022') && dt_pks(pp)<=datenum('January 15, 2023'))
           Winter_Peak=1;
           Mag_Peaks(1)=max(m_pks(pp),Mag_Peaks(1));
       end
       if(dt_pks(pp)>=datenum('July 1, 2023') && dt_pks(pp)<=datenum('August 15, 2023'))
           Summer_Peak=1;
           Mag_Peaks(2)=max(m_pks(pp),Mag_Peaks(2));
       end
    end
    if(Summer_Peak*Winter_Peak>0)
        if(min(Mag_Peaks)>=1000)
            Pks=1;
        end
    end
end
end