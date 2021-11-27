/* RANCHING */

/* Deklarasi fakta EXP yang didapat per hasil ternak */
exp_chicken(3).
exp_cow(10).
exp_sheep(10).
exp_goat(15).
exp_duck(5).
exp_horse(10).
exp_angora(15).
exp_buffalo(15).

/* checkInRanch: cek apakah posisi pemain di tile ranch */
checkInRanch :- position(X, Y), isAtRanch(X,Y).

/* ranch: antarmuka jumlah hewan ternak */
ranch :-
	\+checkInRanch,
	write('You are not in ranch!'), nl,
	!.
ranch :-
	checkInRanch,
	write('Welcome to the ranch! You have:'), nl,
	invenItem(chicken, ChickenAmount, -1),
	invenItem(cow, CowAmount, -1),
	invenItem(sheep, SheepAmount, -1),
	invenItem(goat, GoatAmount, -1),
	invenItem(duck, DuckAmount, -1),
	invenItem(horse, HorseAmount, -1),
	invenItem(angora_rabbit, AngoraAmount, -1),
	invenItem(buffalo, BuffaloAmount, -1),
	write(ChickenAmount), write(' chicken'), nl,
	write(CowAmount), write(' cow'), nl,
	write(SheepAmount), write(' sheep'), nl,
	write(GoatAmount), write(' goat'), nl,
	write(DuckAmount), write(' duck'), nl,
	write(HorseAmount), write(' horse'), nl,
	write(AngoraAmount), write(' angora rabbit'), nl,
	write(BuffaloAmount), write(' buffalo'), nl, nl,
	write('What do you want to do?'), nl.

