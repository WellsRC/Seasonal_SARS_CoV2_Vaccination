clear;
clc;

T=readtable('United_States_country_level_age_distribution_85.txt');

N=T.Var2;
Age_Class=cell(length(N),1);
for ii=1:length(N)-1
    Age_Class{ii}=['[' num2str(T.Var1(ii)) ', ' num2str(T.Var1(ii+1)) ')'];
end
ii=length(N);
Age_Class{ii}=['[' num2str(T.Var1(ii)) ', Inf)'];

C=table2array(readtable('United_States_country_level_M_overall_contact_matrix_85.txt'));

save('Contact_USA_85.mat','N','C','Age_Class');

