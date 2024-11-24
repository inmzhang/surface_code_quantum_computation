#import "@preview/physica:0.9.3": *
#import "@preview/quill:0.5.0": *
#import "@preview/touying:0.5.3": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9", footer: self => self.info.title, config-info(
    title: [Surface Code Quantum Computation], subtitle: [Progress and Challenges], author: [Yiming Zhang], date: datetime(year: 2024, month: 11, day: 27), institution: [University of Science and Technology of China],
  ),
)
#show link: underline
#show figure.caption: set text(10pt)

#set heading(numbering: numbly("{1}.", default: "1.1"))
#let highlightMath(x) = text(fill: red)[$#x$]

#title-slide()

// = Outline <touying:hidden>
//
// #outline(title: none, indent: 1em, depth: 1)

= Quantum Error Correction: Where We Are?

== Why do we need QEC?

#columns(
  2,
)[
  - Today's quantum computers are noisy: $tilde 1$ error per 100 operations.

  - Practical advantage of quantum computer needs _MegaQuOp_ scale.

  - Practical Application of quantum computer needs _GigaQuOp_/_TeraQuop_ scale.
  #colbreak()
  #figure(
    image("images/quop.png"), caption: [_QuOp_ Scale of Practical Quantum Application@riverlane2024report],
  )
]

== Where We are?(Superconducting Qubits)

- We are at the point where the theory of QEC is beginning to be proven
  experimentally.

- We are still growing and improving single logical qubit.

- In 2024, Google demonstrated _sub-threshold_ quantum error correction
  experimentally@acharya2024quantum.

#figure(
  image("./images/google_surface_code.png", width: 65%), caption: [Google's Logical Memory Experiment(d=3,5,7)],
)

== Hardware Progress(USTC)

#columns(
  2,
)[
  #figure(
    image("./images/zuchongzhi.png", width: 80%), caption: [_Zuchongzhi2_ Quantum Processor],
  )
  #colbreak()
  We demonstrated $d=3$ surface code on _Zuchongzhi2_ processor in
  2022@zhao2022realization. The hardware has been improved since then#footnote[The design is optimized for targeted quantum error correction experiments.]:
  - 100+ qubits with tunable couplers
  - average $T_1 tilde 60 mu s$
  - parallel single qubit gate fidelity $tilde 99.9%$
  - parallel CZ gate fidelity $tilde 99.4%$
  - parallel readout fidelity $tilde 98.5%$
  - better support for _repeated measurements_ and _reset_ operations
]

= Surface Code: A Practical Way towards Fault-Tolerant Quantum Computation

== Surface Code

#columns(
  2,
)[
  #figure(
    image("./images/surface_code.png", width: 60%), caption: [$d=5$ Rotated Surface Code],
  )

  #colbreak()

  #figure(
    image("./images/syndrom_circuit.png"), caption: [Syndrome Measurement Circuits],
  )
]

---

#text[
  #set heading(numbering: none)
  === Pros

  - A high error threshold: near $1%$
  - 2D Nearest-neighbor connectivity: suitable for superconducting qubits
  - Good decoders available: MWPM, Union-Find, Tensor Network, Neural Network
  - Mature protocols for logical operations: lattice surgery, transversal gates

  === Cons

  - High resource overhead: vanishing encoding rate($1/d^2$)
]

== Logical Operations: Initialization/Measurement

#columns(
  2,
)[
  - Logical init in X(Z) basis: reset all data qubits in $|plus〉$($|0〉$) state,
    takes *$O(1)$* time.

  - Logical meas in X(Z) basis: measure all data qubits in X(Z) basis, takes
    *$O(1)$* time.

  - Logical init/meas in Y basis requires more complex circuits, which maps between
    the logical Y operator and the product of specific stabilizers, takes *$d/2$*
    time.@gidney2024inplace

  #colbreak()
  #figure(
    image("./images/y-basis_measurement.png", width: 80%), caption: "Y Basis Measurement",
  )
]

== Logical Operations: Pauli Gates

_Logical Pauli gates_(or corrections from decoding) can be tracked in software
and do not require physical operations on hardware. Takes *zero* time.

#columns(
  2,
)[
  #figure(
    image("./images/byproduct_before.png", width: 80%), caption: "Logical Circuit(Raw)",
  )
  #colbreak()
  #figure(
    image("./images/byproduct_after.png", width: 80%), caption: "Equivalent Logical Circuit After Pushing Paulis",
  )
]

== Logical Operations: H

_Logical Hadamard Effect_ can be applied with a layer of transversal H gates on
data qubits, while exchanging the boundary types. Takes *$O(1)$* time.

Rotating the boundary types back can be achieved in *$4d^3$* spacetime volume.

#figure(image("./images/h.svg", width: 50%), caption: "Logical H Effect")

With space-time symmetry, the logical Hadamard effect can also be implemented in
spatial direction.

