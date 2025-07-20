model pack.mod; #装入模型
data pack10.dat; #装入数据文件
let P:={(4,2),(5,6)};

option solver cplex; #用cplex求解

objective TotalValue;

solve;

display TotalValue;
display x;