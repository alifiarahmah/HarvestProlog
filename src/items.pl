/* DYNAMIC FACTS */
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
items(catfish, 25).
items(tuna, 55).
items(salmon, 55).
items(musky, 55).
items(bluegill, 55).
items(carp, 55).
items(bass, 90).
items(trout, 90).
items(cod, 90).
items(pufferfish, 90).

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



    
