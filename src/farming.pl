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
/*Melakukan Commad dig*/
dig :-
    started(1),
    position(X,Y),
    Y =:= 1,
    \+isAtMarketplace(X,Y), \+isAtRanch(X,Y), \+isAtHouse(X,Y), \+isAtQuest(X,Y), \+isAtAir(X,Y), \+atDig(X,Y), \+atPlant(X,Y, _Sim),
    asserta(atDig(X,Y)),
    s,
    write('You digged the tile.'),nl.

dig :-
    started(1),
    position(X,Y),
    Y > 1,
    \+isAtMarketplace(X,Y), \+isAtRanch(X,Y), \+isAtHouse(X,Y), \+isAtQuest(X,Y), \+isAtAir(X,Y), \+atDig(X,Y), \+atPlant(X,Y, _Sim),
    asserta(atDig(X,Y)),
    X1 is X - 1,
    X2 is X + 1,
    Y1 is Y - 1,
    Y2 is Y + 1,
    (   \+isAtAir(X, Y1) ->
        w
    ;   \+isAtAir(X1, Y) ->
        a
    ;   \+isAtAir(X2, Y) ->
        d
    ;   \+isAtAir(X, Y2) ->
        s
    ),
    write('You digged the tile.'),nl.

/*Menampilkan seed yang ada di Inventory*/
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

/*Mengetahui Jumlah Seed di Inventory*/
seedInInventory([Head|Tail], SumSeed):-
    Tail == [],
    invenItem(Head, Amount,_),
    SumSeed is Amount, !.
seedInInventory([Head|Tail], SumSeed):-
    invenItem(Head, Amount, _),
    seedInInventory(Tail, SumSeed1),
    SumSeed is Amount + SumSeed1.


/*plant the seed*/
/*Jika belum punya seed*/
plant :-
    started(1),
    nameSeed(ListSeed),
    seedInInventory(ListSeed, SumSeed),
    SumSeed =:= 0,
    write('You Have\'t  any seed.'), !.
/*Jika sudah punya seed*/
plant :-
    started(1),
    nameSeed(ListSeed),
    seedInInventory(ListSeed, SumSeed),
    SumSeed > 0,
    position(X,Y),
    X1 is X + 1,
    atDig(X1, Y),
    write('You have : '), nl,
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X1, Y)),
    seedHelper(NameSeed,_, Sim),
    asserta(atPlant(X1,Y, Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X1, Y)), !.

plant :-
    started(1),
    nameSeed(ListSeed),
    seedInInventory(ListSeed, SumSeed),
    SumSeed > 0,
    position(X,Y),
    X2 is X - 1,
    atDig(X2, Y),
    write('You have : '), nl,
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X2, Y)),
    seedHelper(NameSeed,_,Sim),
    asserta(atPlant(X2,Y,Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X2, Y)), !.

plant :-
    started(1),
    nameSeed(ListSeed),
    seedInInventory(ListSeed, SumSeed),
    SumSeed > 0,
    position(X,Y),
    Y1 is Y+1,
    atDig(X, Y1),
    write('You have : '), nl,
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X, Y1)),
    seedHelper(NameSeed,_,Sim),
    asserta(atPlant(X,Y1,Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X, Y1)), !.

plant :-
    started(1),
    nameSeed(ListSeed),
    seedInInventory(ListSeed, SumSeed),
    SumSeed > 0,
    position(X,Y),
    Y2 is Y-1,
    atDig(X, Y2),
    write('You have : '), nl,
    displaySeed(ListSeed),
    write('What do you want to plant?'), nl,
    read(NameSeed),
    delItem(NameSeed, 1, -1),
    retract(atDig(X, Y2)),
    seedHelper(NameSeed,_,Sim),
    asserta(atPlant(X,Y2, Sim)),
    time(T),
    timeSeed(NameSeed, Time),
    asserta(seed(NameSeed, T, Time, X, Y2)), !.

/*Sistem Exp Farm, jika Farmer 0*/
farmExpSistem(Exp):-
    job(X),
    X == 'Farmer',
    Exp1 is 0.25*Exp,
    SumEXP is Exp + round(Exp1),
    writeAddExpFarmer(SumEXP).
farmExpSistem(Exp):-
    job(X),
    X \== 'Farmer',
    writeAddExpFarmer(Exp).

/*Jumlah panen berdasarkan level*/
harvestHelper(AmountItem):-
    lvlFarmer(Level),
    Level < 4,
    random(1, 3, Am),
    AmountItem is Am.
harvestHelper(AmountItem):-
    lvlFarmer(Level),
    Level > 3, Level < 8,
    random(3, 5, Am),
    AmountItem is Am.
harvestHelper(AmountItem):-
    lvlFarmer(Level),
    Level >7,
    random(5, 7, Am),
    AmountItem is Am.

/*Panen*/
/*Belum dapat dipanen*/
harvest:-
    started(1),
    position(X, _Y),
    X1 is X+1,
    seed(_NameSeed, T1, T, Xseed, _Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime < Ttotal,
    X1 =:= Xseed,
    write('You Can\'t Harvest yet.'), !.
harvest:-
    started(1),
    position(X, _Y),
    X1 is X-1,
    seed(_NameSeed, T1, T, Xseed, _Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime < Ttotal,
    X1 =:= Xseed,
    write('You Can\'t Harvest yet.'), !.
harvest:-
    started(1),
    position(_X, Y),
    Y1 is Y+1,
    seed(_NameSeed, T1, T, _Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime < Ttotal,
    Y1 =:= Yseed,
    write('You Can\'t Harvest yet.'), !.
harvest:-
    started(1),
    position(_X, Y),
    Y1 is Y-1,
    seed(_NameSeed, T1, T, _Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime < Ttotal,
    Y1 =:= Yseed,
    write('You Can\'t Harvest yet.'), !.

/*Sudah Dapat dipanen*/
harvest:-
    started(1),
    position(X, _Y),
    X1 is X+1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    X1 =:= Xseed,
    retract(atPlant(Xseed, Yseed,_)),
    harvestHelper(AmountItem),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, AmountItem, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * AmountItem,
    farmExpSistem(SumEXP), !.
harvest:-
    started(1),
    position(X, _Y),
    X1 is X-1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    X1 =:= Xseed,
    retract(atPlant(Xseed, Yseed,_)),
    harvestHelper(AmountItem),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, AmountItem, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * AmountItem,
    farmExpSistem(SumEXP), !.
harvest:-
    started(1),
    position(_X, Y),
    Y1 is Y+1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    Y1 =:= Yseed,
    retract(atPlant(Xseed, Yseed,_)),
    harvestHelper(AmountItem),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, AmountItem, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * AmountItem,
    farmExpSistem(SumEXP), !.
harvest:-
    started(1),
    position(_X, Y),
    Y1 is Y-1,
    seed(NameSeed, T1, T, Xseed, Yseed),
    time(CTime),
    Ttotal is T1 + T,
    CTime > Ttotal,
    Y1 =:= Yseed,
    retract(atPlant(Xseed, Yseed,_)),
    harvestHelper(AmountItem),
    seedHelper(NameSeed, NameFruit,_),
    addItem(NameFruit, AmountItem, -1),
    retract(seed(NameSeed, T1, T, Xseed, Yseed)),
    write('You Haversted '), write(NameFruit), nl,
    farmExp(NameSeed, FEXP),
    SumEXP is FEXP * AmountItem,
    farmExpSistem(SumEXP), !.







    