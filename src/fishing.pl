/*daftar ikan*/
/*nameFish = [tuna,salmon,catfish,musky,bass,bluegill,trout,carp,cod,pufferfish,none].*/
/*jumlah dan rarity ikan, berdasarkan harga*/

/*
none : 10 -> 0.2
catfish : 12 -> 0.24  
tuna : 4 -> 0.08
salmon : 4 -> 0.08
musky : 4 -> 0.08
bluegill : 4 -> 0.8
carp : 4 -> 0.08
bass : 2 -> 0.04
trout : 2 -> 0.04
cod : 2 -> 0.04
pufferfish : 2 -> 0.04
*/
/*total ikan ada 50 (termasuk none)*/
ikan(1,none).
ikan(2,none).
ikan(3,none).
ikan(4,none).
ikan(5,none).
ikan(6,none).
ikan(7,none).
ikan(8,none).
ikan(9,none).
ikan(10,none).
ikan(11,catfish).
ikan(12,catfish).
ikan(13,catfish).
ikan(14,catfish).
ikan(15,catfish).
ikan(16,catfish).
ikan(17,catfish).
ikan(18,catfish).
ikan(19,catfish).
ikan(20,catfish).
ikan(21,catfish).
ikan(22,catfish).
ikan(23,tuna).
ikan(24,tuna).
ikan(25,tuna).
ikan(26,tuna).
ikan(27,salmon).
ikan(28,salmon).
ikan(29,salmon).
ikan(30,salmon).
ikan(31,musky).
ikan(32,musky).
ikan(33,musky).
ikan(34,musky).
ikan(35,bluegill).
ikan(36,bluegill).
ikan(37,bluegill).
ikan(38,bluegill).
ikan(39,carp).
ikan(40,carp).
ikan(41,carp).
ikan(42,carp).
ikan(43,bass).
ikan(44,bass).
ikan(45,trout).
ikan(46,trout).
ikan(47,cod).
ikan(48,cod).
ikan(49,pufferfish).
ikan(50,pufferfish).
/*Tambahan peluang mendapat ikan mahal ketika dia seorang fisher*/
/*Memiliki peluang 40% lebih besar*/
ikan(51,bass).
ikan(52,trout).
ikan(53,cod).
ikan(54,pufferfish).


/*exp ikan, ditentukan dengan perbandingan harga ikan dan maksimal exp, yaitu 50*/
exp(tuna,30).
exp(salmon,30).
exp(catfish,13).
exp(musky,30).
exp(bass,50).
exp(bluegill,30).
exp(trout,50).
exp(carp,30).
exp(cod,50).
exp(pufferfish,50).
exp(none,5).

/*fishing*/
/*if he is a fisherman, get 40% chance to get expensive fish*/
fishing :-
	job(Job), (Job == fisherman),
	position(X,Y), isNearAir(X,Y),
	random(1,54,R), ikan(R,Fish),
	gotFish(Fish),
	exp(Fish,Exp), addExpTotal(Exp), addExpFisher(Exp),
	addFishtoInv(Fish).

/*fishing if he isn't a fisherman, don't get a privilege*/
fishing :-
	position(X,Y), isNearAir(X,Y),
	random(1,50,R), ikan(R,Fish),
	gotFish(Fish),
	exp(Fish,Exp), addExpTotal(Exp), addExpFisher(Exp),
	addFishtoInv(Fish).

/*write what he get*/
/*he get nothing*/
gotFish(Item) :-
	(Item == none),
	exp(Item,Exp),
	write('You didn\'t get anything!'), nl,
	write('You gained '), write(Exp), write(' fishing exp.').
/*he get a fish*/
gotFish(Item) :-
	exp(Item,Exp),
	write('You got '), write(Item), write('!'), nl,
	write('You gained '), write(Exp), write(' fishing exp.').

/*Add fish to invetory*/
addFishtoInv(Fish) :-
	invenItem(Fish, Total, _),
	Totalnew is Total+1,
	retract(invenItem(Fish,Total,_)),
	asserta(invenItem(Fish,Totalnew,-1)).
