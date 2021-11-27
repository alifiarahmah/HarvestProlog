/* PLAYER */

/* 1 jam -> 45 - 55 gold */
/* 1 jam -> 4 - 6 exp */

/* Dynamic facts */
:- dynamic(job/1).
:- dynamic(gold/1).
:- dynamic(expTotal/2).
:- dynamic(expFisher/2).
:- dynamic(expFarmer/2).
:- dynamic(expRancher/2).
:- dynamic(lvlTotal/1).
:- dynamic(lvlFisher/1).
:- dynamic(lvlFarmer/1).
:- dynamic(lvlRancher/1).
:- dynamic(initiated/1).

chooseJob(1, 'Fisherman').
chooseJob(2, 'Farmer').
chooseJob(3, 'Rancher').

initiated(0).

/* initPlayer: Menyiapkan status awal player sebelum mulai bermain */
initPlayer :- 
	asserta(gold(1000)),
	asserta(expTotal(0, 300)),
	asserta(expFisher(0, 300)),
	asserta(expFarmer(0, 300)),
	asserta(expRancher(0, 300)),
	asserta(lvlTotal(1)), 
	asserta(lvlFisher(1)), 
	asserta(lvlFarmer(1)), 
	asserta(lvlRancher(1)).
	/*initRanch.*/

/* prepareJob: Menyiapkan inventory sesuai job (WIP) */
prepareJob(X) :- 
	write('Anda mendapat alat-alat untuk '), write(X), nl.

/* status: Menulis stats player: job, level & exp total dan masing2 job */
status :-
	initiated(X),
	X =:= 0,
	write('There isn\'t any status yet. Start to create your character !'),
	!.
status :- 
	initiated(X),
	X =:= 1,
	write('=================='), nl,
	write('      STATUS'), nl,
	write('=================='), nl, nl,
	write('  O   Job  : '), job(Job), write(Job), nl,
	write(' /|\\  Gold : '), gold(G), write(G), write(' G'), nl,
	write('  |   Level: '), lvlTotal(Lvl), write(Lvl), nl,
	write(' / \\  Exp  : '), expTotal(ExpTotal, ExpCap), write(ExpTotal), write('/'), write(ExpCap), nl, nl,
	write('FARMING    Level: '), lvlFarmer(LvlFarm), write(LvlFarm), nl,
	write('           EXP  : '), expFarmer(ExpFarm, _), write(ExpFarm), nl,
	write('FISHING    Level: '), lvlFisher(LvlFish), write(LvlFish), nl,
	write('           EXP  : '), expFisher(ExpFish, _), write(ExpFish), nl,
	write('RANCHING   Level: '), lvlRancher(LvlRanch), write(LvlRanch), nl,
	write('           EXP  : '), expRancher(ExpRanch, _), write(ExpRanch), nl,
	!.


/* addGold: Menambah Gold player sebanyak A */
addGold(A) :- 
	gold(G), 
	G1 is G + A, 
	retract(gold(G)), 
	asserta(gold(G1)).

/* writeAddGold: Menambah Gold player sebanyak A dan menuliskan di layar */
writeAddGold(A) :- 
	addGold(A), 
	write('You got '), write(A), write(' G.'), nl,
	write('Total Money: '), gold(G), write(G), write(' G'), nl.

/* substractGold: Mengurang Gold sebanyak A */
substractGold(A) :- gold(G), G1 is G - A, retract(gold(G)), asserta(gold(G1)).

/* writeAddGold: Mengurang Gold player sebanyak A  dan menuliskan di layar */
writeSubstractGold(A) :- 
	substractGold(A), 
	write('You lose '), write(A), write(' G.'), nl,
	write('Total Money: '), gold(G), write(G), write(' G'), nl.

/* addExpTotal: Menambah EXP Total ke player sebanyak X */
addExpTotal(X) :- 
	expTotal(E, C), 
	E1 is (E + X), 
	retract(expTotal(E, C)), 
	asserta(expTotal(E1, C)),
	lvlUpTotal.

/* addExpFisher: Menambah EXP Fisher ke player sebanyak X */
addExpFisher(X) :- 
	expFisher(E, C), 
	E1 is E + X, 
	retract(expFisher(E, C)), 
	asserta(expFisher(E1, C)),
	addExpTotal(E1),
	lvlUpFisher.

/* addExpFarmer: Menambah EXP Farmer ke player sebanyak X */
addExpFarmer(X) :- 
	expFarmer(E, C), 
	E1 is E + X, 
	retract(expFarmer(E, C)), 
	asserta(expFarmer(E1, C)),
	addExpTotal(E1),
	lvlUpFarmer.

/* addExpRancher: Menambah EXP Rancher ke player sebanyak X */
addExpRancher(X) :- 
	expRancher(E, C), 
	E1 is E + X, 
	retract(expRancher(E, C)), 
	asserta(expRancher(E1, C)),
	addExpTotal(E1),
	lvlUpRancher.

/* lvlUp: cek untuk level up, jika melebihi capacity naik level, sesuai job */
lvlUpTotal :- 
	expTotal(X, C), 
	X >= C, !,
	lvlTotal(L),
	L1 is L + 1,
	X1 is X - C,
	C1 is C + 150, /* Tiap naik level, batas exp naik +150 */
	retract(expTotal(X, C)),
	asserta(expTotal(X1, C1)),
	retract(lvlTotal(L)),
	asserta(lvlTotal(L1)).
	lvlUpTotal.

lvlUpFisher :- 
	expFisher(X, C), 
	X >= C, !,
	lvlFisher(L),
	L1 is L + 1,
	X1 is X - C,
	C1 is C + 150, /* Tiap naik level, batas exp naik +150 */
	retract(expFisher(X, C)),
	asserta(expFisher(X1, C1)),
	retract(lvlFisher(L)),
	asserta(lvlFisher(L1)).
	lvlUpFisher.

lvlUpFarmer :- 
	expFarmer(X, C), 
	X >= C, !,
	lvlFarmer(L),
	L1 is L + 1,
	X1 is X - C,
	C1 is C + 150, /* Tiap naik level, batas exp naik +150 */
	retract(expFarmer(X, C)),
	asserta(expFarmer(X1, C1)),
	retract(lvlFarmer(L)),
	asserta(lvlFarmer(L1)).
	lvlUpFarmer.

lvlUpRancher :- 
	expRancher(X, C), 
	X >= C, !,
	lvlRancher(L),
	L1 is L + 1,
	X1 is X - C,
	C1 is C + 150, /* Tiap naik level, batas exp naik +150 */
	retract(expRancher(X, C)),
	asserta(expRancher(X1, C1)),
	retract(lvlRancher(L)),
	asserta(lvlRancher(L1)).
	lvlUpRancher.