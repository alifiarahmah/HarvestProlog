/*daftar ikan*/
nameFish([tuna,salmon,catfish,musky,bass,bluegill,trout,carp,cod,pufferfish,none]).

/*exp ikan, ditentukan dengan perbandingan harga ikan dan maksimal exp, yaitu 50*/
exp(tuna,30).
exp(salmon,30).
exp(catfish,13).
exp(musky,30).
exp(bass,50).
exp(bluegill,30).
exp(trout,50).
exp(carp,30).
exp(cod,50).
exp(pufferfish,50).
exp(none,5).

/*rarity*/
rarity(tuna,0.1).
rarity(salmon,0.1).
rarity(catfish,0.1).
rarity(musky,0.1).
rarity(bass,0.1).
rarity(bluegill,0.1).
rarity(trout,0.1).
rarity(carp,0.1).
rarity(cod,0.1).
rarity(pufferfish,0.05).
rarity(none,0.05).

/*memancing*/
fish(A) :- 
	position(X,Y),
	isNearAir(X,Y),
	random_member(Item,nameFish),
	gotFish(Item).
	
gotFish(Item) :-
	(Item == none),
	exp(Item,Exp),
	write("You didn't get anything!"), nl,
	write('You gained '), write(Exp), write(' fishing exp.').
gotFish(Item) :-
	exp(Item,Exp),
	write("You got "), write(Item), write("!"), nl,
	write('You gained '), write(Exp), write(' fishing exp.').


/*Exp bertambah*/
