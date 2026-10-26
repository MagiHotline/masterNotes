#import "../../../conf.typ": *

#show: conf.with(
  title: "Logic in AI",
  profs: [Margherita Zorzi],
  accademic_year: "2026/2027",
)

= Introduction

There are two main goals for this course:

- Introducing a notion of deduction 
- Introducing Curry Howard Isomorphism, that connect the notion of computation with the notion of deduction. A proof is just a mathematical object that can be manipulated and transformed.

#def("Logical System", [
  A logical system has at least three components: 
  
  - Syntax (an alphabet, a grammar, a set of well-formed formulas)
  - Semantics (in order to link a meaning to the syntax)
  - Deductive system (a set of rules to derive new formulas from the existing ones)
])

Perhaps, in the past you have encountered a logical system like Natural Deduction, tableaux, or sequent calculus.

== Areas of interest

There are several applications of logic in AI, took directly from SOTA (state of art) papers: 

- * 'Theoritical' Computer Science*: automata, formal languages, computability or recursion theory, complexity theory, etc.
- *Artificial Intelligence*: deduction systems (proof theory), expert systems, NLP, automated proof, multi-agent systems, etc.
- *Programming Languages*: logical programming, resolution functional programming, semantics, type systems, etc.
- *Software Engineering*: program verification, program design, speficications, etc.
- *Hardware*: circuit design verification, etc.

== Roadmap 

We will be following a roadmap that is based on the following topics:

+ Propositional logic 
  - Natural deduction, with which we will use it to reason about logical principles.
+ First Order Logic  
+ Intuitionistic logic 
  - $underbrace(tack phi arrow.l.r.long.double tack.rr phi, arrow.l)$
  - $lambda$ calculus
  - Curry Howard
+ Modal Logics $ballot, diamond$

= Propositional Logic 

We are going to start with propositional logic, which is the simplest logical system.

== Syntax 

Propositional logic is composed by: 

- Proposition symbols: AT = ${p_0, p_1, p_2, dots,} union bot$ ($abs(NN) = aleph_0$)
- Connectives: 
  - Negation: $not phi$
  - Conjunction: $phi and psi$
  - Disjunction: $phi or psi$
  - Implication: $phi arrow.r psi$
  - Bi-implication: $phi arrow.l.r psi$
- Auxialiary symbol: $( , )$

The set PROP of propositions is the _smallest_ set $X$ with the properties:

+ $p_i in X (i in NN), bot in X$
+ $phi, psi in X arrow.double (phi and psi), (phi or psi), (phi arrow psi), (psi arrow.r.l phi) in X$
+ $phi in X arrow.double (not phi) in X$

We need the following induction principles in order to use proof by induction:

#thm("Induction Principle", [
  Let $A$ be property when $A(phi)$ holds for all $phi in$ PROP if: 
  + $A(p_i)$ holds for all $i in NN$ and $A(bot)$ holds
  + $A(phi)$ and $A(psi)$ hold implies $A(phi and psi)$, $A(phi or psi)$, $A(phi arrow psi)$, $A(psi arrow.l.r phi)$ hold
  + $A(phi)$ holds implies $A(not phi)$ holds 
]) <label:indprinc>

#thm("Definition by Recursion", [
  Let mappings $H_(ballot) : A^2 arrow A$ and $H_(not) : A arrow A$ be given and let $H_("at")$ be a mapping from the set of atoms into $A$,
  then there exists exactly one mapping $F: "PROP" arrow A$ such that
  /*
  $
    cases(
      F(phi) &= H_("at")(phi) "if" phi in AT,
      F(phi ballot psi) &= H_(ballot)(F(phi), F(psi)),
      F(not phi) &= H_(not)(F(phi)
    )
  $
  */
])

#thm("Primitive Recursion", [
  $exists ! f : NN arrow NN$ and $h : NN times NN arrow NN$
  where $c in NN$ such that $f(0) = c$ and $forall n in NN, f(n + 1) = H(f(n))$: 
  - $Omega$ class of satisfying sets $Z$
    - $
    (0,c) in Z, (n,x) in Z arrow.double (s(n), h(n,x))
    $ 
    - $
    f "intersection of all the sets above"
    $
    - $
        f "is a set and in" Omega  
      $
