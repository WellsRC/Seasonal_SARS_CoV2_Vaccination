# Evaluation of strategies for transitioning to annual SARS-CoV-2 vaccination campaigns in the United States
Chad R. Wells <sup>1</sup>, Abhishek Pandey <sup>1</sup>, Seyed M. Moghadas <sup>2</sup>, Meagan C. Fitzpatrick <sup>3</sup>, Burton H. Singer <sup>4</sup>, Alison P. Galvani <sup>1</sup>


1 Center for Infectious Disease Modeling and Analysis (CIDMA), Yale School of Public Health, New Haven, Connecticut 06520, USA <br /> 
2 Agent-Based Modelling Laboratory, York University, Toronto, Ontario, Canada <br /> 
3 Center for Vaccine Development and Global Health, University of Maryland School of Medicine, Baltimore, Maryland, 21201, <br /> 
4 Emerging Pathogens Institute, University of Florida, P.O. Box 100009, Gainesville, FL 32610, USA <br /> 

*Corresponding author: alison.galvani@yale.edu

Copyright (C) <2024>, Chad R. Wells et. al. All rights reserved. Released under the GNU General Public License (GPL)

This repository contains codes and data used to simulate and analyze annual SARS-CoV-2 vaccination campaigns.

## Contact matrix
The age-stratified contact matrix downloaded from [Mistry et al 2021](https://github.com/mobs-lab/mixing-patterns).
## Immunity
Optimization for the temporal natural and vaccine immunity. The m-files starting with AIC_Name_Immunity (e.g., AIC_Vaccine_Immunity) optimize the different immunity models and compute the AIC score.
## ODE
Contains the scripts and functions to run the different vaccination campaigns
### Vaccination_Dynamics_Fit
The estimation of the vaccine uptake and vaccination rates used in the model
### Figures
Contains the scripts to produce the figures, tables, and model results for the manuscript
### Ananlayze_Samples
Contains the scripts to conduct the trajectory filtering as well as analyze and sumamrize the model output.
