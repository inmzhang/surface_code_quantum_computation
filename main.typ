#import "@preview/physica:0.9.3": *
#import "@preview/quill:0.5.0": *
#import "@preview/touying:0.5.3": *
#import themes.metropolis: *

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9", footer: self => self.info.title, config-info(
    title: [An Introduction to Quantum Error Correction], subtitle: [with a particular appetite for surface code], author: [Yiming Zhang], date: datetime.today(), institution: [USTC],
  ),
)
#show link: underline

#set heading(numbering: numbly("{1}.", default: "1.1"))
#let highlightMath(x) = text(fill: red)[$#x$]

#title-slide()

= Outline <touying:hidden>

#outline(title: none, indent: 1em, depth: 1)

= Background

---

== Stabilizers

A compact #underline[representation of quantum states] with (signed) Pauli
operators @gottesman1997stabilizer:

$|Psi〉 = 1 / sqrt(2) |000〉 + |111〉 arrow.stroked angle.l +X X X, + Z Z I, + I Z Z〉$

The state $|Psi〉$ is _stabilized_ by the 3 independent stabilizers.

For complex states, it's tedious or even impossible to write down the full state
vector. The stabilizer representation comes to rescue.

---

== Stabilizer Sign

The sign of a stabilizer is useful for detecting errors. For a _Pauli error_ $E$ that
anticommutes with a stabilizer $S$:

$|Psi〉 = highlightMath(S)|Psi〉 arrow.long.r^E E|Psi〉 = E S|Psi〉 = highlightMath(-S) E|Psi〉$

== Identify Errors

For the state $|Psi〉 = 1 / sqrt(2) |000〉 + |111〉 arrow.stroked angle.l +X X X, + Z Z I, + I Z Z〉$:

- $ X_0|Psi〉 = 1 / sqrt(2) |100〉 + |011〉 arrow.stroked angle.l +X X X, highlightMath(- Z Z I), + I Z Z〉$:
- $ X_1|Psi〉 = 1 / sqrt(2) |010〉 + |101〉 arrow.stroked angle.l +X X X, highlightMath(- Z Z I), highlightMath(- I Z Z)〉$:
- $ X_2|Psi〉 = 1 / sqrt(2) |001〉 + |110〉 arrow.stroked angle.l +X X X, + Z Z I, highlightMath(+ I Z Z)〉$:

By measuring the stabilizers, we get the so-called _syndromes_.

== Stabilizer Projector

#figure(
  quantum-circuit(
    lstick($|0〉$), $H$, ctrl(1), $H$, meter(), [\ ], setwire(4), lstick($|Psi〉$), 1, $U$, 2, scale: 200%,
  ), caption: "Operator Projector",
)

Two perspectives of the above circuit:

+ If $|Psi〉= plus.minus U |Psi〉$ , then it's a simple phase kickback to measure
  the eigenvalue, i.e. the sign of the stabilizer.
+ Meanwhile, it plays the role of a projector operator $(I plus.minus U)/2 |Psi〉$ with
  the measurement backaction. Continuous errors will be digitized as Pauli errors.

== Logical Qubit

What is a logical qubit?

- _Error Detection_: A set of independent stabilizer generators to detect errors
  on the state.

- _Degree of Freedom_: $op("#Stabilizers") lt.eq op("#Data Qubits")$

We can define a three-qubit state under the stabilizer constraints $angle.l Z Z I, I Z Z angle.r$,
then

$
  |Psi 〉_L = alpha |0〉_L + beta |1〉_L
$

where
$
  |+〉_L = 1 / sqrt(2) |000〉 + |111〉, |-〉_L = 1 / sqrt(2) |000〉 - |111〉,
$

And we can define the logical operator pairs $X_L = X X X, Z_L = Z I I$

= Surface Code

== Definition

#columns(
  2,
)[
  #figure(
    image("./images/surface_patch.png", width: 55%), caption: "Surface Code",
  )

  #colbreak()

  #figure(
    image("./images/syndrom_circuit.png", width: 100%), caption: "Stabilizer Measurements",
  )
]

== Logical Operations

It's all about how to map the logical operators!

- $I_L:$
$
  Z_L arrow.long.r^(I_L) Z_L, X_L arrow.long.r^(I_L) X_L
$

- $X_L:$
$
  Z_L arrow.long.r^(X_L) -Z_L, X_L arrow.long.r^(X_L) X_L
