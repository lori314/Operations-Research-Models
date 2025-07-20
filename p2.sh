var x1;
var x2;
var x3;

minimize Myobj:x1-2*x2+x3;
subject to Con1:
x1+x2-2*x3<=10;
subject to Con2:
2*x1-x2+4*x3<=8;
subject to Con3:
-x1+2*x2-4*x3<=4;
subject to Con4:
x1>=0;
subject to Con5:
x2>=0;
subject to Con6:
x3>=0;

option solver cplex;
objective Myobj;
solve;
display Myobj,x1,x2,x3;