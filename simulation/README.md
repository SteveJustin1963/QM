# Quantum Simulations Journal

## Program Overview

### t1.m - De Broglie Wavelength Calculator (Function-based)
**Purpose:** Calculates the de Broglie wavelength of an electron given its kinetic energy. Provides an ASCII graph showing how wavelength varies with energy across a customizable range.

**Key Features:**
- Can be called with or without arguments
- Interactive prompts when called without arguments
- Customizable energy range for visualization
- Generates ASCII bar graph of wavelength vs. energy

**Usage:**
- `t1()` - Interactive mode with prompts
- `t1(10000)` - Calculate for 10 keV electron with auto-ranging
- `t1(10000, [1000, 50000], 10)` - Custom energy range from 1-50 keV with 10 points

---

### t2.m - Quantum Tunneling Simulation (Script)
**Purpose:** Simulates quantum tunneling through a 1D potential barrier using finite difference methods and analytical transmission coefficient calculation.

**Key Features:**
- Sets up a 1D square potential barrier
- Uses analytical formula for transmission probability
- Demonstrates quantum tunneling when electron energy < barrier height

**Parameters (hardcoded in script):**
- Electron energy: 0.5 eV
- Barrier height: 1.0 eV
- Barrier width: 1 nm
- Simulation space: 10 nm total

---

### t3.m - Interactive De Broglie Wavelength Calculator (Script)
**Purpose:** Simple interactive script version of de Broglie wavelength calculation. Prompts user for kinetic energy and displays the resulting wavelength.

**Key Features:**
- Interactive user input
- Error checking for positive energy values
- Outputs velocity and wavelength in nm
- Provides context about when quantum effects are significant

---

### t4.m - Interactive Quantum Tunneling Calculator (Script)
**Purpose:** Analytical quantum tunneling probability calculator with interactive input. Calculates the transmission coefficient for electrons tunneling through a square barrier.

**Key Features:**
- Interactive prompts for all parameters
- Analytical solution for square barrier tunneling (E < U0 regime)
- Displays both probability and percentage
- Error checking to ensure E < U0 (tunneling regime)

---

## Development Log

### Session 1: Initial Setup and Interactive Improvements

**Date:** 2025-11-27

#### 1. Enhanced t1.m with Interactive Input
**Changes Made:**
- Added interactive user prompts when function is called without arguments
- Implemented `nargin == 0` check to detect when no arguments are provided
- Added prompts for:
  - Kinetic energy (with default 10000 eV)
  - Custom energy range option (yes/no)
  - Min/max energy values if custom range selected
  - Number of graph points (with default 7)

**Benefits:**
- Function now works both as a callable function with parameters and as an interactive prompt-based tool
- More user-friendly for exploratory analysis
- Maintains backward compatibility with argument-based calling

**Code Location:** `/home/sj/quantum-simulations/t1.m` (lines 8-28)

---

#### 2. Created Project Journal
**Purpose:**
- Document all programs and their purposes
- Track development history and changes
- Provide reference for future work

**File:** `/home/sj/quantum-simulations/journal.md`

---

## Next Steps / Future Enhancements

Potential improvements to consider:
- Add similar interactive prompts to t2.m
- Create visualization exports for graphs
- Add more quantum phenomena simulations (particle in a box, harmonic oscillator, etc.)
- Implement 2D/3D quantum tunneling simulations
- Add relativistic corrections for high-energy electrons
- Create batch processing capabilities for parameter sweeps
