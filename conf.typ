
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
  set page(header: context {
    // Gets the last heading before the current page and uses it as the header text
    let headings = query(selector(heading.where(outlined: true)).before(here()))

    let header-text = if headings.len() > 0 {
      headings.last().body
    }

    align(right, text(size: 9pt, header-text))
  })
  set text(font: "New Computer Modern", size: 11pt, lang: "it")
  set par(justify: true, leading: 0.75em)
  set heading(numbering: "1.1")
  show heading: smallcaps
  show title: set text(weight: "thin", size: 18pt)
  // We love old school math

  // Heading styling
  show heading: it => {
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

#let eq(eq) = math.equation(block: true, eq)
