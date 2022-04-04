/* set of locations */
set LOCATION;

/* parameters */
param demanda{i in LOCATION};
param sobrante {i in LOCATION};
param costes {i in LOCATION, j in LOCATION};


/* decision variables */
var decision {i in LOCATION, j in LOCATION} integer,>= 0; 

/* objective function */
minimize z: sum{i in LOCATION, j in LOCATION} costes[i,j]*decision[i,j];

/* Constraints */
s.t. R1: sum{j in LOCATION} decision['L1',j] + sum{j in LOCATION} decision['L4',j] >= sum{i in LOCATION} demanda[i];
s.t. R21: sum{i in LOCATION} decision[i,"L2"] - sum{j in LOCATION} decision["L2",j] >= demanda["L2"];
s.t. R22: sum{i in LOCATION} decision[i,"L3"] - sum{j in LOCATION} decision["L3",j] >= demanda["L3"];
s.t. R31: sum{i in LOCATION}decision[i,'L1'] - sum{j in LOCATION} decision['L1',j] <= sobrante['L1'];
s.t. R32: sum{i in LOCATION}decision[i,'L4'] - sum{j in LOCATION} decision['L4',j] <= sobrante['L4'];
s.t. R41: sum{j in LOCATION} decision["L1",j] >= 0.9 * sobrante["L1"];
s.t. R42: sum{j in LOCATION} decision["L4",j] >= 0.9 * sobrante["L4"];

end;
