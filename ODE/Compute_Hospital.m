function [Hospital_Admission,Hospital_Prevalence]=Compute_Hospital(Daily_Hospital_Age,T_Run)

A=size(Daily_Hospital_Age,1);

Hospital_Admission=zeros(A,length(T_Run)-1);
Hospital_Prevalence=zeros(A,length(T_Run)-1);

for t=1:(size(Hospital_Admission,2)-1)
    ta=[1:size(Hospital_Admission,2)-t];
    
    pdf_H=gamcdf(ta,3.667,3.029)-gamcdf(ta-1,3.667,3.029);
    for aa=1:A
        Hospital_Admission(aa,t+ta)=Hospital_Admission(aa,t+ta)+Daily_Hospital_Age(aa,t).*pdf_H;
    end
end

for t=1:(size(Hospital_Prevalence,2))
    ta=[0:size(Hospital_Prevalence,2)-t];
    
    for aa=1:A
        if(aa<=18)
            pdf_DOS=gamcdf(ta+1,0.6792,3.5/0.6792)-gamcdf(ta,0.6792,3.5/0.6792);
        elseif(aa<=51)
            pdf_DOS=gamcdf(ta+1,0.5128,4.3/0.5128)-gamcdf(ta,0.5128,4.3/0.5128);            
        else
            pdf_DOS=gamcdf(ta+1,0.8483,6.2/0.8483)-gamcdf(ta,0.8483,6.2/0.8483); 
        end
        Hospital_Prevalence(aa,t+ta)=Hospital_Prevalence(aa,t+ta)+Hospital_Admission(aa,t).*pdf_DOS;
    end
end
Hospital_Admission=sum(Hospital_Admission,1);
Hospital_Prevalence=sum(Hospital_Prevalence,1);
end