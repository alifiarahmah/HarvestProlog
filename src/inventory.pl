:- dynamic(invenItem/3).
:- dynamic(equipment/3).
:- dynamic(ranchItem/3).
:- dynamic(sumItem/1).

/*invenItem(A,B,C) -> A nama, B quantity, C level (-1 if nontools) */
/* tools */
/*Dibuat angka dibelakang nama agar memudahkan pencatatan nama item di Inventory*/
equipment(shovel, 0, 0).    
equipment(fishing_rod, 0, 0).
equipment(handcarts, 0, 0).

/* seeds */
invenItem(tomato_seed, 0, -1).
invenItem(corn_seed, 0, -1).
invenItem(eggplant_seed, 0, -1).
invenItem(chilli_seed, 0, -1).
invenItem(apple_seed, 0, -1).
invenItem(pineapple_seed, 0, -1).
invenItem(grape_seed, 0, -1).
invenItem(turnip_seed, 0, -1).
invenItem(pomegranate_seed, 0, -1).
invenItem(strawberry_seed, 0, -1).

/*Fruit*/
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

/* product */
invenItem(chicken_egg, 0, -1).
invenItem(cow_milk, 0, -1).
invenItem(sheep_wool, 0, -1).
invenItem(goat_milk, 0, -1).
invenItem(duck_egg, 0, -1).
invenItem(horse_milk, 0, -1).
invenItem(angora_wool, 0, -1).
invenItem(buffalo_milk, 0, -1).

/* lifestock */
ranchItem(chicken, 0, -1).
ranchItem(cow, 0, -1).
ranchItem(sheep, 0, -1).
ranchItem(goat, 0, -1).
ranchItem(duck, 0, -1).
ranchItem(horse, 0, -1).
ranchItem(angora_rabbit, 0, -1).
ranchItem(buffalo, 0, -1).

/*Initial Nama Item*/
nameItem([tomato_seed, corn_seed, eggplant_seed, chilli_seed, apple_seed, pineapple_seed, grape_seed, turnip_seed, pomegranate_seed, strawberry_seed, tomato, corn, eggplant, chilli, apple, pineapple, grape, turnip, pomegranate, strawberry, tuna, salmon, catfish, musky, bass, bluegill, trout, carp, cod, pufferfish,chicken_egg,cow_milk, sheep_wool, goat_milk,duck_egg,horse_milk,angora_wool,buffalo_milk]).
nameRanch([chicken, cow, sheep, goat, duck, horse, angora_rabbit, buffalo]).
nameEquipment([shovel, fishing_rod, handcarts]).

/*Initial Jumlah Item*/
sumItem(0).

/*Insert First Elmn*/
insertFirst(List, Elmt, [Elmt|List]) :- !.

/*Search Item in Inventroy*/
srcItem([Head|_Tail], Name, Flag):-
    Head == Name,
    invenItem(Name, Amount, _),
    Amount =:= 0,
    Flag is 0.
srcItem([Head|_Tail], Name, Flag):-
    Head == Name,
    invenItem(Name, Amount, _),
    Amount > 0,
    Flag is 1.
srcItem([Head|Tail], Name, Flag):-
    Head \== Name,
    srcItem(Tail, Name, Flag).

srcEquipment([Head|_Tail], Name, Flag):-
    Head == Name,
    equipment(Name, Amount, _),
    Amount =:= 0,
    Flag is 0.
srcEquipment([Head|_Tail], Name, Flag):-
    Head == Name,
    equipment(Name, Amount, _),
    Amount > 0,
    Flag is 1.
srcEquipment([Head|Tail], Name, Flag):-
    Head \== Name,
    srcEquipment(Tail, Name, Flag).



/*AddItem to Inventory*/
addItemHelper(SumItem, Name, Amount, Level):-
    SumItem + Amount =< 100,
    invenItem(Name, PrevAmount,Level),
    CAmount is PrevAmount + Amount,
    CSum is SumItem + Amount,
    retractall(sumItem(_)),
    retract(invenItem(Name, PrevAmount, Level)),
    asserta(sumItem(CSum)),
    asserta(invenItem(Name, CAmount, Level)).
addItemHelper(SumItem, _Nama, Amount, _Level):- SumItem + Amount > 100, write('Your inventory can\'t hold all items. Inventory max capacity is 100.'),!.

addEquipmentHelper(SumItem, Name, Amount, Level):-
    SumItem + Amount =< 100,
    equipment(Name, PrevAmount,Level),
    CAmount is PrevAmount + Amount,
    CSum is SumItem + Amount,
    retractall(sumItem(_)),
    retract(equipment(Name, PrevAmount, Level)),
    asserta(sumItem(CSum)),
    asserta(equipment(Name, CAmount, Level)).
