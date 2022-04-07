use "lakisha_aer.dta", clear

//desc


*Replicate table 4 panel A

*for white
ttest call if race == "w", by(h)

*for black
ttest call if race == "b", by(h)

*1CDEF --- Replicating the Table 5

*City dummy
generate chicago = 0
replace chicago = 1 if city =="c"

*sex dummy

generate female = 0
replace female =1 if sex == "f"

*generate experience squared
generate yearsexp2 = yearsexp*yearsexp

*run probit for All
probit call yearsexp yearsexp2 i.volunteer i.military i.email i.empholes i.workinschool i.honors i.computerskills i.specialskills  i.chicago i.female i.manager i.supervisor i.secretary  i.offsupport  i.salesrep  i.req i.expreq i.compreq i.comreq i.orgreq i.educreq, robust
margins, dydx(yearsexp yearsexp2 i.volunteer i.military i.email i.empholes i.workinschool i.honors i.computerskills i.specialskills  i.chicago i.female i.manager i.supervisor i.secretary  i.offsupport  i.salesrep  i.req i.expreq i.compreq i.comreq i.orgreq i.educreq) post  
estimates store margins1
outreg2 using hw2-table1.doc, drop(i.chicago i.manager i.supervisor i.secretary i.offsupport i.salesrep i.expreq i.compreq i.comreq i.orgreq i.educreq i.req i.female)



*run probit for White 

keep if (race == "w")

probit call yearsexp yearsexp2 i.volunteer i.military i.email i.empholes i.workinschool i.honors i.computerskills i.specialskills  i.chicago i.female i.manager i.supervisor i.secretary  i.offsupport  i.salesrep  i.req i.expreq i.compreq i.comreq i.orgreq i.educreq, robust
margins, dydx(yearsexp yearsexp2 i.volunteer i.military i.email i.empholes i.workinschool i.honors i.computerskills i.specialskills  i.chicago i.female i.manager i.supervisor i.secretary  i.offsupport  i.salesrep  i.req i.expreq i.compreq i.comreq i.orgreq i.educreq) post 

estimates store margins2

outreg2 margins1 using hw2-table1.doc, drop(i.chicago i.manager i.supervisor i.secretary i.offsupport i.salesrep i.expreq i.compreq i.comreq i.orgreq i.educreq i.req i.female) append

*probit for black

use "lakisha_aer.dta", clear
keep if (race == "b")

generate chicago = 0
replace chicago = 1 if city =="c"

*sex dummy

generate female = 0
replace female =1 if sex == "f"

*generate experience squared
generate yearsexp2 = yearsexp*yearsexp

*probit for black

probit call yearsexp yearsexp2 i.volunteer i.military i.email i.empholes i.workinschool i.honors i.computerskills i.specialskills  i.chicago i.female i.manager i.supervisor i.secretary  i.offsupport  i.salesrep  i.req i.expreq i.compreq i.comreq i.orgreq i.educreq, robust
margins, dydx(yearsexp yearsexp2 i.volunteer i.military i.email i.empholes i.workinschool i.honors i.computerskills i.specialskills  i.chicago i.female i.manager i.supervisor i.secretary  i.offsupport  i.salesrep  i.req i.expreq i.compreq i.comreq i.orgreq i.educreq) post

estimates store margins2

outreg2 margins1 using hw2-table1.doc, drop(i.chicago i.manager i.supervisor i.secretary i.offsupport i.salesrep i.expreq i.compreq i.comreq i.orgreq i.educreq i.req i.female) append

*1G --- LPM instead of probit marginal effects

use "lakisha_aer.dta", clear

*City dummy
generate chicago = 0
replace chicago = 1 if city =="c"

*sex dummy

generate female = 0
replace female =1 if sex == "f"

*generate experience squared
generate yearsexp2 = yearsexp*yearsexp

// Results for All

reg call yearsexp yearsexp2 volunteer military email empholes workinschool honors computerskills specialskills  chicago female manager supervisor secretary  offsupport  salesrep  req expreq compreq comreq orgreq educreq

outreg2 margins1 using hw2-table2.doc, drop(chicago manager supervisor secretary offsupport salesrep expreq compreq comreq orgreq educreq req female)


// Results for Whites

keep if (race == "w")

reg call yearsexp yearsexp2 volunteer military email empholes workinschool honors computerskills specialskills  chicago female manager supervisor secretary  offsupport  salesrep  req expreq compreq comreq orgreq educreq

outreg2 margins1 using hw2-table2.doc, drop(chicago manager supervisor secretary offsupport salesrep expreq compreq comreq orgreq educreq req female) append
// Results for Blacks

use "lakisha_aer.dta", clear

keep if (race == "b")

*City dummy
generate chicago = 0

replace chicago = 1 if city =="c"

*sex dummy

generate female = 0

replace female =1 if sex == "f"

*generate experience squared
generate yearsexp2 = yearsexp*yearsexp

reg call yearsexp yearsexp2 volunteer military email empholes workinschool honors computerskills specialskills  chicago female manager supervisor secretary  offsupport  salesrep  req expreq compreq comreq orgreq educreq

outreg2 margins1 using hw2-table2.doc, drop(chicago manager supervisor secretary offsupport salesrep expreq compreq comreq orgreq educreq req female) append


// 