$

- $H_L:$
$
  Z_L arrow.long.r^(H_L) X_L, X_L arrow.long.r^(H_L) Z_L
$

---

- $C N O T_L:$
$
  Z_L^C I_L^T arrow.long.r^(C N O T_L) Z_L^C I_L^T, \
  I_L^C Z_L^T arrow.long.r^(C N O T_L) Z_L^C Z_L^T, \
  X_L^C I_L^T arrow.long.r^(C N O T_L) X_L^C X_L^T, \
  I_L^C X_L^T arrow.long.r^(C N O T_L) I_L^C X_L^T
$

== Move the Logical Operators

_Spacetime Stabilizer:_ another way to think about "gate as map".

#columns(
  2,
)[
  #figure(image("./images/spacetime_stabilizer.png"))
  #colbreak()
  #figure(image("./images/spacetime_stabilizer_example.png", width: 90%))
]

---

Look at the code at circuit level under a 3D picture. The logical operators can
be moved by multiplying the spacetime stabilizers.

Stabilizer measurement circuits revisited:

- #link(
    "https://algassert.com/quirk#circuit={%22cols%22:[[1,%22Z%22,%22Z%22],[1,%22Z%22,%22Z%22],[%22X%22,%22%E2%80%A2%22],[%22X%22,1,%22%E2%80%A2%22],[%22X%22,1,1,%22%E2%80%A2%22],[%22X%22,1,1,1,%22%E2%80%A2%22],[%22Measure%22,%22Z%22,%22Z%22]]}",
  )[Logical operator preserved in time]

- #link(
    "https://algassert.com/quirk#circuit={%22cols%22:[[1,%22Z%22,%22Z%22],[%22Z%22,%22Z%22,%22Z%22,%22Z%22,%22Z%22],[%22X%22,%22%E2%80%A2%22],[%22X%22,1,%22%E2%80%A2%22],[%22X%22,1,1,%22%E2%80%A2%22],[%22X%22,1,1,1,%22%E2%80%A2%22],[%22Z%22],[%22Measure%22]]}",
  )[Logical operator moved in space]: be careful about the measurements.

What is the famous _Lattice Surgery_?

