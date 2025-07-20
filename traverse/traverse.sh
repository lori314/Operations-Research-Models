model traverse.mod;
data traverse.dat;
option solver cplex;
objective MyObj;
solve;
for{d in DAY}
{
	printf "第%d天，区域=%d，天气=%d, 消耗(%d, %d), 购入(%d, %d), 剩余(%d, %d), 负重=%d, 挖矿(%d)=%d, 余钱=%f\n",d, sum{i in AREA}stay[d,i]*i, sum{w in WEATHER}WEA[d,w]*w, CS[d,1], CS[d,2], pur[d,1],pur[d,2],left_r[d,1],left_r[d,2], sum{r in RES}left_r[d,r]*weight[r], mining[d], mining[d]*basicRev, left_m[d]  >> out.txt;
}
display MyObj;