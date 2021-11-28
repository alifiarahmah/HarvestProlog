/* DYNAMIC FACTS */
:- dynamic(isShopping/1).
:- dynamic(isInsideHouse/1).

/* w: Bergerak ke utara 1 langkah */
w :-
	isShopping(0),
	isInsideHouse(0),
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
		write('Day '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

/* s: Bergerak ke selatan 1 langkah */
s :-
	isShopping(0),
	isInsideHouse(0),
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
		write('Day '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

/* d: Bergerak ke timur 1 langkah */
d :-
	isShopping(0),
	isInsideHouse(0),
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
		write('Day '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

/* a: Bergerak ke barat 1 langkah */
a :-
	isShopping(0),
	isInsideHouse(0),
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
		write('Day '), write(Date), nl,
		write('Current Time: '), write(Hour), nl
	).

outputPos :- position(X,Y), write(X), write(','), write(Y), nl.

/* house : masuk ke dalam house */

isInsideHouse(0).
house :-
	position(X,Y),
	\+isAtHouse(X,Y),
	write('You are not at house right now'), nl, !.
house :- 
	position(X,Y),
	isAtHouse(X,Y),
	isInsideHouse(0),
	retractall(isInsideHouse(_)),
	asserta(isInsideHouse(1)),
	write('What do you want to do?'), nl,
	write('- sleep'), nl,
	write('- exitHouse'), nl, !.

sleep :-
	isInsideHouse(1),
	time(Time),
	Date is (Time//24) + 1,
	Hour is Time mod 24,
	(	Hour < 6 ->
		Hour1 is 6,
		Date1 is Date,
		Time1 is ((Date1 - 1) * 24) + Hour1,
		retractall(time(_)),
		asserta(time(Time1))
	; 	Hour >= 6 ->
		Hour2 is 6,
		Date2 is Date + 1,
		Time2 is ((Date2 - 1) * 24) + Hour2,
		retractall(time(_)),
		asserta(time(Time2))
	),
	retractall(isInsideHouse(_)),
	asserta(isInsideHouse(0)),
	time(CurTime),
	CurDate is (CurTime//24) + 1,
	CurHour is CurTime mod 24,
	write('Day '), write(CurDate), nl,
	write('Current Time: '), write(CurHour), nl.

exitHouse :-
	isInsideHouse(1),
	retractall(isInsideHouse(_)),
	asserta(isInsideHouse(0)).

goalState :- 
	gold(X),
	X < 20000,
	!.
goalState :- 
	gold(X),
	X >= 20000,
	nl, write('Congratulations! You have finally collected 20000 golds!'), nl,
	halt.

/* market : masuk ke dalam marketplace*/

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

/* buy : membeli dari shop*/

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
    ), !.

/* buyList : list barang yang bisa dibeli */
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

/* buyThis : memilih barang yang dibeli */
buyThis([_|Tail], Number, _, _, _) :- Tail = [], Number > 1, write('Please choose a valid number'), !, fail.
buyThis([Head|_], 1, Name, Price, Level) :-
    items(Head, Price),
    Name = Head, 
    invenItem(Head, _, Level), !.
buyThis([_|Tail], Number, Name, Price, Level) :-
    Number > 1,
    Number1 is Number - 1,
    buyThis(Tail, Number1, Name, Price, Level).

/* sell : menjual barang di inventory */

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
        write('How many do you want to sell ?'), nl,
        write('> '),
        read_integer(SellAmnt),
        (   Amount < SellAmnt ->
            write('You don\'t have enough item'), nl,
            fail
        ;   Amount >= SellAmnt ->
            AddedGold is SellAmnt * Price,
            write('You sold '), write(SellAmnt), write(' '), write(Name), write('.'), nl,
            writeAddGold(AddedGold),
            delItem(Name, SellAmnt, Level)
        )
    ), !.

/* upgrade : melakukan upgrade equipment */

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

/* upgradeThis : memilih equipment yang diupgrade */
upgradeThis([_|Tail], I, Name) :- Tail = [], I > 1, Name = invalidname, write('Please choose a valid number!'), !, fail.
upgradeThis([Head|_], 1, Name) :-
    Name = Head.
upgradeThis([_|Tail], I, Name) :-
    I > 1,
    I1 is I - 1,
    upgradeThis(Tail, I1, Name).

/* upgradeList : daftar equipment yang bisa diupgrade */
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

/* writeUpgrade : menulis equipment yang ingin diupgrade */
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
    

/* exitShop : keluar dari marketplace */

exitShop :- 
    retractall(isShopping(_)),
    asserta(isShopping(0)),
    write('You exited the shop').