set Node;
param D{Node,Node};
param Node_X{Node};
param Node_Y{Node};
param M:=114514;
param k;
set PD in {Node,Node}:={(5,9),(6,3),(1,4),(10,7),(8,2)};

var x{Node,Node} binary;
var u{Node};

var Load{Node}>=0; #表示从i出发的负载

minimize distance:sum{i in Node,j in Node:i<>j}D[i,j]*x[i,j];

subject to Con1{i in Node}:
	Load[i]<=k;
subject to Con2{j in Node}:
	sum{i in Node:i<>j}x[i,j]=1;
subject to Con3{i in Node}:
	sum{j in Node:i<>j}x[i,j]=1;
subject to Con4{i in Node,j in Node:i<>j and j>0}:
	u[j]-u[i]>=1-M*(1-x[i,j]);
subject to Con5{i in Node}:
	u[i]<=card(Node)-1;
subject to Con6{i in Node}:
	u[i]>=0;
subject to Con7{i in Node,j in Node,(i1,j1) in PD:i<>j and j>0}:
	Load[j]>=Load[i]+1-M*abs(i-i1);
subject to Con8{i in Node,j in Node,(i1,j1) in PD:i<>j and j>0}:
	Load[j]<=Load[i]-1+M*abs(j-j1);
subject to Con9{(i,j) in PD}:
	u[i]<=u[j]-1;