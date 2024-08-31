#import "@preview/codly:1.0.0": *
#import "@preview/subpar:0.1.1"


// Template
#let conf(
  title: none,
  subject: none,
  students: (),
  teachers: (),
  auxiliaries: (),
  assistants: (),
  lab-assistants: (),
  due-date: none,
  university: none,
  faculty: none,
  department: none,
  logo: none,
  course-code: none,
  course-name: none,
  doc
) = {
  // Seteo general del documento
  set document(title: title, author: auxiliaries)

  set page(
    "us-letter",
    margin: (top: 4.46cm, bottom: 2.7cm, right: 2.54cm, left: 2.54cm),
    header: [
    #set align(left)
    #set text(11pt)
    #stack(
      dir: ttb,
      spacing: 4pt,
      [#stack(
        dir: ltr,
        spacing: 1fr,
        [#stack(
          dir: ttb,
          spacing: 6pt,
          [#university],
          [#department],
          [#course-code #course-name]
        )],
        logo
      )],
      [#line(length: 100%, stroke: 0.4pt)]
    )
  ],
    footer: [#stack(
      dir: ttb,
      spacing: 4.5pt,
      line(length: 100%, stroke: 0.4pt),
      [#h(1fr) #context counter(page).display(here().page-numbering())]
    )],
    numbering: "1"
  )

  set par(leading: 0.55em, justify: true)
  set heading(numbering: "1.")
  set text(size: 11pt, font: "New Computer Modern", lang: "es")
  set raw(syntaxes: "template/assets/syntaxes/Arduino.sublime-syntax")
  show raw: set text(size: 11pt, font: "New Computer Modern Mono")
  show bibliography: set par(justify: false)
  set bibliography(style: "institute-of-electrical-and-electronics-engineers")

  
  // Resize de títulos y subtítulos
  let font-sizes = (17.28pt, 14.4pt, 12pt)
  show heading: it => block(above: 1.4em, below: 1em)[
    #let new-size = font-sizes.at(it.level - 1, default: 11pt)
    #set text(size: new-size)
    #if it.numbering == none {
      it.body
    } else [
      #context counter(it.func()).display() #h(10pt) #it.body
    ]
  ]

  
  // Título
  let place-people(people, single-people-str, multiple-people-str) = {
    let num-people = people.len()
    if num-people == 0 {()}

    let identifier = if num-people == 1 {
      single-people-str
    } else {
      multiple-people-str
    }

    return [*#identifier* #people.join(", ")]  
  }

  align(center)[
    #text(size: 20pt)[#title] \
    #if subject != none { text(size: 14pt)[#subject] } else { none }
    
    #place-people(teachers, "Profesor:",   "Profesores:")
    #place-people(auxiliaries, "Auxiliar:", "Auxiliares:") \
    #place-people(assistants, "Ayudante:", "Ayudantes:")

    *Fecha de entrega:* #due-date
  ]


  // Modifica enum para enumerar preguntas
  // set enum(numbering: n => return [*P#n.*], tight: false)

  // Modifica apariencia de tablas
  show table.cell.where(y: 0): strong
  set table(
    stroke: (_, y) => (
      left: 0pt,
      right: 0pt,
      top: if y == 1 { 1pt } else { 0pt },
      bottom: 1pt
    ),
    inset: (x, y) => if y == 0 { 8pt } else { 5pt }
  )

  // Usa el paquete Codly para modificar la apariencia de códigos
  show figure.where(kind: raw): set figure(supplement: "Código")
  
  let icon(codepoint) = {
    box(
      height: 0.8em,
      baseline: 0.05em,
      image(codepoint)
    )
    h(0.1em)
  }
  
  show: codly-init.with()
  codly(languages: (
    python: (
      name: "Python",
      icon: icon("template/assets/logos/python.svg"),
      color: rgb("#FFC331")
    ),
    rust: (
      name: "Rust",
      icon: icon("template/assets/logos/rust.svg"),
      color: rgb("#CE412B")
    ),
    arduino: (
      name: "Arduino",
      icon: icon("template/assets/logos/arduino.svg"),
      color: rgb("#00878F")
    )
  ))

  // Figuras pueden ser contenidas en múltiples páginas
  show figure: set block(breakable: true)
  

  // Comienzo del documento
  doc
}


// Crea función para subfigures
#let subfigures = subpar.grid.with(
  gap: 1em,
  numbering-sub-ref: "1.a",
)


// Misc: configuraciones extra
#let months = ("January": "Enero", "February": "Febrero", "March": "Marzo", "April": "Abril", "May": "Mayo", "June": "Junio", "July": "Julio", "August": "Agosto", "September": "Septiembre", "October": "Octubre", "November": "Noviembre", "December": "Diciembre")

#let month = datetime.today().display("[month repr:long]")
#let today = datetime.today().display("[day] de [month repr:long] de [year]").replace(month, months.at(month))