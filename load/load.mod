#load.mod
set N;  #表示车间
param X:=130; 
param Y:=90; #表示车间的长和宽
param x{N}; #表示车间N的长度
param y{N}; #表示车间N的宽度
param w{N,N}; #表示车间i，j之间的物料搬运两
param M:=999;
var center_x{N} integer;
var center_y{N} integer;
var set_mode{N} binary;
var d{N,N} integer;#表示车间i，j之间的距离
var d_x{N,N} integer;
var d_y{N,N} integer;
var p_x{N,N} binary;
var p_y{N,N} binary;

minimize TP:sum{i in N,j in N:i<>j}d[i,j]*w[i,j]/2;

subject to Con1{i in N}:
center_x[i]-(x[i]*(1-set_mode[i])+y[i]*set_mode[i])/2>=0;
subject to Con2{i in N}:
center_y[i]-(y[i]*(1-set_mode[i])+x[i]*set_mode[i])/2>=0;
subject to Con3{i in N,j in N:i<>j}:
d[i,j]=d_x[i,j]+d_y[i,j];
subject to Con4{i in N,j in N:i<>j}:
d_x[i,j]+(1-p_x[i,j])*M>=(x[i]*(1-set_mode[i])+y[i]*set_mode[i]+x[j]*(1-set_mode[j])+y[j]*set_mode[j])/2;
subject to Con5{i in N,j in N:i<>j}:
d_y[i,j]+(1-p_y[i,j])*M>=(y[i]*(1-set_mode[i])+x[i]*set_mode[i]+y[j]*(1-set_mode[j])+x[j]*set_mode[j])/2;
subject to Con6{i in N}:
center_x[i]+(x[i]*(1-set_mode[i])+y[i]*set_mode[i])/2<=X;
subject to Con7{i in N}:
center_y[i]+(y[i]*(1-set_mode[i])+x[i]*set_mode[i])/2<=Y;
subject to Con8a{i in N,j in N:i<>j}:
d_x[i,j]>=center_x[i]-center_x[j];
subject to Con8b{i in N,j in N:i<>j}:
d_x[i,j]>=center_x[j]-center_x[i];
subject to Con8c{i in N,j in N:i<>j}:
d_y[i,j]>=center_y[i]-center_y[j];
subject to Con8d{i in N,j in N:i<>j}:
d_y[i,j]>=center_y[j]-center_y[i];
subject to Con9{i in N,j in N:i<>j}:
p_x[i,j]+p_y[i,j]>=1;