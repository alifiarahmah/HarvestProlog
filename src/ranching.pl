/* RANCHING */

/* Deklarasi fakta livestock */
/* Format: livestock(<nama>, <waktu awal beli/setelah ambil sebelumnya>, <waktu ambil hasil ternak>) */
:- dynamic(livestock/3).

/* Deklarasi durasi dapat mengambil hasil ternak, dalam jam */
:- dynamic(timeRanch/2).

/* Deklarasi fakta EXP yang didapat per hasil ternak */
ranchExp(chicken, 3).
ranchExp(cow, 10).
ranchExp(sheep, 10).
ranchExp(goat, 15).
ranchExp(duck, 5).
ranchExp(horse, 10).
ranchExp(angora_rabbit, 15).
ranchExp(buffalo, 15).

/* initRanch: inisialisasi durasi dapat hasil ternak saat pertama main */
initTimeRanch :-
	asserta(timeRanch(chicken, 6)),
	asserta(timeRanch(cow, 6)),
	asserta(timeRanch(sheep, 6)),
	asserta(timeRanch(goat, 6)),
	asserta(timeRanch(duck, 6)),
	asserta(timeRanch(horse, 6)),
	asserta(timeRanch(angora_rabbit, 6)),
	asserta(timeRanch(buffalo, 6)).

/* decreaseTimeRanch: Mengecek dan mengurangi timeRanch */
/* Setiap naik ke level 5, 10, 15... (kelipatan 5), timeRanch berkurang 1 */
decreaseTimeRanch :-
	lvlRancher(Lvl, _),
	ModLvl is Lvl mod 5,
	ModLvl =\= 0,
	fail.
decreaseTimeRanch :-
	lvlRancher(Lvl, _),
	ModLvl is Lvl mod 5,
	ModLvl =:= 0,
	timeRanch(_, Time),
	Time1 is Time - 1,
	retractall(timeRanch(_, _)),
	asserta(timeRanch(_, Time1)).

/* Deklarasi string untuk write */
strLivestock(chicken, 'chicken').
strLivestock(cow, 'cow').
strLivestock(sheep, 'sheep').
strLivestock(goat, 'goat').
strLivestock(duck, 'duck').
strLivestock(horse, 'horse').
strLivestock(angora_rabbit, 'angora rabbit').
strProduct(chicken_egg, 'chicken egg').
strProduct(cow_milk, 'cow milk').
strProduct(sheep_wool, 'sheep wool').
strProduct(goat_milk, 'goat milk').
strProduct(duck_egg, 'duck egg').
strProduct(horse_milk, 'horse milk').
strProduct(angora_wool, 'angora wool').
strProduct(buffalo_milk, 'buffalo milk').

/* isInRanch: cek apakah posisi pemain di tile ranch */
isInRanch :- position(X, Y), isAtRanch(X,Y).

/* ranch: antarmuka jumlah hewan ternak */
ranch :-
	\+isInRanch,
	write('You are not in ranch!'), nl,
	!.
ranch :-
	isInRanch,
	invenItem(chicken, ChickenAmount, -1),
	invenItem(cow, CowAmount, -1),
	invenItem(sheep, SheepAmount, -1),
	invenItem(goat, GoatAmount, -1),
	invenItem(duck, DuckAmount, -1),
	invenItem(horse, HorseAmount, -1),
	invenItem(angora_rabbit, AngoraAmount, -1),
	invenItem(buffalo, BuffaloAmount, -1),
	write('Welcome to the ranch! You have:'), nl,
	write(ChickenAmount), write(' chicken'), nl,
	write(CowAmount), write(' cow'), nl,
	write(SheepAmount), write(' sheep'), nl,
	write(GoatAmount), write(' goat'), nl,
	write(DuckAmount), write(' duck'), nl,
	write(HorseAmount), write(' horse'), nl,
	write(AngoraAmount), write(' angora rabbit'), nl,
	write(BuffaloAmount), write(' buffalo'), nl, nl,
	write('What do you want to do?'), nl,
	write('Commands:'), nl,
	write('- chicken    - duck'), nl,
	write('- cow        - horse'), nl,
	write('- sheep      - angora_rabbit'), nl,
	write('- goat       - buffalo'), nl.

