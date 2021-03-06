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
	lvlRancher(Lvl),
	ModLvl is Lvl mod 5,
	ModLvl =\= 0,
	fail.
decreaseTimeRanch :-
	lvlRancher(Lvl),
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
strLivestock(buffalo, 'buffalo').
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
    started(1),
	\+isInRanch,
	write('You are not in ranch!'), nl,
	!.
ranch :-
    started(1),
	isInRanch,
	ranchItem(chicken, ChickenAmount, -1),
	ranchItem(cow, CowAmount, -1),
	ranchItem(sheep, SheepAmount, -1),
	ranchItem(goat, GoatAmount, -1),
	ranchItem(duck, DuckAmount, -1),
	ranchItem(horse, HorseAmount, -1),
	ranchItem(angora_rabbit, AngoraAmount, -1),
	ranchItem(buffalo, BuffaloAmount, -1),
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

chicken :- started(1),checkLivestock(chicken, chicken_egg).
cow :- started(1),checkLivestock(cow, cow_milk).
sheep :- started(1),checkLivestock(sheep, sheep_wool).
goat :- started(1),checkLivestock(goat, goat_milk).
duck :- started(1),checkLivestock(duck, duck_egg).
horse :- started(1),checkLivestock(horse, horse_milk).
angora_rabbit :- started(1),checkLivestock(angora_rabbit, angora_wool).
buffalo :- started(1),checkLivestock(buffalo, buffalo_milk).

/* checkLivestock */

checkLivestock(_, _) :-
	\+isInRanch,
	write('You\'re not in ranch!'), nl,
	!, fail.
checkLivestock(Livestock, _) :- % kasus tidak ada Livestock
	isInRanch,
	ranchItem(Livestock, Amount, -1),
	Amount =:= 0,
	strLivestock(Livestock, StrLivestock),
	write('You don\'t have any '), write(StrLivestock), write('!'), nl, 
	!.
checkLivestock(Livestock, Product) :- % kasus ada livestock, tapi belum bisa ambil hasil
	isInRanch,
	ranchItem(Livestock, Amount, -1),
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
	ranchItem(Livestock, Amount, -1),
	Amount > 0,
	strLivestock(Livestock, StrLivestock),
	strProduct(Product, StrProduct),
	isRanchTime(Livestock, Flag),
	Flag =:= 1,

	% multiplier hasil karena ada handcart
	% setiap naik level, hasil bertambah sebesar <level> kali lipat
	equipment(handcarts, HandcartAmount, HandcartLevel),
	(
		HandcartAmount =:= 0,
		ExtraAmount is 1
	;
		HandcartAmount > 0,
		ExtraAmount is HandcartLevel
	),
	ProductAmount is Amount * ExtraAmount,

	write('Your '), write(StrLivestock), write(' produced '), 
	write(ProductAmount), write(' '), write(StrProduct), nl,
	write('You got '), write(ProductAmount), write(' '), write(StrProduct), write('!'), nl,
	addItem(Product, ProductAmount, -1),
	fulfillRanchQuest(ProductAmount),

	% multiplier exp karena job
	% kalau job rancher, dapat tambahan exp 2x lipat 
	job(Job),
	(	
		Job = 'Rancher' ->
		ExtraXP is 2
	;
		ExtraXP is 1 
	),
	ranchExp(Livestock, XP),
	TotalXP is XP * ProductAmount * ExtraXP,
	writeAddExpRancher(TotalXP),
	resetLivestockTimer(Livestock), 
	!.