We prove by induction that $forall n in NN, exists! a in NN$ such that 
$s tack (n,a) in f$.

- *Base case*: $(0,c) in f$ by definition. Suppose $exists d eq.not c$ and $f backslash {(0,d)}$ is satisfied and properly contained in $f$. 
Since I am violating the fact that $f$ is the smallest one, this is impossible. 
  - *Inductive case*: Suppose $exists ! w (i,w) in f$. By construction of $f$: 
  $
      (s(i), h(i,w)) in f
  $
  suppose $c eq.not h(i,w) "s.t." (s(i), e) in f$. 
  $
    f backslash {(s(i), e)} "is satisfied and properly contained in" f \
    arrow.double "impossible"
  $

])

== Semantics

The following two definitions are equal: 

#def("1", [
  A mapping $v: "PROP" arrow {0,1}$ is a valuation if: 
  - $v(p_i) in {0,1}$ for all $i in NN$ and $v(bot) = 0$
  - $v(phi and psi) = min(v(phi), v(psi))$
  - $v(phi or psi) = max(v(phi), v(psi))$
  - $v(phi arrow psi) = max(1 - v(phi), v(psi))$
  - $v(phi arrow.l.r psi) = 1 arrow.double.l.r v(phi) = v(psi)$
  - $v(not phi) = 1 - v(phi)$ 
])

#def("2", [
  A mapping $v: "PROP" arrow {0,1}$ is a valuation if: 
  - $v(p_i) in {0,1}$ for all $i in NN$ and $v(bot) = 0$
  - $v(phi and psi) = 1$ iff $v(phi) = v(psi) = 1$
  - $v(phi or psi) = 1$ iff $v(phi) = 1$ or $v(psi) = 1$
  - $v(phi arrow psi) = 0$ iff $v(phi) = 1$ and $v(psi) = 0$
  - $v(phi arrow.l.r psi) = 1$ iff $v(phi) = v(psi)$
  - $v(not phi) = 1$ iff $v(phi) = 0$
])

== Tautology 

#def("3", [
  Let $Gamma$ be a set propositions, $phi$ is a tautology if $forall v$ valuation, 
  $
    Gamma tack.rr arrow.double.r.l forall v: ([psi]_v = 1 " for all " psi in Gamma) arrow.double.r.l [phi]_v = 1
  $
])
 
=== Reductio ad absurdum 

What does it mean having the bottom as a logical consequence? We have: 

$
  Gamma, not alpha tack.rr bot arrow.double Gamma tack.rr alpha
$

Let's provide a valuation for the bottom symbol. 

$
  forall v. [abs(bot)]_v = 0
$

But if I have something like this: 

$
  Delta tack.rr bot 
$
Let's try to reason about it using the definition: 
$
forall v. [abs(Delta)]_v = 1 arrow.double [abs(bot)]_v = 1
$
Now let's see the meta-conjuction as a disjunction using this theorem: 
$
  A arrow B := not A or B
$

So: 
$
  underbrace([abs(Delta)]_v eq.not 1, forall v. exists gamma in Delta "s.t." [abs(gamma)]_v = 0) or underbrace([abs(bot)]_v = 1, "false")
$

This is the meaning of having the bottom has a logical consequence. So: 

$
  forall v . exists gamma in Delta "s.t." [abs(gamma)]_v = 0 arrow Gamma union {not alpha} "unsat so" Gamma tack.rr alpha 
$

From this, we get the following principles:

- $not alpha arrow.double.l.r.long alpha arrow bot$ 
- $Gamma, alpha tack.rr beta arrow.double.long.l.r Gamma tack.rr alpha arrow beta$
Let's unwrap this using the rules we have just shown: 

$
  Gamma, not alpha tack.rr bot arrow.double.long not alpha arrow bot 
$

So we can derive intuitively the following:

$
  not not alpha equiv alpha
$

We proved the left ($arrow.l$) direction, but let's now prove the right ($arrow.r$) direction:

