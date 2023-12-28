
temp_cd=pwd;
for ii=1:500
     try 
         load([temp_cd(1:end-15) 'Sample_Gen_' num2str(ii) '.mat'], 'T_Run');
     catch ME
         ii
     end
end