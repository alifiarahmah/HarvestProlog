/* Deklarasi dynamic angka */
:- dynamic(chicken/1).
:- dynamic(chicken_egg/1).
:- dynamic(cow/1).
:- dynamic(cow_milk/1).
:- dynamic(sheep/1).
:- dynamic(sheep_wool/1).
:- dynamic(goat/1).
:- dynamic(goat_milk/1).
:- dynamic(duck/1).
:- dynamic(duck_egg/1).
:- dynamic(horse/1).
:- dynamic(horse_milk/1).
:- dynamic(angora_rabbit/1).
:- dynamic(angora_wool/1).
:- dynamic(buffalo/1).
:- dynamic(buffalo_milk/1).

/* initRanch: inisialisasi banyak hewan ternak */
initRanch :- 
	job(X), X \= rancher,
	asserta(chicken(0)),
	asserta(chicken_egg(0)),
	asserta(cow(0)),
	asserta(cow_milk(0)),
	asserta(sheep(0)),
	asserta(sheep_wool(0)),
	asserta(goat(0)),
	asserta(goat_milk(0)),
	asserta(duck(0)),
	asserta(duck_egg(0)),
	asserta(horse(0)),
	asserta(horse_milk(0)),
	asserta(angora_rabbit(0)),
	asserta(angora_wool(0)),
	asserta(buffalo(0)),
	asserta(buffalo_milk(0)).

initRanch :- 
	job(X), X = rancher,
	asserta(chicken(2)),
	asserta(cow(1)),
	asserta(sheep(1)),
	asserta(goat(0)),
	asserta(duck(0)),
	asserta(horse(0)),
	asserta(angora_rabbit(0)),
	asserta(buffalo(0)).

/* checkInRanch: cek apakah posisi pemain di tile ranch */
checkInRanch :- position(X, Y), ranch(A, B), X = A, Y = B.

/* ranch: antarmuka jumlah hewan ternak */
ranch :-
	checkInRanch,
	write('Welcome to the ranch! You have:'), nl,
	chicken(X), write(X), write(' chicken'), nl,
	cow(X), write(X), write(' cow'), nl,
	sheep(X), write(X), write(' sheep'), nl,
	goat(X), write(X), write(' goat'), nl,
	duck(X), write(X), write(' duck'), nl,
	horse(X), write(X), write(' horse'), nl,
	angora_rabbit(X), write(X), write(' angora rabbit'), nl,
	buffalo(X), write(X), write(' buffalo'), nl, nl,
	write('What do you want to do?'), nl.

/* chicken: cek ayam */

chicken :- 
	checkInRanch,
	chicken_egg(Y), Y = 0, 
	write('Your chicken hasn\'t lay any eggs.'), nl,
	write('Please check again later.'), nl.

chicken :- 
	checkInRanch,
	chicken_egg(Y), Y > 0, 
	write('Your chicken lays '), write(Y), write(' eggs.'), nl,
	addItem(chicken_egg, Y, -1),
	retract(chicken_egg(Y)), asserta(chicken_egg(0)),
	write('You got '), write(Y), write('eggs!'),
	ExpRanch is Y * 3, /* TODO: tambah data exp tiap dapet telor di player */
	addExpRancher(ExpRanch),
	write('You gained '), write(ExpRanch), (' ranching EXP!'), nl.