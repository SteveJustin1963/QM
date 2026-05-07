#!/usr/bin/env wolframscript

(* --- Parameters & Configuration --- *)
n = 6;
jVal = 1.0;
hRange = Range[0.05, 3.0, 0.1];
dim = 2^n;

(* Operators *)
id = IdentityMatrix[2];
sx = PauliMatrix[1];
sz = PauliMatrix[3];

(* Operator on site i *)
siteOp[op_, i_] := KroneckerProduct @@ Table[If[k == i, op, id], {k, n}];

(* Hamiltonian components, periodic boundary *)
zzTerm = Total[
   Table[
    siteOp[sz, i].siteOp[sz, Mod[i, n] + 1],
    {i, n}
   ]
];

xTerm = Total[Table[siteOp[sx, i], {i, n}]];

getHamiltonian[h_] := -jVal zzTerm - h xTerm;

(* --- Analysis Functions --- *)
calculateMetrics[h_] := Module[
  {ham, vals, vecs, sorted, e0, e1, gap, gs, rhoHalf,
   u, s, v, singVals, entropy, szOrder, sxOrder},

  ham = N[getHamiltonian[h]];

  {vals, vecs} = Eigensystem[ham];

  sorted = SortBy[Transpose[{vals, vecs}], First];

  e0 = sorted[[1, 1]];
  e1 = sorted[[2, 1]];
  gap = e1 - e0;
  gs = sorted[[1, 2]];

  (* Half-chain Schmidt decomposition *)
  rhoHalf = ArrayReshape[gs, {2^(n/2), 2^(n/2)}];

  {u, s, v} = SingularValueDecomposition[rhoHalf];

  singVals = Select[Diagonal[s]^2, # > 10^-14 &];

  entropy = -Total[singVals Log[singVals]];

  (* Order parameters *)
  szOrder = Abs[Re[Conjugate[gs].(siteOp[sz, 1].gs)]];
  sxOrder = Re[Conjugate[gs].(siteOp[sx, 1].gs)];

  {h, e0, gap, entropy, szOrder, sxOrder}
];

(* --- 1. Phase Transition Scan --- *)
Print["--- Phase Transition Scan (N=6) ---"];

results = calculateMetrics /@ hRange;

minGapEntry = MinimalBy[results, #[[3]] &][[1]];

Print[
 StringForm[
  "Numerical Critical Point found at h/J ≈ ``  Min Gap: ``",
  NumberForm[minGapEntry[[1]], {4, 2}],
  NumberForm[minGapEntry[[3]], {8, 6}]
 ]
];

(* --- Phase Transition Graphs --- *)

gapPlot = ListLinePlot[
  results[[All, {1, 3}]],
  Frame -> True,
  FrameLabel -> {"h/J", "Energy gap"},
  PlotMarkers -> Automatic,
  PlotLabel -> "Energy Gap vs Field",
  ImageSize -> Large
];

entropyPlot = ListLinePlot[
  results[[All, {1, 4}]],
  Frame -> True,
  FrameLabel -> {"h/J", "Entanglement entropy"},
  PlotMarkers -> Automatic,
  PlotLabel -> "Entanglement Entropy vs Field",
  ImageSize -> Large
];

orderPlot = ListLinePlot[
  {
   results[[All, {1, 5}]],
   results[[All, {1, 6}]]
  },
  Frame -> True,
  FrameLabel -> {"h/J", "Order parameter"},
  PlotLegends -> {"|<Sz>|", "<Sx>"},
  PlotMarkers -> Automatic,
  PlotLabel -> "Order Parameters vs Field",
  ImageSize -> Large
];

Print[gapPlot];
Print[entropyPlot];
Print[orderPlot];

Export["gap_plot.png", gapPlot];
Export["entropy_plot.png", entropyPlot];
Export["order_plot.png", orderPlot];

(* --- 2. Quantum Quench Dynamics --- *)
Print["\n--- Quantum Quench Dynamics ---"];

(* Initial state: all spins up *)
psi0 = KroneckerProduct @@ Table[{1, 0}, {n}];

hQuench = N[getHamiltonian[1.5]];
times = Range[0, 5, 0.2];

quenchData = Table[
   Module[{u, psiT, szExp},
    u = MatrixExp[-I hQuench t];
    psiT = u.psi0;
    szExp = Re[Conjugate[psiT].(siteOp[sz, 1].psiT)];
    {t, szExp}
   ],
   {t, times}
];

Print["Quench results Time vs <Sz>:"];

Do[
 Print[
  StringForm[
   "t: `` -> <Sz>: ``",
   NumberForm[q[[1]], {3, 1}],
   NumberForm[q[[2]], {8, 5}]
  ]
 ],
 {q, quenchData}
];

(* --- Quench Graph --- *)

quenchPlot = ListLinePlot[
  quenchData,
  Frame -> True,
  FrameLabel -> {"Time", "<Sz>"},
  PlotMarkers -> Automatic,
  PlotLabel -> "Quantum Quench: <Sz> vs Time",
  ImageSize -> Large
];

Print[quenchPlot];

Export["quench_plot.png", quenchPlot];

Print["\nGraphs saved as:"];
Print["gap_plot.png"];
Print["entropy_plot.png"];
Print["order_plot.png"];
Print["quench_plot.png"];

Print["\nScript Complete."];
