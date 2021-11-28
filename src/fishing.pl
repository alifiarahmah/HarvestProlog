/*Fishing.pl*/
/*Fungsi yang bisa digunakan:
- fishing
*/
/*(jumlah,rarity) tiap 2 level, berdasarkan harga*/
/*
fishing lvl-> lvl 1-2		lvl 3-4			lvl 5-6		   lvl 7-8		   lvl >=9
none 		: (5, 20%) 	-> (5, 12.8%) 	-> (5, 9.4%) 	-> (5, 7.5%)	-> (5, 6.2%) 
catfish 	: (6, 24%) 	-> (6, 15.4%) 	-> (6, 11.3%) 	-> (6, 9%) 		-> (6, 7.5%)
tuna 		: (2, 8%) 	-> (4, 10.2%) 	-> (6, 11.3%) 	-> (8, 11.9%)	-> (10, 12.3%)
salmon 		: (2, 8%) 	-> (4, 10.2%) 	-> (6, 11.3%) 	-> (8, 11.9%)	-> (10, 12.3%)
musky 		: (2, 8%) 	-> (4, 10.2%) 	-> (6, 11.3%) 	-> (8, 11.9%)	-> (10, 12.3%)
bluegill	: (2, 8%) 	-> (4, 10.2%) 	-> (6, 11.3%) 	-> (8, 11.9%)	-> (10, 12.3%)
carp 		: (2, 8%) 	-> (4, 10.2%) 	-> (6, 11.3%) 	-> (8, 11.9%)	-> (10, 12.3%)
bass 		: (1, 4%) 	-> (2, 5.2%) 	-> (3, 5.7%) 	-> (4, 6%)		-> (5, 6.2%)
trout	 	: (1, 4%) 	-> (2, 5.2%) 	-> (3, 5.7%) 	-> (4, 6%)		-> (5, 6.2%)
cod 		: (1, 4%) 	-> (2, 5.2%) 	-> (3, 5.7%) 	-> (4, 6%)		-> (5, 6.2%)
pufferfish 	: (1, 4%) 	-> (2, 5.2%) 	-> (3, 5.7%) 	-> (4, 6%)		-> (5, 6.2%)
total		: (25, 100%)-> (39, 100%)	-> (53, 100%)	-> (67, 100%)	-> (81, 100%)
*/
/*total ikan ada 81 (termasuk none)*/
/*Level 1-2*/
ikan(1,none).
ikan(2,none).
ikan(3,none).
ikan(4,none).
ikan(5,none).
ikan(6,catfish).
ikan(7,catfish).
ikan(8,catfish).
ikan(9,catfish).
ikan(10,catfish).
ikan(11,catfish).
ikan(12,tuna).
ikan(13,tuna).
ikan(14,salmon).
ikan(15,salmon).
ikan(16,musky).
ikan(17,musky).
ikan(18,bluegill).
ikan(19,bluegill).
ikan(20,carp).
ikan(21,carp).
ikan(22,bass).
ikan(23,trout).
ikan(24,cod).
ikan(25,pufferfish).
/*Added fish for Level 3-4*/
ikan(26,tuna).
ikan(27,tuna).
ikan(28,salmon).
ikan(29,salmon).
ikan(30,musky).
ikan(31,musky).
ikan(32,bluegill).
ikan(33,bluegill).
ikan(34,carp).
ikan(35,carp).
ikan(36,bass).
ikan(37,trout).
ikan(38,cod).
ikan(39,pufferfish).
/*Added fish for Level 5-6*/
ikan(40,tuna).
ikan(41,tuna).
ikan(42,salmon).
ikan(43,salmon).
ikan(44,musky).
ikan(45,musky).
ikan(46,bluegill).
ikan(47,bluegill).
ikan(48,carp).
ikan(49,carp).
ikan(50,bass).
ikan(51,trout).
ikan(52,cod).
ikan(53,pufferfish).
/*Added fish for Level 7-8*/
ikan(54,tuna).
ikan(55,tuna).
ikan(56,salmon).
ikan(57,salmon).
ikan(58,musky).
ikan(59,musky).
ikan(60,bluegill).
ikan(61,bluegill).
ikan(62,carp).
ikan(63,carp).
ikan(64,bass).
ikan(65,trout).
ikan(66,cod).
ikan(67,pufferfish).
/*Added fish for Level >= 9*/
ikan(68,tuna).
ikan(69,tuna).
ikan(70,salmon).
ikan(71,salmon).
ikan(72,musky).
ikan(73,musky).
ikan(74,bluegill).
ikan(75,bluegill).
ikan(76,carp).
ikan(77,carp).
ikan(78,bass).
ikan(79,trout).
ikan(80,cod).
ikan(81,pufferfish).

/*Fishing time for each fish*/
timeFish(none,1).
timeFish(catfish,1).
timeFish(tuna,1).
timeFish(salmon,1).
timeFish(musky,1).
timeFish(bluegill,1).
timeFish(carp,1).
timeFish(bass,2).
timeFish(trout,2).
timeFish(cod,2).
timeFish(pufferfish,2).

