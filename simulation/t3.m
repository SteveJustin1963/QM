# Interactive De Broglie Wavelength Calculator

# Constants
h = 6.62607015e-34; # Planck's constant in J*s
m_e = 9.10938356e-31; # Electron mass in kg
e = 1.60218e-19;      # Elementary charge

# --- User Input Section ---
printf("--- De Broglie Wavelength Calculator ---\n");
KE_eV = input("Enter the electron kinetic energy in electron-volts (eV) (e.g., 10000 for 10 keV): ");
printf("\n");

# --- Calculation Section ---
KE_J = KE_eV * e; # Convert eV to Joules

if (KE_J <= 0)
    printf("Kinetic energy must be positive.\n");
else
    # v = sqrt(2 * KE / m)
    v = sqrt(2 * KE_J / m_e); # Velocity in m/s

    # lambda = h / (m * v)
    lambda_deb = h / (m_e * v);

    # Convert to nanometers
    lambda_nm = lambda_deb * 1e9;

    # --- Output Section ---
    printf("Results:\n");
    printf("  Electron velocity: %.2e m/s\n", v);
    printf("  De Broglie wavelength: %.4f nm\n", lambda_nm);
    printf("\nNote: Quantum effects become significant when the wavelength (%.4f nm)\n", lambda_nm);
    printf("      is comparable to the physical structure size (e.g., transistor channel).\n");
endif
