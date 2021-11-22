:- dynamic(seed/5).
/*seed(A,B,C,D,E) => A nama seed, B waktu mulai, C lama waktu panen, D koodinat X, E Koordinat Y*/


/*timeSeed(A,B) => A nama seed B lama waktu untuk dipanen*/
timeSeed(tomato,10).
timeSeed(corn, 6).
timeSeed(eggplant, 12).
timeSeed(chilli, 8).
timeSeed(apple, 24).
timeSeed(pineapple, 20).
timeSeed(grape, 20).
timeSeed(turnip, 18).
timeSeed(pomegranate, 15).
timeSeed(strawberry, 20).


nameSeed([tomato, corn, eggplant, chilli, apple, pineapple, grape, turnip, pomegranate, strawberry]).
dig :-
    position(X,Y),
    asserta(atDig(X,Y)),
    w,
    write('You digged the tile.'),nl.

displaySeed([]) :-!.

displaySeed([Head|Tail]):-
    invenItem(Head, Amount,_),
    Amount > 0,
    write('- '), write(Amount), write(' '), write(Head), write(' seed'), nl,
    displaySeed(Tail).


/*ada Masalah dalam Menampilkan Seed*/
plant :-
    position(X,Y),
    X1 is X + 1,
    atDig(X1, Y),
    write('You have : '), nl,
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X1, Y)),
    asserta(atPlant(X1,Y)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X1, Y)).

plant :-
    position(X,Y),
    X2 is X - 1,
    atDig(X2, Y),
    write('You have : '), nl,
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X2, Y)),
    asserta(atPlant(X2,Y)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X2, Y)).

plant :-
    position(X,Y),
    Y1 is Y+1,
    atDig(X, Y1),
    write('You have : '), nl,
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X, Y1)),
    asserta(atPlant(X,Y1)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X, Y1)).

plant :-
    position(X,Y),
    Y2 is Y-1,
    atDig(X, Y2),
    write('You have : '), nl,
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X, Y2)),
    asserta(atPlant(X,Y2)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X, Y2)).
/*
harvest:-
    position(X, Y),
    X1 is X+1,
    seed(Name, T1, T, Xseed, Yseed),
    X1 =:= Xseed,
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,*/






    