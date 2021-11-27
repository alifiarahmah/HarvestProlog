:- dynamic(seed/5).
/*seed(A,B,C,D,E) => A nama seed, B waktu mulai, C lama waktu panen, D koodinat X, E Koordinat Y*/


/*timeSeed(A,B) => A nama seed B lama waktu untuk dipanen*/
timeSeed(tomato_seed, 5).
timeSeed(corn_seed, 7).
timeSeed(eggplant_seed, 3).
timeSeed(chilli_seed, 4).
timeSeed(apple_seed, 3).
timeSeed(pineapple_seed, 7).
timeSeed(grape_seed, 3).
timeSeed(turnip_seed, 3).
timeSeed(pomegranate_seed, 4).
timeSeed(strawberry_seed, 4).

/*seedHelper(A, B, C) => A nama seed, B nama buah yang dihasilkan, C lambang (pada saat ditanam) pada Map*/
seedHelper(tomato_seed, tomato, 't').
seedHelper(corn_seed, corn, 'c').
seedHelper(eggplant_seed, eggplant, 'e').
seedHelper(chilli_seed, chilli, 'c').
seedHelper(apple_seed, apple, 'a').
seedHelper(pineapple_seed, pineapple, 'p').
seedHelper(grape_seed, grape, 'g').
seedHelper(turnip_seed, turnip, 'n').
seedHelper(pomegranate_seed, pomegranate, 'm').
seedHelper(strawberry_seed, strawberry, 's').

/*farmExp(A,B) => A nama seed B EXP*/
farmExp(tomato_seed, 7).
farmExp(corn_seed, 8).
farmExp(eggplant_seed, 5).
farmExp(chilli_seed, 6).
farmExp(apple_seed, 5).
farmExp(pineapple_seed, 8).
farmExp(grape_seed, 5).
farmExp(turnip_seed, 5).
farmExp(pomegranate_seed, 6).
farmExp(strawberry_seed, 6).


nameSeed([tomato_seed, corn_seed, eggplant_seed, chilli_seed, apple_seed, pineapple_seed, grape_seed, turnip_seed, pomegranate_seed, strawberry_seed]).
dig :-
    position(X,Y),
    Y =:= 1,
    asserta(atDig(X,Y)),
    s,
    write('You digged the tile.'),nl.

dig :-
    position(X,Y),
    Y > 1,
    asserta(atDig(X,Y)),
    w,
    write('You digged the tile.'),nl.

displaySeed([]) :-!.
displaySeed([Head|Tail]):-
    invenItem(Head, Amount,_),
    Amount =:= 0,
    displaySeed(Tail).
displaySeed([Head|Tail]):-
    invenItem(Head, Amount,_),
    Amount > 0,
    write('- '), write(Amount), write(' '), write(Head), nl,
    displaySeed(Tail).


/*plant the seed*/
plant :-
    position(X,Y),
    X1 is X + 1,
    atDig(X1, Y),
    write('You have : '), nl,
    nameSeed(ListSeed),
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X1, Y)),
    seedHelper(nameSeed,_, Sim),
    asserta(atPlant(X1,Y, Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X1, Y)).

plant :-
    position(X,Y),
    X2 is X - 1,
    atDig(X2, Y),
    write('You have : '), nl,
    nameSeed(ListSeed),
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X2, Y)),
    seedHelper(NameSeed,_,Sim),
    asserta(atPlant(X2,Y,Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X2, Y)).

plant :-
    position(X,Y),
    Y1 is Y+1,
    atDig(X, Y1),
    write('You have : '), nl,
    nameSeed(ListSeed),
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X, Y1)),
    seedHelper(NameSeed,_,Sim),
    asserta(atPlant(X,Y1,Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X, Y1)).

plant :-
    position(X,Y),
    Y2 is Y-1,
    atDig(X, Y2),
    write('You have : '), nl,
    nameSeed(ListSeed),
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X, Y2)),
    seedHelper(NameSeed,_,Sim),
    asserta(atPlant(X,Y2, Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X, Y2)).

/*Sistem Exp Farm, jika Farmer 0*/
farmExpSistem(Exp):-
    job(X),
    X == 'Farmer',
    Exp1 is 0.25*Exp,
    SumEXP is Exp + round(Exp1),
    addExpFarmer(SumEXP).
farmExpSistem(Exp):-
    job(X),
    X \== 'Farmer',
    addExpFarmer(Exp).

/*Panen*/
harvest:-
    position(X, _Y),
    X1 is X+1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    X1 =:= Xseed,
    retract(atPlant(Xseed, Yseed,_)),
    random(1, 5, Am),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, Am, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * Am,
    farmExpSistem(SumEXP).
harvest:-
    position(X, _Y),
    X1 is X-1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    X1 =:= Xseed,
    retract(atPlant(Xseed, Yseed,_)),
    random(1, 5, Am),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, Am, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * Am,
    farmExpSistem(SumEXP).
harvest:-
    position(_X, Y),
    Y1 is Y+1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    Y1 =:= Yseed,
    retract(atPlant(Xseed, Yseed,_)),
    random(1, 5, Am),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, Am, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * Am,
    farmExpSistem(SumEXP).
harvest:-
    position(_X, Y),
    Y1 is Y-1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    Y1 =:= Yseed,
    retract(atPlant(Xseed, Yseed,_)),
    random(1, 5, Am),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, Am, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * Am,
    farmExpSistem(SumEXP).







    