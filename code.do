use "/Users/fan/Desktop/maindata.dta",clear
global vars gender age livarea freinoc ffreinunoc trustom edu frewalp lnpgdp lncysj lnwage baiduindex

********Table1******
logout,save(mytable_Table 1) word replace : sum tggap dswz govres govtran  poleff $vars 
********Table2******
reg tggap  dswz $vars
est store m1
reg tggap  dwsz_pl $vars
est store m2
reg  trucengov dswz $vars
est store m3
reg trucprogov dswz  $vars
est store m4
reg tructowgov dswz $vars
est store m5
reg tructvillage dswz $vars
est store m6
esttab m1 m2 m3 m4 m5 m6 using Table2.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) t(%7.2f) r2(%9.3f)  scalars(F) mtitles("tggap""tggap""trucengov" "trucprogov" "tructowgov" "tructvillage") title(Table2 Estimation results of the impact of TV politics on residents' hierarchical trust in government)

********Table3******
reg dswz IV $vars 
est store m1
ivreg2 tggap (dswz=IV) $vars, first
est store m2
esttab m1 m2 using Table3.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) t(%7.2f) r2(%9.3f)  scalars(F) title(Table 3  Estimation results of Instrumental variable)

********Table4******
set seed 111000
psmatch2 dswz $vars ,out(tggap) common neighbor(1) caliper(0.02) ate
reg tggap  dswz $vars  if _support==1
est store m1
psmatch2 dswz $vars ,out(tggap) common radius caliper(0.01) ate
reg tggap  dswz $vars if _support==1
est store m2
psmatch2 dswz $vars ,out(tggap) common kernel bw(0.03) ate
reg tggap  dswz $vars  if _support==1
est store m3
psmatch2 dswz  $vars , outcome(tggap) llr ate logit common 
reg tggap  dswz $vars  if _support==1
est store m4
esttab m1 m2 m3 m4 using Table4.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) t(%7.2f) r2(%9.3f)  scalars(F) title(Table4  Results of PSM)


********Table5******
reg govtran dswz $vars
est store m1
reg tggap govtran dswz $vars
est store m2
sgmediation tggap , mv(govtran) iv(dswz) cv($vars)

reg govres dswz $vars
est store m3
reg tggap govres dswz $vars
est store m4
sgmediation tggap , mv(govres) iv( dswz ) cv($vars)

reg poleff dswz $vars 
est store m5
reg tggap poleff dswz $vars 
est store m6
sgmediation tggap , mv(poleff) iv(dswz) cv($vars)
esttab m1 m2  m3 m4 m5  m6 using Table5.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) t(%7.2f) r2(%9.3f)  scalars(F) title(Table 5 Results of mediation effect test)


********Table6******

reg tggap dswz $vars  if age==2|age==3|age==4|age==5
est store m1
reg tggap dswz $vars  if age==6|age==7
est store m2
reg tggap dswz $vars if age==8|age==9|age==10
est store m3

reg tggap dswz  $vars  if gender==1
est store m4
reg tggap dswz  $vars  if gender==0
est store m5

reg tggap dswz  $vars if zhengzhimianmao==1
est store m6
reg tggap  dswz $vars if zhengzhimianmao==0
est store m7

reg tggap  dswz $vars if digitalization>2
est store m8
reg tggap  dswz $vars if digitalization<3
est store m9
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 using Table6.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) t(%7.2f) r2(%9.3f)  scalars(F) title(Table 6  Heterogeneity effect of individual characteristics)

********Table7******
reg tggap  dswz $vars if east==1
est store m1
reg tggap  dswz  $vars if middle==1
est store m2
reg tggap  dswz  $vars  if west==1
est store m3
reg tggap  dswz  $vars if shenghui==1
est store m4
reg tggap  dswz  $vars if shenghui==0
est store m5
esttab m1 m2 m3 m4 m5 using Table7.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) t(%7.2f) r2(%9.3f)  scalars(F) title(Table 7  Heterogeneity effect of regional characteristics)

********Table8******
**We have no permission to share data of CGG2019 and CGG2021,we can apply for downloads through this website
http://csqr.cass.cn****

*************Appendix A********************
use "/Users/fan/Desktop/maindata.dta"
mixed tggap || city_id:,mle
estat icc