#link(
  "https://algassert.com/crumble#circuit=Q(0,2)0;Q(0.5,0.5)1;Q(0.5,1.5)2;Q(0.5,2.5)3;Q(1,0)4;Q(1,1)5;Q(1,2)6;Q(1.5,0.5)7;Q(1.5,1.5)8;Q(1.5,2.5)9;Q(2,1)10;Q(2,2)11;Q(2,3)12;Q(2.5,0.5)13;Q(2.5,1.5)14;Q(2.5,2.5)15;Q(3,0)16;Q(3,1)17;Q(3,2)18;Q(3.5,0.5)19;Q(3.5,1.5)20;Q(3.5,2.5)21;Q(4,1)22;Q(4,2)23;Q(4,3)24;Q(4.5,0.5)25;Q(4.5,1.5)26;Q(4.5,2.5)27;Q(5,0)28;Q(5,1)29;Q(5,2)30;Q(5.5,0.5)31;Q(5.5,1.5)32;Q(5.5,2.5)33;Q(6,1)34;Q(6,2)35;Q(6,3)36;Q(6.5,0.5)37;Q(6.5,1.5)38;Q(6.5,2.5)39;Q(7,1)40;POLYGON(0,0,1,0.25)7_13_14_8;POLYGON(0,0,1,0.25)2_8_9_3;POLYGON(0,0,1,0.25)7_1;POLYGON(0,0,1,0.25)15_9;POLYGON(0,0,1,0.25)31_37_38_32;POLYGON(0,0,1,0.25)26_32_33_27;POLYGON(0,0,1,0.25)31_25;POLYGON(0,0,1,0.25)39_33;POLYGON(1,0,0,0.25)1_7_8_2;POLYGON(1,0,0,0.25)8_14_15_9;POLYGON(1,0,0,0.25)2_3;POLYGON(1,0,0,0.25)13_14;POLYGON(1,0,0,0.25)25_31_32_26;POLYGON(1,0,0,0.25)32_38_39_33;POLYGON(1,0,0,0.25)26_27;POLYGON(1,0,0,0.25)37_38;TICK;R_1_2_3_7_8_9_13_14_15_25_26_27_31_32_33_37_38_39;TICK;R_6_10_4_12_30_34_28_36;RX_5_11_0_17_29_35_23_40;TICK;CX_5_1_2_6_7_10_11_8_9_12_17_13_29_25_26_30_31_34_35_32_33_36_40_37;TICK;CX_8_6_13_10_5_2_11_9_15_12_17_14_32_30_37_34_29_26_35_33_39_36_40_38;TICK;CX_3_6_8_10_1_4_5_7_0_2_11_14_27_30_32_34_25_28_29_31_23_26_35_38;TICK;CX_5_8_9_6_14_10_11_15_0_3_7_4_29_32_33_30_38_34_35_39_23_27_31_28;TICK;M_6_10_4_12_30_34_28_36;MX_5_11_0_17_29_35_23_40;DT(1,2,0)rec[-16];DT(2,1,0)rec[-15];DT(1,0,0)rec[-14];DT(2,3,0)rec[-13];DT(5,2,0)rec[-12];DT(6,1,0)rec[-11];DT(5,0,0)rec[-10];DT(6,3,0)rec[-9];TICK;POLYGON(0,0,1,0.25)2_8_9_3;POLYGON(0,0,1,0.25)7_1;POLYGON(0,0,1,0.25)15_9;POLYGON(0,0,1,0.25)31_37_38_32;POLYGON(0,0,1,0.25)31_25;POLYGON(0,0,1,0.25)39_33;POLYGON(0,0,1,0.25)7_13_14_8;POLYGON(0,0,1,0.25)26_32_33_27;POLYGON(1,0,0,0.25)1_7_8_2;POLYGON(1,0,0,0.25)8_14_15_9;POLYGON(1,0,0,0.25)2_3;POLYGON(1,0,0,0.25)25_31_32_26;POLYGON(1,0,0,0.25)32_38_39_33;POLYGON(1,0,0,0.25)37_38;POLYGON(1,0,0,0.25)20;POLYGON(1,0,0,0.25)19;POLYGON(1,0,0,0.25)21;POLYGON(1,0,0,0.25)13_19_20_14;POLYGON(1,0,0,0.25)20_26_27_21;TICK;R_6_10_4_12_30_34_28_36_18_22_24_16;RX_5_11_0_17_29_35_23_40_19_20_21;MARKZ(0)7_8_9_31_32_33;TICK;CX_5_1_2_6_7_10_11_8_9_12_17_13_29_25_26_30_31_34_35_32_33_36_40_37_14_18_19_22_23_20_21_24;TICK;CX_8_6_13_10_5_2_11_9_15_12_17_14_32_30_37_34_29_26_35_33_39_36_40_38_20_18_23_21_27_24_25_22;TICK;CX_3_6_8_10_1_4_5_7_0_2_11_14_27_30_32_34_25_28_29_31_23_26_35_38_15_18_20_22_17_19_13_16;TICK;CX_5_8_9_6_14_10_11_15_0_3_7_4_29_32_33_30_38_34_35_39_23_27_31_28_17_20_26_22_19_16_21_18;TICK;M_6_10_4_12_30_34_28_36_24_16_22_18;MX_5_11_0_17_29_35_23_40;DT(1,2,1)rec[-20]_rec[-36];DT(2,1,1)rec[-19]_rec[-35];DT(1,0,1)rec[-18]_rec[-34];DT(2,3,1)rec[-17]_rec[-33];DT(5,2,1)rec[-16]_rec[-32];DT(6,1,1)rec[-15]_rec[-31];DT(5,0,1)rec[-14]_rec[-30];DT(6,3,1)rec[-13]_rec[-29];DT(1,1,1)rec[-8]_rec[-28];DT(2,2,1)rec[-7]_rec[-27];DT(0,2,1)rec[-6]_rec[-26];DT(3,1,1)rec[-5]_rec[-25];DT(5,1,1)rec[-4]_rec[-24];DT(6,2,1)rec[-3]_rec[-23];DT(4,2,1)rec[-2]_rec[-22];DT(7,1,1)rec[-1]_rec[-21];OI(0)rec[-9]_rec[-10]_rec[-11]_rec[-12]_rec[-17]_rec[-18]_rec[-19]_rec[-20];TICK;POLYGON(0,0,1,0.25)2_8_9_3;POLYGON(0,0,1,0.25)7_1;POLYGON(0,0,1,0.25)15_9;POLYGON(0,0,1,0.25)31_37_38_32;POLYGON(0,0,1,0.25)31_25;POLYGON(0,0,1,0.25)39_33;POLYGON(0,0,1,0.25)7_13_14_8;POLYGON(0,0,1,0.25)26_32_33_27;POLYGON(0,0,1,0.25)19_25_26_20;POLYGON(0,0,1,0.25)19_13;POLYGON(0,0,1,0.25)27_21;POLYGON(0,0,1,0.25)14_20_21_15;POLYGON(1,0,0,0.25)1_7_8_2;POLYGON(1,0,0,0.25)8_14_15_9;POLYGON(1,0,0,0.25)2_3;POLYGON(1,0,0,0.25)25_31_32_26;POLYGON(1,0,0,0.25)32_38_39_33;POLYGON(1,0,0,0.25)37_38;POLYGON(1,0,0,0.25)13_19_20_14;POLYGON(1,0,0,0.25)20_26_27_21;TICK;R_6_10_4_12_30_34_28_36_18_22_24_16;RX_5_11_0_17_29_35_23_40;TICK;CX_5_1_2_6_7_10_11_8_9_12_17_13_29_25_26_30_31_34_35_32_33_36_40_37_14_18_19_22_23_20_21_24;TICK;CX_8_6_13_10_5_2_11_9_15_12_17_14_32_30_37_34_29_26_35_33_39_36_40_38_20_18_23_21_27_24_25_22;TICK;CX_3_6_8_10_1_4_5_7_0_2_11_14_27_30_32_34_25_28_29_31_23_26_35_38_15_18_20_22_17_19_13_16;TICK;CX_5_8_9_6_14_10_11_15_0_3_7_4_29_32_33_30_38_34_35_39_23_27_31_28_17_20_26_22_19_16_21_18;TICK;M_6_10_4_12_30_34_28_36_24_16_22_18;MX_5_11_0_17_29_35_23_40;DT(1,2,2)rec[-20]_rec[-40];DT(2,1,2)rec[-19]_rec[-39];DT(1,0,2)rec[-18]_rec[-38];DT(2,3,2)rec[-17]_rec[-37];DT(5,2,2)rec[-16]_rec[-36];DT(6,1,2)rec[-15]_rec[-35];DT(5,0,2)rec[-14]_rec[-34];DT(6,3,2)rec[-13]_rec[-33];DT(4,3,2)rec[-12]_rec[-32];DT(3,0,2)rec[-11]_rec[-31];DT(4,1,2)rec[-10]_rec[-30];DT(3,2,2)rec[-9]_rec[-29];DT(1,1,2)rec[-8]_rec[-28];DT(2,2,2)rec[-7]_rec[-27];DT(0,2,2)rec[-6]_rec[-26];DT(3,1,2)rec[-5]_rec[-25];DT(5,1,2)rec[-4]_rec[-24];DT(6,2,2)rec[-3]_rec[-23];DT(4,2,2)rec[-2]_rec[-22];DT(7,1,2)rec[-1]_rec[-21];TICK;R_6_10_4_12_30_34_28_36_18_22_24_16;RX_5_11_0_17_29_35_23_40;TICK;CX_5_1_2_6_7_10_11_8_9_12_17_13_29_25_26_30_31_34_35_32_33_36_40_37_14_18_19_22_23_20_21_24;TICK;CX_8_6_13_10_5_2_11_9_15_12_17_14_32_30_37_34_29_26_35_33_39_36_40_38_20_18_23_21_27_24_25_22;TICK;CX_3_6_8_10_1_4_5_7_0_2_11_14_27_30_32_34_25_28_29_31_23_26_35_38_15_18_20_22_17_19_13_16;TICK;CX_5_8_9_6_14_10_11_15_0_3_7_4_29_32_33_30_38_34_35_39_23_27_31_28_17_20_26_22_19_16_21_18;TICK;M_6_10_4_12_30_34_28_36_24_16_22_18;MX_5_11_0_17_29_35_23_40_19_20_21;DT(1,2,3)rec[-23]_rec[-43];DT(2,1,3)rec[-22]_rec[-42];DT(1,0,3)rec[-21]_rec[-41];DT(2,3,3)rec[-20]_rec[-40];DT(5,2,3)rec[-19]_rec[-39];DT(6,1,3)rec[-18]_rec[-38];DT(5,0,3)rec[-17]_rec[-37];DT(6,3,3)rec[-16]_rec[-36];DT(4,3,3)rec[-15]_rec[-35];DT(3,0,3)rec[-14]_rec[-34];DT(4,1,3)rec[-13]_rec[-33];DT(3,2,3)rec[-12]_rec[-32];DT(1,1,3)rec[-11]_rec[-31];DT(2,2,3)rec[-10]_rec[-30];DT(0,2,3)rec[-9]_rec[-29];DT(3,1,3)rec[-8]_rec[-28];DT(5,1,3)rec[-7]_rec[-27];DT(6,2,3)rec[-6]_rec[-26];DT(4,2,3)rec[-5]_rec[-25];DT(7,1,3)rec[-4]_rec[-24];TICK;POLYGON(0,0,1,0.25)7_13_14_8;POLYGON(0,0,1,0.25)2_8_9_3;POLYGON(0,0,1,0.25)7_1;POLYGON(0,0,1,0.25)15_9;POLYGON(0,0,1,0.25)31_37_38_32;POLYGON(0,0,1,0.25)26_32_33_27;POLYGON(0,0,1,0.25)31_25;POLYGON(0,0,1,0.25)39_33;POLYGON(1,0,0,0.25)1_7_8_2;POLYGON(1,0,0,0.25)8_14_15_9;POLYGON(1,0,0,0.25)2_3;POLYGON(1,0,0,0.25)13_14;POLYGON(1,0,0,0.25)25_31_32_26;POLYGON(1,0,0,0.25)32_38_39_33;POLYGON(1,0,0,0.25)26_27;POLYGON(1,0,0,0.25)37_38;TICK;R_6_10_4_12_30_34_28_36;RX_5_11_0_17_29_35_23_40;TICK;CX_5_1_2_6_7_10_11_8_9_12_17_13_29_25_26_30_31_34_35_32_33_36_40_37;TICK;CX_8_6_13_10_5_2_11_9_15_12_17_14_32_30_37_34_29_26_35_33_39_36_40_38;TICK;CX_3_6_8_10_1_4_5_7_0_2_11_14_27_30_32_34_25_28_29_31_23_26_35_38;TICK;CX_5_8_9_6_14_10_11_15_0_3_7_4_29_32_33_30_38_34_35_39_23_27_31_28;TICK;M_6_10_4_12_30_34_28_36;MX_5_11_0_17_29_35_23_40;DT(1,2,4)rec[-16]_rec[-39];DT(2,1,4)rec[-15]_rec[-38];DT(1,0,4)rec[-14]_rec[-37];DT(2,3,4)rec[-13]_rec[-36];DT(5,2,4)rec[-12]_rec[-35];DT(6,1,4)rec[-11]_rec[-34];DT(5,0,4)rec[-10]_rec[-33];DT(6,3,4)rec[-9]_rec[-32];DT(1,1,4)rec[-8]_rec[-27];DT(2,2,4)rec[-7]_rec[-26];DT(0,2,4)rec[-6]_rec[-25];DT(3.5,1.5,4)rec[-5]_rec[-18]_rec[-19]_rec[-24];DT(5,1,4)rec[-4]_rec[-23];DT(6,2,4)rec[-3]_rec[-22];DT(3.5,2.5,4)rec[-2]_rec[-17]_rec[-18]_rec[-21];DT(7,1,4)rec[-1]_rec[-20];TICK;M_1_2_3_7_8_9_13_14_15_25_26_27_31_32_33_37_38_39;DT(1,0,5)rec[-15]_rec[-18]_rec[-32];DT(1,2,5)rec[-13]_rec[-14]_rec[-16]_rec[-17]_rec[-34];DT(2,1,5)rec[-11]_rec[-12]_rec[-14]_rec[-15]_rec[-33];DT(2,3,5)rec[-10]_rec[-13]_rec[-31];DT(5,0,5)rec[-6]_rec[-9]_rec[-28];DT(5,2,5)rec[-4]_rec[-5]_rec[-7]_rec[-8]_rec[-30];DT(6,1,5)rec[-2]_rec[-3]_rec[-5]_rec[-6]_rec[-29];DT(6,3,5)rec[-1]_rec[-4]_rec[-27];OI(1)rec[-16]_rec[-17]_rec[-18];OI(2)rec[-7]_rec[-8]_rec[-9]",
)[Nothing more than logical operator movements]

