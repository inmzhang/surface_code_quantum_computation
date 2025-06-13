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
      #image("images/below-threshold-google.png") #v(0.1em) $d=3, 5, 7$ Surface Code \ *Below Threshold* \ Google 2024@acharya2024quantum
    ],
    [
      #image("images/color-google.png") #v(0.1em) $d=3,5$ Color Code \ Google 2024@lacroix2024
    ],
  )
]

= Surface Code Computation

== Toric Code

#slide[
  #figure(image("images/toric-code-lattice.png", width: 60%))

  #figure(image("images/toric-code-logical.png", width: 60%))
][
  Define stabilizers on a 2D square lattice:
  $
    A_v = product_(i in v) X_i, B_f = product_(i in f) Z_i
  $

  Hamiltonian:
  $
    H = - sum_(v in V) A_v - sum_(f in F) B_f
  $
  Nontrivial loops define logical operators. Encodes two logical
  qubits in the Hilbert space: $[[2L^2, L, 2]]$.
]

== Surface Code

#[
  #set align(horizon + center)
  #slide[
    #figure(image("images/unrotated-surface-code.png", width: 60%))
    #v(1em)
    Unrotated Surface Code\
    $[[2d^2-2d+1, 1, d]]$
  ][
    #figure(image("images/rotated-surface-code.png", width: 60%))
    #v(1em)
    Rotated Surface Code\
    $[[d^2, 1, d]]$
  ]
]

== Stabilizer Measurements

#slide[
  #figure(image("images/surface-code-with-schedules.png", width: 80%))
][
  #figure(image("images/surface-plaquette-measurement.png"))
]

== Anyonic Excitations in Surface Code

#slide[
  #figure(image("images/em-excitation.png", width: 80%))
][
  #figure(image("images/surface-code-logicals.png", width: 80%))
][
  #figure(image("images/spatial-boundary-3d.png", width: 60%))
]

== Time Boundaries

#slide[
  #figure(image("images/initialization.png", width: 80%))
][
  #figure(image("images/time-boundary-3d.png", width: 40%))
]

== Lattice Surgery

_Lattice Surgery_@horsman2012 connects the boundaries of surface codes and *correlates the
logical operators* in spacetime.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 5em,
  image("images/mzz.png"), image("images/mzz-3d.png", width: 60%),
)

We can fault-tolerantly implement $M_(Z Z)$ and $M_(X X)$ parity measurements for
surface codes with lattice surgery. They are the true primitives for fault-tolerant
surface code computation instead of CNOT/CZ gates. It's kind of MBQC-style computation.

#place(top + right, dy: 25pt)[
  #align(center)[#rect(inset: 0.5em)[$O(2d times d times d)$ spacetime volume]]
]

== Correlation Surface

_Correlation Surface_ is a set of 2D surfaces in spacetime that represents the correlation
between logical operators.

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 2em,
  [
    #figure(image("images/mzz-correlation-x.png"))
    $
      X_1 X_2 X_3 X_4 = (-1)^M
    $
  ],
  [
    #figure(image("images/mzz-correlation-zz.png", width: 110%))
    $
      Z_1 Z_2 = (-1)^(M_(Z Z))
    $
  ],
  [
    #figure(image("images/mzz-correlation-z.png"))
    $
      Z_1 Z_2 = +1
    $
  ],
)

== Universal Gateset: Paulis

Physically we can apply the logical operators $X_L$/$Z_L$ to implement
the logical Pauli gates:

$
  X = mat(0, 1; 1, 0), Y = mat(0, -i; i, 0), Z = mat(1, 0; 0, -1)
$

In practice, we track a _Pauli Frame_ in software to keep track of the logical
Pauli gates applied. We reinterpret the subsequent logical measurement outcomes
based on the Pauli Frame at that time. Therefore, Pauli gates are zero-cost operations.

#place(top + right)[
  #align(center)[#rect(inset: 0.5em)[zero spacetime volume]]
]

== Universal Gateset: $H$

Hadamard Gate:
$
  H = 1 / sqrt(2) mat(1, 1; 1, -1), #h(2em) X arrow.long.l.r^(H) Z
$

We can construct a _transparent domain wall_ in the bulk of the surface code to realize
the anyon mapping:
$
  e arrow.long.l.r^(phi) m
$

