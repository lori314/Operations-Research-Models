set N;
param p{N};
param w{N};
param M:=9999;

var s{i in N,j in N} binary;
var c{N};

minimize TTP:sum{i in N}c[i]*w[i];

subject to Con1{i in N,j in N:i<>j}:
	s[i,j]+s[j,i]=1;

subject to Con2{i in N,j in N:i<>j}:
	c[j]-c[i]>=p[j]-M*(1-s[i,j]);
	
subject to Con3{i in N}:
	c[i]>=p[i];
	
subject to Con4{i in N}:
	c[i]>=0;
	
subject to Con5{i in N}:
	s[i,i]=0;