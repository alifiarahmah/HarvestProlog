/* DYNAMIC FACTS */
:- dynamic(isShopping/1).
:- dynamic(upgradeList/1).

/* tools */

/* equipmentUpgrade(A,B,C,D) A: Name, B: Level awal, C: Level akhir, D: Harga upgrade */
equipmentUpgrade(shovel, 0, 1, 200).
equipmentUpgrade(shovel, 1, 2, 500).
equipmentUpgrade(shovel, 2, 3, 1000).
equipmentUpgrade(fishing_rod, 0, 1, 200).
equipmentUpgrade(fishing_rod, 1, 2, 500).
equipmentUpgrade(fishing_rod, 2, 3, 1000).
equipmentUpgrade(handcarts, 0, 1, 200).
equipmentUpgrade(handcarts, 1, 2, 500).
equipmentUpgrade(handcarts, 2, 3, 1000).

/* seeds */

items(tomato_seed, 150).
items(corn_seed, 250).
items(eggplant_seed, 70).
items(chilli_seed, 100).
items(apple_seed, 70).
items(pineapple_seed, 250).
items(grape_seed, 70).
items(turnip_seed, 70).
items(pomegranate_seed, 100).
items(strawberry_seed, 100).

/*Fruit*/
items(tomato, 200).
items(corn, 300).
items(eggplant, 120).
items(chilli, 150).
items(apple, 120).
items(pineapple, 300).
items(grape, 120).
items(turnip, 120).
items(pomegranate, 150).
items(strawberry, 150).

/* fish */
items(catfish, 20).
items(tuna, 50).
items(salmon, 50).
items(musky, 50).
items(bluegill, 50).
items(carp, 50).
items(bass, 80).
items(trout, 80).
items(cod, 80).
items(pufferfish, 80).

/* lifestock */

items(chicken, 500).
items(cow, 3000).
items(sheep, 2500).
items(goat, 2500).
items(duck, 700).
items(horse, 5000).
items(angora_rabbit, 4500).
items(buffalo, 5000).

/* product */

items(chicken_egg, 80).
items(cow_milk, 100).
items(sheep_wool, 100).
items(goat_milk, 150).
items(duck_egg, 100).
items(horse_milk, 180).
items(angora_wool, 180).
items(buffalo_milk, 200).

/* market */

isShopping(0).

shopItemsList([tomato_seed, corn_seed, eggplant_seed, chilli_seed, apple_seed, pineapple_seed, grape_seed, turnip_seed, pomegranate_seed, strawberry_seed, chicken, cow, sheep, goat, duck, horse, angora_rabbit, buffalo]).

market :-
    position(X,Y),
    isAtMarketplace(X,Y),
    write('What do you want to do?'), nl,
    write('1. Buy'), nl,
    write('2. Sell'), nl,
    write('3. Upgrade'),
    retractall(isShopping(_)),
    asserta(isShopping(1)),
    !.
market :-
    position(X,Y),
    \+isAtMarketplace(X,Y),
    write('You\'re not at the marketplace right now.'),
    !.

/* buy */

buy :-
    isShopping(1),
    write('What do you want to buy?'), nl,
    shopItemsList(List),
    buyList(List, 1),
    write('> '),
    read_integer(Number),
    buyThis(List, Number, Name, Price, Level),
    write('How many do you want to buy?'), nl,
    write('> '),
    read_integer(Amount),
    gold(CurMoney),
    NeededMoney is Price * Amount,
    (   CurMoney < NeededMoney ->
        write('You don\'t have enough gold'), nl,
        fail
    ;   CurMoney >= NeededMoney ->
        retractall(gold(_)),
        CurMoney1 is CurMoney - NeededMoney,
        asserta(gold(CurMoney1)),
        addItem(Name, Amount, Level),
        write('You have bought '), write(Amount), write(' '), write(Name), write('.'), nl,
        write('You are charged '), write(NeededMoney), write(' golds.')
    ).

buyList([], _) :- !.
buyList([Head|Tail], I) :-
    items(Head, Price),
    write(I), 
    write('. '),
    write(Head),
    write(' ('),
    write(Price),
    write(' golds)'),
    nl,
    I1 is I + 1,
    buyList(Tail, I1).

buyThis([_|Tail], Number, _, _, _) :- Tail = [], Number > 1, write('Please choose a valid number'), !, fail.
buyThis([Head|_], 1, Name, Price, Level) :-
    items(Head, Price),
    Name = Head, 
    invenItem(Head, _, Level), !.