#grid(
  columns: (1.3fr, 0.7fr, 1fr, 1fr),
  [
    #figure(image("images/temporal-h.png"))
  ],
  [
    #figure(image("images/temporal-h-3d.png", width: 60%))
  ],
  [
    #figure(image("images/spatial-h.png", width: 50%))
  ],
  [
    #figure(image("images/spatial-h-3d.png"))
  ],
)
#place(top + right)[
  #align(center)[#rect(inset: 0.5em)[$O(d^2 times 1)$ spacetime volume]]
]

== Universal Gateset: CNOT

#grid(
  columns: (1fr, 2fr),
  [
    #figure(image("images/cnot-by-parity-measurement.png", width: 80%))
    #figure(image("images/logical_cnot.png", width: 80%))
  ],
  [
    #set align(horizon + center)
    #grid(
      columns: (1fr, 1fr),
      rows: (0.2fr, 1fr),
      grid.cell(colspan: 2)[
        $
          X I arrow.long.r^("CNOT") X X, & #h(2em) I X arrow.long.r^("CNOT") I X \
          Z I arrow.long.r^("CNOT") Z I, & #h(2em) Z Z arrow.long.r^("CNOT") I Z
        $
      ],
      [
        #figure(image(
          "images/logical-cnot-xixx.png",
          width: 70%,
        )) $X I arrow.long.r X X$
      ],
      [
        #figure(image(
          "images/logical-cnot-zziz.png",
          width: 75%,
        )) $Z Z arrow.long.r I Z$
      ],
    )
  ],
)

#place(bottom + right, dx: -40pt, dy: 20pt)[
  #align(center)[#rect(inset: 0.5em)[$O(3d^2 times 2d)$ spacetime volume]]
]

== Universal Gateset: CZ

$
  X I arrow.long.r^("CZ") X Z, & #h(2em) I X arrow.long.r^("CZ") Z X \
  Z I arrow.long.r^("CZ") Z I, & #h(2em) I Z arrow.long.r^("CZ") I Z
$
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  figure(image("images/logical-cz.png")),
  figure(image("images/logical-cz-xixz.png", width: 92%)),
  figure(image("images/logical-cz-ixzx.png", width: 92%)),
)

== Universal Gateset: $S$

#slide[
  S gate can be implemented fault-tolerantly by moving the twist defects in surface
  code with code deformation@brown2017.

  However, it requires separating the twist defects far enough to avoid decreasing
  the code distance, which needs heavy resource overhead.

  A better way to implement the $S$ gate is by _gate teleportation_, which requires
  fault-tolerant Y-basis initialization or measurement@gidney2024inplace.
][
  #figure(image("images/s-gate-by-moving-twists.png", width: 70%))
  #figure(image("images/s-gate-teleportation.png", width: 80%))
]

== Universal Gateset: Y-basis Init/Meas

#grid(
  columns: (1.2fr, 0.9fr),
  [
    #figure(image("images/y-basis-measurement.png", width: 75%))
    #figure(image("images/y-basis-measurement-simplified.png", width: 75%))
  ],
  [
    + Topologically, $M_Y$ can be implemented by fusing the pairs of twists along
      diagonal lines.

    + Diagonal movements of twists can be implemented by ending domain walls in the
      in the bulk of the surface code.

    + Domain walls can be implemented by the walking surface code@mcewen2023 in the bulk.

    #align(center)[#rect(inset: 0.5em)[$O(d^2 times d/2)$ spacetime volume]
    ]
  ],
)

== Universal Gateset: $S$

$
  Z arrow.long.r^S Z, & #h(2em) X arrow.long.r^S Y \
$

#grid(
  columns: (1fr, 1fr),
  figure(image("images/logical-s-3d.png", width: 72%)),
  figure(image("images/logical-s-correlation.png", width: 80%)),
)

#place(top + right, dx: 20pt)[
  #align(center)[#rect(inset: 0.5em)[$O(2d^2 times 1.5d)$ spacetime volume]]
]

== Universal Gateset: T

Given a high-fidelity logical $|T⟩$ state, we can implement the $T$ gate by
gate teleportation similar to the $S$ gate:

#figure(image("images/t-gate-teleportation.png", width: 80%))

== Magic State Injection and Distillation