== Logical Operations: Parity Measurement($M_(X X), M_(Z Z)$)

_Parity measurement_ is an elementary operation in lattice surgery based surface
code quantum computation.

It can be achieved by merge and split operations between two logical qubits.

#columns(
  2,
)[
  #figure(
    image("./images/mxx.png", width: 80%), caption: [Product of physical qubit measurements realizes $M_(X X)$],
  )
  #figure(
    image("./images/mzz.png", width: 80%), caption: [Product of stabilizer measurements realizes $M_(Z Z)$],
  )
]

== Logical Operations: S

_Logical S gate_ can be implemented via gate teleportation@gidney2024inplace.
Takes *$3d^3$* spacetime volume.

#columns(
  2,
)[
  #linebreak()
  #figure(
    quantum-circuit(
      lstick($|Psi〉$), mqgate($M_(Z Z)$, n: 2), [\ ], lstick($|+〉$), 1, meter(label: $M_Y$), scale: 200%,
    ), caption: [Logical S Gate #footnote[Pauli corrections conditioned on the measurement results are not plotted.]],
  )
  #colbreak()
  #figure(
    image("./images/s_zx_diagram.png", width: 50%), caption: "Logical S Gate ZX Diagram",
  )
]

== Logical Operations: CNOT

_Logical CNOT gate_ can be implemented by two parity measurements. Takes
*$6d^3$* spacetime volume.

#columns(
  2,
)[
  #linebreak()
  #figure(
    quantum-circuit(
      lstick($|#text[Control]〉$), mqgate($M_(Z Z)$, n: 2), [\ ], lstick($|0〉$), 1, mqgate($M_(X X)$, n: 2), meter(label: $M_X$), [\ ], lstick($|#text[Target]〉$), 1, 1, scale: 200%,
    ), caption: [Logical CNOT Gate #footnote[Pauli corrections conditioned on the measurement results are not plotted.]],
  )
  #colbreak()
  #figure(
    image("./images/cnot_patch.svg", width: 70%), caption: "Logical CNOT Patches",
  )
]

== Logical Operations: T

Historically, implmenting _T gates_ requires expensive magic state distillation
and is the main overhead of surface code quantum computation. Now preparing a
high-fidelity magic state is as cheap as a logical CNOT gate#footnote[
  for magic state fidelity achieving $1e^(-9)$
] by cultivation@gidney2024magic.

#figure(image("./images/cultivation.png"), caption: "Magica State Cultivation")

= _TQEC_: Design Automation for Surface Code Quantum Computation

== _TQEC_ Community

- _TQEC_ is an open-source community for design automation of Topological Quantum
  Error Correction, currently focusing on surface code quantum computation. It is
  organized by Austin G. Fowler from Google Quantum AI.

- We are building the tools to manage the complexity of scalable circuit
  compilation, arrangement optimization.

- It's not for good, but necessary...

- The code is open-source and available on GitHub: https://github.com/tqec/tqec.
  It's still in the very early stage.

== High-level Workflow

The workflow for compiling a quantum algorithm or a general logical quantum
circuit to the physical instructions maybe:

+ Write the quantum algorithm in a high-level quantum programming language like `Q#` or `Qualtran`.

+ Compile and optimize the quantum algorithm with _ZX-calculus_.

+ Compile the ZX-diagram representation to a 3D surface code spacetime structure
  with `TQEC`.

+ Compile the 3D spacetime structure to the physical instructions for the quantum
  hardware with `TQEC`.

== TQEC

- `TQEC` provides a programmable 3D spacetime representation for surface code, and
its corresponding ZX diagram representation.

#columns(
  2,
)[
  #figure(
    image("./images/logical_cnot.png", width: 65%), caption: "Logical CNOT Spacetime Diagram",
  )
  #colbreak()
  #figure(
    image("./images/logical_s_correlation.png", width: 80%), caption: "Logical S Spacetime Diagram",
  )
]

- Constructing the detectors in the QEC circuits automatically.

- Finding the logical observables(correlation surfaces) in the surface code
  quantum computation automatically.

- Transpilation between the ZX-digram representation and the 3D spacetime
  representation.

- Compiling the 3D spacetime representation to the a simulatable `stim` circuit.

- Currently, only limited building blocks are implemented. We can construct and
  compile a logical CNOT gate. The compiled circuits were tested on Google's
  hardware.

= Challenges and Future Directions

---

- Error sources that have effects under ultra-low error rate region, e.g. cosmic
  rays.

- Real-time decoding: tradeoff between decoding speed and accuracy.

- The hardware/software architecture of large-scale FT quantum computer.

#focus-slide[
  #text(size: 2.0em)[
    Thanks!
  ]

  #text(
    size: 0.8em,
  )[
    The slides are available on #link("https://github.com/inmzhang/surface_code_quantum_computation")[Github].
  ]
]

#show: appendix

#bibliography("./references.bib")
