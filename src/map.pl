/* DYNAMIC FACTS */
:- dynamic(marketplace/2).
:- dynamic(ranch/2).
:- dynamic(house/2).
:- dynamic(quest/2).
:- dynamic(air/2).
:- dynamic(atDig/2).
:- dynamic(atPlant/2).
/* MAP */

panjang(16).
lebar(16).

createRandomMap :-
	retractall(marketplace(_,_)),
	retractall(ranch(_,_)),
	retractall(house(_,_)),
	retractall(quest(_,_)),
	retractall(air(_,_)),
	/*panjang(X),
	lebar(Y),
	X1 is X + 1, 
	Y1 is Y + 1,*/
	random(1,5,XM),
	random(1,5,YM),
	asserta(marketplace(XM,YM)),
	random(1,6,XR),
	random(6,16,YR),
	asserta(ranch(XR,YR)),
	random(6,8,XH),
	random(1,10,YH),
	asserta(house(XH,YH)),
	random(8,15,XQ),
	random(14,17,YQ),
	asserta(quest(XQ,YQ)),
	random(9,13,XA),
	random(2,10,YA),
	YA1 is YA + 1,
	YA2 is YA + 2,
	YA3 is YA - 1,
	YA4 is YA + 3,
	XA1 is XA + 1,
	XA2 is XA + 2,
	asserta(air(YA,XA)),
	asserta(air(YA1,XA)),
	asserta(air(YA2,XA)),
	asserta(air(YA3,XA1)),
	asserta(air(YA,XA1)),
	asserta(air(YA1,XA1)),
	asserta(air(YA2,XA1)),
	asserta(air(YA4,XA1)),
	asserta(air(YA,XA2)),
	asserta(air(YA1,XA2)),
	asserta(air(YA2,XA2)).

isAtMarketplace(X,Y) :-
	marketplace(XM, YM),
	X =:= XM,
	Y =:= YM.

isAtRanch(X,Y) :-
	ranch(XR, YR),
	X =:= XR,
	Y =:= YR.

isAtHouse(X,Y) :-
	house(XH, YH),
	X =:= XH,
	Y =:= YH.

isAtQuest(X,Y) :-
	quest(XQ, YQ),
	X =:= XQ,
	Y =:= YQ.

isAtAir(X,Y) :-
	air(XA, YA),
	X =:= XA,
	Y =:= YA.

isNearAir(X,Y) :-
	air(XA, YA),
	((X-1 =:= XA, Y =:= YA);
	(X+1 =:= XA, Y =:= YA);
	(X =:= XA, Y-1 =:= YA);
	(X =:= XA, Y+1 =:= YA)),
	!.

isSide(X,Y) :- 
	panjang(P),
	lebar(L),
	P1 is P + 1,
	L1 is L + 1,
	(X =:= 0; X =:= P1; Y =:= 0; Y =:= L1).

isPlayer(X,Y):-
	position(X,Y).

isBlank(X,Y) :-
	\+isAtMarketplace(X,Y), \+isAtRanch(X,Y), \+isAtHouse(X,Y), \+isAtQuest(X,Y), \+isAtAir(X,Y), \+isSide(X,Y), \+isPlayer(X,Y), \+atDig(X,Y), \+atPlant(X,Y).

writeS(X,Y) :- \+isPlayer(X,Y), isAtMarketplace(X,Y), write('M'), !.
writeS(X,Y) :- \+isPlayer(X,Y), isAtRanch(X,Y), write('R'), !.
writeS(X,Y) :- \+isPlayer(X,Y), isAtHouse(X,Y), write('H'), !.
writeS(X,Y) :- \+isPlayer(X,Y), isAtQuest(X,Y), write('Q'), !.
writeS(X,Y) :- \+isPlayer(X,Y), isAtAir(X,Y), write('o'), !.
writeS(X,Y) :- \+isPlayer(X,Y), isSide(X,Y), panjang(P), X =\= P + 1, write('#'), !.
writeS(X,Y) :- \+isPlayer(X,Y), isSide(X,Y), panjang(P), X =:= P + 1, write('#'), nl, !.
writeS(X,Y) :- isPlayer(X,Y), write('P'), !.
writeS(X,Y) :- isBlank(X,Y), write('-'), !.
writeS(X,Y) :- atDig(X, Y), write('='),!.
writeS(X,Y) :- atPlant(X,Y), write('f'),!.

displayMap(K) :- panjang(P), lebar(L), P2 is (P + 2), L2 is (L + 2), K =:= (P2*L2), nl, !.

displayMap(K) :-
	panjang(P),
	P2 is (P + 2),
	X1 is (K mod P2),
	Y1 is (K // P2),
	writeS(X1,Y1),
	K1 is K + 1,
	displayMap(K1).

output :- 
	marketplace(IM,JM),ranch(IR,JR),house(IH,JH),quest(IQ,JQ),air(IA,JA),
	write(IM), write(','), write(JM), nl,
	write(IR), write(','), write(JR), nl,
	write(IH), write(','), write(JH), nl,
	write(IQ), write(','), write(JQ), nl,
	write(IA), write(','), write(JA), nl.