$
  forall v. ([abs(Gamma)]_v = 1 arrow.double [abs(alpha)]_v = 1) arrow.double.long.l.r forall v. ([abs(Gamma)]_v = 1 arrow.double [abs(not not alpha)]_v = 1)
$

== Natural Deduction

We now consider the persective of the so-called: inference making. 
The origin of modern notion of inference making? 
*David Hilbert* proposed a system called *Hilbert-style Deductive System* which is a set of axioms and inference rules. Several mathimaticians understood that this style is not very close to the usual practice of reasoning, so Gentzen proposed *Sequent Calculi* and *Natural Deduction*. In the 60', Dag Brawitz structured Natural Deduction and wrote a beutiful reference called *Natural Deduction: A Proof Theoritical Study*, which is the very first step towards automated theorem proving. 

The structure of Natural Deduction is based on the notion of a _proof tree_, which is a tree where each node is a formula and each edge is an inference rule. The root of the tree is the conclusion and the leaves are the premises.

#align(center, 
prooftree(rule(
  label: [Label],
  name: [Rule name],
  [Premise 1],
  [Premise 2],
  [Premise 3],
  [Conclusion],
)
))

There are usually two kind of rules: 

- *Introduction rules*: they introduce a new connective in the conclusion.
- *Elimination rules*: they eliminate a connective from the premises.

For example: 

// Elimination of implication 
- Elimination rule for implication: #align(center, 
prooftree(rule(
  name: $arrow E$,
  $phi arrow psi$,
  $phi$,
  $psi$,
)))
- Introduction rule for implication: #align(center,
prooftree(rule(
  name: $arrow I$,
  $Gamma, phi tack psi$,
  $Gamma tack phi arrow psi$,
)))

Let's prove some basic tautologies: 

- $A arrow A$
#align(
center,
prooftree(rule(
  name: $arrow I^1$,
    $[A]^1$,
  $A arrow A$,
))
)

Let's now add the *Conjunction* rule: 

- Introduction rule for conjunction: #align(center,
prooftree(rule(
  name: $and I$,
  $phi$,
  $psi$,
  $phi and psi$,
))
)
- Elimination and introduction rule for conjunction: #align(center, [
#prooftree(rule(
  name: $and E_1$,
  $phi and psi$,
  $phi$,
))
#prooftree(rule(
  name: $and E_2$,
  $phi and psi$,
  $psi$,
))
]
)
- Introduction and elimination rule for disjunction: #align(center, [
#prooftree(rule(
  name: $or I_1$,
  $phi$,
  $phi or psi$,
))
#prooftree(rule(
  name: $or I_2$,
  $psi$,
  $phi or psi$,
))
#prooftree(rule(
  name: $or E$,
  $phi or psi$,
  $Gamma, phi tack chi$,
  $Gamma, psi tack chi$,
  $Gamma tack chi$,
))]) Elimination rule for disjunction is a bit more complex, since it requires two premises and a conclusion and it introduce proof by cases.
- Ex falso: #align(center,
  prooftree(rule(
    name: $bot E$,
    $bot$,
    $phi$,
  ))
) Ex falso is accepted also in intuitionistic logic, but the following is not:
- Reductio ad Absurdum (RAA), a *strong* classical principle
#align(center, 
  prooftree(
    rule(
      name: "RAA",
      $Gamma, not phi tack bot$,
      $Gamma tack phi$,
    )
  )
)
- Tertium non datur: #align(center, 
  prooftree(
    rule(
      name: "TND",
      $phi or not phi$,
    )
  )
)

  In a classical context you always know if a formula is true or false.
  In order to prove this, I need to use the RAA rule.

  #align(center, 
  prooftree(
    rule(
    name: $arrow E$,
    rule(
      $not alpha or alpha$,
      $not (alpha or not alpha)$,
      $bot$,
    ),
    $alpha or not alpha$
    )
  ))

  // Continua a casa


#thm("Pierce's law", [
  Pierce's law is a theorem in propositional logic that states:
$
  ((P arrow Q) arrow P) arrow P
$ 
])

