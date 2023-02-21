clear;
clc;
close all;

NS=10^4;

MM={'August','September','October','November','December','January','February','March','April'};
YM=[2022 2022 2022 2022 2022 2023 2023 2023 2023];

T_Run=[datenum('July 1, 2022'):datenum('July 1, 2023')];


temp_cd=pwd;
temp_cd=temp_cd(1:end-3);
Parameters=load([temp_cd 'Contact_Matrix/Contact_USA_85.mat'],'N');

A=length(Parameters.N);
AC=[0:84];
VD=zeros(NS,length(T_Run));
for jj=1:NS
    % Vaccination parameters
    Parameters.nu_V.vac_rate=ones(A,1).*(0.01+(0.05-0.01).*rand(1));
    Parameters.nu_V.t0=T_Run(1);

    Parameters.nu_V.vac_start=datenum('August 1, 2022');


    Parameters.vac_int=zeros(A,1);

    Parameters.vac_int(AC<=4)=0.636+(0.752-0.636).*rand(1);
    Parameters.vac_int(AC>=5 & AC<=12)=0.542+(0.645-0.542).*rand(1);
    Parameters.vac_int(AC>=13 & AC<=17)=0.337+(0.533-0.337).*rand(1);
    Parameters.vac_int(AC>=18 & AC<=49)=0.269+(0.384-0.269).*rand(1);
    Parameters.vac_int(AC>=50 & AC<=64)=0.397+(0.542-0.397).*rand(1);
    Parameters.vac_int(AC>=65)=0.596+(0.752-0.596).*rand(1);

    Parameters.X0=Parameters.N.*Parameters.vac_int;

    opts = odeset('RelTol',1e-6,'AbsTol',1e-6,'NonNegative',1:length(Parameters.X0));

    [T,Y] = ode15s(@(t,x)ODE_Vac(t,x,Parameters.nu_V), [min(T_Run) max(T_Run)], Parameters.X0, opts);
    test=sum(Parameters.X0).*ones(length(T),1)-sum(Y,2)./sum(Parameters.N);
    VD(jj,:)=pchip(T,test,T_Run);
end
