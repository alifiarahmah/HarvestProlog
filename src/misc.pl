/* MISCELLANEOUS COMMANDS */

/* writeTitle: Write game Title */
writeTitle :- 
	write('================================================================'), nl,
	write('      _  _                     _   ___         _  '), nl,
	write('     | || |__ _ _ ___ _____ __| |_| _ \\_ _ ___| |___  __ _ '), nl,
	write('     | __ / _\` | \'_\\ V / -_|_-<  _|  _/ \'_/ _ \\ / _ \\/ _\` |'), nl,
	write('     |_||_\\__,_|_|  \\_/\\___/__/\\__|_| |_| \\___/_\\___/\\__, |'), nl,
	write('                                                     |___/'), nl,
	write('================================================================'), nl.

quit :-
	write('      ___________'), nl,
	write('     /  __   __  \\'), nl,
	write('    /  /  | |  \\  \\       You decided to go back to the city.'), nl,
	write(' __/  /___| |___\\  \\__    See you later in the next adventure.'), nl,
	write('|     __       __     |'), nl,
	write('|____/  \\_____/  \\____|'), nl,
	write('     \\__/     \\__/'), nl, halt.