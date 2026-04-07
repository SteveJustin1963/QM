### Thesis Summary (103 pages, Uppsala University, Nov 2022)
**Title:** Quantum Simulation of Quantum Effects in Sub-10-nm Transistor Technologies  
**Author:** Anders Winka  
**Degree:** Master’s thesis in Engineering Physics (30 ECTS)

### Core Objective
Develop a 2D quantum simulator for sub-10-nm transistors that correctly captures the dominant quantum effects (tunneling and confinement) by self-consistently solving the coupled 2D **Schrödinger–Poisson equations with open boundary conditions (OBC)**, and explore whether a real quantum annealer (D-Wave) can accelerate the computationally heaviest part.

### Why this matters
- Transistors are now <10 nm → electrons behave as waves, not classical particles.
- Classical drift-diffusion models fail completely.
- Accurate quantum modeling is essential for next-generation nodes (3 nm, 2 nm, etc.).
- Quantum simulations are extremely slow (large sparse complex linear systems must be solved many times).

### Main Physical & Numerical Methods
1. **Schrödinger equation with open boundaries**
   - Solved using the **Quantum Transmitting Boundary Method (QTBM)** → correctly injects/transmits traveling waves from source/drain leads.
   - Discretized with finite-element method on rectangular mesh.

2. **Poisson equation** → gives electrostatic potential from charge distribution.

3. **Self-consistent loop**
   - Iterate Schrödinger → charge density → Poisson → new potential → Schrödinger … until convergence.

4. **Key bottleneck**
   - Solving the large complex linear system from the discretized OBC Schrödinger equation (repeated hundreds of times per bias point).

### Acceleration Strategies Developed
#### 1. Classical acceleration: Block Cyclic Reduction (BCR)
- Domain decomposition method that breaks the big linear system into many smaller independent blocks.
- In BCR, many small matrix inverses (typically 20×20 to 100×100) must be computed.
- Result: BCR is **≥15× faster** (CPU time) than direct solve with numpy.linalg.solve / LAPACK.

#### 2. “Extra layer BCR”
- Small modification proposed in the thesis that adds one extra mesh layer.
- Improves accuracy for certain potential landscapes with almost no speed penalty.

#### 3. Quantum-annealer acceleration
- Used real hardware: **D-Wave Advantage_system4.1** (2022).
- Matrix inversion reformulated as Quadratic Unconstrained Binary Optimization (QUBO).
- Two approaches tested:
  - “Unit-vector” method (Rogers & Singleton) → practical with current qubit counts.
  - “Whole-matrix” method (developed in thesis) → theoretically interesting but needs too many qubits.
- Finding: Quantum annealer gives correct inverses, but is **500× slower** than classical numpy.linalg.inv and at best **25× slower** than full classical solve.

### Key Results
| Component                      | Speedup vs classical direct solve | Accuracy |
|--------------------------------|-----------------------------------|----------|
| Pure BCR (classical)           | ≥15× faster                       | Excellent |
| Extra-layer BCR                | Same speed, better accuracy       | Improved |
| Quantum-assisted BCR (D-Wave)  | 25× slower (best case)            | Good     |
| Quantum vs numpy.inv alone     | 500× slower                       | Good     |

### Demonstrated Quantum Effects
- Resonant tunneling diode (RTD) characteristics clearly reproduced.
- Gate-induced quantum confinement and source-to-drain tunneling in MOSFET-like structures.

### Main Conclusions
1. A working 2D open-boundary Schrödinger–Poisson solver was successfully implemented.
2. Block Cyclic Reduction is highly effective and makes realistic 2D quantum simulations feasible on ordinary laptops.
3. Current quantum annealers (2022 hardware) are far too slow and qubit-limited to be useful for practical transistor simulation — the classical BCR version is vastly superior today.
4. Quantum annealers might become relevant in the future when solving much larger inverse problems or when thousands of qubits with lower noise become available.

### Most Important Formulas (simplified)
- Time-independent 2D Schrödinger with OBC:  
  $\[-\frac{\hbar^2}{2m^*} (\partial_x^2 + \partial_y^2) \psi + V(x,y)\psi = E \psi\]$
  with transparent boundary conditions via QTBM self-energies Σ_L, Σ_R.

- Electron density (from all injecting states):  
  $\(n(x,y) = \frac{2}{2\pi} \int_{E_\text{min}}^{E_\text{max}} |\psi_E(x,y)|^2 g(E) f(E - E_F) \, dE\)$

- Self-consistent loop convergence typically requires 20–100 iterations.

In short: Great physics and numerics (the BCR-accelerated classical simulator works very well), but in 2022 a real quantum annealer provided no practical speedup — it was interesting proof-of-concept only.
