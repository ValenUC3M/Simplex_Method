/* set of locations */
set LOCATION;
set FREELANCER;
set SCOOTER;

/* parameters */
param restr {i in FREELANCER};
param costes_recarga {i in FREELANCER, j in LOCATION};
param loc_scoot {i in SCOOTER, j in LOCATION};
param demanda{i in LOCATION};
param sobrante {i in LOCATION};
param costes_mover {i in LOCATION, j in LOCATION};

/* decision variables */
var decision_mod2 {i in SCOOTER, j in FREELANCER} binary; 
var decision_mod1 {i in LOCATION, j in LOCATION} integer >= 0; 

/* objective function */
minimize z: sum{i in SCOOTER, j in LOCATION, k in FREELANCER} costes_recarga[k,j]*loc_scoot[i,j]*decision_mod2[i,k] + sum{i in LOCATION, j in LOCATION} costes_mover[i,j]*decision_mod1[i,j];

/* Constraints */
s.t. mod1_R1: sum{j in LOCATION} decision_mod1['L1',j] + sum{j in LOCATION} decision_mod1['L4',j] >= sum{i in LOCATION} demanda[i];
s.t. mod1_R21: sum{i in LOCATION} decision_mod1[i,"L2"] - sum{j in LOCATION} decision_mod1["L2",j] >= demanda["L2"];
s.t. mod1_R22: sum{i in LOCATION} decision_mod1[i,"L3"] - sum{j in LOCATION} decision_mod1["L3",j] >= demanda["L3"];
s.t. mod1_R31: sum{i in LOCATION}decision_mod1[i,"L1"] - sum{j in LOCATION} decision_mod1["L1",j] <= sobrante["L1"];
s.t. mod1_R32: sum{i in LOCATION}decision_mod1[i,"L4"] - sum{j in LOCATION} decision_mod1["L4",j] <= sobrante["L4"];
s.t. mod1_R41: sum{j in LOCATION} decision_mod1["L1",j] >= 0.9 * sobrante["L1"];
s.t. mod1_R42: sum{j in LOCATION} decision_mod1["L4",j] >= 0.9 * sobrante["L4"];
s.t. mod2_R1 {i in SCOOTER}: sum{k in FREELANCER} decision_mod2[i,k]=1;
s.t. mod2_R2 {k in FREELANCER}: sum{i in SCOOTER} decision_mod2[i,k]<=restr[k];
s.t. mod2_R31: sum{i in SCOOTER} loc_scoot[i,"L1"]*decision_mod2[i,"F1"]=0;
s.t. mod2_R32: sum{i in SCOOTER} loc_scoot[i,"L3"]*decision_mod2[i,"F2"]=0;
s.t. mod2_R4 {k in FREELANCER, q in FREELANCER: k<>q}: sum{i in SCOOTER} decision_mod2[i,k]<= sum{i in SCOOTER} 1.5*decision_mod2[i,q];

end;
