# Quantum Tunneling Simulation in Octave (simplified 1D)

# Constants
hbar = 1.0545718e-34; # Reduced Planck's constant
m_e = 9.10938356e-31; # Electron mass
e = 1.60218e-19; # Elementary charge

# Simulation parameters
L = 10e-9; # Total length of the simulation space (10 nm)
Nx = 500; # Number of spatial points
dx = L / Nx; # Spatial step size

# Potential barrier parameters
barrier_width = 1e-9; # 1 nm barrier
barrier_height_eV = 1; # 1 eV barrier height
barrier_height_J = barrier_height_eV * e; # Barrier height in Joules
# Define the potential profile U(x)
x = linspace(0, L, Nx);
U = zeros(1, Nx);
# Place barrier in the middle
barrier_start = (L/2) - (barrier_width/2);
barrier_end = (L/2) + (barrier_width/2);
U(x >= barrier_start & x <= barrier_end) = barrier_height_J;

# Electron energy (less than barrier height for tunneling)
E_eV = 0.5; # 0.5 eV electron energy
E_J = E_eV * e;

# Discretized 1D Schrödinger equation (Finite Difference Method)
# H*psi = E*psi
# The Hamiltonian matrix H is tridiagonal
T0 = -hbar^2 / (2 * m_e * dx^2);
H = 2 * T0 * eye(Nx) + T0 * diag(ones(Nx-1, 1), 1) + T0 * diag(ones(Nx-1, 1), -1);

# Add potential energy to the diagonal of H
for i = 1:Nx
    H(i, i) = H(i, i) + U(i);
end

# NOTE: Solving the full eigenvalue problem (H*psi = E*psi) gives bound states.
# To model the *transport* (tunneling probability for a specific incoming energy E),
# a scattering approach (Transfer Matrix Method or Non-Equilibrium Green's Function) is needed,
# which is more involved than this basic example.

# Basic transmission calculation using a simplified Transfer Matrix approach idea
# For a square barrier, the transmission coefficient (T) can be calculated analytically
# The following provides the *analytical* T for a square barrier, which is much simpler
# than the numerical method for transport (which involves boundary conditions).

k1 = sqrt(2 * m_e * E_J) / hbar; # Wave vector outside barrier
k2 = sqrt(2 * m_e * (barrier_height_J - E_J)) / hbar; # Evanescent wave vector inside barrier (for E < U0)

T_analytical = 1 / (1 + ( (barrier_height_J^2) * sinh(k2 * barrier_width)^2 ) / (4 * E_J * (barrier_height_J - E_J)) );

printf("\nQuantum Tunneling Calculation (Analytical for E < U0):\n");
printf("Electron Energy: %.1f eV, Barrier Height: %.1f eV, Barrier Width: %.1f nm\n", E_eV, barrier_height_eV, barrier_width*1e9);
printf("Transmission Probability (T): %.4e\n", T_analytical);