/* isRanchTime: Flag 1 kalau sudah dapat ambil hasil, Flag 0 kalau belum */
isRanchTime(Livestock, Flag) :-
	\+livestock(Livestock, _, _),
	time(CTime),
	timeRanch(Livestock, CD),
	RanchTime is CTime + CD,
	asserta(livestock(Livestock, CTime, RanchTime)),
	Flag is 0.
isRanchTime(Livestock, Flag) :-
	livestock(Livestock, _, TAkhir),
	time(CTime),
	CTime < TAkhir,
	Flag is 0.
isRanchTime(Livestock, Flag) :-
	time(CTime),
	livestock(Livestock, _, TAkhir),
	CTime >= TAkhir,
	Flag is 1.

/* resetLivestockTimer: Reset waktu livestock. Digunakan setelah ambil hasil ternak */
resetLivestockTimer(Livestock) :-
	timeRanch(Livestock, CD),
	time(CTime),
	RanchTime is CTime + CD,
	retractall(livestock(Livestock, _, CTime)),
	asserta(livestock(Livestock, CTime, RanchTime)).

/* fulfillQuest: Mengurang jumlah ranching di quest */
fulfillRanchQuest(_) :-
	\+ongoingQ(_, _, _),
	fail.
fulfillRanchQuest(Amount) :-
	ongoingQ(X, Y, QuestAmount),
	QuestAmount < Amount,
	retract(ongoingQ(X, Y, QuestAmount)),
	asserta(ongoingQ(X, Y, 0)).
fulfillRanchQuest(Amount) :-
	ongoingQ(X, Y, QuestAmount),
	QuestAmount >= Amount,
	Amount1 is QuestAmount - Amount,
	retract(ongoingQ(X, Y, QuestAmount)),
	asserta(ongoingQ(X, Y, Amount1)).

/* command tiap livestock */

chicken :- checkLivestock(chicken, chicken_egg).
cow :- checkLivestock(cow, cow_milk).
sheep :- checkLivestock(sheep, sheep_wool).
goat :- checkLivestock(goat, goat_milk).
duck :- checkLivestock(duck, duck_egg).
horse :- checkLivestock(horse, horse_milk).
angora_rabbit :- checkLivestock(angora_rabbit, angora_wool).
buffalo :- checkLivestock(buffalo, buffalo_milk).

/* checkLivestock */

checkLivestock(_, _) :-
	\+isInRanch,
	write('You\'re not in ranch!'), nl,
	!, fail.
checkLivestock(Livestock, _) :- % kasus tidak ada Livestock
	isInRanch,
	invenItem(Livestock, Amount, -1),
	Amount = 0,
	strLivestock(Livestock, StrLivestock),
	write('You don\'t have any '), write(StrLivestock), write('!'), nl, 
	!.
checkLivestock(Livestock, Product) :- % kasus ada livestock, tapi belum bisa ambil hasil
	isInRanch,
	invenItem(Livestock, Amount, -1),
	Amount > 0,
	strLivestock(Livestock, StrLivestock),
	strProduct(Product, StrProduct),
	isRanchTime(Livestock, Flag),
	Flag = 0,
	write('Your '), write(StrLivestock), write(' hasn\'t produced any '), write(StrProduct), write('s'), nl,
	write('Please check again later.'), nl, 
	!.
checkLivestock(Livestock, Product) :- % kasus ada livestock dan bisa ambil hasil
	isInRanch,
	invenItem(Livestock, Amount, -1),
	Amount > 0,
	strLivestock(Livestock, StrLivestock),
	strProduct(Product, StrProduct),
	isRanchTime(Livestock, Flag),
	Flag = 1,
	write('Your '), write(StrLivestock), write(' produced '), 
	write(Amount), write(' '), write(StrProduct), nl,
	write('You got '), write(Amount), write(' '), write(StrProduct), write('!'), nl,
	addItem(Product, Amount, -1),
	fulfillRanchQuest(Amount),
	ranchExp(Livestock, XP),
	TotalXP is XP * Amount,
	writeAddExpRancher(TotalXP),
	resetLivestockTimer(Livestock).