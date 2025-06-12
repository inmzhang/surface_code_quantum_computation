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

= Quantum Error Correction

== The Promise of Quantum Computer

_Quantum Computers_ are expected to solve certain exponentially hard classical
problems in polynomial time or provide superior speedup for some applications@dalzell2023:

- _Condensed Matter Physics:_ simulation of Fermi-Hubbard model, SYK model, etc.

- _Quantum Chemistry:_ computing electronic structure and vibrational structures.

- _Optimization:_ combinatorial optimization and continuous optimization problems.

- _Cryptography:_ breaking of RSA, ECC, and symmetric key cryptography.


== Build a Quantum Computer
#{
  set align(center + horizon)
  set text(size: 0.8em)
  grid(
    columns: (1fr, 2fr, 1fr),
    gutter: 2pt,
    [#image("./images/zuchongzhi.png")\ Superconducting Qubits],
    [#image("images/H2.png", width: 75%)\ Trapped Ions],
    [
      #image("images/neutral-atom.png")\ Neutral Atoms \ \
      #image("images/questionmark.png", width: 70%) \ Topological Qubits
    ],
  )
}

== Superconducting Quantum Computer

#slide[
  #figure(image("images/electronic-control.png", width: 75%))
  #set align(horizon + center)
  #set text(size: .5em)
][
  - #emph[Bottom: Quantum Processor(QPU)]
    - aluminum film on sapphire substrate
    - MBE, optical lithography, etc.
    - flip-chip bonding, TSV, etc.
    - dilution refrigerator

  - #emph[Middle: Control Electronics]
    - DAC, ADC, AWG, attenuator, filter, amplifier, etc.

  - #emph[Top: Control Software System]
    - abstraction of hardware details
    - quantum ISA (QCIS)
    - calibration and experiments
]

== Quantum Noise

Quantum systems are extremely sensitive to their environment, the interaction with
the environment, unexpected coupling between qubits, and nonideal control can
lead to unwanted evolution of quantum states, which can be characterized by a _quantum
channel_:

$
  cal(E)(rho) = sum_k A_k rho A_k^dagger
$


_Dephasing Channel:_ $cal(E)(rho) = (1 - p)rho + p Z rho Z^dagger$

_Amplitude Damping:_ $cal(E)(rho) = A_0 rho A_0^dagger + A_1 rho A_1^dagger, A_0 = mat(1, 0; 0, sqrt(1-p)), A_1 = mat(0, sqrt(p); 0, 0)$

_Depolarizing Channel:_ $cal(E)(rho) = (1 - p)rho + p/3 (X rho X^dagger + Y rho Y^dagger + Z rho Z^dagger)$

#text(size: 0.8em)[
  And more: Unitary Channel, Leakage Channel, Erasure Channel, etc.
]

== The limitations of NISQ

#slide[
  #figure(image("images/zuchongzhi3.png"))
  #figure(image("images/fidelity.png"))
  #set align(horizon + center)
  #set text(size: .5em)
][
  #set align(horizon)
  - #emph[Quantity]

    - 105 transmon qubits
    - 182 tunable couplers

  - #emph[Quality (benchmarked with parallel XEB)]

    - 99.90% single-qubit gate
    - 99.62% two-qubit gate(FSIM)
    - 99.18% readout
    - $72 mu s$ relaxation time($T_1$)
    - $58 mu s$ dephasing time($T_2^"CPMG"$)
]

---

_Random Circuit Sampling:_ demonstration of quantum advantage in NISQ on a carefully
designed task that is of no practical use@gao2025@wu2021.

#figure(image(
  "images/random-circuit-sampling.png",
  width: 100%,
)) <fig-random-circuit-sampling>

It is a benchmark for the NISQ hardware rather than a quantum application.

== Practical Quantum Advantage

_Practical quantum advantage_ requires qubits with ultra-high fidelity ($10^(-9) tilde 10^(-15)$) and
might run for weeks or more on quantum hardware@beverland2022b@riverlane2024report.

#grid(
  columns: (1fr, 0.9fr),
  gutter: 1em,
  image("images/quops.png"), image("images/fidelity-trend.png"),
)

It's not expected to achieve this level of fidelity by improving the hardware.

== Quantum Error Correction(QEC)

#grid(
  columns: (1.5fr, 1fr),
  gutter: 3em,
  [
    + *Encoding* information with redundancy:

      $
        |0⟩_L = 1 / sqrt(2) |00000⟩ + |11111⟩,\ |1⟩_L = 1 / sqrt(2) |00000⟩ + |11111⟩,
      $

    + *Detecting* errors by projection measurements:

      #figure(image("images/phase-kickback.png", width: 50%))

    + *Decoding* and correcting errors.
  ],
  image("images/parity-bits.png", width: 70%),
)

== Stabilizer Formalism


A compact #underline[representation of quantum states] with (signed) Pauli
operators:

$|Psi〉 = 1 / sqrt(2) |000〉 + |111〉 arrow.stroked angle.l +X X X, + Z Z I, + I Z Z〉$

The state $|Psi〉$ is _stabilized_ by the 3 independent stabilizers.

For complex states, it's tedious or even impossible to write down the full state
vector. The stabilizer representation comes to rescue.

== Quantum Error Correction Codes(QECC)
#grid(
  columns: (1fr, 1fr, 1fr),
  align: center + horizon,
  gutter: 1em,
  [#image("images/toric-code.png") #v(1em)Toric Code],
  [#image("images/steane-code.png", width: 80%) #v(1em) Color Code],
  [#image("images/bbcode.png") #v(1em) BB Code(QLDPC)],
)

#v(2em)
#align(center)[And more: Floquet codes, Subsystem codes, Bosonic codes, ...]

== Topological Quantum Error Correcting Codes


- _Stabilizer Formalism_ of the code:
  $
    S_p^(X) = product_(j in partial p) X_j, S_p^(Z) = product_(j in partial p) Z_j
  $
- _Hamiltonian system_ whose low-energy excitations are anyons:
  $
    H = - sum_(p in P) S_p^(X) - sum_(p in P) S_p^(Z)
  $
- _Anyon Model_ describing the anyon excitations of the system:
  #figure(image("images/color-anyons.png", width: 20%))
- _Symmetries_ between the anyonic excitations give rise to non-trivial
  domain walls and pointlike topological defects that can be utilized for
  fault-tolerant quantum protocols.

== Experimental Progress on QEC

#[
  #set text(size: 0.8em)
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #image("images/d3-zuchongzhi.png") #v(0.1em) $d=3$ Surface Code \ USTC 2022@zhao2022realization
    ],
    [
      #image("images/d3-d5-google.png", width: 80%) #v(0.1em) $d=3,5$ Surface Code \ Google 2023@googlequantumai2023
    ],
    [
      #image("images/neutral-atom-2023.png", width: 90%) #v(0.1em) 280 Physical Qubits \ 40 Logical Qubits \ QuEra 2023@bluvstein2023
    ],
  )
]

---

#[
  #set text(size: 0.8em)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #image("images/below-threhsold-google.png") #v(0.1em) $d=3, 5, 7$ Surface Code \ *Below Threshold* \ Google 2024@acharya2024quantum
    ],
    [
      #image("images/color-google.png") #v(0.1em) $d=3,5$ Color Code \ Google 2024@lacroix2024
    ],
  )
]

= Surface Code Computation

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
