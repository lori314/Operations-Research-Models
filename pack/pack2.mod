#pack2.mod

set M; #定义石头的集合
param v{M}; #定义石头的体积
param w{M}; #weight
param p{M}; #石头的价值
#param u{M}; #石头的内部体积
set B; #定义背包的集合
param V{B}; #最大容量
param W{B};  #最大重量
set P in {M,M};

#定义变量
var x{M,B} binary; #0/1变量

#定义目标函数
maximize TotalValue:sum{i in M,j in B}p[i]*x[i,j];

#约束条件
subject to Con1{j in B}:
	sum{i in M}v[i]*x[i,j]<=V[j];
	
subject to Con2{j in B}:
	sum{i in M}w[i]*x[i,j]<=W[j];

subject to Con3{i in M}:
	sum{j in B}x[i,j]<=1;