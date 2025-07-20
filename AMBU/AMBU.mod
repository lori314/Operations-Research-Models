#AMBU.mod
set N; # 表示区域
param A{i in N}; #表示区域的人口
param T{i in N,j in N}; #表示区域间的时间

var d{i in N,j in N} binary; #表示区域i能否覆盖区域j
var x{i in N} binary;  #表示是否在区域i建立救援中心

maximize TP:sum{i in N}sum{j in N}x[i]*d[i,j]*A[j];

subject to Con1:
	sum{i in N}x[i]<=3;
subject to Con2{i in N,j in N}:
	T[i,j]<=8+1000*(1-d[i,j]);
subject to Con3{i in N}:
	sum{j in N}x[i]*d[i,j]*A[j]<=100000;
subject to Con4{i in N,j in N}:
	d[i,j]<=x[i];
subject to Con5{j in N}:
	sum{i in N}d[i,j]<=1;
