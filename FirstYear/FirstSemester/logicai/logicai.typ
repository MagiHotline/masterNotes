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

