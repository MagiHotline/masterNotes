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
  forall phi$ $Pi / phi$ in $cal(N), exists Pi^* / phi$ in $cal(N)
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





/* Examples 


#let tree = rule(
  label: [Label],
  name: [Rule name],
  [Premise 1],
  [Premise 2],
  [Premise 3],
  [Conclusion],
)

#prooftree(tree)

#let variable = prooftree(rule(
  name: [Variable],
  $Gamma, x : A tack x : A$,
))
#let abstraction = prooftree(rule(
  name: [Abstraction],
  $Gamma, x: A tack P : B$,
  $Gamma tack lambda x . P : A => B$,
))

#let application = prooftree(rule(
  name: [Application],
  $Gamma tack P : A => B$,
  $Delta tack Q : B$,
  $Gamma, Delta tack P Q : B$,
))

#let weakening = prooftree(rule(
  name: [Weakening],
  $Gamma tack P : B$,
  $Gamma, x : A tack P : B$,
))

#let contraction = prooftree(rule(
  label: [Contraction],
  $Gamma, x : A, y : A tack P : B$,
  $Gamma, z : A tack P[x, y <- z]: B$,
))

#let exchange = prooftree(rule(
  label: [Exchange],
  $Gamma, x : A, y: B, Delta tack P : B$,
  $Gamma, y : B, x: A, Delta tack P : B$,
))

#align(center, rule-set(
  variable,
  abstraction,
  application,
  weakening,
  contraction,
  exchange
))

#thm("ciao", lorem(100))
*/

