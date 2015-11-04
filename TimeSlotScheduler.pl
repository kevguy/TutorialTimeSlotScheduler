constraints(alice_tt,[n,n,a,n,n,a,a,a,a,a,a,n,n,n]).
constraints(bob_tt,[n,a,n,n,n,a,n,n,a,a,a,n,a,a]).
student_timetable(s12676,[a,a,a,n,n,a,n,n,a,a,a,n,n,a]).
student_timetable(s12466,[n,a,n,n,a,a,n,a,n,a,n,n,a,a]).

% print every element in the list
% try print_all([1,2,3,4,5]).
print_all([]).
print_all([X|Rest]) :- write(X), nl, print_all(Rest).


% replace an element in a list at a specified index
% it will return the original list if index is out of bound
% replace (+List, +Index, +Value, NewList).
% try replace([1,2,3,4,5,6,7], 1, 3, X).
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).



write_list:-
	forall(constraints(_,A), format('~q', [A])).

write_list_same:-
	forall(constraints(_,A), print_A(A)).

print_A(X):-
	format('~q', [X]).

find_list_length(X):-
	constraints(_,A),
	length(A,X).
	%format('oh gg ~w' , [X]).

% this makes a dummy list with L = [1,2,3,...,length]
make_dummy_list(M):-
	find_list_length(X),
	numlist(1,X,L),
	%format('dumb ~q', [L]),
	replace(L,0,a,M).
	%format('dumbass ~q', [M]).

% this part create the list [a,a,a,a,a,a...,a]
replace_a(0,L1,M):-
	replace(L1,0,a,N),
	M = N.

replace_a(X,L1,M):-
	replace(L1,X,a,N),
	%format('dumbass ~q', [N]),
	Y is X-1,
	replace_a(Y,N,M).

make_a_list(N):-
	make_dummy_list(M),
	find_list_length(X),
	Y is X-1,
	replace_a(Y,M,N).
	%format('headline ~q', [N]).

replace_nnn(0,L1,M):-
	replace(L1,0,n,N),
	M = N.

replace_nnn(X,L1,M):-
	replace(L1,X,n,N),
	%format('dumbass ~q', [N]),
	Y is X-1,
	replace_nnn(Y,N,M).