#grid(
  columns: (0.5fr, 0.5fr, 0.5fr),
  align: center + horizon,
  [#figure(image("images/hook-injection.png"))\ Magic State Injection@gidney2023b],
  [#figure(image("images/15-1-distillation.png", width: 70%)) \ 15-1 Distillation],
  [#figure(image("images/15-1-distillation-3d.png", width: 60%)) \ 15-1 Distillation in 3D@gidney2019a],
)

== Magic State Cultivation

#grid(
  columns: (0.8fr, 1fr),
  [
    - Color code has the transversal $H_(X Y)$ gate that can be used to check and
      post-select the $|T⟩$ state@gidney2024magic.

    - Inject the $|T⟩$ state into the color code, grow the fault distance
      incrementally during checking the logical values.

    - Escape the magic state into a "grafted" matchable code and increase the host
      code distance rapidly.
  ],
  figure(image("images/cultivation.png")),
)

---

#figure(image("images/cultivation-spacetime-overhead.png"))

== Yoked Surface Code

In large-scale quantum algorithms, the storage of idling logical qubits contributes
to a large portion of logical error rate. _Yoked Surface Code_ use the simple idea
of code concatenation to reduce the overhead of storing logical qubits@gidney2025b.

For 1D yoked surface code, two parity bits are used to check the X and Z parity of the
row. Therefore, it is a $[[n, n-2, 2]]$ code.

#figure(image("images/yoked-1d.png", width: 80%))

= Surface Code Compilation

== Logical Circuit Compilation

Given a quantum circuit that express a quantum algorithm/application, logical circuit
compilation need to:

+ Compile it into a circuit/representation consisted of primitive operations that
  are supported fault-tolerantly by the underlying QECC.

+ Map the components in the compiled circuit/representation onto the coordinate
  space of the logical qubits.

+ Give a schedule for the serial/parallel execution of the compiled primitive operations.

+ Optimize the compilation with the goal of minimizing the number of logical qubits/algorithm
  execution time/spacetime volume.

== Sequential Pauli-based Computation

_Sequential Pauli-based Computation_@litinski2019a moves all the Clifford gates to the end of the
circuit and absorbs them with the final measurements. After that, the circuit consists
of solely joint Pauli measurements and $pi/8$ multi-Pauli rotations.

#figure(image("images/sequential-pauli-based.png", width: 70%))

---
#[
  #set align(center + horizon)
  *Primitive operations*
  #grid(
    columns: (1fr, 1fr),
    [
      #figure(image("images/pauli-product-measurement.png", width: 80%))
      Pauli Product Measurement
    ],
    [
      #figure(image("images/pi-8-rotation.png", width: 80%))
      $pi/8$ Pauli Rotation by consuming a magic state
    ],
  )
]

#grid(
  columns: (1.2fr, 1fr),
  gutter: 2em,
  align: center + horizon,
  [
    #figure(image("images/circuit-as-consequtive-pi-8-rotation.png"))
    Rewrite circuit as consecutive $pi/8$ rotations
  ],
  [
    #figure(image("images/fast-block.png", width: 80%))
    Block Layout
  ],
)


== Clifford + T Compilation

Compile a circuit into gateset {$"Init"_Z, "Init"_X, M_Z, M_X, "CNOT", X, Y, Z, H, S, T$}
and mapping the gates onto the data blocks with path-finding algorithms to increase
the parallelism of the circuit execution while maintaining low-weight parity measurements@beverland2022.

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  align: center + horizon,
  [
    #figure(image("images/bell-pairs-long-cnot.png", width: 80%))
    #set text(size: 0.8em)
    Long-range CNOTs with Bell Pairs and parity measurements
  ],
  [
    #figure(image("images/edp.png", width: 50%))
    #set text(size: 0.8em)
    Routing parallizable CNOTs with vertex-disjoint paths(VDP) and
    edge-disjoint paths(EDP).
  ],
)

== TQEC Project

_TQEC_ is a project with open community collaboration to develop open-source tools
for topological quantum error correction. Currently, it mainly focuses on the representation
and compilation of 2D planar surface codes.

The project is initially organized and led by #link("https://scholar.google.com/citations?user=U6lreOYAAAAJ&hl=en")[Dr. Austin Fowler].


#grid(
  columns: (1fr, 0.2fr),
  gutter: 2em,
  align: center,
  figure(image("images/tqec.png")),
  [
    #figure(image("images/austin-fowler.png", width: 50%))
    #set text(size: 0.8em)
    Austin Fowler
  ],
)

== Block Diagram Representation

A quantum computation is represented by composing the following building blocks
(not complete). Each block has a carefully
designed physical circuit associated with it.

#figure(image("images/sketchup.png", width: 40%))

The project focuses on two levels of compilation mediated by the block diagram
representation.

== Logical-level Compilation

_Logical-level Compilation:_ compile a high-level/intermediate representation of a quantum
circuit, e.g. circuit/ZX diagram, into a low-level representation that specifies all the
details needed to layout the circuit onto the hardware (2+1D).
#figure(image("images/three-cnots-circuit.png", width: 60%))

