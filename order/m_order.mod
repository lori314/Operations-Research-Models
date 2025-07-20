#m_order.mod

set N;
set K;
param w{N};
param p{N,K};
param M:=9999;

var d{N,K} binary;
var s{N,N} binary;
var c{N}>=0;

minimize T:sum{i in N}w[i]*c[i];

subject to Con2{i in N,j in N:i<>j}:
	s[i,j]+s[j,i]=1;
subject to Con3{i in N,j in N,k in K}:
	c[i]-c[j]>=p[j,k]-M*(3-s[i,j]-d[i,k]-d[j,k]);
subject to Con4{i in N,k in K}:
	c[i]>=p[i,k]-M*(1-d[i,k]);
subject to Con5{i in N}:
	sum{k in K}d[i,k]=1;

	
