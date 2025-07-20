#question3.mod

set M;	#零件的集合
set N;	#半成品的集合

param p{M};
param v{M};
param c{M};
param hp{N};
param hv{N};
param hc{N};
param hd{N};
param cp:=0.1;
param cv:=8;
param cc:=6;
param cd:=10;
param price:=200;
param rechange:=40;

#定义变量
var if_check{M} binary;
var if_hcheck{N} binary;
var if_ccheck binary;
var if_hdismantle{N} binary;
var if_cdismantle binary;
var pass_percent{M};
var h_percent{N};
var c_percent;
var check_value;
var rechange_price;
var dismantle_price;

#定义目标函数
maximize expect_value:c_percent*(price-sum{i in M}v[i]-sum{j in N}hv[j]-cv-rechange_price-check_value-dismantle_price);

#约束条件
subject to Con1{i in M}:
	pass_percent[i]<=1-p[i]+p[i]*if_check[i];
subject to Con2:
	h_percent[0]<=pass_percent[0]*pass_percent[1]*pass_percent[2]*(1-hp[0]+hp[0]*if_hcheck[0])*(1+if_hdismantle[0]-if_hdismantle[0]*pass_percent[0]*pass_percent[1]*pass_percent[2]*(1-hp[0]+hp[0]*if_hcheck[0]));
subject to Con3:
	h_percent[1]<=pass_percent[3]*pass_percent[4]*pass_percent[5]*(1-hp[1]+hp[1]*if_hcheck[1])*(1+if_hdismantle[1]-if_hdismantle[1]*pass_percent[3]*pass_percent[4]*pass_percent[5]*(1-hp[1]+hp[1]*if_hcheck[1]));
subject to Con4:
	h_percent[2]<=pass_percent[6]*pass_percent[7]*(1-hp[2]+hp[2]*if_hcheck[2])*(1+if_hdismantle[2]-if_hdismantle[2]*pass_percent[6]*pass_percent[7]*(1-hp[2]+hp[2]*if_hcheck[2]));
subject to Con5:
	c_percent<=h_percent[0]*h_percent[1]*h_percent[2]*(1-cp+cp*if_ccheck)*(1+if_cdismantle-if_cdismantle*h_percent[0]*h_percent[1]*h_percent[2]*(1-cp+cp*if_ccheck));
subject to Con6:
	check_value>=sum{i in M}c[i]*if_check[i]+sum{j in N}hc[j]*if_hcheck[j]+cc*if_ccheck;
subject to Con7:
	dismantle_price>=sum{j in N}if_hdismantle[j]*hd[j]+if_cdismantle*cd;
subject to Con8:
	rechange_price>=rechange*(1-c_percent);
	

