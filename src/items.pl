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
items(tomato, 600).
items(corn, 900).
items(eggplant, 360).
items(chilli, 450).
items(apple, 360).
items(pineapple, 900).
items(grape, 360).
items(turnip, 360).
items(pomegranate, 450).
items(strawberry, 450).

/* fish */
items(catfish, 75).
items(tuna, 165).
items(salmon, 165).
items(musky, 165).
items(bluegill, 165).
items(carp, 165).
items(bass, 270).
items(trout, 270).
items(cod, 270).
items(pufferfish, 270).

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

items(chicken_egg, 240).
items(cow_milk, 300).
items(sheep_wool, 300).
items(goat_milk, 450).
items(duck_egg, 300).
items(horse_milk, 540).
items(angora_wool, 540).
items(buffalo_milk, 600).



    
