/* DYNAMIC FACTS */
:- dynamic(started/1).
:- dynamic(time/1).
:- dynamic(position/2).

/* PROGRAM UTAMA */

/* External files */
:- include('player.pl').
:- include('misc.pl').
:- include('map.pl').
:- include('items.pl').
:- include('command.pl').
:- include('quest.pl').
:- include('inventory.pl').
:- include('farming.pl').
:- include('ranching.pl').
:- include('fishing.pl').

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
	write('HarvestProlog!!!'), nl, nl,
	write('Let\'s play and pay our debts together!'), nl, nl,
	writeCommandList, nl.

/* initTime */
initTime :- 
	retractall(time(_)),
	asserta(time(1420)).

/* initPosition */
initPosition :- 
	house(X,Y),
	retractall(position(_,_)),
	asserta(position(X,Y)).
	
/* start: Mulai game baru dan inisialisasi gold, exp, level */
start :- 
	started(M),
	M =:= 1,
	write('Welcome to HarvestProlog! Choose your job.'), nl,
	write('1. Fisherman'), nl,
	write('2. Farmer'), nl,
	write('3. Rancher'), nl,
	write('> '), read_integer(X), nl,
	chooseJob(X, Y), asserta(job(Y)),
	write('You choose '), write(Y), write('. Let\'s start.'), nl,
	initPlayer,
	retractall(initiated(_)),
	asserta(initiated(1)),
	!.

/* map: Menampilkan map */
map :- 
	started(X),
	X =:= 1,
	displayMap(0).

/* help: Menampilkan command yang bisa dilakukan */
help :- started(0), writeHelpListV1, !.
help :- started(1), writeHelpListV2, !.

/* goal and final State */

goalState :- 
	gold(X),
	X < 20000,
	!.
goalState :- 
	gold(X),
	X >= 20000,
	nl, write('Congratulations! You have finally collected 20000 golds!'), nl,
	done.

failState :-
    time(T),
    T < 1440,
    !.

failState :-
    time(T),
    gold(G),
    T >= 1440, 
    G < 20000,
    nl, write('You have worked hard, but in the end result is all that matters.'), nl,
    write('May God bless you in the future with kind people!'), nl,
    done.

done :- 
	retractall(started(_)),
	quit1,
	asserta(started(0)).

	
	