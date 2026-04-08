# PR Box Simulation — Popescu-Rohrlich Correlations

> A C simulation of the Popescu-Rohrlich (PR) Box: a theoretical super-quantum device
> that achieves 100% correlation in the CHSH game while obeying no-signaling — provably
> impossible to build in our universe, yet one of the most important objects in the
> foundations of quantum mechanics.

---

## Table of Contents

1. [What Is a PR Box?](#1-what-is-a-pr-box)
2. [The Three Worlds of Correlation](#2-the-three-worlds-of-correlation)
3. [Bell's Theorem and the Classical Limit](#3-bells-theorem-and-the-classical-limit)
4. [Quantum Entanglement and Tsirelson's Bound](#4-quantum-entanglement-and-tsirelsons-bound)
5. [The PR Box — Beyond Quantum](#5-the-pr-box--beyond-quantum)
6. [The No-Signaling Condition](#6-the-no-signaling-condition)
7. [Why the PR Box Cannot Exist](#7-why-the-pr-box-cannot-exist)
8. [Why Physicists Study Impossible Objects](#8-why-physicists-study-impossible-objects)
9. [The Code — How the Simulation Works](#9-the-code--how-the-simulation-works)
10. [How the Simulation Cheats](#10-how-the-simulation-cheats)
11. [Build and Run](#11-build-and-run)
12. [Sample Output](#12-sample-output)
13. [The Open Question](#13-the-open-question)
14. [Further Reading](#14-further-reading)

---

## 1. What Is a PR Box?

The **Popescu-Rohrlich (PR) Box** was introduced by Sandu Popescu and Daniel Rohrlich in
1994. It is a hypothetical two-party device with the following interface:

```
  ┌──────────────────────────────────────────────────────────┐
  │                      PR BOX                              │
  │                                                          │
  │   Alice feeds in ──► x ∈ {0,1}    y ∈ {0,1} ◄── Bob    │
  │                       │                   │              │
  │                       ▼                   ▼              │
  │   Alice receives ◄── a ∈ {0,1}    b ∈ {0,1} ──► Bob    │
  │                                                          │
  │   GUARANTEE:  a XOR b  =  x AND y   (always)            │
  │   GUARANTEE:  Alice and Bob cannot communicate           │
  └──────────────────────────────────────────────────────────┘
```

The constraint `a XOR b = x AND y` written out for all inputs:

| x | y | x AND y | Required: a XOR b |
|---|---|---------|-------------------|
| 0 | 0 |    0    | 0  (outputs same) |
| 0 | 1 |    0    | 0  (outputs same) |
| 1 | 0 |    0    | 0  (outputs same) |
| 1 | 1 |    1    | 1  (outputs differ) |

The outputs must **disagree only when both inputs are 1**. In every other case they must
agree — yet neither party knows the other's input when producing their output.

---

## 2. The Three Worlds of Correlation

Physics defines three distinct layers of how correlated two separated systems can be:

```
─────────────────────────────────────────────────────────────────────
  CLASSICAL          QUANTUM              SUPER-QUANTUM (PR Box)
  (shared tables)    (entanglement)       (hypothetical)

  Max CHSH = 75%     Max CHSH ≈ 85.4%     Max CHSH = 100%
  Bell inequality    Tsirelson's bound     No physical bound exceeded
─────────────────────────────────────────────────────────────────────
```

All three worlds obey **no-signaling** (information cannot travel faster than light).
Only the first two are physically realizable. The PR box lives in a third region that
is logically consistent but excluded from our universe by some deeper principle we do
not yet fully understand.

---

## 3. Bell's Theorem and the Classical Limit

### The CHSH Game

The **CHSH game** (Clauser-Horne-Shimony-Holt, 1969) is a cooperative game between
Alice and Bob. Before the game they may agree on a shared strategy, but once started
they cannot communicate.

- A referee sends Alice a random bit `x` and Bob a random bit `y`.
- Alice responds with bit `a`, Bob with bit `b`.
- They **win** if `a XOR b = x AND y`.

### Classical Strategy

With shared randomness (pre-agreed tables, shared dice, etc.) the best possible strategy
wins 3 out of 4 input pairs. The fourth pair always fails.

**Classical maximum: 75% win rate.**

This is not a limitation of cleverness — John Bell proved in 1964 that **no classical
hidden-variable theory can exceed this bound**. It is a mathematical theorem, not an
engineering problem.

### The Bell Inequality (CHSH form)

The CHSH value S is defined as:

```
S = |E(0,0) + E(0,1) + E(1,0) − E(1,1)|

where E(x,y) = P(a=b|x,y) − P(a≠b|x,y)
```

For any classical (local hidden variable) theory: `S ≤ 2`

Equivalently: win rate ≤ 75%.

---

## 4. Quantum Entanglement and Tsirelson's Bound

### Entangled Qubits

Quantum mechanics allows particles to share **entangled states** — correlations that
have no classical explanation. The canonical example is a Bell state (singlet):

```
|Ψ⁻⟩ = (1/√2)(|01⟩ − |10⟩)
```

When Alice and Bob each measure their qubit along carefully chosen axes, their results
are correlated in a way that violates the classical Bell inequality.

### Tsirelson's Bound

Boris Tsirelson proved in 1980 that quantum mechanics obeys its own upper limit:

```
S ≤ 2√2 ≈ 2.828
```

Equivalently: **maximum CHSH win rate ≈ 85.355%**

This is achieved with the optimal measurement angles of 45°. The quantum advantage
over classical physics is real and measurable — but it is bounded.

### Experimental Confirmation (Nobel Prize 2022)

The 2022 Nobel Prize in Physics was awarded to **Alain Aspect, John Clauser, and Anton
Zeilinger** for experiments that demonstrated quantum entanglement violates the classical
Bell inequality. These loophole-free experiments confirmed:

- Quantum correlations are real.
- They exceed the classical 75% limit.
- They do **not** exceed Tsirelson's ~85.4% limit.

---

## 5. The PR Box — Beyond Quantum

### The Constraint

The PR box achieves **100% CHSH win rate** — it satisfies `a XOR b = x AND y` for
every possible input pair, every single time.

```
Classical ──────────── Quantum ──────────────────── PR Box
   75%           ~85.4% (Tsirelson)               100%
   ↑                    ↑                           ↑
Bell limit         Nature's actual limit      Logically possible
                                               Physically forbidden
```

### Why It Is Logically Self-Consistent

The PR box does not violate logic or mathematics. You can write down the probability
distribution it produces:

```
P(a,b | x,y) = 1/2   if  a XOR b = x AND y
P(a,b | x,y) = 0     otherwise
```

This is a perfectly valid probability distribution. It is normalized. It is
non-negative. It does not involve time travel or contradiction.

It simply does not correspond to anything in our universe.

---

## 6. The No-Signaling Condition

No-signaling means: **Alice's output distribution cannot depend on Bob's input, and
vice versa.**

Formally:

```
∑_b P(a,b | x,y)  must be independent of y    (Alice cannot detect y)
∑_a P(a,b | x,y)  must be independent of x    (Bob cannot detect x)
```

The PR box satisfies this. For any input `y` Bob chooses, Alice's marginal output is:

```
P(a=0 | x, y=0) = 1/2    P(a=0 | x, y=1) = 1/2
P(a=1 | x, y=0) = 1/2    P(a=1 | x, y=1) = 1/2
```

Alice always sees a fair coin — she learns nothing about `y`. Bob sees the same.
The correlations are **only visible when both outputs are compared together**, which
requires a classical communication channel (and therefore cannot be used for FTL
signaling).

This is why the PR box is called "no-signaling super-quantum" — it is more correlated
than quantum mechanics, yet it does not violate special relativity on its own.

---

## 7. Why the PR Box Cannot Exist

If PR boxes existed physically, they would violate at least one of the following
principles (it is not agreed which one is the "true" reason):

### Information Causality (Pawlowski et al., 2009)

If Bob receives `m` classical bits from Alice and has access to a PR box, the amount
of information Bob can learn about Alice's data is bounded by `m`. PR boxes violate
this bound — they would allow Bob to learn more than the classical channel permits.
Quantum mechanics exactly saturates this principle.

### Macroscopic Locality

If you coarse-grain measurements into macroscopic averages, quantum correlations look
classical. PR box correlations would remain non-classical even at the macroscopic level,
violating our everyday experience of a local world.

### Non-Trivial Communication Complexity

With PR boxes, **every** two-party communication complexity problem could be solved
with just one bit of communication — an extraordinary computational collapse. The
structure of our universe appears to avoid this.

### Uncertainty Relations / State Disturbance

Quantum mechanics enforces fundamental limits on how precisely two incompatible
observables can be known simultaneously. PR correlations are inconsistent with these
limits when you try to embed them in a Hilbert space.

**The honest answer:** We know the PR box is impossible, and we have several candidate
reasons, but there is no single universally agreed-upon axiom that rules it out while
cleanly deriving Tsirelson's bound from first principles. This remains an open problem.

---

## 8. Why Physicists Study Impossible Objects

This is the central question. Why spend time on something that cannot be built?

### Mapping the Boundary

By studying what lies *just outside* quantum mechanics, physicists learn what is special
*about* quantum mechanics. The PR box is a probe of the exact boundary between the
quantum and the impossible.

### Reconstructing Quantum Theory

There is an active research program (Quantum Foundations) trying to derive quantum
mechanics from simple operational axioms — the way thermodynamics can be derived from
a few principles without knowing about atoms. The PR box helps identify which axioms
are load-bearing.

If you can find a principle P such that:
```
"P is physically reasonable"  AND  "P rules out PR boxes"  AND  "P implies Tsirelson's bound"
```
...you have found a deep reason *why* quantum mechanics is the way it is.

### Generalized Probabilistic Theories (GPT)

The PR box lives in the framework of **Generalized Probabilistic Theories** — a
mathematical sandbox where you can study arbitrary probabilistic theories, not just
classical probability and quantum mechanics. GPT lets physicists ask:

- What operational features are unique to quantum mechanics?
- Which quantum protocols (teleportation, cryptography) rely on which features?
- Could an alien universe with different correlations still support computation?

The PR box is one of the most studied objects in this framework.

---

## 9. The Code — How the Simulation Works

### File: `pr_box.c`

```c
typedef struct {
    int a; // Alice's output
    int b; // Bob's output
} PRBoxResult;

PRBoxResult simulate_pr_box(int x, int y) {
    PRBoxResult result;

    // Alice's output is locally random — she does not know y
    result.a = rand() % 2;

    // The PR constraint: a XOR b = x AND y
    // Solved for b: b = a XOR (x AND y)
    result.b = (result.a ^ (x & y));

    return result;
}
```

### The Logic

Step 1 — Alice produces a uniformly random bit (models no-signaling):
```
a ∈ {0, 1}   with probability 1/2 each
```

Step 2 — Bob's output is derived to satisfy the constraint:
```
b = a XOR (x AND y)
```

Proof that this satisfies the constraint:
```
a XOR b = a XOR (a XOR (x AND y))
        = (a XOR a) XOR (x AND y)     [XOR is associative]
        = 0 XOR (x AND y)             [a XOR a = 0]
        = x AND y                     ✓
```

### Verification in `main()`

```c
int correlation = (res.a ^ res.b);   // compute a XOR b
int target      = (x & y);           // compute x AND y
// These must always be equal
```

The program tests all four input pairs `{(0,0), (0,1), (1,0), (1,1)}` and prints
`VALID` if the constraint holds, `INVALID` otherwise.

---

## 10. How the Simulation Cheats

This is critical to understand. **The simulation is not a genuine two-party protocol.**

In a real experiment:
```
Alice (Lab A)                              Bob (Lab B)
─────────────                              ───────────
Receives x                                 Receives y
Produces a                                 Produces b
         ←── NO COMMUNICATION ALLOWED ───►
```

Alice and Bob must produce their outputs **independently**, before comparing results.

In the simulation:
```c
result.a = rand() % 2;
result.b = (result.a ^ (x & y));   // ← Bob uses Alice's output 'a'
```

Bob's output is computed **using Alice's output**. This only works because both "parties"
run on the same machine with shared memory. It is equivalent to Alice secretly phoning
Bob before he answers.

This is why real quantum entanglement cannot achieve 100% — in a genuine experiment,
Bob has no access to Alice's result. The simulation demonstrates the *mathematical
structure* of PR correlations, not a physical mechanism to produce them.

---

## 11. Build and Run

### Requirements

- GCC or any C99-compatible compiler
- Standard C library (stdio, stdlib, time)

### Compile

```bash
gcc -Wall -Wextra -o pr_box pr_box.c
```

### Run

```bash
./pr_box
```

### Run Multiple Times

```bash
for i in 1 2 3 4 5; do echo "=== Run $i ===" && ./pr_box; done
```

---

## 12. Sample Output

```
--- PR Box (Post-Quantum) Simulation ---
Inputs (x,y) | Outputs (a,b) | (a+b)%2 == x*y
--------------------------------------------
  (0, 0)     |    (1, 1)     |      VALID
  (0, 1)     |    (0, 0)     |      VALID
  (1, 0)     |    (1, 1)     |      VALID
  (1, 1)     |    (0, 1)     |      VALID
```

Key observations:

- When `x=1, y=1`: outputs **must differ** (a XOR b = 1). Here `(0,1)` — correct.
- All other pairs: outputs **must match** (a XOR b = 0). They do — correct.
- Alice's `a` changes randomly each run; Bob's `b` always adjusts to maintain validity.
- **Win rate: 100%** across all runs. Quantum mechanics caps at ~85.4%.

---

## 13. The Open Question

The central mystery this simulation points at:

> **Why does quantum mechanics stop at Tsirelson's bound (~85.4%) and not go further?**

We know:
- Classical physics stops at 75% — Bell's theorem tells us why (local hidden variables).
- PR boxes hit 100% — mathematically consistent, no-signaling satisfied.
- Quantum mechanics lands at ~85.4% — experimentally confirmed.

What we do **not** know is the single, clean, physically motivated axiom that:
1. Rules out the PR box region (85.4% to 100%).
2. Is independently motivated (not just "because it matches QM").
3. Derives Tsirelson's bound as a consequence.

Multiple candidates exist (information causality, macroscopic locality, etc.) but none
is universally accepted as *the* answer. This is one of the deepest open questions in
the foundations of physics.

The PR box is the theoretical object that keeps this question sharp.

---

## 14. Further Reading

| Resource | Topic |
|---|---|
| Popescu & Rohrlich, *Foundations of Physics* 24, 1994 | Original PR box paper |
| Bell, *Physics* 1, 195 (1964) | Bell's theorem |
| Tsirelson, *Letters in Mathematical Physics* 4, 1980 | Quantum bound proof |
| Pawlowski et al., *Nature* 461, 2009 | Information causality |
| Barrett, *Phys. Rev. A* 75, 2007 | Generalized Probabilistic Theories |
| Aspect, Clauser, Zeilinger — Nobel Lecture 2022 | Experimental entanglement |
| [PMC7514197](https://pmc.ncbi.nlm.nih.gov/articles/PMC7514197/) | PR box review |
| [arXiv:1708.07425](https://arxiv.org/abs/1708.07425) | GPT framework |
| [Nature s41598-024-59492-8](https://www.nature.com/articles/s41598-024-59492-8) | CHSH and PR correlations |
| [arXiv:2509.26271](https://arxiv.org/pdf/2509.26271) | Recent PR box research |

---

## Correlation Hierarchy Summary

```
╔══════════════════════════════════════════════════════════════════╗
║  CLASSICAL        QUANTUM              PR BOX (hypothetical)    ║
║  ─────────        ───────              ─────────────────────    ║
║  Shared tables    Entangled qubits     Mathematical object      ║
║  Local hidden     Non-local but        Non-local, no-signaling  ║
║  variables        bounded              unbounded within NS      ║
║                                                                  ║
║  CHSH ≤ 2         CHSH ≤ 2√2           CHSH = 4                 ║
║  Win ≤ 75%        Win ≤ 85.4%          Win = 100%               ║
║                                                                  ║
║  Bell (1964)      Tsirelson (1980)     Popescu-Rohrlich (1994)  ║
║  Nobel 2022       Nobel 2022           (no Nobel — not real)    ║
╚══════════════════════════════════════════════════════════════════╝
```

---

*Simulation written in C99. Theory based on published work in quantum foundations.*
*The PR box is a theoretical construct — it cannot be physically realized.*