make_n_list(N):-
	make_dummy_list(M),
	find_list_length(X),
	Y is X-1,
	replace_nnn(Y,M,N).
	%format('headline ~q', [N]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%There is a built-in predicate construction in Prolog which allows you to express exactly such conditions: 
%the if-then-else construct. In Prolog, if A then B else C is written as ( A -> B ; C). To Prolog this means: 
%try A. If you can prove it, go on to prove B and ignore C. If A fails, however, go on to prove C ignoring B. 
% The max predicate using the if-then-else construct looks as follows:

%max(X,Y,Z) :-
%    (  X =< Y
%    -> Z = Y
%    ;  Z = X  
%     ).

%%%%%%%%%%%%%%%%%%%%%% work %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this part replaces L1 with n if L2 has n at the same index
replace_n(0,L1,L2,M):-
	nth0(0, L2, Elem),
	nth0(0, L1, Elem1),
	(Elem == 'n'
	-> replace(L1,0,Elem,N)
	;	
		replace(L1,0,Elem1,N)
	),
	%format('dumbass ~q', [N]),
	M = N.
	%format('fine ~q', [M]).

replace_n(X,L1,L2,M):-
	nth0(X, L2, Elem),
	nth0(X, L1, Elem1),
	(Elem == 'n'
	-> replace(L1,X,Elem,N)	
	;	
		replace(L1,X,Elem1,N)
	),
	%format('dumbass ~q', [N]),
	Y is X-1,
	replace_n(Y,N,L2,M).

replace_n_list(N):-
	replace_n(14, [a,a,a,a,a,a,a,a,a,a,a,a,a,a,a], [n,n,a,n,n,a,a,a,a,a,a,n,n,n,a], M),
	replace_n(14, M, [n,a,n,n,n,a,n,n,a,a,a,n,a,a,a], N).
	%format('finally ~q', [N]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printLabel(0, L1):-
	nth0(0, L1, Elem),
	constraints(Elem, Da).
	%format('label ~q', [Da]).

printLabel(X, L1):-
	nth0(X, L1, Elem),
	constraints(Elem, Da), 
	%format('label ~q', [Da]),
	Y is X-1,
	printLabel(Y, L1).

change_constraint_list(0, ConstraintList, L2, L3):-
	nth0(0, ConstraintList, Elem),
	constraints(Elem, Da),
	%format('label ~q', [Da]),
	length(L2, Y),
	Z is Y-1,
	replace_n(Z, L2, Da, NewTable),
	L3 = NewTable.

change_constraint_list(X, ConstraintList, L2, L3):-
	nth0(X, ConstraintList, Elem),
	constraints(Elem, Da), 
	%format('label ~q', [Da]),
	length(L2, Y),
	Z is Y-1,
	replace_n(Z, L2, Da, NewTable),
	A is X-1,
	change_constraint_list(A, ConstraintList, NewTable, L3).

use_constraints(Label, Product):-
	length(Label, A),
	%format('length ~w', [A]),
	L is A-1,
	printLabel(L, Label),
	make_a_list(F),
	%format('F is ~q', [F]),
	change_constraint_list(L, Label, F, Final),
	%format('Final is ~q', [Final]),
	Product = Final.


change_timetable_list(0, ConstraintList, L2, L3):-
	nth0(0, ConstraintList, Elem),
	student_timetable(Elem, Da),
	%format('label ~q', [Da]),
	length(L2, Y),
	Z is Y-1,
	replace_n(Z, L2, Da, NewTable),
	L3 = NewTable.

change_timetable_list(X, ConstraintList, L2, L3):-
	nth0(X, ConstraintList, Elem),
	student_timetable(Elem, Da), 
	%format('label ~q', [Da]),
	length(L2, Y),
	Z is Y-1,
	replace_n(Z, L2, Da, NewTable),
	A is X-1,
	change_timetable_list(A, ConstraintList, NewTable, L3).


use_timetable(Label, Product):-
	%format('oh shit'),
	length(Label, A),
	%format('length ~w', [A]),
	L is A-1,
	%printLabel(L, Label),
	make_a_list(F),
	%format('F is ~q', [F]),
	change_timetable_list(L, Label, F, Final),
	%format('Final is ~q', [Final]),
	Product = Final.




count_aaa(0, L, InitCount, FinalCount):-
	nth0(0, L, Elem),
	(Elem == 'a'
	-> FinalCount = InitCount+1
	;
		FinalCount = InitCount	
	).

count_aaa(Idx, L, InitCount, FinalCount):-
	nth0(Idx, L, Elem),
	(Elem == 'a'
	-> TmpCount is InitCount+1
	;	TmpCount is InitCount
	),
	Y is Idx-1,
	%format('idx is ~w', [Y]),
	count_aaa(Y, L, TmpCount, FinalCount).

find_aaa(0, L, AIdx):-
	nth0(0, L, Elem),
	(Elem == 'a'
	-> AIdx = Idx	
	).

find_aaa(Idx, L, AIdx):-
	nth0(Idx, L, Elem),
	(Elem == 'a'
	-> AIdx = Idx
		%format('index is found ~w', [AIdx])
	;	Y is Idx-1,
		find_aaa(Y, L, Aidx)
	).
	


find_time_slots(ConstraintLabels, StudentIDs, NumOfTutorials, TutorialTime):-
	use_constraints(ConstraintLabels, Result),
	use_timetable(StudentIDs, SResult),
	length(Result, L),
	TreuLength is L-1,
	replace_n(TreuLength,Result, SResult, Final),
	%format('finally ~q', [Final]),
	length(Result, Le),
	TrueLength is Le-1,
	%format('final length ~w', [TrueLength]),
	count_aaa(TrueLength, Final, 0, OhBoy),
	%format('final count ~w', [OhBoy]),
	(OhBoy =< 1
	-> NumOfTutorials is OhBoy,
		TutorialTime = Final
	; NumOfTutorials is 1,
		nth0(AIndex, Final, a),
		%find_aaa(TrueLength, Final, AIndex),
		%format('fuckin index is ~w', [AIndex]),
		make_n_list(RealFinal),
		replace(RealFinal, AIndex, a, ReallyFinal),
		TutorialTime = ReallyFinal
	),
	format('NumOfTut ~w, ~n ~n', [NumOfTutorials]),
	format('TutTime ~q.', [TutorialTime]).



test_final(A,B):-
	find_time_slots([alice_tt, bob_tt], [s12676, s12466], A, B).