/*fish exp, depend on the time to get the fish*/
exp(none,1).
exp(catfish,2).
exp(tuna,5).
exp(salmon,5).
exp(musky,5).
exp(bluegill,5).
exp(carp,5).
exp(bass,8).
exp(trout,8).
exp(cod,8).
exp(pufferfish,8).

/*fishing*/
/*If not in tail air area*/

fishing :-
	position(X,Y), \+ isNearAir(X,Y),
	write('You\'re not in tail air area. So, you can\'t start fishing.'), !.
/*For fishing level 1-2*/
fishing :-
	position(X,Y), isNearAir(X,Y),
	lvlFisher(Level), Level =< 2,
	random(1,26,R), ikan(R,Fish),
	exp(Fish,Exp), newExp(Exp,NewExp) ,addExpTotal(NewExp), addExpFisher(NewExp),
	gotFish(Fish,NewExp),
	addTimeFishing(Fish), 
	time(T1),
	Date is (T1//24) + 1,
	Hour is T1 mod 24, nl,
	write('Day '), write(Date), nl,
	write('Current Time: '), write(Hour), nl,
	!.
/*For fishing level 3-4*/
fishing :-
	position(X,Y), isNearAir(X,Y),
	lvlFisher(Level), Level >= 3, Level =< 4,
	random(1,40,R), ikan(R,Fish),
	exp(Fish,Exp), newExp(Exp,NewExp) ,addExpTotal(NewExp), addExpFisher(NewExp),
	gotFish(Fish,NewExp),
	addTimeFishing(Fish),  
	time(T1),
	Date is (T1//24) + 1,
	Hour is T1 mod 24, nl,
	write('Day '), write(Date), nl,
	write('Current Time: '), write(Hour), nl,
	!.
/*For fishing level 5-6*/
fishing :-
	position(X,Y), isNearAir(X,Y),
	lvlFisher(Level), Level >= 5, Level =< 6,
	random(1,54,R), ikan(R,Fish),
	exp(Fish,Exp), newExp(Exp,NewExp) ,addExpTotal(NewExp), addExpFisher(NewExp),
	gotFish(Fish,NewExp),
	addTimeFishing(Fish),  
	time(T1),
	Date is (T1//24) + 1,
	Hour is T1 mod 24, nl,
	write('Day '), write(Date), nl,
	write('Current Time: '), write(Hour), nl,
	!.
/*For fishing level 7-8*/
fishing :-
	position(X,Y), isNearAir(X,Y),
	lvlFisher(Level), Level >= 7, Level =< 8,
	random(1,68,R), ikan(R,Fish),
	exp(Fish,Exp), newExp(Exp,NewExp) ,addExpTotal(NewExp), addExpFisher(NewExp),
	gotFish(Fish,NewExp),
	addTimeFishing(Fish),  
	time(T1),
	Date is (T1//24) + 1,
	Hour is T1 mod 24, nl,
	write('Day '), write(Date), nl,
	write('Current Time: '), write(Hour), nl,
	!.
/*For fishing level >= 9*/
fishing :-
	position(X,Y), isNearAir(X,Y),
	lvlFisher(Level), Level >= 9,
	random(1,82,R), ikan(R,Fish),
	exp(Fish,Exp), newExp(Exp,NewExp) ,addExpTotal(NewExp), addExpFisher(NewExp),
	gotFish(Fish,NewExp),
	addTimeFishing(Fish),  
	time(T1),
	Date is (T1//24) + 1,
	Hour is T1 mod 24, nl,
	write('Day '), write(Date), nl,
	write('Current Time: '), write(Hour), nl,
	!.

/*write what he get and update the quest*/
/*he get nothing, no need to update the quest*/
gotFish(Item,Exp) :-
	Item == none,
	write('You didn\'t get anything!'), nl,
	write('You gained '), write(Exp), write(' fishing exp.'), !.
/*he get a fish, and update the quest*/
gotFish(Item,Exp) :-
	write('You got '), write(Item), write('!'), nl,
	write('You gained '), write(Exp), write(' fishing exp.'),
	addItem(Item,1,-1),
	ongoingQ(X,Y,Z), Y > 0,
	X1 is X,
	Y1 is Y-1,
	Z1 is Z,
	retract(ongoingQ(_,_,_)),
	asserta(ongoingQ(X1,Y1,Z1)), !.

/*Checking exp mechanism for fisher and non-fisher*/
/*For fisher, got 20% exp addition*/
newExp(Exp,NewExp) :-
	job(Job), Job == 'Fisherman',
	AddExp is Exp*0.2,
	NewExp1 is Exp+AddExp,
	NewExp is round(NewExp1), !.
/*For non-fisher, didn't get any addition*/
newExp(Exp,NewExp) :-
	job(Job), Job \== 'Fisherman',
	NewExp is Exp, !.

/*Add time every get a fish*/
addTimeFishing(Fish) :-
	timeFish(Fish,T),
	time(X), Tnew is X+T,
	retract(time(_)),
	asserta(time(Tnew)), !.