The computational equivalent of Pierce's law is the type of the constructor *call_cc* in Scheme. The derivation of Pierce's law is interesting since
we need to use the classical principles: 

#align(center, 
  prooftree(
    rule(
      name: $arrow I^3$,
      rule(
        name: $"RAA"^2$,
        rule(
          name: $arrow E$,
          rule(
            name: $arrow E$,
            rule(
              name: $arrow I^1$,
              rule(
                name: "EF",
                rule(
                  name: $arrow E$,
                  $[alpha]^1$,
                  $[not alpha]^2$,
                  $bot$,
                ),
                $beta$
              ),
              $alpha arrow beta$
            ), 
            $[(alpha arrow beta) arrow alpha]^3$,
            $alpha$
        ),
        $not alpha$,
        $bot$
      ), 
      $alpha$
    ),
    $((alpha arrow beta) arrow alpha) arrow alpha$
  )
  )
)

This is the derivation of the Pierce's law.
Redundant rules can be eliminated, in some other deductive systems, but in Natural Deduction we need to keep them so we can close the derivation tree.

=== Derivation 

A derivation $phi$ is a finite tree of formulas where each node is a formula and each edge is an inference rule. The root of the tree is the conclusion and the leaves are the premises.

#def("Derivability", [
  Let $cal(L)$ be a language and $Gamma$ a set of formulas

    + $Gamma subset.eq "WFF"_(cal(L))$ derives $phi$ ($Gamma tack phi$) if there exists $Pi / phi$ s.t. $cal(H)p[Pi] subset.eq Gamma$
    + $phi$ is a theorem if $emptyset tack phi$
])

#def("Eliminability", [
  An inference rule $R$ is eliminable if for each derivation $Pi / phi$ in which $R$ is used there exists another derivation $Pi^* / phi$ in which $R$ is not used and $cal(H)p[Pi^*] subset.eq cal(H)p[Pi] subset.eq Gamma$.
])

#def("Equivalence", [
  Let's take two different deductive systems $I$ and $J$. $I$ and $J$ are equivalent if:
  $
    forall Gamma, phi, Gamma tack_I phi arrow.double.long.r.l Gamma tack_J phi
  $ 
])

Exercise for home: Prove that we can sussume / replace in the derivation,
EX FALSO by RAA and in the hint is copying the following proof: 

#thm("Example", [
Let's define $cal(N)$ natural deduction, with this set of rules: {EF, RAA, TND, $arrow I\/E$, $and I\/E$, $or I \/E$}.

$
  cal(N)^* := cal(N) backslash {"RAA"} union {"TND"}
$

*and $cal(N)$ and $cal(N)^*$ are equivalent.*
])
Proof: 
$
  forall phi$ $Pi / phi$ in $cal(N), exists Pi^* / phi$ in $cal(N)^*
$
$
  cal(H)p[Pi] = cal(H)p[Pi^*]
$
+ Base case: $Pi equiv phi$ is a derivation of length 1, then $Pi^* = Pi$.
+ Inductive step: $Pi = frac(Pi_1 dots Pi_k , phi)r$
  1. $r eq.not "RAA"$ by IH 
  $
    frac(Pi_1^* dots Pi_k^*, phi)r = Pi^*
  $
  2. $r = "RAA"$

  $
    Pi = prooftree(
      rule(
        name: "RAA",
        Pi_1,
        phi
      )
    )
  $

  $
    Pi^* = prooftree(
      rule(
        name: "TND",
        Pi_1^*,
        phi
      )
    )
  $

  FINIRE A CASA

== Soundness and Completeness


There are two main property about a logic that we would like to connect: syntax and semantics. To do that, we want to have soundness and completeness for the System.

$
  tack phi arrow.double.long.l.r tack.rr phi
$

Where $arrow.double.long$ is *soundness* and $arrow.double.long.l$ is *completeness*.

There's a nice application of the soundness theorem which is the following one: 

Note: 
$
tack phi arrow.long.double tack.rr phi tilde tack.rr.not phi arrow.long.double tack.not phi
$
since 
$
  A arrow B arrow.double.l.r not B arrow A
