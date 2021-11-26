/* PLAYER */

/* Dynamic facts */
:- dynamic(job/1).
:- dynamic(gold/1).
:- dynamic(expTotal/1).
:- dynamic(expTotalCapacity/1).
:- dynamic(expFisher/1).
:- dynamic(expFisherCapacity/1).
:- dynamic(expFarmer/1).
:- dynamic(expFarmerCapacity/1).
:- dynamic(expRancher/1).
:- dynamic(expRancherCapacity/1).
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
	asserta(totalexp(0)), asserta(expCapacity(300)),
	asserta(lvlTotal(1)), asserta(lvlFisher(1)), asserta(lvlFarmer(1)), asserta(lvlRancher(1)),
	asserta(expTotal(0)), asserta(expFisher(0)), asserta(expFarmer(0)), asserta(expRancher(0)).
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
	write(' / \\  Exp  : '), expTotal(ExpTotal), expCapacity(ExpCap), write(ExpTotal), write('/'), write(ExpCap), nl, nl,
	write('FARMING    Level: '), lvlFarmer(LvlFarm), write(LvlFarm), nl,
	write('           EXP  : '), expFarmer(ExpFarm), write(ExpFarm), nl,
	write('FISHING    Level: '), lvlFisher(LvlFish), write(LvlFish), nl,
	write('           EXP  : '), expFisher(ExpFish), write(ExpFish), nl,
	write('RANCHING   Level: '), lvlRancher(LvlRanch), write(LvlRanch), nl,
	write('           EXP  : '), expRancher(ExpRanch), write(ExpRanch), nl,
	!.


/* addGold: Menambah Gold player sebanyak A */
addGold(A) :- gold(G), G1 is G + A, retract(gold(G)), asserta(gold(G1)).

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
	expTotal(E), 
	E1 is E + X, 
	retract(expTotal(E)), 
	asserta(expTotal(E1)),
	lvlUpTotal.

/* addExpFisher: Menambah EXP Fisher ke player sebanyak X */
addExpFisher(X) :- 
	expFisher(E), 
	E1 is E + X, 
	retract(expFisher(E)), 
	asserta(expFisher(E1)),
	addExpTotal(E1),
	lvlUpFisher.

/* addExpFarmer: Menambah EXP Farmer ke player sebanyak X */
addExpFarmer(X) :- 
	expFarmer(E), 
	E1 is E + X, 
	retract(expFarmer(E)), 
	asserta(expFarmer(E1)),
	addExpTotal(E1),
	lvlUpFarmer.

/* addExpRancher: Menambah EXP Rancher ke player sebanyak X */
addExpRancher(X) :- 
	expRancher(E), 
	E1 is E + X, 
	retract(expRancher(E)), 
	asserta(expRancher(E1)).
	addExpTotal(E1),
	lvlUpRancher.

/* lvlUp: cek untuk level up, jika melebihi capacity naik level */
lvlUpTotal :- 
	expTotal(X), 
	expTotalCapacity(Y),
	X >= Y,
	X1 is X mod Y,
	Y1 is Y * 2,
	lvlTotal(Z),
	Z1 is Z + 1,
	retract(expTotal(X)),
	asserta(expTotal(X1)),
	retract(expTotalCapacity(Y)),
	asserta(expTotalCapacity(Y1)),
	retract(lvlTotal(Z)),
	asserta(lvlTotal(Z1)).

lvlUpFisher :- 
	expFisher(X), 
	expFisherCapacity(Y),
	X >= Y,
	X1 is X mod Y,
	Y1 is Y * 2, /* Tiap naik level, batas exp naik 2x */
	lvlFisher(Z),
	Z1 is Z + 1,
	retract(expFisher(X)),
	asserta(expFisher(X1)),
	retract(expFisherCapacity(Y)),
	asserta(expFisherCapacity(Y1)),
	retract(lvlFisher(Z)),
	asserta(lvlFisher(Z1)).

lvlUpFarmer :- 
	expFarmer(X), 
	expFarmerCapacity(Y),
	X >= Y,
	X1 is X mod Y,
	Y1 is Y * 2, /* Tiap naik level, batas exp naik 2x */
	lvlFarmer(Z),
	Z1 is Z + 1,
	retract(expFarmer(X)),
	asserta(expFarmer(X1)),
	retract(expFarmerCapacity(Y)),
	asserta(expFarmerCapacity(Y1)),
	retract(lvlFarmer(Z)),
	asserta(lvlFarmer(Z1)).

lvlUpRancher :- 
	expRancher(X), 
	expRancherCapacity(Y),
	X >= Y,
	X1 is X mod Y,
	Y1 is Y * 2, /* Tiap naik level, batas exp naik 2x */
	lvlRancher(Z),
	Z1 is Z + 1,
	retract(expRancher(X)),
	asserta(expRancher(X1)),
	retract(expRancherCapacity(Y)),
	asserta(expRancherCapacity(Y1)),
	retract(lvlRancher(Z)),
	asserta(lvlRancher(Z1)).