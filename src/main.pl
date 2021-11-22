/* DYNAMIC FACTS */
:- dynamic(started/1).
:- dynamic(time/1).
:- dynamic(position/2).

/* PROGRAM UTAMA */

/* External files */
:- include('player.pl').
:- include('misc.pl').
:- include('map.pl').
:- include('move.pl').
:- include('quest.pl').
:- include('inventory.pl').
:- include('farming.pl').

/* startGame: Menu awal game */
started(0).
startGame :-
	started(X),
	X =:= 0,
	retractall(started(_)),
	asserta(started(1)),
	initTime,
	createRandomMap,
	initPosition,
	writeTitleV2, nl,
	write('Harvest Star!!!'), nl, nl,
	write('Let\'s play and pay our debts together!'), nl, nl,
	writeCommandList, nl.

/* initTime */
initTime :- 
	retractall(time(_)),
	asserta(time(0.0)).

/* initPosition */
initPosition :- 
	house(X,Y),
	retractall(position(_,_)),
	asserta(position(X,Y)).
	
/* start: Mulai game baru dan inisialisasi gold, exp, level */
start :- 
	started(X),
	X =:= 1,
	write('Welcome to HarvestProlog! Choose your job.'), nl,
	write('1. Fisherman'), nl,
	write('2. Farmer'), nl,
	write('3. Rancher'), nl,
	write('> '), read_integer(X), nl, 
	chooseJob(X, Y), asserta(job(Y)),
	write('You choose '), write(Y), write('. Let\'s start.'), nl,
	initPlayer, prepareJob(Y).

/* map: Menampilkan map */
map :- 
	started(X),
	X =:= 1,
	displayMap(0).

/* help: Menampilkan command yang bisa dilakukan */
help :- writeCommandList.

	
	