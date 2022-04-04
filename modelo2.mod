/* set of locations */
set LOCATION;
set FREELANCER;
set SCOOTER;


/* parameters */
param restr {i in FREELANCER};
param costs {i in FREELANCER, j in LOCATION};
param loc_scoot {i in SCOOTER, j in LOCATION};

/* decision variables */
var decision {i in SCOOTER, j in FREELANCER} binary; 

/* objective function */
minimize z: sum{i in SCOOTER, j in LOCATION, k in FREELANCER} costs[k,j]*loc_scoot[i,j]*decision[i,k];

/* Constraints */
s.t. R1 {i in SCOOTER}: sum{k in FREELANCER} decision[i,k]=1;
s.t. R2 {k in FREELANCER}: sum{i in SCOOTER} decision[i,k]<=restr[k];
s.t. R31: sum{i in SCOOTER} loc_scoot[i,"L1"]*decision[i,"F1"]=0;
s.t. R32: sum{i in SCOOTER} loc_scoot[i,"L3"]*decision[i,"F2"]=0;
s.t. R4 {k in FREELANCER, q in FREELANCER: k<>q}: sum{i in SCOOTER} decision[i,k]<= sum{i in SCOOTER} 1.5*decision[i,q];


end;
