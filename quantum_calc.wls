(* Constants and Operators *)
n = 6;
sx = PauliMatrix[1]; sy = PauliMatrix[2]; sz = PauliMatrix[3]; id = IdentityMatrix[2];

(* Function to place operator at site i *)
op[mat_, i_] := Apply[KroneckerProduct, Table[If[j == i, mat, id], {j, n}]]

(* Build Hamiltonian *)
h = Total[Table[
    op[sx, i].op[sx, i + 1] + op[sy, i].op[sy, i + 1] + op[sz, i].op[sz, i + 1], 
    {i, n - 1}
]];

(* Initial State: Up-Down-Up-Down-Up-Down *)
psi0 = Flatten[Apply[KroneckerProduct, Table[If[OddQ[i], {1, 0}, {0, 1}], {i, n}]]];

(* Evolution and Expectation *)
t = Pi/4;
u = MatrixExp[-I * h * t];
psiT = u . psi0;
obs = op[sz, 1];
expectation = Conjugate[psiT] . obs . psiT;

Print[FullSimplify[expectation]];
Print[N[expectation, 10]];

