/* DYNAMIC FACTS */
:- dynamic(isShopping/1).
:- dynamic(isInsideHouse/1).

/* w: Bergerak ke utara 1 langkah */
w :-
    started(1),
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
	), failState.

/* s: Bergerak ke selatan 1 langkah */
s :-
    started(1),
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
	), failState.

/* d: Bergerak ke timur 1 langkah */
d :-
    started(1),
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
	), failState.

/* a: Bergerak ke barat 1 langkah */
a :-
    started(1),
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
	), failState.

outputPos :- position(X,Y), write(X), write(','), write(Y), nl.

/* ***************** BONUS ***************** */

/* teleportBySleepFairy: teleport berdasar lokasi X yang dipilih player */
teleportBySleepFairy(X) :-
    started(1),
    X =:= 0,
    write('You declined the sleep fairy\'s offer'),
    write('You will still be in house when you wake up.'), nl.
teleportBySleepFairy(X) :-
    started(1),
    X =:= 1,
    ranch(XR, YR),
    retract(position(_, _)),
    asserta(position(XR, YR)),
    write('You will be teleported to Ranch after you wake up'), nl.
teleportBySleepFairy(X) :-
    started(1),
    X =:= 2,
    marketplace(XM, YM),
    retract(position(_, _)),
    asserta(position(XM, YM)),
    write('You will be teleported to Marketplace after you wake up'), nl.
teleportBySleepFairy(X) :-
    started(1),
    X =:= 3,
    quest(XQ, YQ),
    retract(position(_, _)),
    asserta(position(XQ, YQ)),
    write('You will be teleported to Quest Pickup place after you wake up'), nl.

/* sleepFairy : bertemu sleep fairy, dapat teleportasi setelah bangun (BONUS) */
sleepFairy(X) :- 
    X < 6,
    !.
sleepFairy(X) :-
    X >= 6,
    write('~~~ RANDOM EVENT ~~~'), nl,
    write('You met a sleep fairy in your dream.'), nl,
    write('Sleep fairy: \"I can teleport you when you wake up. Just choose one place.\"'), nl, nl,
    write('Where do you want to go after you wake up?'), nl,
    write('0. House (Cancel offer)'), nl,
    write('1. Ranch'), nl,
    write('2. Marketplace'), nl,
    write('3. Quest'), nl,
    write('> '),
    read_integer(Z),
    teleportBySleepFairy(Z),
    write('Have a nice sleep!'), nl, 
    write('~~~ RANDOM EVENT END ~~~'), nl,
    !.

/* ***************** END BONUS ***************** */

/* house : masuk ke dalam house */

isInsideHouse(0).
house :-
    started(1),
	position(X,Y),
	\+isAtHouse(X,Y),
	write('You are not at house right now'), nl, !.
house :- 
    started(1),
	position(X,Y),
	isAtHouse(X,Y),
	isInsideHouse(0),
	retractall(isInsideHouse(_)),
	asserta(isInsideHouse(1)),
	write('What do you want to do?'), nl,
	write('- sleep'), nl,
	write('- exitHouse'), nl, !.

sleep :-
    started(1),
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
    random(1,11,X), sleepFairy(X),  % sleep fairy trigger
	retractall(isInsideHouse(_)),
	asserta(isInsideHouse(0)),
	time(CurTime),
	CurDate is (CurTime//24) + 1,
	CurHour is CurTime mod 24,
	write('Day '), write(CurDate), nl,
	write('Current Time: '), write(CurHour), nl,
    failState.

exitHouse :-
    started(1),
	isInsideHouse(1),
	retractall(isInsideHouse(_)),
	asserta(isInsideHouse(0)).

/* market : masuk ke dalam marketplace*/

isShopping(0).

shopItemsList([tomato_seed, corn_seed, eggplant_seed, chilli_seed, apple_seed, pineapple_seed, grape_seed, turnip_seed, pomegranate_seed, strawberry_seed, chicken, cow, sheep, goat, duck, horse, angora_rabbit, buffalo]).

market :-
    started(1),
    position(X,Y),
    isAtMarketplace(X,Y),
    write('What do you want to do?'), nl,
    write('- buy'), nl,
    write('- sell'), nl,
    write('- upgrade'), nl,
    write('- exitShop'), nl,
    retractall(isShopping(_)),
    asserta(isShopping(1)),
    !.
market :-
    started(1),
    position(X,Y),
    \+isAtMarketplace(X,Y),
    write('You\'re not at the marketplace right now.'),
    !.

/* buy : membeli dari shop*/

buy :-
    started(1),
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
    (   Amount =< 0 ->
        write('You don\'t buy anything'), nl,
        !
    ;   Amount > 0 ->
        gold(CurMoney),
        NeededMoney is Price * Amount,
        (   CurMoney < NeededMoney ->
            write('You don\'t have enough gold'), nl,
            fail
        ;   CurMoney >= NeededMoney ->
            retractall(gold(_)),
            CurMoney1 is CurMoney - NeededMoney,
            asserta(gold(CurMoney1)),
            (   invenItem(Name, _, _) ->
                addItem(Name, Amount, Level)
            ;   ranchItem(Name, _, _) ->
                addRanchItem(Name, Amount, Level)
            ),
            write('You have bought '), write(Amount), write(' '), write(Name), write('.'), nl,
            write('You are charged '), write(NeededMoney), write(' golds.')
        ), !
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
    (   invenItem(Head, _, Level) ->
        !
    ;   ranchItem(Head, _, Level) ->
        !
    ),
    !.
buyThis([_|Tail], Number, Name, Price, Level) :-
    Number > 1,
    Number1 is Number - 1,
    buyThis(Tail, Number1, Name, Price, Level).

/* sell : menjual barang di inventory */

sell :-
    started(1),
    isShopping(1),
    inventoryWithoutEquipment,
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
        (   SellAmnt =< 0 ->
            write('You don\'t sell anything'), nl,
            !
        ;   Amount < SellAmnt ->
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
    started(1),
    upgradeAvailable,
    upgradeList(List),
    writeUpgrade(List, 1, Flag),
    (   Flag =:= 1,
        write('Which equipment do you want to upgrade?'), nl,
        write('> '),
        read_integer(Number),
        upgradeThis(List, Number, Name),
        (   Name \== invalidname ->
            equipment(Name, Am, Lvl),
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
                (
                    Am =:= 0 ->
                    sumItem(Sum),
                    Sum1 is Sum + 1,
                    retract(sumItem(Sum)),
                    asserta(sumItem(Sum1)),
                    retractall(equipment(Name, _, _)),
                    asserta(equipment(Name, 1, Lvl1))
                ;
                    Am =:= 1 ->
                    retractall(equipment(Name, _, _)),
                    asserta(equipment(Name, 1, Lvl1))
                )
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
    started(1),
    retractall(isShopping(_)),
    asserta(isShopping(0)),
    write('You exited the shop').