# Interactive Quantum Tunneling Probability Calculator (Analytical Solution)

# Constants
hbar = 1.0545718e-34; # Reduced Planck's constant (J*s)
m_e = 9.10938356e-31; # Electron mass (kg)
e = 1.60218e-19;      # Elementary charge (C)

# --- User Input Section ---
printf("--- Quantum Tunneling Calculator (Square Barrier) ---\n");
E_eV = input("Enter the electron energy in eV (e.g., 0.5): ");
U0_eV = input("Enter the barrier height in eV (must be higher than electron energy, e.g., 1.0): ");
barrier_width_nm = input("Enter the barrier width in nanometers (nm) (e.g., 1.0): ");
printf("\n");

# --- Calculation Section ---
if (E_eV >= U0_eV)
    printf("Error: This analytical formula is for E < U0 (tunneling regime).\n");
    printf("If E >= U0, the transmission probability is typically 1 (passing over the barrier).\n");
else
    E_J = E_eV * e;         # Electron energy in Joules
    U0_J = U0_eV * e;       # Barrier height in Joules
    barrier_width_m = barrier_width_nm * 1e-9; # Barrier width in meters

    # Wave vectors
    k1 = sqrt(2 * m_e * E_J) / hbar;
    k2 = sqrt(2 * m_e * (U0_J - E_J)) / hbar; # Evanescent wave vector

    # Analytical transmission coefficient (T) calculation
    # Formula: T = [1 + ( (U0^2) * sinh(k2*a)^2 ) / (4*E*(U0-E)) ]^-1
    sinh_term = sinh(k2 * barrier_width_m);
    denominator_term = (U0_J^2 * sinh_term^2) / (4 * E_J * (U0_J - E_J));
    T_analytical = 1 / (1 + denominator_term);

    # --- Output Section ---
    printf("Results:\n");
    printf("  Transmission Probability (T): %.4e\n", T_analytical);
    printf("  Percentage chance to tunnel through: %.2f%%\n", T_analytical * 100);
endif

