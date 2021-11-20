/* DYNAMIC FACTS */
:- dynamic(marketplace/2).
:- dynamic(ranch/2).
:- dynamic(house/2).
:- dynamic(quest/2).
:- dynamic(air/2).

/* MAP */

panjang(16).
lebar(16).

createRandomMap :-
	retractall(marketplace(_,_)),
	retractall(ranch(_,_)),
	retractall(house(_,_)),
	retractall(quest(_,_)),
	retractall(air(_,_)),
	panjang(X),
	lebar(Y),
	X1 is X + 1, 
	Y1 is Y + 1,
	random(1,X1,XM),
	random(1,Y1,YM),
	asserta(marketplace(XM,YM)),
	random(1,X1,XR),
	random(1,Y1,YR),
	asserta(ranch(XR,YR)),
	random(1,X1,XH),
	random(1,Y1,YH),
	asserta(house(XH,YH)),
	random(1,X1,XQ),
	random(1,Y1,YQ),
	asserta(quest(XQ,YQ)),
	random(1,X1,XA),
	random(1,Y1,YA),
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
	ranch(XH, YH),
	X =:= XH,
	Y =:= YH.

isAtQuest(X,Y) :-
	ranch(XQ, YQ),
	X =:= XQ,
	Y =:= YQ.

isNearAir(X,Y) :-
	air(XA, YA),
	((X-1 =:= XA, Y =:= YA);
	(X+1 =:= XA, Y =:= YA);
	(X =:= XA, Y-1 =:= YA);
	(X =:= XA, Y+1 =:= YA)),
	!.

output :- 
	marketplace(IM,JM),ranch(IR,JR),house(IH,JH),quest(IQ,JQ),air(IA,JA),
	write(IM), write(','), write(JM), nl,
	write(IR), write(','), write(JR), nl,
	write(IH), write(','), write(JH), nl,
	write(IQ), write(','), write(JQ), nl,
	write(IA), write(','), write(JA), nl.

