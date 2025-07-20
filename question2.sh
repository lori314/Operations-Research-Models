model question2.mod;		#装入模型
data question2.dat;		#装入数据
option solver cplex;		#设定求解器
option cplex_options  "mipdisplay=2 timelimit=3600";	#设定显示方式 和 计算时间上限

objective TotalValue;	#设定目标函数

solve;			#开始求解

#显示结果
display x1;
display x2;
display y,d,TotalValue;