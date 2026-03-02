#set document(
  title: "Document Title",
  author: "Karol Broda",
  date: auto,
)

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 3cm),
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
)

#set heading(numbering: "1.")

#set par(
  justify: true,
  leading: 0.65em,
)

#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[Document Title]
  #v(1em)
  #text(size: 14pt)[Karol Broda]
  #v(0.5em)
  #text(size: 12pt, style: "italic")[#datetime.today().display()]
]

#pagebreak()

= introduction

write content here
