function t1(KE_eV = 10000, energy_range = [], num_points = 7)
  # Calculate de Broglie wavelength for an electron
  # Inputs:
  #   KE_eV: Kinetic energy in electronvolts for main calculation (default: 10000 eV)
  #   energy_range: [min_eV, max_eV] for graph (default: auto-generated range)
  #   num_points: Number of points to plot in graph (default: 7)

  # Prompt for user input if no arguments provided
  if nargin == 0
    KE_eV = input("Enter kinetic energy in eV (press Enter for 10000 eV): ");
    if isempty(KE_eV)
      KE_eV = 10000;
    endif

    use_custom_range = input("Use custom energy range for graph? (y/n, press Enter for auto): ", "s");
    if strcmpi(use_custom_range, "y")
      min_eV = input("Enter minimum energy in eV: ");
      max_eV = input("Enter maximum energy in eV: ");
      energy_range = [min_eV, max_eV];
    else
      energy_range = [];
    endif

    num_points = input("Enter number of points for graph (press Enter for 7): ");
    if isempty(num_points)
      num_points = 7;
    endif
  endif

  # Constants
  h = 6.62607015e-34; # Planck's constant in J*s
  m_e = 9.10938356e-31; # Electron mass in kg

  # Calculate velocity from kinetic energy
  # KE = 1/2 * m * v^2 -> v = sqrt(2 * KE / m)
  KE_J = KE_eV * 1.60218e-19; # Convert eV to Joules
  v = sqrt(2 * KE_J / m_e); # Velocity in m/s

  # De Broglie wavelength calculation: lambda = h / (m * v)
  lambda_deb = h / (m_e * v);

  # Convert to nanometers for easier comparison with transistor size
  lambda_nm = lambda_deb * 1e9;

  # Display results
  printf("\n=== De Broglie Wavelength Calculation ===\n");
  printf("Kinetic Energy: %.2f keV\n", KE_eV/1000);
  printf("Electron velocity: %.2e m/s\n", v);
  printf("De Broglie wavelength: %.4f nm\n", lambda_nm);
  printf("Nanometer scale is ~1-10 nm. If the wavelength (%.4f nm) is comparable, quantum effects are significant.\n\n", lambda_nm);

  # Generate ASCII graph showing wavelength vs energy
  printf("=== Wavelength vs Energy Graph ===\n");

  # Set energy range for graph
  if isempty(energy_range)
    # Auto-generate range around input energy
    energies = logspace(log10(max(100, KE_eV/10)), log10(KE_eV*10), num_points);
  else
    # Use specified range
    energies = linspace(energy_range(1), energy_range(2), num_points);
  endif

  wavelengths = [];

  for i = 1:length(energies)
    KE_J_temp = energies(i) * 1.60218e-19;
    v_temp = sqrt(2 * KE_J_temp / m_e);
    lambda_temp = h / (m_e * v_temp) * 1e9; # in nm
    wavelengths(i) = lambda_temp;
  endfor

  # Find max wavelength for scaling
  max_wl = max(wavelengths);
  graph_width = 60;

  printf("\nEnergy (keV)  Wavelength (nm)  Graph\n");
  printf("------------  ---------------  %s\n", repmat("-", 1, graph_width));

  for i = 1:length(energies)
    bar_length = round((wavelengths(i) / max_wl) * graph_width);
    bar = repmat("█", 1, bar_length);
    printf("%8.1f      %10.4f      %s %.4f nm\n", energies(i)/1000, wavelengths(i), bar, wavelengths(i));
  endfor

  printf("\nGraph range: %.2f - %.2f keV\n", min(energies)/1000, max(energies)/1000);
  printf("Wavelength range: %.4f - %.4f nm\n\n", min(wavelengths), max(wavelengths));
endfunction
