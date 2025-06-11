#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.title,
  config-info(
    title: [Fault-tolerant Quantum Computation based on Surface Code],
    subtitle: [],
    author: [Yiming Zhang],
    date: datetime(year: 2025, month: 6, day: 13),
    institution: [The University of Science and Technology of China],
  ),
)
#show link: underline
#show figure: set align(center + horizon)
#show figure.caption: set text(10pt)

#show heading.where(level: 1): set heading(numbering: numbly("{1}."))
#let highlightMath(x) = text(fill: red)[$#x$]

#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 1em, depth: 1)

= Quantum Computation and Quantum Error Correction

---

== The Promise of Quantum Computation

#lorem(30)

== Build a Quantum Computer

#lorem(30)

== Face the Enemy: Noise

#lorem(30)

== Practical Quantum Advantage

#lorem(30)

== Quantum Error Correction(QEC)

#lorem(30)

== Quantum Error Correction Codes(QECC)

#lorem(30)

== Topological Quantum Error Correction

#lorem(30)

== Experimental Progress on QEC

#lorem(30)

= Fault-tolerant Surface Code Computation

---

== Toric Code

#lorem(30)

== Surface Code

#lorem(30)

== Universal Gateset: Paulis

#lorem(30)

== Universal Gateset: Initialization and Measurement

#lorem(30)

== Universal Gateset: $H$

#lorem(30)

== Universal Gateset: $S$

#lorem(30)

== Universal Gateset: CNOT

#lorem(30)

== Universal Gateset: T

#lorem(30)

== Universal Gateset: CCZ

#lorem(30)

== Yoked Surface Code

#lorem(30)

== 3D Spacetime Diagram

#lorem(30)

= Surface Code Compilation

== Pauli-based Compilation

#lorem(30)

== Clifford + T Compilation

#lorem(30)

== TQEC Project

#lorem(30)

#focus-slide[
  Thanks for your attention!

  #align(center + bottom)[
    #set text(size: 0.5em)
    The slides are available online: \
    https://github.com/inmzhang/surface_code_quantum_computation/tree/talk/ymsc
  ]
]

#show: appendix

= Appendix <touying:unoutlined>

== Bibliography

#bibliography("./references.bib", title: none)

== Useful Links

#set list(marker: "• 🔗")

- Link to the source code of #link("https://github.com/inmzhang/surface_code_quantum_computation/tree/talk/ymsc")[this slides].
- Link to #link("https://github.com/tqec/tqec")[TQEC Github repository].
- Link to #link("https://github.com/inmzhang/awesome-tqec")[list of resources] to learn more about this topic.
