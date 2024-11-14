#import "@preview/physica:0.9.3": *
#import "@preview/touying:0.5.3": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.title,
  config-info(
    title: [An Introduction to Quantum Error Correction],
    subtitle: [with a particular appetite for surface code],
    author: [Yiming Zhang],
    date: datetime.today(),
    institution: [USTC],
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))
#let highlightMath(x) = text(fill: red)[$#x$]

#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 1em, depth: 1)

= Background

---

== Stabilizers

A compact #underline[representation of quantum states] with (signed) Pauli operators:

$|Psi angle.r = 1 / sqrt(2) |000 angle.r + |111 angle.r arrow.stroked angle.l +X X X, + Z Z I, + I Z Z angle.r$

The state $|Psi angle.r$ is _stabilized_ by the 3 independent stabilizers.

For complex states, it's tedious or even impossible to write down the full state vector. The stabilizer representation comes to rescue.

---

== Stabilizer Projector


---

== Errors

The sign of a stabilizer is useful for detecting errors. For a _Pauli error_ $E$ that anticommutes with a stabilizer $S$:

$|Psi angle.r = highlightMath(S)|Psi angle.r arrow.long.r^E E|Psi angle.r = E S|Psi angle.r = highlightMath(-S) E|Psi angle.r$


= Surface Code

---

= Experiment Progress

---
