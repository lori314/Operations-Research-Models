model m_order.mod;
data m_order.dat;
option solver cplex;
objective T;
solve;

param sn{K,N};
for{i in N,k in K}let sn[k,i]:=d[i,k]+sum{j in N:j<>i}s[j,i]*d[i,k]*d[j,k];
param ps{K,N};
for{k in K,i in N}let ps[k,i]:=0;
for{k in K,i in N:sn[k,i]>0}let ps[k,sn[k,i]]:=i;
#输出
for{k in K}
{
	printf"machine%d:\t",k;
	for{i in N:ps[k,i]>0}printf"%d\t",ps[k,i];
	printf"\n";
}

display T;