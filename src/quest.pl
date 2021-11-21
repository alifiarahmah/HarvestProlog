/* DYNAMIC FACTS */
:- dynamic(activeQ/1).
:- dynamic(ongoingQ/3).

/* quest: Untuk mengambil quest */

activeQ(0).
ongoingQ(0,0,0).

quest :-
    position(X,Y),
    \+isAtQuest(X,Y),
    write('You have to be at quest pick up place (Q) to take a quest!'), nl, !.

quest :-
    position(X,Y),
    isAtQuest(X,Y),
    activeQ(K),
    K =:= 1,
    write('You have an on-going quest!'), nl, !.

quest :-
    position(X,Y),
    isAtQuest(X,Y),
    activeQ(K),
    K =:= 0,
    random(1,11,H),
    random(1,11,F),
    random(1,11,E),
    write('You got a new quest!'), nl, nl,
    write('You need to collect:'), nl,
    write('- '), write(H), write(' harvest item'), nl,
    write('- '), write(F), write(' fish'), nl,
    write('- '), write(E), write(' eggs'), nl,
    retractall(activeQ(_)),
    retractall(ongoingQ(_,_,_)),
    asserta(activeQ(1)),
    asserta(ongoingQ(H,F,E)).