buyThis([_|Tail], Number, Name, Price, Level) :-
    Number > 1,
    Number1 is Number - 1,
    buyThis(Tail, Number1, Name, Price, Level).

/* sell */

sell :-
    isShopping(1),
    inventory,
    write('What do you want to sell ?'), nl,
    write('> '),
    read(Name),
    nameItem(List),
    srcItem(List, Name, Flag),
    (   Flag =:= 0 ->
        write('You don\'t have such item'), nl,
        fail
    ;   Flag =:= 1 ->
        invenItem(Name, Amount, Level),
        items(Name, Price),
        gold(CurMoney),
        write('How many do you want to sell ?'), nl,
        write('> '),
        read_integer(SellAmnt),
        (   Amount < SellAmnt ->
            write('You don\'t have enough item'), nl,
            fail
        ;   Amount >= SellAmnt ->
            retractall(gold(_)),
            AddedGold is SellAmnt * Price,
            CurMoney1 is CurMoney + AddedGold,
            asserta(gold(CurMoney1)),
            delItem(Name, SellAmnt, Level),
            write('You sold '), write(SellAmnt), write(' '), write(Name), write('.'), nl,
            write('You received '), write(AddedGold), write(' golds.'), nl
        )
    ), !.

/* upgrade */

upgrade :-
    upgradeAvailable,
    upgradeList(List),
    writeUpgrade(List, 1, Flag),
    (   Flag =:= 1,
        write('Which equipment do you want to upgrade?'), nl,
        write('> '),
        read_integer(Number),
        upgradeThis(List, Number, Name),
        (   Name \== invalidname ->
            equipment(Name, _, Lvl),
            Lvl1 is Lvl + 1,
            equipmentUpgrade(Name, Lvl, Lvl1, Price),
            gold(CurMoney),
            (   CurMoney < Price ->
                write('You don\'t have enough gold'), nl,
                fail
            ;   CurMoney >= Price ->
                write('You succesfully upgraded your '), write(Name), write(' to level '), write(Lvl1), nl,
                retractall(gold(_)),
                CurMoney1 is CurMoney - Price,
                asserta(gold(CurMoney1)),
                retractall(equipment(Name, _, _)),
                asserta(equipment(Name, 1, Lvl1))
            )
        )
    ), !.

upgradeThis([_|Tail], I, Name) :- Tail = [], I > 1, Name = invalidname, write('Please choose a valid number!'), !, fail.
upgradeThis([Head|_], 1, Name) :-
    Name = Head.
upgradeThis([_|Tail], I, Name) :-
    I > 1,
    I1 is I - 1,
    upgradeThis(Tail, I1, Name).


upgradeList([]).
upgradeAvailable :-
    equipment(shovel, _, SL),
    equipment(fishing_rod, _, FL),
    equipment(handcarts, _, HL),
    retractall(upgradeList(_)),
    asserta(upgradeList([])),
    (   HL < 3 ->
        upgradeList(List),
        insertFirst(List, handcarts, Result),
        retractall(upgradeList(_)),
        asserta(upgradeList(Result))
    ;   HL >= 3 ->
        upgradeList(List4),
        retractall(upgradeList(_)),
        asserta(upgradeList(List4))
    ),
    (   FL < 3 ->
        upgradeList(List1),
        insertFirst(List1, fishing_rod, Result1),
        retractall(upgradeList(_)),
        asserta(upgradeList(Result1))
    ;   FL >= 3 ->
        upgradeList(List5),
        retractall(upgradeList(_)),
        asserta(upgradeList(List5))
    ),
    (   SL < 3 ->
        upgradeList(List2),
        insertFirst(List2, shovel, Result2),
        retractall(upgradeList(_)),
        asserta(upgradeList(Result2))
    ;   SL >= 3 ->
        upgradeList(List6),
        retractall(upgradeList(_)),
        asserta(upgradeList(List6))
    ).

writeUpgrade([], 1, Flag) :- write('Tidak ada equipment yang bisa diupgrade'), Flag is 0, !.
writeUpgrade([], I, Flag) :- I>1, Flag is 1, !.
writeUpgrade([Head|Tail], I, Flag) :-
    equipment(Head, _, Lvl),
    equipmentUpgrade(Head, Lvl, Lvl1, Price),
    write(I), 
    write('. Level '),
    write(Lvl1),
    write(' '),
    write(Head),
    write(' ('),
    write(Price),
    write(' golds)'),
    nl,
    I1 is I + 1,
    writeUpgrade(Tail, I1, Flag).
    

/* exitShop */

exitShop :- 
    retractall(isShopping(_)),
    asserta(isShopping(0)),
    write('You exited the shop').

    
