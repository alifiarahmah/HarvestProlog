:- dynamic(invenItem/3).
:- dynamic(nameItem/1).
:- dynamic(sumItem/1).

/*invenItem(A,B,C) -> A nama, B quantity, C level (-1 if nontools) */
/* tools */
/*Dibuat angka dibelakang nama agar memudahkan pencatatan nama item di Inventory*/
invenItem(shovel1, 0, 1).    
invenItem(fishing_rod1, 0, 1).
invenItem(handcarts1, 0, 1).
invenItem(shovel2, 0, 2).
invenItem(fishing_rod2, 0, 2).
invenItem(handcarts2, 0, 2).
invenItem(shovel3, 0, 3).
invenItem(fishing_rod3, 0, 3).
invenItem(handcarts3, 0, 3).

/* seeds */
invenItem(tomato, 0, -1).
invenItem(corn, 0, -1).
invenItem(eggplant, 0, -1).
invenItem(chilli, 0, -1).
invenItem(apple, 0, -1).
invenItem(pineapple, 0, -1).
invenItem(grape, 0, -1).
invenItem(turnip, 0, -1).
invenItem(pomegranate, 0, -1).
invenItem(strawberry, 0, -1).

/* fish */
invenItem(tuna, 0, -1).
invenItem(salmon, 0, -1).
invenItem(catfish, 0, -1).
invenItem(musky, 0, -1).
invenItem(bass, 0, -1).
invenItem(bluegill, 0, -1).
invenItem(trout, 0, -1).
invenItem(carp, 0, -1).
invenItem(cod, 0, -1).
invenItem(pufferfish, 0, -1).

/* lifestock */
invenItem(chicken, 0, -1).
invenItem(cow, 0, -1).
invenItem(sheep, 0, -1).
invenItem(goat, 0, -1).
invenItem(duck, 0, -1).
invenItem(horse, 0, -1).
invenItem(angora_rabbit, 0, -1).
invenItem(buffalo, 0, -1).

/* product */
invenItem(chicken_egg, 0, -1).
invenItem(cow_milk, 0, -1).
invenItem(sheep_wool, 0, -1).
invenItem(goat_milk, 0, -1).
invenItem(duck_egg, 0, -1).
invenItem(horse_milk, 0, -1).
invenItem(angora_wool, 0, -1).
invenItem(buffalo_milk, 0, -1).

/*Initial Nama Item*/
nameItem([]).

/*Initial Jumlah Item*/
sumItem(0).

srcItem([], _Name, Flag) :- Flag is 0, !.
srcItem([A|_], Name, Flag) :- A == Name, Flag is 1, !.
srcItem([Head|Tail], Name, Flag) :- 
    Head \== Name,
    srcItem(Tail, Name, Flag).

insertFirst(List, Elmt, [Elmt|List]) :- !.

addItem(Name, Amount, Level) :-
    nameItem(List),
    srcItem(List, Name, Flag),
    Flag =:= 1,
    invenItem(Name, PrevAmount, Level),
    sumItem(Sum),
    CurrenAmount is PrevAmount + Amount,
    CurrenSum is Sum + Amount,
    retract(sumItem(Sum)),
    retract(invenItem(Name, PrevAmount, Level)),
    asserta(sumItem(CurrenSum)),
    asserta(invenItem(Name, CurrenAmount, Level)).

addItem(Name, Amount, Level) :-
    nameItem(List),
    srcItem(List, Name, Flag),
    Flag =:= 0,
    retract(nameItem(List)),
    insertFirst(List, Name, Result),
    asserta(nameItem(Result)),
    invenItem(Name, PrevAmount, Level),
    sumItem(Sum),
    CurrenSum is Sum + Amount,
    retract(sumItem(Sum)),
    retract(invenItem(Name, PrevAmount, Level)),
    asserta(sumItem(CurrenSum)),
    asserta(invenItem(Name, Amount, Level)).

delItem(Name, Amount, Level) :-
    nameItem(List),
    srcItem(List, Name, Flag),
    Flag =:= 1,
    invenItem(Name, PrevAmount, Level),
    sumItem(Sum),
    CurrenAmount is PrevAmount - Amount,
    CurrenSum is Sum - Amount,
    retract(sumItem(Sum)),
    retract(invenItem(Name, PrevAmount, Level)),
    asserta(sumItem(CurrenSum)),
    asserta(invenItem(Name, CurrenAmount, Level)).

delItem(Name, Amount, Level) :-
    nameItem(List),
    srcItem(List, Name, Flag),
    Flag =:= 0,
    retract(nameItem(List)),
    insertFirst(List, Name, Result),
    asserta(nameItem(Result)),
    invenItem(Name, PrevAmount, Level),
    sumItem(Sum),
    CurrenSum is Sum - Amount,
    retract(sumItem(Sum)),
    retract(invenItem(Name, PrevAmount, Level)),
    asserta(sumItem(CurrenSum)),
    asserta(invenItem(Name, Amount, Level)).


/*Kalau menggunakan shovel1, bermasalah nanti saat print ke layar*/
inventory([]):- !.
inventory([Head|Tail]):-
    invenItem(Head, Amount, Level),
    Amount > 0,
    Level > 0,
    write(Amount), write(' Level '), write(Level),write(' '), write(Head), nl,
    inventory(Tail).
inventory([Head|Tail]):-
    invenItem(Head, Amount, Level),
    Amount > 0,
    Level =:= -1,
    write(Amount), write(' '), write(Head), nl,
    inventory(Tail).
inventory:-
    nl,
    sumItem(Sum),
    write('Your inventory ('), write(Sum), write('/100)'), nl,
    nameItem(List),
    inventory(List).


throwItem(Throw, Amount, Item):-
    Throw > Amount,
    write('You dont have enough '), write(Item), write('. Cancelling...'), nl.

throwItem(Throw, Amount, Item):-
    Throw <  Amount+1,
    retract(invenItem(Item, Amount, _)),
    Camount is Amount - Throw,
    asserta(invenItem(Item,Camount, _)),
    sumItem(Sum),
    Csum is Sum - Throw,
    retract(sumItem(Sum)),
    asserta(sumItem(Csum)),
    write('You throw away '), write(Throw), write(' '), write(Item), nl.

throwItem :-
    inventory,
    write('What do you want to throw ?'), nl,
    write('> '), read(Item), nl,
    invenItem(Item, Amount, _),
    write('You have '), write(Amount), write(' '), write(Item), write('. How many do you want to throw?'),nl,
    write('> '), read(Throw),
    throwItem(Throw, Amount, Item).



    

    

