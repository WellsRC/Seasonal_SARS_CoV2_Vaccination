function [Hospital_Admission]=Compute_Hospital(Daily_Hospital_Age,T_Run)

A=size(Daily_Hospital_Age,1);

Hospital_Admission=zeros(A,length(T_Run)-1);

for t=1:(size(Hospital_Admission,2)-1)
    ta=[1:size(Hospital_Admission,2)-t];
    
    pdf_H=gamcdf(ta,3.667,3.029)-gamcdf(ta-1,3.667,3.029);
    for aa=1:A
        Hospital_Admission(aa,t+ta)=Hospital_Admission(aa,t+ta)+Daily_Hospital_Age(aa,t).*pdf_H;
    end
end
Hospital_Admission=sum(Hospital_Admission,1);
end