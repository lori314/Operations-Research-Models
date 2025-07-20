#traverse.sh
set DAY;			#期间（天）集合
set AREA;			#区域集合
set WEATHER;		#天气集合
set RES;			#水和食物
set Conn in {AREA, AREA};	#相邻区域集合

param WEA{DAY,WEATHER} binary;	#天气情况
param COST{WEATHER,RES};	#不同天气下消耗资源的基础消耗数量
param price{RES};		#资源（水和食物）的价格/箱
param weight{RES};		#资源（水和食物）的质量/箱

param MAX_weight:=1200;
param initial_m:=10000;
param basicRev:=1000;

param M:=99999;

var stay{DAY, AREA} binary;		#每天到达的区域
var ini_r{RES} integer >=0;		#初始携带的资源（箱）
var CS{DAY, RES} integer >=0;		#每天的资源消耗
var pur{DAY,RES} integer >=0;		#在村庄（15号）购买的资源
var mining{DAY} binary;		#是否挖矿（12号）
var left_r{DAY, RES} integer >=0;		#每天的资源剩余
var left_m{DAY}>=0;			#每天剩余的钱

maximize MyObj: sum{r in RES}left_r[30,r]*price[r]/2 + left_m[30];	

subject to Con1:
	stay[1,1]=1;	#第1天从第1号区域出发
subject to Con2:
	stay[30,27]=1;	#最后一天到达第27号区域
subject to Con3{d in DAY}:
	sum{a in AREA}stay[d,a]=1;		#每天只能呆在1个区域
subject to Con4{d in DAY,i in AREA:d>1}:
	stay[d,i]<=sum{(j,i) in Conn}stay[d-1,j]+stay[d-1,i];#若第d(d>1)天所处位置为第i区域，则必须在第d-1天处于与i相邻的区域（或i区域本身）
subject to Con5{d in DAY,i in AREA:d<30}:
	stay[d+1,i]>=stay[d,i]-M*(2-stay[d,i]-WEA[d,3]);
subject to Con6{d in DAY,r in RES,i in AREA,w in WEATHER:d<30}:
	CS[d,r]>=COST[w,r]-M*(2-stay[d,i]-WEA[d,3]);#每天资源消耗量（基础消耗）
subject to Con8{d in DAY,r in RES,i in AREA,w in WEATHER:d<30}:
	CS[d,r]>=2*COST[w,r]-M*(2+stay[d+1,i]-stay[d,i]-WEA[d,w]);#每天资源消耗量(行走1天2倍消耗)
subject to Con7{d in DAY,r in RES,i in AREA,w in WEATHER:d<30}:
	CS[d,r]>=3*COST[w,r]-M*(3-stay[d,i]-WEA[d,w]-mining[d]);#每天资源消耗量(挖矿3倍消耗)
subject to Con9{d in DAY,r in RES}:
	pur[d,r]<=M*stay[d,15];#在村庄（15号）购买的资源
subject to Con10{r in RES}:
	left_r[1,r]=ini_r[r]-CS[1,r]+pur[1,r];
subject to Con11{d in DAY,r in RES:d>1}:
	left_r[d,r]=left_r[d-1,r]-CS[d,r]+pur[d,r];#剩余资源计算
subject to Con12:
	sum{r in RES}ini_r[r]*weight[r]<=MAX_weight;
subject to Con13{d in DAY}:
	sum{r in RES}left_r[d,r]*weight[r]<=MAX_weight;#总重量不超过上限
subject to Con14{d in DAY:d>1}:
	mining[d]<=stay[d,12];
subject to Con17{d in DAY:d<30}:
	mining[d]<=stay[d+1,12];	#在矿山（12号）是否挖矿
subject to Con15:
	left_m[1]=initial_m;
subject to Con16{d in DAY:d>1}:
	left_m[d]=left_m[d-1]+mining[d]*basicRev-2*sum{r in RES}pur[d,r]*price[r];
#钱流平衡
 