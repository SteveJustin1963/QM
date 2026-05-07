# Transverse-Field Ising Model: Phase Transition & Quench Dynamics

This script is a physics simulation of the Transverse-Field Ising Model (TFIM) — a digital experiment to see how a chain of tiny magnets behaves when pushed by different forces.

## Key Concepts

### The "Tug-of-War" (The Hamiltonian)

The Hamiltonian is the formula for total energy. It describes a battle between two forces:

- **Coupling (J):** Wants all spins to point in the same direction — ferromagnetism. Think of a row of 6 people holding hands, all facing North.
- **Transverse Field (h):** An outside force shaking the magnets toward a different direction, creating quantum fluctuations. Like a loud noise from the West making people turn to face it.

### Phase Transition: The Breaking Point

A phase transition is a sudden change in behavior (like water turning to ice).

- If h is **weak**, the magnets stay lined up — **ordered phase**.
- If h is **strong** (h > J), the magnets follow the field — **disordered phase**.
- The breaking point is exactly at **h/J = 1**.

Key signals of the transition:

| Signal | What it means |
|--------|---------------|
| **Energy gap** shrinks | The system becomes "unsteady" right before it flips |
| **Entanglement entropy** peaks | The magnets are maximally "talking" to each other at the transition |
| **Order parameters** cross | The ferromagnetic score falls; the paramagnetic score rises |

### Exact Diagonalization: The Brute-Force Method

With only 6 spins (each up or down), there are just 2⁶ = 64 possible states. The computer builds a full 64×64 energy matrix and solves it exactly — no approximations or shortcuts, like solving a 64-piece puzzle by trying every combination.

### Quantum Quench: The Sudden Shock

A quench means changing the rules of the game instantly and watching the chaos unfold.

1. **Start:** All magnets perfectly aligned (all-up state, the h=0 ground state).
2. **Shock:** Suddenly switch on a strong transverse field (h=1.5).
3. **Result:** The magnets don't flip instantly — they wobble and oscillate, gradually losing their original alignment. Like standing still and having the floor suddenly spin beneath you.

---

Exact diagonalization study of the 1D transverse-field Ising model on a periodic 6-site chain.

## Model

The Hamiltonian is:

**H = −J Σᵢ ZᵢZᵢ₊₁ − h Σᵢ Xᵢ**

| Parameter | Value |
|-----------|-------|
| Sites (n) | 6 |
| Coupling (J) | 1.0 |
| Field range (h/J) | 0.05 → 3.0, step 0.1 |
| Hilbert space dim | 64 (2⁶) |

The ZZ coupling favors ferromagnetic alignment; the transverse field X drives quantum fluctuations. The model has an exact quantum phase transition at h/J = 1.

---

## Part 1: Phase Transition Scan

For each value of h, the script:

1. Builds the full 64×64 Hamiltonian via Kronecker products of Pauli matrices.
2. Diagonalises it exactly with `Eigensystem`.
3. Computes the following observables on the ground state:

| Observable | Description |
|------------|-------------|
| Energy gap | E₁ − E₀; closes at the critical point |
| Entanglement entropy | Von Neumann entropy from half-chain Schmidt decomposition |
| \|⟨Sz⟩\| | Ferromagnetic order parameter; non-zero in ordered phase |
| ⟨Sx⟩ | Paramagnetic order parameter; grows with h |

The script reports the numerical critical point (the h where the gap is minimum) and exports:

- `gap_plot.png` — energy gap vs h/J
- `entropy_plot.png` — entanglement entropy vs h/J
- `order_plot.png` — both order parameters vs h/J

---

## Part 2: Quantum Quench Dynamics

Starting from the all-spins-up state |↑↑↑↑↑↑⟩ (ground state at h=0), the system is evolved under the Hamiltonian at h=1.5 (paramagnetic phase) via exact matrix exponentiation:

**|ψ(t)⟩ = e^{−iHt} |ψ₀⟩**

⟨Sz⟩ is measured on site 1 at times t ∈ [0, 5] in steps of 0.2, showing oscillation and decay as the initial ferromagnetic state dephases under the paramagnetic Hamiltonian.

Exports:

- `quench_plot.png` — ⟨Sz⟩ vs time

---

## How the Script Works — Step by Step

### Step 1: Set parameters and build operators

```wolfram
n = 6; jVal = 1.0; hRange = Range[0.05, 3.0, 0.1]; dim = 2^n;
```

