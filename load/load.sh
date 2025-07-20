#load.sh
model load.mod;		#装入模型
data load.dat;		#装入数据
option solver cplex;		#设定求解器

objective TP;	#设定目标函数

solve;			#开始求解

#显示结果
display center_x;
display center_y;
display TP;
display set_mode;
display d_x;
display d_y;
display p_x;
display p_y;
display w;