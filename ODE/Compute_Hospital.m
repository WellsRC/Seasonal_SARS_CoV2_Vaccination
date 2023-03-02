function [Hospital_Admission,Hospital_Prevalence,Hospital_Count]=Compute_Hospital(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run)
Daily_Incidence_Unvaccinated_Hospital=zeros(size(Daily_Incidence_Unvaccinated));
Daily_Incidence_Vaccinated_Hospital=zeros(size(Daily_Incidence_Vaccinated));

A=length(Parameters.N);

Hospital_Admission=zeros(A,length(T_Run)-1);
Hospital_Prevalence=zeros(A,length(T_Run)-1);

for a=1:A    
   Daily_Incidence_Unvaccinated_Hospital(a,:)=Parameters.prob_H(a).*Daily_Incidence_Unvaccinated(a,:);
   Daily_Incidence_Vaccinated_Hospital(a,:)=(1-Parameters.eps_H(a)).*Parameters.prob_H(a).*Daily_Incidence_Vaccinated(a,:);
end

temp_H=Daily_Incidence_Unvaccinated_Hospital+Daily_Incidence_Vaccinated_Hospital;

for t=1:(size(Hospital_Admission,2)-1)
    ta=[1:size(Hospital_Admission,2)-t];
    
    pdf_H=gamcdf(ta,3.667,3.029)-gamcdf(ta-1,3.667,3.029);
    for aa=1:A
        Hospital_Admission(aa,t+ta)=Hospital_Admission(aa,t+ta)+temp_H(aa,t).*pdf_H;
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
Hospital_Count=sum(temp_H,1);
Hospital_Admission=sum(Hospital_Admission,1);
Hospital_Prevalence=sum(Hospital_Prevalence,1);
end