addEquipmentHelper(SumItem, _Nama, Amount, _Level):- SumItem + Amount > 100,write('Your inventory can\'t hold all items. Inventory max capacity is 100.'),!.

addItem(Name, Amount, Level) :- sumItem(Sum), addItemHelper(Sum, Name, Amount, Level).

addEquipment(Name, Amount, Level) :- sumItem(Sum), addEquipmentHelper(Sum, Name, Amount, Level).

addRanchItem(Name, Amount, Level):-
    ranchItem(Name, PrevAmount, Level),
    CAmount is PrevAmount + Amount,
    retract(ranchItem(Name, PrevAmount, Level)),
    asserta(ranchItem(Name, CAmount, Level)).

/*delete Item in Inventory*/
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

delItem(Name, _Amount, _Level) :-
    nameItem(List),
    srcItem(List, Name, Flag),
    Flag =:= 0,!.

delEquipment(Name, Amount, Level):-
    nameEquipment(List),
    srcEquipment(List, Name, Flag),
    Flag =:= 1,
    equipment(Name, PrevAmount, Level),
    sumItem(Sum),
    CurrenAmount is PrevAmount - Amount,
    CurrenSum is Sum - Amount,
    retract(sumItem(Sum)),
    retract(equipment(Name, PrevAmount, Level)),
    asserta(sumItem(CurrenSum)),
    asserta(equipment(Name, CurrenAmount, Level)).

delEquipment(Name, _Amount, _Level):-
    nameEquipment(List),
    srcEquipment(List, Name, Flag),
    Flag =:= 0,!.


/*Show The Inventory*/
inventoryItem([]):- !.
inventoryItem([Head|Tail]):-
    invenItem(Head, Amount, _),
    Amount =:= 0,
    inventoryItem(Tail).
inventoryItem([Head|Tail]):-
    invenItem(Head, Amount, Level),
    Amount > 0,
    Level =:= -1,
    write(Amount), write(' '), write(Head), nl,
    inventoryItem(Tail).
inventoryEquipment([]):- !.
inventoryEquipment([Head|Tail]):-
    equipment(Head, Amount, _),
    Amount =:= 0,
    inventoryEquipment(Tail).
inventoryEquipment([Head|Tail]):-
    equipment(Head, Amount, Level),
    Amount > 0,
    Level > 0,
    write(Amount), write(' Level '), write(Level),write(' '), write(Head), nl,
    inventoryEquipment(Tail).
inventory:-
    started(1),
    nl,
    sumItem(Sum),
    write('Your inventory ('), write(Sum), write('/100)'), nl,
    nameEquipment(ListEquipment),
    inventoryEquipment(ListEquipment),
    nameItem(ListItem),
    inventoryItem(ListItem),!.

/*Throw Item from Inventory*/
throwItemHelper2(Throw, Amount, Item, _Level):-
    Throw > Amount,
    write('You dont have enough '), write(Item), write('. Cancelling...'), nl.
throwItemHelper2(Throw, Amount, Item, _Level):-
    Throw <  Amount+1,
    delItem(Item, Throw,_),
    write('You throw away '), write(Throw), write(' '), write(Item), nl.
throwItemHelper2(Throw, Amount, Item, Level):-
    Throw <  Amount+1,
    delEquipment(Item, Throw,Level),
    write('You throw away '), write(Throw), write(' level '), write(Level), write(' '), write(Item), nl.

throwItemHelper(Item):-
    nameItem(List),
    srcItem(List, Item, Flag),
    Flag =:= 1,
    invenItem(Item, Amount, _Level),
    write('You have '), write(Amount), write(' '), write(Item), write('. How many do you want to throw?'),nl,
    write('> '), read(Throw),
    throwItemHelper2(Throw, Amount, Item,_Level).
throwItemHelper(Item):-
    nameEquipment(List),
    srcEquipment(List, Item, Flag),
    Flag =:= 1,
    equipment(Item, Amount, Level),
    write('You have '), write(Amount), write(' level '), write(Level), write(' '), write(Item), write('. How many do you want to throw?'),nl,
    write('> '), read(Throw),
    throwItemHelper2(Throw, Amount, Item, Level).
throwItemHelper(Item):-
    nameItem(List),
    srcItem(List, Item, Flag),
    Flag =:= 0, write('You don\'t have that item.'),!.
throwItemHelper(Item):-
    nameEquipment(List),
    srcEquipment(List, Item, Flag),
    Flag =:= 0, write('You don\'t have that item.'),!.

throwItem :-
    started(1),
    inventory,
    write('What do you want to throw ?'), nl,
    write('> '), read(Item), nl,
    throwItemHelper(Item).

    



    

    

