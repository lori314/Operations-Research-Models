#pack3.mod
set N; #表示石头
set M; #表示背包
param v{N};
param w{N};
param u{N};
param p{N};
param V{M};
param W{M};

var x{N,M} binary;
var y{N,N} binary;

maximize TV:sum{i in N,j in M}p[i]*x[i,j]+sum{i in N,k in N}p[i]*y[i,k];

subject to Con1{j in M}:
	sum{i in N}w[i]*x[i,j]+sum{i in N,k in N}w[k]*x[i,j]*y[k,i]<=W[j];
	
subject to Con2{j in M}:
	sum{i in N}v[i]*x[i,j]<=V[j];

subject to Con3{i in N}:
	sum{j in M}x[i,j]+sum{k in N}y[i,k]<=1;

subject to Con4{k in N}:
	sum{i in N}y[i,k]*v[i]<=u[k]*(sum{j in M}x[k,j]);

subject to Con5{i in N,j in M,k in N}:
	y[k,i]<=x[i,j];
	
	
