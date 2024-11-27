#import "@preview/physica:0.9.3": *
#import "@preview/quill:0.5.0": *
#import "@preview/touying:0.5.3": *
#import themes.metropolis: *
#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9", footer: self => self.info.title, config-info(
    title: [Surface Code Quantum Computation], subtitle: [Progress and Challenges], author: [Yiming Zhang], date: datetime(year: 2024, month: 11, day: 27), institution: [University of Science and Technology of China],
  ),
)
#show link: underline
#show figure: set align(center + horizon)
#show figure.caption: set text(10pt)

#set heading(numbering: numbly("{1}.", default: "1.1"))
#let highlightMath(x) = text(fill: red)[$#x$]

#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 1em, depth: 1)

= QEC: Where We Are?

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
  2022@zhao2022realization. The hardware has been improved since then:
  - 100+ qubits with tunable couplers
  - $T_1 tilde 50 mu s$
  - Parallel 1Q gate $tilde 99.9%$
  - Parallel CZ gate fidelity $tilde 99.5%$
  - Parallel repeated measurement $tilde 98%$
  - Faster _repeated measurements_
  - Support _reset_ operation
  - The design is optimized for targeted quantum error correction experiments
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
  - Developed protocols for logical operations: lattice surgery, transversal gates

  === Cons

  - Resource overhead: vanishing encoding rate($1/d^2$)
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
    the logical Y operator and the product of stabilizers, takes *$d/2$*
    time@gidney2024inplace.

  #colbreak()
  #figure(
    image("./images/y-basis_measurement.png", width: 80%), caption: "Y Basis Measurement",
  )
]

== Logical Operations: Pauli Gates

_Logical Pauli gates_(or corrections from decoding) can be tracked in software
and do not require physical operations on hardware. Takes *zero* time.

#figure(
  stack(
    dir: ltr, spacing: 2mm, image("./images/byproduct_before.png", width: 48%), image("./images/byproduct_after.png", width: 50%),
  ), caption: "Pushing Pauli Gates Through the Circuit",
)

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

#figure(
  stack(
    dir: ltr, spacing: 20mm, quantum-circuit(
      lstick($|Psi〉$), mqgate($M_(Z Z)$, n: 2), [\ ], lstick($|+〉$), 1, meter(label: $M_Y$), scale: 200%,
    ), image("./images/s_zx_diagram.png", width: 25%),
  ), caption: [Logical S Gate #footnote[Pauli corrections conditioned on the measurement results are not plotted.]],
)

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

== _TQEC_

- _TQEC_ is an open-source community for design automation of surface code quantum
  computation. It is organized by Austin G. Fowler from Google Quantum AI.

- We are building the tools to manage the complexity of scalable circuit
  compilation, arrangement optimization. It's not for good, but necessary...

- The code is open-source and available on GitHub: https://github.com/tqec/tqec. #footnote[Disclaimer: The author is one of the core maintainers of _TQEC_.]
  It's still in the very early stage.

== _TQEC_ Workflow(Possibly)

#let tqec-color = gradient.radial(red.lighten(80%), red, center: (30%, 20%), radius: 80%) 

#diagram(
  node-stroke: .1em,
  node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
  spacing: 4em,
  edge((-1,0), "r", "-|>", `Algorithm`, label-pos: 0, label-side: center),
  node((0,0), `QPL`, radius: 2.5em),
  edge(`compile`, "-|>"),
  node((1,0), `Logical Circuit`, radius: 2.5em),
  edge(`trans`, "-|>"),
  node((2,0), `ZX-Calculus`, radius: 2.5em, fill: tqec-color),
  edge(`compile`, "-|>", label-pos: 0.5, label-side: center),
  node((2,1), `Spacetime Structure`, radius: 2.5em, fill: tqec-color),
  edge(`compile`, "-|>"),
  node((3,1), `Physical Circuit`, radius: 2.5em, fill: tqec-color),
  edge(`transpile`, "-|>", label-pos: 0.5, label-side: center),
  node((3,0), `Hardware/Simulator`, radius: 2.5em),
  edge((2,0), (2,0), `optimize`, "--|>", bend: 130deg),
)


