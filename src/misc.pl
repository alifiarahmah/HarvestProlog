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

writeTitleV2 :-
	write('======================================================================'), nl,
	write('  _    _                           _   _____           _             '), nl,
	write(' | |  | |                         | | |  __ \\         | |            '), nl,
	write(' | |__| | __ _ _ ____   _____  ___| |_| |__) | __ ___ | | ___   __ _ '), nl,
	write(' |  __  |/ _` |  __\\ \\ / / _ \\/ __| __|  ___/  __/ _ \\| |/ _ \\ / _` |'), nl,
	write(' | |  | | (_| | |   \\ V /  __/\\__ \\ |_| |   | | | (_) | | (_) | (_| |'), nl,
	write(' |_|  |_|\\__,_|_|    \\_/ \\___||___/\\__|_|   |_|  \\___/|_|\\___/ \\__, |'), nl,
	write('                                                                __/ |'), nl,
	write('                                                               |___/ '), nl,
	write('======================================================================'), nl.

writeCommandList :-
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
	write('%                               ~HarvestProlog~                                %'), nl,
	write('% 1. start   : untuk memulai petualanganmu                                     %'), nl,
	write('% 2. map     : menampilkan peta                                                %'), nl,
	write('% 3. status  : menampilkan kondisimu terkini                                   %'), nl,
	write('% 4. w       : gerak ke utara 1 langkah                                        %'), nl,
	write('% 5. s       : gerak ke selatan 1 langkah                                      %'), nl,
	write('% 6. d       : gerak ke ke timur 1 langkah                                     %'), nl,
	write('% 7. a       : gerak ke barat 1 langkah                                        %'), nl,
	write('% 8. help    : menampilkan segala bantuan                                      %'), nl,
	write('% 9. quit    : keluar dari permainan                                           %'), nl,
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

writeHelpListV1 :-
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
	write('%                                ~HarvestProlog~                                  %'), nl,
	write('% 1. status     : menampilkan kondisimu terkini                                   %'), nl,
	write('% 2. map        : menampilkan peta                                                %'), nl,
	write('% 3. inventory  : menampilkan isi barang yang disimpan                            %'), nl,
	write('% 4. w          : gerak ke utara 1 langkah                                        %'), nl,
	write('% 5. s          : gerak ke selatan 1 langkah                                      %'), nl,
	write('% 6. d          : gerak ke ke timur 1 langkah                                     %'), nl,
	write('% 7. a          : gerak ke barat 1 langkah                                        %'), nl,
	write('% 8. help       : menampilkan segala bantuan                                      %'), nl,
	write('% 9. quit       : keluar dari permainan                                           %'), nl,
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

writeHelpListV2 :-
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
	write('%                                ~HarvestProlog~                                  %'), nl,
	write('% 1. status     : menampilkan kondisimu terkini                                   %'), nl,
	write('% 2. map        : menampilkan peta                                                %'), nl,
	write('% 3. inventory  : menampilkan isi barang yang disimpan                            %'), nl,
	write('% 4. w          : gerak ke utara 1 langkah                                        %'), nl,
	write('% 5. s          : gerak ke selatan 1 langkah                                      %'), nl,
	write('% 6. d          : gerak ke ke timur 1 langkah                                     %'), nl,
	write('% 7. a          : gerak ke barat 1 langkah                                        %'), nl,
	write('% 8. help       : menampilkan segala bantuan                                      %'), nl,
	write('% 9. market     : masuk ke dalam marketplace                                      %'), nl,
	write('% 10. house     : masuk ke dalam house                                            %'), nl,
	write('% 11. quest     : mengambil quest                                                 %'), nl,
	write('% 12. submit    : menyelesaikan quest                                             %'), nl,
	write('% 13. dig       : menggali tanah                                                  %'), nl,
	write('% 14. plant     : menanam seed                                                    %'), nl,
	write('% 15. fishing   : memancing ikan                                                  %'), nl,
	write('% 16. ranch     : beternak                                                        %'), nl,
	write('% 17. quit      : keluar dari permainan                                           %'), nl,
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

quit :-
	write('      ___________'), nl,
	write('     /  __   __  \\'), nl,
	write('    /  /  | |  \\  \\       You decided to go back to the city.'), nl,
	write(' __/  /___| |___\\  \\__    See you later in the next adventure.'), nl,
	write('|     __       __     |'), nl,
	write('|____/  \\_____/  \\____|'), nl,
	write('     \\__/     \\__/'), nl, nl, halt.

quit1 :-
	write('      ___________'), nl,
	write('     /  __   __  \\'), nl,
	write('    /  /  | |  \\  \\       You decided to go back to the city.'), nl,
	write(' __/  /___| |___\\  \\__    See you later in the next adventure.'), nl,
	write('|     __       __     |'), nl,
	write('|____/  \\_____/  \\____|'), nl,
	write('     \\__/     \\__/'), nl, nl.