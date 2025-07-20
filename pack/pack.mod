#pack.mod

set M; #定义石头的集合
param v{M}; #定义石头的体积
param w{M}; #weight
param p{M}; #石头的价值
param V:=100; #最大容量
param W:=150;  #最大重量
set P in {M,M};


#定义变量
var x{M} binary; #0/1变量
var s13 binary; #表示13是否同时拿走
var s78 binary; #表示78是否同时拿走

#定义目标函数
maximize TotalValue:sum{i in M}p[i]*x[i]+s13*(p[1]+p[3])*0.5+s78*(p[7]+p[8])*0.8;

#约束条件
subject to Con1:
	sum{i in M}v[i]*x[i]<=V;
	
subject to Con2:
	sum{i in M}w[i]*x[i]<=W;

subject to Con3{(i,j) in P}:
	x[i]+x[j]<=1;
	
subject to Con4:
	x[1] + x[3] >= s13*2; 

subject to Con5:
	x[7]+ x[8] >= s78*2;

	