The script defines the chain length, coupling strength, and the list of field values to scan. It then defines the three building-block matrices: the 2×2 identity (`id`), Pauli-X (`sx`), and Pauli-Z (`sz`).

### Step 2: Embed single-site operators into the full chain

```wolfram
siteOp[op_, i_] := KroneckerProduct @@ Table[If[k == i, op, id], {k, n}]
```

To act on site `i` of a 6-spin chain you need a 64×64 matrix. `siteOp` builds this by tensoring the chosen operator into position `i` and placing identity matrices on all other sites.

### Step 3: Assemble the Hamiltonian

```wolfram
zzTerm = Total[Table[siteOp[sz,i].siteOp[sz, Mod[i,n]+1], {i,n}]]
xTerm  = Total[Table[siteOp[sx, i], {i, n}]]
getHamiltonian[h_] := -jVal zzTerm - h xTerm
```

- `zzTerm` sums the ZZ interaction over all nearest-neighbour pairs, with the last site wrapping back to the first (periodic boundary).
- `xTerm` sums the transverse field on every site.
- `getHamiltonian[h]` combines them into the full 64×64 matrix for a given field strength h.

### Step 4: Diagonalise and extract ground state observables

For each h in the scan range, `calculateMetrics[h]` does the following:

1. **Diagonalise** — calls `Eigensystem` to get all 64 eigenvalues and eigenvectors.
2. **Sort** — pairs each eigenvalue with its eigenvector and sorts by energy, so index 1 is the ground state.
3. **Energy gap** — subtracts ground state energy E₀ from the first excited energy E₁.
4. **Entanglement entropy** — reshapes the ground state vector into a 8×8 matrix (splitting the chain in half), runs a singular value decomposition, squares the singular values to get Schmidt coefficients λᵢ, and computes S = −Σ λᵢ ln λᵢ.
5. **Order parameters** — evaluates the expectation value ⟨ψ|O|ψ⟩ for both Sz and Sx on site 1.

### Step 5: Find the numerical critical point

```wolfram
minGapEntry = MinimalBy[results, #[[3]] &][[1]]
```

Scans all (h, gap) pairs and picks the h where the gap is smallest. This is the numerical estimate of the phase transition, expected near h/J = 1.

### Step 6: Plot and export the phase transition data

Three plots are created with `ListLinePlot` and saved as PNG files:

- **gap_plot.png** — energy gap vs h/J (dips at the critical point)
- **entropy_plot.png** — entanglement entropy vs h/J (peaks at the critical point)
- **order_plot.png** — |⟨Sz⟩| and ⟨Sx⟩ on the same axes (the two order parameters cross near h/J = 1)

### Step 7: Prepare the quantum quench

```wolfram
psi0 = KroneckerProduct @@ Table[{1, 0}, {n}]
hQuench = N[getHamiltonian[1.5]]
```

The initial state is the all-spins-up product state |↑↑↑↑↑↑⟩, built by tensoring six copies of the single-spin-up vector `{1, 0}`. The quench Hamiltonian is fixed at h=1.5.

### Step 8: Time-evolve and measure

```wolfram
u = MatrixExp[-I hQuench t]
psiT = u.psi0
szExp = Re[Conjugate[psiT].(siteOp[sz, 1].psiT)]
```

At each time step t ∈ [0, 5]:

1. Compute the exact unitary evolution operator `e^{−iHt}` via matrix exponentiation.
2. Apply it to the initial state to get |ψ(t)⟩.
3. Measure ⟨Sz⟩ on site 1 as the real part of ⟨ψ(t)|Sz|ψ(t)⟩.

### Step 9: Plot and export the quench data

`quench_plot.png` shows ⟨Sz⟩ vs time. The initial value is +1 (all spins up). As the system evolves under the paramagnetic Hamiltonian the expectation value oscillates and decays toward zero, reflecting the dephasing of the initial ferromagnetic state.

---

## Running

```bash
wolframscript -file tfim_phase_quench.wls
```

Requires a Wolfram Engine or Mathematica installation with `wolframscript` on the PATH.

## Output Files

| File | Contents |
|------|----------|
| `gap_plot.png` | Energy gap vs transverse field |
| `entropy_plot.png` | Half-chain entanglement entropy vs field |
| `order_plot.png` | Ferromagnetic and paramagnetic order parameters vs field |
| `quench_plot.png` | Post-quench ⟨Sz⟩ dynamics |

