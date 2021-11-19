/* PROGRAM UTAMA */

/* External files */
:- include('player.pl').
:- include('misc.pl').

/* start: Mulai game baru dan inisialisasi gold, exp, level */
start :- 
	writeTitle, nl,
	write('Welcome to HarvestProlog! Choose your job.'), nl,
	write('1. Fisherman'), nl,
	write('2. Farmer'), nl,
	write('3. Rancher'), nl,
	write('> '), read_integer(X), nl, 
	chooseJob(X, Y), asserta(job(Y)),
	write('You choose '), write(Y), write('. Let\'s start.'), nl,
	initPlayer, prepareJob(Y).