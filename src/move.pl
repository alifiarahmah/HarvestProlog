/* w: Bergerak ke utara 1 langkah */
w :-
	position(X,Y),
	Y1 is Y - 1,
	(	Y =:= 1 ->
		write('You are not able to enter the border area'), nl,
		fail
	;	isAtAir(X, Y1) ->
		write('You are not able to enter the water area'), nl,
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
		write('You are not able to enter the border area'), nl,
		fail
	;	isAtAir(X, Y1) ->
		write('You are not able to enter the water area'), nl,
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
		write('You are not able to enter the border area'), nl,
		fail
	;	isAtAir(X1, Y) ->
		write('You are not able to enter the water area'), nl,
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
		write('You are not able to enter the border area'), nl,
		fail
	;	isAtAir(X1, Y) ->
		write('You are not able to enter the water area'), nl,
		fail
	;	time(T),
		retractall(position(_,_)),
		retractall(time(_)),
		T1 is T + 0.5,
		asserta(position(X1, Y)),
		asserta(time(T1))
	).

outputPos :- position(X,Y), write(X), write(','), write(Y), nl.