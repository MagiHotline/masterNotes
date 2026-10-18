#import "@preview/curryst:0.6.0": rule, rule-set, prooftree
#import "@preview/showybox:2.0.4": *
#import "@preview/hydra:0.6.3": hydra
#import "@preview/theorion:0.6.0": *


#let conf(
  title: (),
  profs: (),
  accademic_year: (),
  accent-color: rgb("#1d3557"),
  uni: "Università degli Studi di Verona",
  author: (
    (
      name: "Imbriani Paolo",
      email: "paolo.imbriani@studenti.univr.it",
      mat: "VR553697",
    )
  ),
  doc,
) = {

  // Global document setup
  set document(title: title, author: author.name)
  set page(paper: "a4", margin: (y: 5em), numbering: "1", header: context {
    if calc.odd(here().page()) {
      align(right, emph(hydra(1)))
    } else {
      align(left, emph(hydra(2)))
    }
    line(length: 100%)
  })
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => pagebreak(weak: true) + it
  set text(font: "New Computer Modern", size: 11pt, lang: "it")
  set par(justify: true, leading: 0.75em)
  set heading(numbering: "1.1")
  show heading: smallcaps
  show title: set text(weight: "thin", size: 18pt)

  // Heading styling
  show heading: it => {
    v(14pt)
    it
    v(7pt)
  }

  place(
    top + center,
    clearance: 2em,
    {
      v(3cm)
      image("UniversityofVerona.png", width: 30%)
      v(30pt)
      title
      par(justify: true)[
        #uni \
        #author.name, #author.mat \
        #link("mailto: " + author.email)[#author.email] \
        Professor #profs
      ]
    },
  )

  place(bottom + center, {
    v(20pt)
    text(size: 9pt, fill: luma(120))[Anno Accademico #accademic_year]
  })

  // Table of contents
  //show outline.entry.where(level: 1): set block(above: 1cm)
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner()),
  )
  outline()
  pagebreak()

  doc
}

#let thm(title, content) = {
  v(8pt)
  showybox(
  title: [
 Theorem:  #title],
  frame: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),
  breakable: true
)[
 #content
]
  v(8pt)
}

#let def(title, content) = {  
  v(8pt)
  showybox(
  title: [
 Definition:  #title],
  frame: (
    border-color: green,
    title-color: green.lighten(30%),
    body-color: green.lighten(95%),
    footer-color: green.lighten(80%)
  ),
  breakable: true
)[
 #content
]
  v(8pt)
}


#let ex(content) = {
  v(8pt)
  showybox(
  title: "Example",
  frame: (
    border-color: orange,
    title-color: orange.lighten(30%),
    body-color: orange.lighten(95%),
    footer-color: orange.lighten(80%)
  ),
  breakable: true
)[
 #content
]
  v(8pt)
}