== Logical Memory

The simplest logical operation is "doing nothing".

Or... Everything?

#columns(
  2,
)[
  #figure(
    image("./images/memory.png", width: 70%), caption: "Logical Memory Spacetime Diagram",
  )
  #colbreak()
  #figure(
    image("./images/memory_correlation_surface.png", width: 70%), caption: "Logical Memory Correlation Surface",
  )

]

== Logical Pauli Gates

#figure(
  quantum-circuit(
    lstick($X_L, Z_L$), 1, $Z_L^a$, $X_L^b$, 1, rstick($(-1)^a X_L, (-1)^b Z_L$), scale: 200%,
  ),
)

Track the byproduct operators in software(Logical Pauli Frame) to avoid applying
logical Pauli gates on hardware.

Byproduct will change over the circuit:

#columns(2)[
  #figure(image("./images/byproduct_before.png", width: 80%))
  #figure(image("./images/byproduct_after.png", width: 80%))
]

== Logical Hadamard

#columns(
  2,
)[
  A layer of transversal H gates on data qubits will do the hadamard transition,
  but the boundary will be changed:
  #figure(
    image("./images/temporal_h.png", width: 50%), caption: "Temporal Hadamard",
  )
  #colbreak()
  Think about that: it's all about mapping the logical operators. We can actually
  rotate the spacetime! (Ummm... the circuit details will change though...)
  #figure(
    image("./images/spatial_h.png", width: 90%), caption: "Spatial Hadamard",
  )
]

