/* PLAYER */

/* Dynamic facts */
:- dynamic(job/1).
:- dynamic(gold/1).
:- dynamic(expTotal/1).
:- dynamic(expCapacity/1).
:- dynamic(expFisher/1).
:- dynamic(expFarmer/1).
:- dynamic(expRancher/1).
:- dynamic(lvlTotal/1).
:- dynamic(lvlFisher/1).
:- dynamic(lvlFarmer/1).
:- dynamic(lvlRancher/1).

chooseJob(1, 'Fisherman').
chooseJob(2, 'Farmer').
chooseJob(3, 'Rancher').


/* initPlayer: Menyiapkan status awal player sebelum mulai bermain */
initPlayer :- 
	asserta(gold(0)),
	asserta(totalexp(0)), asserta(expCapacity(300)),
	asserta(lvlTotal(1)), asserta(lvlFisher(1)), asserta(lvlFarmer(1)), asserta(lvlRancher(1)),
	asserta(expTotal(0)), asserta(expFisher(0)), asserta(expFarmer(0)), asserta(expRancher(0)).

/* prepareJob: Menyiapkan inventory sesuai job (WIP) */
prepareJob(X) :- write('Anda mendapat alat-alat untuk '), write(X), nl.

/* status: Menulis stats player: job, level & exp total dan masing2 job */
status :- 
	write('=================='), nl,
	write('      STATUS'), nl,
	write('=================='), nl,
	write('Job: '), job(Job), write(Job), nl,
	write('Gold: '), gold(G), write(G), nl,
	write('Level: '), lvlTotal(Lvl), write(Lvl), nl,
	write('Exp: '), expTotal(ExpTotal), expCapacity(ExpCap), write(ExpTotal), write('/'), write(ExpCap), nl, nl,
	write('Level farming: '), lvlFarmer(LvlFarm), write(LvlFarm), nl,
	write('Exp farming: '), expFarmer(ExpFarm), write(ExpFarm),nl, nl,
	write('Level fishing: '), lvlFisher(LvlFish), write(LvlFish), nl,
	write('Exp fishing: '), expFisher(ExpFish), write(ExpFish), nl, nl,
	write('Level ranching: '), lvlRancher(LvlRanch), write(LvlRanch), nl,
	write('Exp ranching: '), expRancher(ExpRanch), write(ExpRanch), nl.