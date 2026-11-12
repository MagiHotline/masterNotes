(* Es1
Implementare la funzione

val isLeapYear = fn: int -> bool
che ritorna true se un anno fornito è bisestile senza usare costrutti
imperativi (e.g., if).
Un anno è bisestile se è divisibile per 4, ad eccezione degli anni
secolari (divisibili per 100), che devono essere divisibili per 400.
*)
fun isLeapYear year = if (year mod 4 = 0 orelse year mod 400 = 0) then true else false;

(* Es2
Implementare la funzione
val sumN = fn: int -> int
che, utilizzando la ricorsione, calcola la somma dei primi 𝑁
numeri interi positivi (da 1 a 𝑁).
*)
fun sumN n = if (n = 0) then 0 else n + sumN(n-1);

(* Es3
Implementare la funzione
val collatzSteps = fn: int -> int
che realizza il contatore di passi della congettura di Collatz. Dato
un intero positivo 𝑛, se è pari dividerlo per 2; se è dispari
moltiplicarlo per 3 e aggiungere 1. Contare i passi necessari per
arrivare a 1.
*)

fun collatzSpets n =
  if n = 1 then 0 else
  if n mod 2 = 0 then 1 + collatzSpets(n div 2) else 1 + collatzSpets((n * 3) + 1);

(*

Esercizio 4: Ricorsione e Funzioni Curried
Implementare la funzione
val power = fn: int -> int -> int
che calcola la potenza 𝑥 𝑦
(𝑥 elevato alla 𝑦) per esponenti interi
non negativi.

*)

fun power(x: int, y: int) = if y = 0 then 1 else x * power(x, y-1);
