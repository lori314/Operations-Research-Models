model order.mod;
data order10.dat;

option cplex_option "mipdisplay=2";

option solver cplex;

objective TTP;

solve;

display s;
#输出排序结果
param pos{N};
for {i in N}{
let pos[i]:=1+sum{j in N:i<>j}s[j,i];
}
display pos;
for{i in N}{
printf "i=%d\n",sum{j in N:pos[j]=i}j;
}
display TTP;