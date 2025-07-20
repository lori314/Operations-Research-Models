model trip.mod; #装入模型
data trip.dat; #装入数据文件
#let P:={(4,2),(5,6)};
for{i in Node,j in Node:i<>j}{
	let D[i,j]:=sqrt((Node_X[i]-Node_X[j])^2+(Node_Y[i]-Node_Y[j])^2);
}
let k:=1;
option solver cplex; #用cplex求解

objective distance;

solve;

display distance;
display x;
display u;
for{i in Node}{
	printf "%f %f\n",Node_X[u[i]],Node_Y[u[i]];
	}