$

= First Order Logic

First Order Logic is a logical system that extends propositional logic by adding quantifiers and variables. It allows us to reason about objects and their properties. 

Sometimes I would like to express a formal language. 
Let's take this language: 

$
  cal(L) = {a^n b^n | n >= 0}
$

We have an alphabet: 

$
  <r_1, dots, r_n; a_1, dots, a_m; k > " with " r_i >= 0, a_j > 0
$

- Predicate symbols: $P_1, dots, P_n$ where $n$ is the arity of the predicate.
- Function symbols: $f_1, dots, f_m$ where $m$ is the arity of the function.
- Constant symbols: $c_1, dots, c_k$ where $k$ is the number of constants.
- Variables: $x_1, dots, x_l$ where $l$ is the number of variables. (countably many: $|"VAR"| = aleph_0$)
- Connectives: $not, and, or, arrow, arrow.l.r, bot, forall, exists$
- Auxialiary symbols: $(, )$

#def("Terms", [
  TERM is the smallest set $X$ with the properties: 

  - $c_i in X (i in I)$ and $x_i in X (i in N)$.
  - $t_1, dots, t_(a_i) in X arrow.long.double f_i(t_1, dots, t_(a_i)) in X$ for $1 <= i <= m$.

  TERM is our _set of terms._
])

#def("Formulas", [
  FORM is the smalles set $X$ with the properties:
  - $bot in X; P_i in X$ if $r_i = 0; t_1, dots, t_(r_i) in$ TERM $arrow.long.double P_i(t_1, dots, t_(r_i)) in X; t_1, t_2 in$ TERM $arrow.double t_1 = t_2 in X$,
  - $phi, psi in X arrow.long.double (phi and psi), (phi or psi), (phi arrow psi), (psi arrow.l.r phi) in X$,
  - $phi in X arrow.long.double (not phi) in X$,
  - $phi in X arrow.long.double (forall x_i phi), (exists x_i phi) in X$.  
])

#def("Induction for terms", [
  Let $A(t)$ be a property of terms. If it holds for $t$  a variable or a constant and if $A(t_1), dots A(t_n) arrow.double A(f(t_1, dots, t_n))$ for all function $f$ then $A(t)$ holds for all $t in$ TERM.
])

#def("Induction for formulas", [
  Let $A(phi)$ be a property of formulas. If:

  - $A(phi)$ for atomic $phi$
  - $A(phi)$ and $A(psi)$ implies $A(phi and psi), A(phi or psi), A(phi arrow psi), A(psi arrow.l.r phi)$
  - $A(phi)$ implies $A(not phi)$
  - $A(phi)$ implies $A((forall x_i)phi, A((exists x_i)phi)$ for all $i$ then $A(phi)$ holds for all $phi in$ FORM.
])


#def("Free variables", [
  The set $"FV"(t)$ of free variables of $t$ is defined by: 

  - $"FV"(x_i) := {x_i}$, $"FV"(overline(c)_i) := emptyset$
  - $"FV"(f_i(t_1, dots, t_(a_i))) := "FV"(t_1) union dots union "FV"(t_n)$
])


#def("Free variables for formuals", [
  The set $"FV"(t)$ of free variables of $t$ is defined by: 

  - $"FV"(P(t_1, dots, t_n)) := "FV"(t_1) union dots union "FV"(t_n)$
  - $"FV"(t_1 = t_2) := "FV"(t_1) union "FV"(t_2)$
  - $"FV"(phi and psi) := "FV"(phi) union "FV"(psi)$, $"FV"(phi or psi) := "FV"(phi) union "FV"(psi)$, $"FV"(phi arrow psi) := "FV"(phi) union "FV"(psi)$, $"FV"(psi arrow.l.r phi) := "FV"(phi) union "FV"(psi)$
  - $"FV"(forall x_i phi) := "FV"(exists x_i phi) := "FV"(phi) - {x_i}$
])

#def("Closed variables", [
  $phi$ is closed variable if 
  $
    "FV"(phi) = emptyset
  $
  A closed formula is also called a _sentence_. 
  A formula without quantifiers is called _open_ formula. 
])

