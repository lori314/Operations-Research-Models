set N:={1..100};
param X{N};
param Y{N};
param D;
param c;
let D:=0;
let c:=0;
for{i in N}{
let X[i]:=round(Uniform(1,100),0);
}
for{i in N}{
let Y[i]:=round(Uniform(1,100),0);
}
for{i in N,j in N:i<j}{
	let D:=D+sqrt((X[i]-X[j])^2+(Y[i]-Y[j])^2);
	let c:=c+1;
}
let D:=D/c;
display D;
