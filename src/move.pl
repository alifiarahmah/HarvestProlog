/* w: Bergerak ke utara 1 langkah */
w :-
	isShopping(0),
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
		T1 is T + 1,
		asserta(position(X, Y1)),
		asserta(time(T1)),
		Date is (T1//24) + 1,
		Hour is T1 mod 24,
		write('Current Date: '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

/* s: Bergerak ke selatan 1 langkah */
s :-
	isShopping(0),
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
		T1 is T + 1,
		asserta(position(X, Y1)),
		asserta(time(T1)),
		Date is (T1//24) + 1,
		Hour is T1 mod 24,
		write('Current Date: '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

/* d: Bergerak ke timur 1 langkah */
d :-
	isShopping(0),
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
		T1 is T + 1,
		asserta(position(X1, Y)),
		asserta(time(T1)),
		Date is (T1//24) + 1,
		Hour is T1 mod 24,
		write('Current Date: '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

/* a: Bergerak ke barat 1 langkah */
a :-
	isShopping(0),
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
		T1 is T + 1,
		asserta(position(X1, Y)),
		asserta(time(T1)),
		Date is (T1//24) + 1,
		Hour is T1 mod 24,
		write('Current Date: '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

outputPos :- position(X,Y), write(X), write(','), write(Y), nl.