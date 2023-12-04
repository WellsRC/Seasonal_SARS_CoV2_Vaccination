function [SD_Natural_Immunity,Infection_Natural_Immunity,SD_Vaccine_Immunity,Infection_Vaccine_Immunity,Fully_Susceptible]=Compute_Daily_Immunity(T,SD_Natural,Infection_Natural,SD_Vaccine,Infection_Vaccine,F_Susceptible,T_Run)


A=size(F_Susceptible,2);
SD_Natural_Immunity=zeros(A,T_Run(end)-T_Run(1));
Infection_Natural_Immunity=zeros(A,T_Run(end)-T_Run(1));
SD_Vaccine_Immunity=zeros(A,T_Run(end)-T_Run(1));
Infection_Vaccine_Immunity=zeros(A,T_Run(end)-T_Run(1));
Fully_Susceptible=zeros(A,T_Run(end)-T_Run(1));

for aa=1:A
    SD_Natural_Immunity(aa,:)=pchip(T,SD_Natural(:,aa),T_Run(2:end));
    Infection_Natural_Immunity(aa,:)=pchip(T,Infection_Natural(:,aa),T_Run(2:end));
    SD_Vaccine_Immunity(aa,:)=pchip(T,SD_Vaccine(:,aa),T_Run(2:end));
    Infection_Vaccine_Immunity(aa,:)=pchip(T,Infection_Vaccine(:,aa),T_Run(2:end));
    Fully_Susceptible(aa,:)=pchip(T,F_Susceptible(:,aa),T_Run(2:end));
end

end