== `ZXGraph` and `BlockGraph` Representation

In `TQEC`, we represent a logical computation by either a `ZXGraph` or a `BlockGraph`.

There is strong correspondence between the two representations:

#figure(
  stack(
    dir: ltr, spacing: 20mm,
    image("./images/logical_cnot_zx.png", width: 30%),
    image("./images/logical_cnot.png", width: 25%),
  ), caption: [Logical CNOT Representation],
)

---

To build a logical computation, we can either:

- Build interactively with 3D model tool like SketchUp. 

- Build programmatically with Python API.

Currently, only limited building blocks are implemented. And the compilation from a general `ZXGraph` to `BlockGraph` is not supported yet.

#figure(
  image("./images/sketchup.png", width: 30%), caption: [Computation Building Blocks in SketchUp],
)

== Implement `Block`s

Represent local circuits as `Plaquette` and compose the `Plaquette`s with the pattern specified by the `Template` to build scalable circuits. Different layers of `Plaquette`s compose a `Block`, e.g. Initialization Layer -> Memory Layer -> Measurement Layer.

#figure(
  image("./images/impl_block.png", width: 50%),
  caption: [Build a `Cube` from `Template` and `Plaquette`s]
)

// Figure for Logical Memory Cube -> Template -> Layer of Plaquettes

== Compose `Block`s

#columns(2)[
  #figure(image("./images/logical_cnot.png", width: 80%))
  #colbreak()

  - `Pipe` occupies no spacetime volume, and is used to replace the plaqeuttes in the `Cube`s it connects.

  - Vertical `Pipe` replaces the `Init`(`Meas`) layer of the top(bottom) `Cube` with a `Memory` layer.

  - Horizontal `Pipe` replaces the boundary plaquettes of weight-2 stabilizer measurements with weight-4 stabilizer measurements.

  - `Pipe`s with Hadamard transition is more complex, but still replacement rules.

]

== Find Observables and Detectors Automatically

- The complete set of _observables_ supported by the logical computation can be found with the notion of `Correlation Surface`:

#figure(
  image("./images/logical_s_correlation.png", width: 30%), caption: [Correlation Surface],
)

- The possible _detectors_ in the circuit can be constructed automatically by matching the creation and destruction stabilizer flows.

== Run the Circuit on Hardware/Simulator

The output circuit is of `.stim` format, and can be simulated with `stim` stabilizer simulator efficiently(when there is no non-Clifford gates). Here we show the simulation results of a single logical CNOT gate:

#figure(
  stack(
    dir: ltr, spacing: 2mm,
    image("./images/XIXX.png", width: 25%),
    image("./images/IXIX.png", width: 25%),
    image("./images/ZIZI.png", width: 25%),
    image("./images/IZZZ.png", width: 25%),
  ), caption: [Logical CNOT Representation],
)

Additionally, we have ran the circuits produced by `TQEC` on Google's 105-qubit Sycamore processor. The paper introducing the `TQEC` tool as well as the experimental results is in preparation.

= Challenges and Future Directions

---

- Real-time decoding: tradeoff between decoding speed and accuracy.

- Error sources that have effects under ultra-low error rate region, e.g. cosmic
  rays.

- Resource optimization for large-scale quantum computation: optimize for compact spacetime layout.

- The hardware/software architecture of large-scale FT quantum computer.

- ...

#focus-slide[
  #text(size: 2.0em)[
    Thanks!
  ]

  #text(
    size: 0.8em,
  )[
    The slides are available at
    
     https://github.com/inmzhang/surface_code_quantum_computation.
  ]
]

#show: appendix

#bibliography("./references.bib")
