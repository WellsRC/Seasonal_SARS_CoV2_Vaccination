function [Pks,Mag_Peaks,Time_Peaks]=Hospital_Admission_Peak(Hospital_Admission,T_Run)

Mag_Peaks=zeros(1,2);
Time_Peaks=zeros(1,2);
Pks=0;

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
    if(Summer_Peak*Winter_Peak>0)
        if(min(Mag_Peaks)>=1000)
            Pks=1;
        end
    end
end
end