#def("Subformulas", [
  A subformula can be inductively defined:
  - $"sub"(phi) = {phi}$
  - $"sub"(phi dot.big psi) = "sub"(phi) union "sub"(psi) union {phi dot.big psi}$ for $dot.big in {and, or, arrow, arrow.l.r}$
  - $"sub"(not phi) = "sub"(phi) union {not phi}$
  - $"sub"(forall x_i phi) = "sub"(exists x_i phi) = "sub"(phi) union {forall x_i phi, exists x_i phi}$
])

#def("Free and Bound occurrences", [
An occurence of a variable $x$ in $delta$ is BOUND, if $x$ occurs in $phi in "sub"{delta}$ and $phi equiv {"Q"x.phi}$ ... FINIRE A CASA
])

#def("Substitution", [
  We define substitution of a variable $x$ with a term $t$ in a formula $phi$ as follows:
  $
    phi[t\/x]
  $
  if $x$ is free:
  $
  phi[t\/x] = (dots t dots)
  $
  if $x$ is bound:
  $
  phi[t\/x] = (dots x dots)
  $
  So $t$ needs to be free for $x$ in $phi$.
])


But first let's show some other theorem using Natural Deduction.

#ex[
  _Proof._ $
  tack underbrace((phi arrow exists x.phi(x)),alpha) arrow underbrace(exists x. (phi arrow psi(x)), beta)
  $

  This is not a theorem in general, we'll need to fix some constraints: $x in.not F V(phi)$. 
  We could try to understand if we are dealing with classical principles. Let's break down how to approach this derivation:
    - ($phi arrow exists x. phi(x)$) will probably need to be derived using the $arrow I$ rule, so we need to assume $phi$ and derive $exists x. phi(x)$. So 
    $
      (phi arrow exists x . psi(x)) in cal(H)p[Pi]
    $
    - I 'destroy' these subformulas: $phi arrow exists x. psi(x)$ since I want to extract the body formula $psi$ and use it inside the second part of the theorem. The idea is to use $psi(x) in beta$.
    - $exists x. psi(x)$ eliminate the $exists$ and derive from $psi(x)$ something of interest like $beta$ with $exists E$.
    - Try to start from $not beta$ to derive $bot$ and then derive $beta$.)

  #prooftree(
      rule(
        rule(
          rule(
            rule(
              rule(
                rule(
                  rule(
                    name: $not E$,
                    rule(
                      name: $exists E^1$,
                      rule(
                        name: $arrow E$,
                        $[phi]^2$,
                        $[phi arrow exists x. psi]^4$,
                        $exists x. psi$,
                      ),
                      rule(
                        name: $exists I$,
                        rule(
                          name: $arrow I$,
                          $[psi]^1$,
                          $phi arrow psi$,
                        ),
                        $exists x. (phi arrow psi)$,
                      ),
                      $exists x. (phi arrow psi)$,
                    ),
                    $[not (exists x. (phi arrow psi))]^3$,
                    $bot$,
                  ),
                  $psi$
                ),
                $phi arrow psi$
              ),
              $exists x . (phi arrow psi)$
            ),
            $[not (exists x. (phi arrow psi))]^3$,
            $bot$
          ),
          $exists x. (phi arrow psi)$
        ),
      $(phi arrow exists x . psi) arrow (exists x. (phi arrow psi(x)))$
    ) 
  )
]

== Completeness Theorem

We want to prove exactly this:
$
  tack.rr phi arrow.double.long tack phi
$
_If for each structure it's satisfafiable then we can derive it._ 
This proof was firstly formulated by Kurt Godel. 
Before jumping into the proof wen need to introduce an important concept of *Consistent Sets*.
Note that $W F F$ stands for the set of well-formed formulas.
$
  Gamma subset.eq W F F_(cal(L)) &"is consistent if" Gamma tack.not bot\
  & "not consistent if" Gamma tack bot 
$

