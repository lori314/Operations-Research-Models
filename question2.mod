#question2.mod

set M;	#表示顺序

param p1{M}; #表示零件1的次品率
param p2{M}; #表示零件2的次品率
param p{M}; #表示成品的次品率
param v1{M};	#表示零件1的检测成本
param v2{M};	#表示零件2的检测成本
param v{M};		#表示成品的检测成本
param rechange{M}; #表示不合格成品的调换损失
param dismantle{M}; #表示不合格成品的拆解费用
param price1:=4; #零件1的单价
param price2:=18; #零件2的单价
param set_price:=6; #成品的装配成本
param value:=56;	#成品的售价

#定义变量
var x1 binary; #是否对零件1进行检测
var x2 binary;	#是否对零件2进行检测
var y binary; #是否对成品进行检测
var d binary; #是否对不合格成品进行拆解

#定义目标函数
maximize TotalValue:sum{i in M}((1-(1-p1[i]+p1[i]*x1)*(1-p2[i]+p2[i]*x2)*(1-p[i]+p[i]*y))*d*(1-p1[i]+p1[i]*x1)*(1-p2[i]+p2[i]*x2)*(1-p[i]+p[i]*y)+(1-p1[i]+p1[i]*x1)*(1-p2[i]+p2[i]*x2)*(1-p[i]+p[i]*y))*(value-price1-price2-v1[i]*x1-v2[i]*x2-v[i]*y-set_price-dismantle[i]*d*(1-(1-p1[i]+p1[i]*x1)*(1-p2[i]+p2[i]*x2)*(1-p[i]+p[i]*y)))-(1-d)*(1-(1-p1[i]+p1[i]*x1)*(1-p2[i]+p2[i]*x2)*(1-p[i]+p[i]*y)))*rechange[i];

#约束条件

	
	
