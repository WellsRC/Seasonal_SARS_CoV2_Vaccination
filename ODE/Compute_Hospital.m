function [Hospital_Admission,Hospital_Prevalence]=Compute_Hospital(Daily_Incidence_Unvaccinated,Daily_Incidence_Vaccinated,Parameters,T_Run)

Daily_Incidence_Unvaccinated_Hospital=zeros(size(Daily_Incidence_Unvaccinated));
Daily_Incidence_Vaccinated_Hospital=zeros(size(Daily_Incidence_Vaccinated));
A=length(Parameters.N);

Hospital_Prevalence=zeros(1,length(T_Run)-1);
Hospital_Admission=zeros(1,length(T_Run)-1);

for a=1:A    
   Daily_Incidence_Unvaccinated_Hospital(a,:)=Parameters.prob_H(a).*Daily_Incidence_Unvaccinated(a,:);
   Daily_Incidence_Vaccinated_Hospital(a,:)=(1-Parameters.eps_H(a)).*Parameters.prob_H(a).*Daily_Incidence_Vaccinated(a,:);
end

temp_H=Daily_Incidence_Unvaccinated_Hospital+Daily_Incidence_Vaccinated_Hospital;

for t=1:(length(Hospital_Admission)-1)
    ta=[1:length(Hospital_Admission)-t];
    
    pdf_H=gamcdf(ta,3.667,3.029)-gamcdf(ta-1,3.667,3.029);
    Hospital_Admission(t+ta)=Hospital_Admission(t+ta)+sum(temp_H(:,t),1).*pdf_H;
    for a=1:A
        for dos=1:Parameters.DOS_Hosp(a)
            if(max(t+ta+(dos-1))>length(Hospital_Prevalence))
                indx_start=min(t+ta+(dos-1));
                Hospital_Prevalence(indx_start:end)=Hospital_Prevalence(indx_start:end)+temp_H(a,t).*pdf_H(t+ta+(dos-1)<=length(Hospital_Prevalence));
            else
                Hospital_Prevalence(t+ta+(dos-1))=Hospital_Prevalence(t+ta+(dos-1))+temp_H(a,t).*pdf_H;
            end
        end
    end
end
end