We also need to introduce the notion of _maximally consistent sets_.
#def("Characterization of inconsistent Set")[
  $
  Gamma tack bot arrow.long.double.l.r forall phi . Gamma tack phi arrow.long.double.l.r exists phi . Gamma tack phi and Gamma tack not phi
  $
]

#def("Maximally consistent set")[
  $
  Gamma tack.not bot &Gamma "is maximally consistent if " Delta tack.not bot, Gamma subset.eq Delta arrow.long.double Gamma = Delta
  $
]

Let's define these other propositions:

#def("Proposition 1")[
  $
    Gamma subset.eq W W F_(cal(L)) "if" Gamma tack bot "then" forall L "interpration"\
    U and rho_U, rho_U tack.rr Gamma
  $
  If theres a structure that satisfy Gamma, the set is consistent. Equivalently: 
  $
    "if" exists U.rho_U s.t. U . rho_U tack.rr Gamma arrow.long.double Gamma tack.not bot
  $
]

Our main proposition GOAL is: 
$
  Gamma subset.eq (W W F)_(cal(L)) "if" Gamma tack.not "then" Gamma "sat".
$
This is the key result for the completeness theorem. 

=== Proof 

We'll include only a fragment of the possible connectives: ${and, arrow, bot, forall}$.
But we want to reason in an existential style since it's better to find a weakness in respect to find a universal argument. Let's define some abbreviations like:
$
  not phi := phi arrow bot\
  exists x. phi := not forall x. not phi
$
The first defintion is the one of *Henkin Set*: 

#def("Henkin Set")[
  $Gamma subset.eq (W F F )_cal(L)$ is an Henkin Set if for each $exists x. phi(x)$ there exists a constant $c$ such that:
  $
    Gamma tack  exists x . phi(x) arrow phi(c)
  $
  Notice that we extending the language.
]

#def("Proposition 2")[
  If $Gamma$ is an Henkin Set and $Delta subset.eq W F F_cal(L)$ with respect $Gamma subset.eq Delta$, $Delta$ is an Henkin Set. 
]

We'll now have to introduce the notion of 'H-extension'.

#def("H-extension")[
  This defintion is split in two parts:
  - $L$ language, we call 'H-extension' of $L$ a new language $L^H$ obtained by adding to the set of constants of $L$ the following set: 
  $
    H C = {c_phi | exists x . phi "is an L formula" }
  $
  - Given $Gamma subset.eq W F F_cal(L)$, the 'H-extension' of $Gamma$ with $L^H$ formulas is:
  $
    Gamma union {exists x. phi(x) arrow phi(c_phi) | exists x. phi "is in" L "and" c_phi in H C  }
  $
]

So I would like to connect derivability from the L language also in the H-extension.

#def("Lemma 4")[
  Suppose $Gamma union {phi}$ and $Gamma tack phi$. If I am deriving this in the H-extension of the language then I can derive it in the original language.
  $
    Gamma tack_(L^H) phi arrow.long.double.l.r Gamma tack_L phi
  $
  The cardinality fo the language: 
  $
    hash[cal(L^H)] = hash[cal(L)] \
    hash[cal(L)] = max(hash[R], hash[F], hash[C], aleph_0)
  $


  #ex[
  We know that $aleph_0 = abs(NN)$. 
  Also $abs(ZZ) = abs(QQ) = aleph_0$. Also if I take the set of $abs("Prime") = aleph_0$. If you can find a bijection between the set of natural numbers and another set, you can say it's countable.
  Also $abs(RR) = 2^(aleph_0).$
  ]
]

We skip the proof of the Henkin extension (Lemma 5), but we can say that it is a very important result in order to prove the completeness theorem.

#def("Lemma 6")[
  $Gamma$ formulas is $W F F_cal(L)$,
  $
    forall phi in cal(L), underbrace(Gamma^H,"Henkin Extension") tack phi arrow.long.double Gamma tack phi
  $
]

Another proposition that follows:

#def("Proposizione 7")[
  $Gamma subset.eq W F F_cal(L)$, if $Gamma$ consistent ($Gamma tack.not bot$) $arrow.double.long$ $Gamma^H tack.not bot$.
]

