/* DYNAMIC FACTS */
:- dynamic(activeQ/1).
:- dynamic(ongoingQ/3).
:- dynamic(reward/2).

/* quest: Untuk mengambil quest */

activeQ(0).
ongoingQ(0,0,0).
/* reward(exp, gold) */
reward(0, 0).  

quest :-
    position(X,Y),
    \+isAtQuest(X,Y),
    write('You have to be at quest pick up place (Q) to take a quest!'), nl, !.

quest :-
    position(X,Y),
    isAtQuest(X,Y),
    activeQ(K),
    K =:= 1,
    write('You have an on-going quest!'), nl, 
    ongoingQ(H,F,E),
    write('You need to collect:'), nl,
    write('- '), write(H), write(' harvest item'), nl,
    write('- '), write(F), write(' fish'), nl,
    write('- '), write(E), write(' ranch item'), nl, !.

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
    write('- '), write(E), write(' ranch item'), nl,
    retractall(activeQ(_)),
    retractall(ongoingQ(_,_,_)),
    asserta(activeQ(1)),
    asserta(ongoingQ(H,F,E)),
    retractall(reward(_, _)),
    RE is (H+F+E)*5,
    RG is (H+F+E)*50,
    asserta(RE, RG).

/* submit: untuk memperoleh reward setelah menyelesaikan quest */
submit :-
    position(X,Y),
    isAtQuest(X,Y),
    activeQ(K),
    K =:= 0,
    write('You don\'t have any active quest'),
    !.

submit :-
    position(X,Y),
    isAtQuest(X,Y),
    activeQ(K),
    K =:= 1,
    ongoingQ(H,F,E),
    H =:= 0, F =:= 0, E =:= 0,
    write('Congratulations, you have completed your quest!'),
    reward(RE, RG),
    writeAddExpTotal(RE),
    writeAddGold(RG),
    retractall(activeQ(_)),
    asserta(activeQ(0)),
    retractall(reward(_, _)),
    asserta(reward(0,0)), !.

submit :-
    position(X,Y),
    isAtQuest(X,Y),
    activeQ(K),
    K =:= 1,
    ongoingQ(H,F,E),
    (H =\= 0; F =\= 0; E =\= 0),
    write('You need to collect:'), nl,
    (   H =\= 0 ->
        write('- '), write(H), write(' harvest item'), nl
    ;   H =:= 0 ->
        !
    ),
    (   F =\= 0 ->
        write('- '), write(F), write(' fish'), nl
    ;   F =:= 0 ->
        !
    ),
    (   E =\= 0 ->
        write('- '), write(E), write(' ranch item'), nl
    ;   E =:= 0 ->
        !
    ), !.
