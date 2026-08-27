#let conf(
  title: (),
  profs: (),
  accademic_year: (),
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
  set text(font: "New Computer Modern", size: 11pt, lang: "it")
  set par(justify: true, leading: 0.75em)
  set heading(numbering: "1.1")
  show heading: set block(above: 1cm)
  show heading: smallcaps
  show title: set text(weight: "thin", size: 18pt)

  // Heading styling
  show heading.where(level: 1): it => {
    v(1.5em)
    it
    v(0.8em)
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

  pagebreak()

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