== Logical CNOT

Forget about the "Lattice Surgery" for now, just build a topological structure
that can move and map the logical operators correctly.

#columns(
  2,
)[
  #figure(
    image("./images/logical_cnot.png", width: 50%), caption: "Logical CNOT",
  )
  #colbreak()
  #figure(
    image("./images/logical_cnot_correlation.png", width: 50%), caption: $X I arrow.r X X$,
  )
]

== Logical S

Gate teleportation with inplace Y basis measurement @gidney2024inplace.

#columns(
  2,
)[
  #figure(
    image("./images/logical_s.png"), caption: "Logical S via gate teleportation",
  )
  #colbreak()
  #figure(
    image("./images/logical_s_correlation.png", width: 80%), caption: $X arrow.r Y$,
  )
]

== Logical T

Non-clifford Gate: beyond the Gottesman–Knill theorem, necessary for practical
universal quantum computation @gidney2024magic.

#figure(image("./images/logical_t.png"), caption: "Logical T gate")

---

#figure(
  image("./images/magic_state.png"), caption: "Magic state preparation improvements over the years",
)

---

#figure(image("./images/cultivation.png"), caption: "Magica State Cultivation")

---

#figure(image("./images/logical_t_diagram.png"), caption: "Logical T diagram")

== TQEC