== Logical Compilation by Hand

#let side-image() = place(top + right, dx: 1em)[
  #figure(image("images/steane-encoding-circuit.png", width: 30%))
]

Consider compiling a following #link("https://docs.google.com/presentation/d/184GHX9jffq9dcwWzbku0K90V9xdA8_25lD8pfeEcgRg/edit")[Steane-encoding circuit]:

#figure(image("images/steane-encoding-circuit.png", width: 80%))

We can build it directly in 3D modeling software like #link("https://www.sketchup.com/app")[SketchUp].

---

#figure(image("images/compile-0.png", width: 60%))
#figure(image("images/compile-1.png", width: 60%))
#side-image()
---

#figure(image("images/compile-2.png", width: 50%))
#figure(image("images/compile-3.png", width: 45%))
#side-image()
---

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/compile-4.png", width: 90%)),
  figure(image("images/compile-5.png")),
)
#side-image()
---

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/compile-6.png")),
  figure(image("images/compile-7.png")),
)
#side-image()
---

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/compile-8.png")),
  figure(image("images/compile-9.png")),
)
#side-image()
---

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/compile-10.png")),
  figure(image("images/compile-11.png")),
)
#side-image()
---

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/compile-12.png")),
  figure(image("images/compile-13.png")),
)
#side-image()
---

#figure(image("images/compile-14.png", width: 60%))
#side-image()
---

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/compile-15.png")),
  figure(image("images/compile-16.png")),
)
---

#slide[
  #figure(image("images/compile-17.png", width: 80%))
][
  - compiled spacetime volume: 16

  - spacetime symmetry in this computation

  - all circuit element like CNOT, H, Initialization, Measurement is deformed
    into blocks.

  - inputs/outputs can be moved to connect to the rest of the algorithm.
]

== ZX-Calculus

_The ZX-calculus_@vandewetering2020 is a graphical language that goes beyond circuit diagrams.
It splits the atom of well-known quantum logic gates to reveal the compositional
structure inside.

#figure(image("images/spiders.png", width: 45%))

#figure(image("images/zx-rules.png", width: 50%))

---

ZX-calculs can be a language of surface code lattice surgery.

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/zx-surface.png", width: 70%)),
  figure(image("images/zx-rules-rgb.png", width: 80%)),
)

== Compile with ZX-Calculus

#figure(image("images/zx-repr-steane-encoding.png", width: 80%))
#side-image()

---

#grid(
  columns: (1fr, 1fr),
  rows: (1fr, 1fr, 1fr),
  gutter: 2em,
  figure(image("images/zx-compile-0.png")),
  figure(image("images/zx-compile-1.png")),

  figure(image("images/zx-compile-2.png")),
  figure(image("images/zx-compile-3.png")),

  figure(image("images/zx-compile-4.png", width: 90%)),
  figure(image("images/zx-compile-5.png", width: 30%)),
)

---

#grid(
  columns: (1fr, 1fr, 1.2fr),
  gutter: 2em,

  figure(image("images/zx-compile-5.png")),
  figure(image("images/zx-compile-6.png")),
  figure(image("images/zx-compile-3d.png")),
)

== Physical-level Compilation

_Physical-level Compilation:_ compile the low-level representation into a sequence of physical
gate instructions that can be executed directly on the hardware.

Physical-level compilation takes care of composing the circuit blocks to generate
a fault-tolerant circuit annotated with correct detectors and observables.

#figure(image("images/memory-to-circuit.png", width: 80%))

---
#grid(
  columns: (1fr, 1fr),
  rows: (1fr, 1fr),
  gutter: 2em,
  figure(image("images/IXIX.png")), figure(image("images/XIXX.png")),
  figure(image("images/IZZZ.png")), figure(image("images/ZIZI.png")),
)

== Current Status and Future Work

*Current Status:*
- All Clifford block circuits except Y-basis initialization and measurement.
- Algorithm combined with SAT solver for circuit detectors automation.
- Algorithm for finding the minimal generating set of correlation surfaces in the
  Clifford computation.
- Can successfully compile the Steane-encoding block diagram above into physical
  circuit that can be simulated with `stim`@gidney2021.
- A greedy graph algorithm for compiling a ZX-diagram into a valid block diagram.

*Future Works:*
- Support Y-basis initialization and measurement and magic state cultivation blocks.
- More general algorithm for finding the correlation surfaces in universal quantum
  circuits and returning time ordering of the non-Clifford gates.
- More efficient algorithm for logical compilation. Explore alternative intermediate
  representations like `Quon`@feng2025quon.

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
