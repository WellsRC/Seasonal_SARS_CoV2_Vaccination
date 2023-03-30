parpool(32);

AC=[0:84];
[T_Run,~] = Parameter_Sample(1);
load([pwd '/Analyze_Samples/Parameter_Filtered.mat'],'P_All','R_WP');
NS=length(P_All);
vac_coverage_baseline=[0.05 0.25 0.50 0.75;
                       0.10 0.20 0.40 0.60;
                       0.15 0.25 0.35 0.45;
                       0.15 0.20 0.30 0.35;
                       0.30 0.35 0.40 0.45;
                       0.50 0.55 0.60 0.75];
                       
    
Age_B=[0 4; 5 12;13 17; 18 49; 50 64; 65 85];
for aa=1:6
    for ss=1:4
        Model_Output_Age=cell(NS,1);

        parfor jj=1:NS
            Pt=Annual_Vaccination_Age(P_All{jj},vac_coverage_baseline(aa,ss),Age_B(aa,1),Age_B(aa,2));
            [~,~,Model_Output_Age{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
        end
        save(['Baseline_Coverages_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_baseline(aa,ss)) '.mat'],'T_Run','Model_Output_Age','R_WP');
    end
end


vac_coverage_influenza=[0.5 0.6 0.8 0.9; 
                        0.4 0.5 0.7 0.8;
                        0.25 0.35 0.55 0.65;
                        0.15 0.25 0.45 0.55;
                        0.25 0.35 0.55 0.65;
                        0.45 0.55 0.75 0.85;];
for aa=1:6
    for ss=1:4
        Model_Output_Age=cell(NS,1);

        parfor jj=1:NS
            Pt=Annual_Vaccination_Age_Influenza(P_All{jj},vac_coverage_influenza(aa,ss),Age_B(aa,1),Age_B(aa,2));
            [~,~,Model_Output_Age{jj}] = Run_Annual_Booster_ODE(T_Run,Pt);
        end
        save(['Seasonal_Influenza_Coverages_Ages_' num2str(Age_B(aa,1)) '_to_' num2str(Age_B(aa,2)) '=' num2str(100.*vac_coverage_influenza(aa,ss)) '.mat'],'T_Run','Model_Output_Age','R_WP');
    end
end