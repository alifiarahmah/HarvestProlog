/* DYNAMIC FACTS */
:- dynamic(started/1).
:- dynamic(time/1).
:- dynamic(position/2).

/* PROGRAM UTAMA */

/* External files */
:- include('player.pl').
:- include('misc.pl').
:- include('map.pl').

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

/* w: Bergerak ke utara 1 langkah */
w :-
	position(X,Y),
	Y1 is Y - 1,
	(	Y =:= 1 ->
		write('Ada batas di utara, tidak bisa bergerak ke utara'), nl,
		fail
	;	isAtAir(X, Y1) ->
		write('Ada air di utara, tidak bisa bergerak ke utara'), nl,
		fail
	;	time(T),
		retractall(position(_,_)),
		retractall(time(_)),
		T1 is T + 0.5,
		asserta(position(X, Y1)),
		asserta(time(T1))
	).

/* s: Bergerak ke selatan 1 langkah */
s :-
	position(X,Y),
	Y1 is Y + 1,
	lebar(L),
	(	Y =:= L ->
		write('Ada batas di selatan, tidak bisa bergerak ke selatan'), nl,
		fail
	;	isAtAir(X, Y1) ->
		write('Ada air di selatan, tidak bisa bergerak ke selatan'), nl,
		fail
	;	time(T),
		retractall(position(_,_)),
		retractall(time(_)),
		T1 is T + 0.5,
		asserta(position(X, Y1)),
		asserta(time(T1))
	).

/* d: Bergerak ke timur 1 langkah */
d :-
	position(X,Y),
	X1 is X + 1,
	panjang(P),
	(	X =:= P ->
		write('Ada batas di timur, tidak bisa bergerak ke timur'), nl,
		fail
	;	isAtAir(X1, Y) ->
		write('Ada air di timur, tidak bisa bergerak ke timur'), nl,
		fail
	;	time(T),
		retractall(position(_,_)),
		retractall(time(_)),
		T1 is T + 0.5,
		asserta(position(X1, Y)),
		asserta(time(T1))
	).

/* a: Bergerak ke barat 1 langkah */
a :-
	position(X,Y),
	X1 is X - 1,
	(	X =:= 1 ->
		write('Ada batas di barat, tidak bisa bergerak ke barat'), nl,
		fail
	;	isAtAir(X1, Y) ->
		write('Ada air di barat, tidak bisa bergerak ke barat'), nl,
		fail
	;	time(T),
		retractall(position(_,_)),
		retractall(time(_)),
		T1 is T + 0.5,
		asserta(position(X1, Y)),
		asserta(time(T1))
	).

outputPos :- position(X,Y), write(X), write(','), write(Y), nl.
	
	