- Building software tools to manage the complexity.

- It's not for good, but necessary...

- Take a look at https://github.com/tqec/tqec, it's still in early stage.

= Experiment Progress

---

== Stepping into the QEC era

*Neutral Atoms*

#link(
  "https://www.nature.com/articles/s41586-023-06927-3",
)[Bluvstein, D., Evered, S.J., Geim, A.A. et al. Logical quantum processor based
  on reconfigurable atom arrays. Nature 626, 58–65 (2024).] @bluvstein2024logical

- Connectivity: arbitray in theory, tradeoffs in practice.
- Scalability: not clear for millions of qubits.
- Gates: qubit loss problem, not suitable for repeated measurements yet.
- Clock time: $tilde m s$, extremely slow compared to superconducting qubits. This
  is important for practical large-scale FT quantum algorithm.

*Trapped Ions*

#link(
  "https://www.science.org/doi/10.1126/science.adp6016",
)[High-fidelity teleportation of a logical qubit using transversal gates and
  lattice surgery] @ryan2024high

---

*Superconducting Qubits*

#link(
  "http://arxiv.org/abs/2408.13687",
)[Quantum error correction below the surface code threshold] @acharya2024quantum

#figure(
  image("./images/google_surface_code.png", width: 90%), caption: "Google d=3,5,7 surface code",
)


= Other topics

---

- Decoding algorithms, real-time decoding...

- Concrete circuit construction for logical operations...

- Compile quantum algorithm down to logical circuit to physical circuit...

- Other quantum codes...

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
