model AMBU.mod;		#装入模型
data AMBU.dat;		#装入数据
option solver cplex;		#设定求解器
option cplex_options  "mipdisplay=2 timelimit=3600";	#设定显示方式 和 计算时间上限

objective TP;	#设定目标函数

solve;			#开始求解

#显示结果
display x;
display d;
display TP;