#def("Henkin Closure")[
  $Gamma subset.eq W F F_cal(L)$, consider the following sequence:
  $
    &Gamma_0 = Gamma " if " L = L_0\
    &Gamma_(i+1) = (Gamma_i)^H " if " L_(i+1) = L_i^H
  $ 
  The *Henkin closure* of $Gamma$:
  $
    Gamma^* = union_{i in NN} Gamma_i "     " L^* = union_{i in NN} L_i
  $ 
]

#def("Theorem 9 ")[
  $Gamma subset.eq W F F_cal(L)$ and $Gamma tack.not bot$:

  + $\#[Gamma^*] = \#[Gamma]$
  + $Gamma^* tack.not bot$ (This proof is _required_)
  + $Gamma^*$ is a Henkin Set
  + $forall phi in W F F_cal(L)$, $Gamma^* tack phi arrow.double Gamma tack phi$ 
]

If you want to a more classical proof, we need to use a very different semantics 
for the first order language: 

#ex()[
  _Proof of Point 2 of Theorem 9_:
  $
    Gamma^* tack.not bot
  $
  Suppose $Gamma^* tack bot$. Then there exists a finite set $Sigma^0$ ($Sigma^0 subset.eq Gamma$) such that
  $Sigma^0 tack bot$ and $Sigma^0 eq.not emptyset$.
  $Sigma^0 = {phi_0, dots, phi_n}$, there exist $n$ such that:
  $
    Gamma_i_i, dots, Gamma_i_n "in the Henkin sequence" ("not nec" Gamma_i_j eq.not Gamma_i_z)
  $
  such that $phi_1 in Gamma_i_1$, dots, $phi_n in Gamma_i_n$.
  Let $m = max(i_1, dots, i_n)$ then $Sigma^0 subset.eq Gamma_m$. 
  $
    Gamma_m tack bot arrow.long.double "impossible"
  $
]

#def("Intermezzo: Zorn's Lemma (Hausdroff's' 1914)")[
  Let $<U, <= >$ be a partially ordered set such that every $V subset.eq U$ which is
  totally ordered by $<=$ has an upper bound in $U$. Then $U$ has a maximal member $z$
  w.r.t  $<=$ (no $x in U$ such that $x >= z$).

  Zorn's Lemma is equivalent to _Axiom of Choice_. 
]

#def("Theorem 10 (Lindenbaum's Lemma)")[
  $Gamma subset.eq W F F_cal(L)$, $exists Gamma^"MC"$, $Gamma subset.eq Gamma^"MC"$ such that:
  $
    Gamma^"MC" "maximally consistent"\
    Gamma^"MC" "is an Henkin Set"
  $


#ex()[
  _Proof._
  Given that $Gamma^*$ is consistent and Henkin.
  $
    E(Gamma^*) = { Delta | Delta tack.not bot, Delta subset.eq W F F_cal(L), Gamma^* subset.eq Delta}
  $
  Take $<E(Gamma^*), subset.eq>$, which is a partially ordered set.
  Let $Sigma = union.big_k Delta$ where $k$ is a chain in $E(Gamma^*)$.

  - $Sigma$ is an upper bound of $k$. 
  - $Sigma tack.not bot$.

  For RAA, suppose $Sigma tack bot$. As for the previous proofs, there exists $Sigma^0 subset Sigma$
  such that $Sigma^0 tack bot$ which is not empty and I can say that $Sigma^0 = {phi_1, dots, phi_n}$. 
  then $exists n$ elements $k_1, dots, k_n$ is the chain $k$ such that $phi_1 in underbrace(k_1, Delta_i_j), 
  dots, phi_n in underbrace(k_n, Delta_n_j)$.
  Since $K$ is an ordered chain ($subset.eq$), $exists K^+$ such that $Sigma^0 subset.eq K^+ arrow.double K^+ tack bot$.
  Which is not possible.  

  By Zorn's Lemma, if we consider the construction $< E(Gamma^*), subset.eq >$ has an upper bound $(Gamma^*)^"MC"$
  which is an Henkin Set and also maximally consistent. 
  So $Gamma subset.eq Gamma^*$. $square$
]
]
